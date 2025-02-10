wait 1.
CORE:DOACTION("Open Terminal", true).

// ===== simulation margins =====
set simMaxThrust to 0.95. // Set to 1 for real launch
// ===== simulation margins =====

// ===== launch and ascension tuning =====
set preLaunchStages to 0. // Number of extra stages before launch (structures etc.)
set desiredOrbitAlt to 100000. // Min 100000 meters
set launchPlane to 90. // In degrees
set ascensionThrustPrecision to 10000. // In meters. Apoapsis this close to desired altitude starts lowering throttle.
set ascensionThrustMin to 0. // Minimal thrust unless out of atmosphere and desired apoapsis reached.
set ascensionAoaCeiling to 30000. // In meters. Above this altitude AoA correction is ignored.
//set ascensionAoaMax to 15. // In degrees. Above this AoA throttle is minimal. Only in atmosphere.
//set ascensionAoaPrecision to 10. // In degrees. Above this AoA throttle correction starts.
// ===== launch and ascension tuning =====

function safeStage {
    wait until stage:ready.
    stage.
}

//prevents angles from being either negative or greater than 360.
function fixangle {
	parameter angle.
	
	local out is angle.
	
	until (out < 360) {
		set out to out - 360.
	}
	
	until (out >= 0) {
		set out to out + 360.
	}
	
	return out.
}

//prevents angles from being less than -180 or greater than 180
function unfixangle {
	parameter angle.
	
	local out is angle.
	
	until (out <= 180) {
		set out to out - 360.
	}
	
	until (out > -180) {
		set out to out + 360.
	}
	
	return out.
}

//returns velocity vector
function velVec {
    if altitude > ascensionAoaCeiling {
        return ship:velocity:orbit.
    } else {
        return ship:velocity:surface.
    }
}

function calculateAoa {

    if altitude > ascensionAoaCeiling { return 0. }
    return vang(ship:velocity:surface, ship:facing:forevector).

}

function doLaunch {
    set launchAlt to altitude.
    lock throttle to simMaxThrust.
    until preLaunchStages <= 0 {
        safeStage().
        set preLaunchStages to preLaunchStages - 1.
    }
    safeStage().
    until altitude >= launchAlt + 50 { wait 0.}
}

//lock aoa to calculateAoa().

function doAscend {
    lock targetPitch to 90 - 90 * max(0, min(1, altitude / desiredOrbitAlt)).
    set targetDirection to launchPlane. // TODO

    lock steering to heading(targetDirection, targetPitch).

    lock throttle to min(simMaxThrust, max(
        ascensionThrustMin,
        //min(
            sqrt(
                min(1, max(0, (desiredOrbitAlt - apoapsis) / ascensionThrustPrecision))
            )//,
            //min(1, max(0, (ascensionAoaMax - aoa) / ascensionAoaPrecision))
        //)
        )
    ).

    set stageThrust to ship:availablethrust.

    until apoapsis >= desiredOrbitAlt and altitude >= 80000 {

        if ship:availableThrust < (stageThrust - 10) {
            safeStage(). wait 1.
            set stageThrust to ship:availablethrust.
        }

    }

    lock throttle to 0.
    lock steering to prograde.

    until ship:angularvel:mag < 0.05 and vang(prograde:vector, ship:facing:forevector) < 0.2 {
        wait 0.
    }

    toggle AG1.

    wait 2.
}

function doShutDown {
    lock throttle to 0.
    lock steering to prograde.
}

doLaunch().
doAscend().
doShutDown().

wait until false.