//THIS IS A BOOSTER'S BOOT FILE
@lazyglobal off.
wait until ship:unpacked.
CORE:DOACTION("Open Terminal", true).

if not ship:status = "PRELAUNCH" { shutdown. }// TODO land

//runoncepath("0:/utilities/distances").
runoncepath("0:/utilities/ui").
runoncepath("0:/utilities/messenger").
runoncepath("0:/utilities/smartRCS").
runoncepath("0:/controllers/ascentController").

local tprint is ui()["tprint"].
local countdown is ui()["countdown"].
//local sendMessageRadius is messenger()["sendMessageRadius"].
local sendMessageCpu is messenger()["sendMessageCpu"].
local quickTranslation is smartRCS()["quickTranslation"].

// -- [ Prelaunch ] -------------
local ascent is ascentController(true).
countdown(10, 1).

// -- [ Launch ] ----------------
lock steering to ship:facing.
lock throttle to 1.
stage. // turn on engines
//stage. // release clamps

// -- [ Ascent ] ----------------
wait until ship:bounds:bottomaltradar > ship:bounds:extents:mag.// Don't hit the clamps!
tprint("Ascent controller engaged").
ascent["passControl"](false).

// -- [ Shutdown ] --------------
tprint("Shutdown").
until sendMessageCpu("second", "BoosterDetaching") {
    wait 0.1.
}
wait 0.25.
stage.
wait 0.1.
quickTranslation("aft", 3).

lock steering to ship:srfretrograde.// TODO
until ship:angularvel:mag < 0.05 and vang(ship:srfretrograde:vector, ship:facing:forevector) < 0.2 {
            wait 0.
        }
//lock throttle to 1.
wait until ship:verticalspeed < 0. // waiting for descent

lock throttle to 0.
unlock throttle.
unlock steering.
wait until false.