@lazyglobal off.

function ui {

    function tprint {
        parameter   str is "", 
                    clear is false.

        if clear { CLEARSCREEN. }
        print(str).
    }

    // public countdown :: int* -> int* -> void
    function countdown {
        parameter   i is 10,
                    prestage is 0.

        if prestage > 0 { lock throttle to 0.05. }
        CLEARSCREEN.
        until i <= 0 {
            local next is time:seconds + 1.
            tprint(i).

            until prestage < i {
                wait until stage:ready.
                stage.
                set prestage to prestage - 1.
            }

            set i to i - 1.
            wait max(0, next - time:seconds).
        }
        tprint("Liftoff", true).
    }

    return lexicon(
        //"getThrottle", getThrottle@,
        //"getSteering", getSteering@,
        //"completed", completed@,
        "tprint", tprint@,
        "countdown", countdown@
    ).
}