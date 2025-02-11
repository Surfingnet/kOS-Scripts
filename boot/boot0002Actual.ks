//THIS IS A CIRCULARIZATION'S STAGE BOOT FILE
@lazyglobal off.
wait until ship:unpacked.
CORE:DOACTION("Open Terminal", true).

//runoncepath("0:/utilities/distances").
runoncepath("0:/utilities/ui").
runoncepath("0:/utilities/messenger").
//runoncepath("0:/utilities/smartRCS").
runoncepath("0:/controllers/ascentController").

local tprint is ui()["tprint"].
//local sendMessageRadius is messenger()["sendMessageRadius"].
//local quickTranslation is smartRCS()["quickTranslation"].

local start is false.

WHEN not core:messages:empty then {
  local message is core:messages:pop.
  if message:content = "BoosterDetaching" {
    set start to true.
    return false.
  }
  return true.
}

tprint("Probe initialized", true).
tprint("Sleeping").

wait until start.

tprint("Ready").

// Counting parts to find moment of staging
local preStagePartCount is 0.
local shipParts is ship:parts.
for part in shipParts {
    part:name.// Just to not trigger variable unused warning...
    set preStagePartCount to preStagePartCount + 1.
}

local currentPartCount is preStagePartCount.

until not (currentPartCount = preStagePartCount) {
    //print ("old: " + preStagePartCount + ", current: " + currentPartCount).
    set currentPartCount to 0.
    set shipParts to ship:parts.
    for part in shipParts {
        part:name.
        set currentPartCount to currentPartCount + 1.
    }
    wait 0.
}
// Staging has occured

tprint("Activated").

RCS ON.
lock steering to ship:prograde.

// Eject fairing
// local engineList is list().
// local ignitionFound is false.
// until ignitionFound {
//     list engines in engineList.
//     for engine in engineList {
//         if engine:ignition {
//             set ignitionFound to true.
//             break.
//         }
//     }
//     if not ignitionFound {
//         wait until stage:ready.
//         stage.
//         wait 0.
//     }
// }

wait until ship:angularvel:mag < 0.05 and vang(ship:prograde:vector, ship:facing:forevector) < 0.2.

// Still in atmosphere, needs thrust
local ascent is ascentController(false).
tprint("Ascent controller engaged").
ascent["passControl"]().

tprint("Shutdown").

wait until false.