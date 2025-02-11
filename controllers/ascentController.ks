@lazyglobal off.

// !!!!!!!! ANTEnNAS AND SOLAR PANELS ON ACTION GROUP ONE (AG1) !!!!!!!!
// !!!!!!!! FAIRINGS ON ACTION GROUP SIX (AG6) !!!!!!!!

WHEN ship:altitude > ship:body:atm:height then {
  AG6 ON.
  AG1 ON.
}

// ascentController :: int* -> int* -> int* -> float* -> ascentController
function ascentController {
    parameter   atmoBypass is false, // if true, completion is only about apoapsis, if false it also needs to be out of atmosphere
                simMaxThrust is 1.0, // simulation margins 
                desiredAp is 100000, // Min 100000 meters
                launchPlane is 90, // In degrees
                ascensionThrustPrecision is 1000, // In meters. Apoapsis this close to desired altitude starts lowering throttle.
                ascensionThrustMin is 0.0. // Minimal thrust unless out of atmosphere and desired apoapsis reached.

    // public getThrottle :: void -> float
    function getThrottle {
        return min(simMaxThrust, max(
            ascensionThrustMin,
                sqrt(
                    min(1, max(0, (desiredAp - ship:apoapsis) / ascensionThrustPrecision))
                )
            )
        ).
    }

    //public getSteering :: void -> direction
    function getSteering {
        local targetPitch to 90 - 90 * max(0, min(1, altitude / desiredAp)).
        local targetDirection to launchPlane. // TODO corrective
        return heading(targetDirection, targetPitch).
    }

    // public passControl :: bool* -> void
    function passControl {
        // performs ascent maneuver
        parameter isUnlocking is true.

        lock steering to getSteering().
        lock throttle to getThrottle().

        local stageThrust is ship:availablethrust.

        until completed() {

            if ship:availableThrust < (stageThrust - 10) {
                wait until stage:ready. stage. wait 1.
                set stageThrust to ship:availablethrust.
            }

        }

        RCS ON.

        lock throttle to 0.
        lock steering to prograde.

        until ship:angularvel:mag < 0.05 and vang(prograde:vector, ship:facing:forevector) < 0.2 {
            wait 0.
        }

        if isUnlocking { unlock throttle. unlock steering. }
    }


    // public completed :: void -> bool
    function completed { return ship:apoapsis >= desiredAp and (atmoBypass or ship:altitude > ship:body:atm:height). }

    // Return Public Fields
    return lexicon(
        //"getThrottle", getThrottle@,
        //"getSteering", getSteering@,
        //"completed", completed@,
        "passControl", passControl@
    ).
}