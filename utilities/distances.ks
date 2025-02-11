// 30 km for in-flight
// Note the order is important.  set UNLOAD BEFORE LOAD,
// and PACK before UNPACK.  Otherwise the protections in
// place to prevent invalid values will deny your attempt
// to change some of the values:
SET KUNIVERSE:DEFAULTLOADDISTANCE:FLYING:UNLOAD TO 30000.
SET KUNIVERSE:DEFAULTLOADDISTANCE:FLYING:LOAD TO 29500.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"
SET KUNIVERSE:DEFAULTLOADDISTANCE:FLYING:PACK TO 29999.
SET KUNIVERSE:DEFAULTLOADDISTANCE:FLYING:UNPACK TO 29000.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"

// 30 km for parked on the ground:
// Note the order is important.  set UNLOAD BEFORE LOAD,
// and PACK before UNPACK.  Otherwise the protections in
// place to prevent invalid values will deny your attempt
// to change some of the values:
SET KUNIVERSE:DEFAULTLOADDISTANCE:LANDED:UNLOAD TO 30000.
SET KUNIVERSE:DEFAULTLOADDISTANCE:LANDED:LOAD TO 29500.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"
SET KUNIVERSE:DEFAULTLOADDISTANCE:LANDED:PACK TO 39999.
SET KUNIVERSE:DEFAULTLOADDISTANCE:LANDED:UNPACK TO 29000.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"

// 30 km for parked in the sea:
// Note the order is important.  set UNLOAD BEFORE LOAD,
// and PACK before UNPACK.  Otherwise the protections in
// place to prevent invalid values will deny your attempt
// to change some of the values:
SET KUNIVERSE:DEFAULTLOADDISTANCE:SPLASHED:UNLOAD TO 30000.
SET KUNIVERSE:DEFAULTLOADDISTANCE:SPLASHED:LOAD TO 29500.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"
SET KUNIVERSE:DEFAULTLOADDISTANCE:SPLASHED:PACK TO 29999.
SET KUNIVERSE:DEFAULTLOADDISTANCE:SPLASHED:UNPACK TO 29000.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"

// 30 km for being on the launchpad or runway
// Note the order is important.  set UNLOAD BEFORE LOAD,
// and PACK before UNPACK.  Otherwise the protections in
// place to prevent invalid values will deny your attempt
// to change some of the values:
SET KUNIVERSE:DEFAULTLOADDISTANCE:PRELAUNCH:UNLOAD TO 30000.
SET KUNIVERSE:DEFAULTLOADDISTANCE:PRELAUNCH:LOAD TO 29500.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"
SET KUNIVERSE:DEFAULTLOADDISTANCE:PRELAUNCH:PACK TO 29999.
SET KUNIVERSE:DEFAULTLOADDISTANCE:PRELAUNCH:UNPACK TO 29000.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"

SET KUNIVERSE:DEFAULTLOADDISTANCE:ORBIT:UNLOAD TO 30000.
SET KUNIVERSE:DEFAULTLOADDISTANCE:ORBIT:LOAD TO 29500.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"
SET KUNIVERSE:DEFAULTLOADDISTANCE:ORBIT:PACK TO 29999.
SET KUNIVERSE:DEFAULTLOADDISTANCE:ORBIT:UNPACK TO 29000.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"

SET KUNIVERSE:DEFAULTLOADDISTANCE:SUBORBITAL:UNLOAD TO 30000.
SET KUNIVERSE:DEFAULTLOADDISTANCE:SUBORBITAL:LOAD TO 29500.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"
SET KUNIVERSE:DEFAULTLOADDISTANCE:SUBORBITAL:PACK TO 29999.
SET KUNIVERSE:DEFAULTLOADDISTANCE:SUBORBITAL:UNPACK TO 29000.
WAIT 0.001. // See paragraph above: "wait between load and pack changes"