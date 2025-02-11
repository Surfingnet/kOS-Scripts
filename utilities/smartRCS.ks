@lazyglobal off.

function smartRCS {

    function quickAft {
        parameter ttime is 0.1.
        set ship:control:fore to -1.
        wait ttime.
    }

    function quickFor {
        parameter ttime is 0.1.
        set ship:control:fore to 1.
        wait ttime.
    }

    function quickUp {
        parameter ttime is 0.1.
        set ship:control:top to 1.
        wait ttime.
    }

    function quickDown {
        parameter ttime is 0.1.
        set ship:control:top to -1.
        wait ttime.
    }

    function quickLeft {
        parameter ttime is 0.1.
        set ship:control:starboard to -1.
        wait ttime.
    }

    function quickRight {
        parameter ttime is 0.1.
        set ship:control:starboard to 1.
        wait ttime.
    }

    function quickTranslation {
        parameter   dir is "aft",
                    ttime is 0.1.

        local wasOn is RCS.
        if not RCS { RCS ON. }

        if dir = "aft" {
            quickAft(ttime).
        }
        else
        if dir = "for" {
            quickFor(ttime).
        }
        else
        if dir = "up" {
            quickUp(ttime).
        }
        else
        if dir = "down" {
            quickDown(ttime).
        }
        else
        if dir = "left" {
            quickLeft(ttime).
        }
        else
        if dir = "right" {
            quickRight(ttime).
        }

        set ship:control:neutralize to true.
        wait 0.
        if not wasOn { RCS OFF. }
    }

    

    return lexicon(
        "quickTranslation", quickTranslation@
    ).
}