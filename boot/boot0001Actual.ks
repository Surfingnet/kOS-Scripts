@lazyglobal off.
wait 1.
CORE:DOACTION("Open Terminal", true).

runoncepath("0:/utilities/ui").
runoncepath("0:/controllers/ascentController").

local tprint is ui()["tprint"].
local countdown is ui()["countdown"].

// -- [ Prelaunch ] -------------
local ascent is ascentController(0.95).
countdown(10, 1).

// -- [ Launch ] ----------------
stage. // turn on engines
lock throttle to 1.
//stage. // release clamps

// -- [ Ascent ] ----------------
tprint("Ascent controller engaged").
ascent["passControl"]().

// -- [ Shutdown ] --------------
tprint("Shutdown").
stage. wait 2.
lock steering to ship:srfretrograde.
//wait until ship:verticalspeed < 0. // waiting for descent

wait until false.