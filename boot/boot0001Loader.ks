//THIS IS A BOOSTER'S BOOT FILE
@lazyglobal off.
wait until ship:unpacked.
LOCAL actualBootFile to "boot0001Actual.ks".
COPYPATH("0:/boot/" + actualBootFile, "1:/").
RUNPATH("1:/" + actualBootFile).