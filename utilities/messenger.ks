@lazyglobal off.

function messenger {

    function sendMessageRadius {
        parameter   str is "",
                    radius is 500,
                    tries is 3.

        local snapshot is list().
        list targets in snapshot.

        for tvessel in snapshot {
            if ((tvessel:position - ship:position):mag <= radius) {
                local c is tvessel:connection.
                if c:isconnected {
                    local skip is tries.

                    until skip <= 0 or c:sendmessage(str) {
                        set skip to skip - 1.
                        wait 0.5.
                    }
                }
            }
        }
    }

    function sendMessageCpu {
        parameter   tag is "",
                    str is "".

        local cpu is processor(tag).
        local c is cpu:connection.
        return c:sendmessage(str).
    }

    return lexicon(
        "sendMessageRadius", sendMessageRadius@,
        "sendMessageCpu", sendMessageCpu@
    ).
}