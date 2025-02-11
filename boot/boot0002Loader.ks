//THIS IS A CIRCULARIZATION'S STAGE BOOT FILE
@lazyglobal off.
wait until ship:unpacked.
LOCAL actualBootFile to "boot0002Actual.ks".
COPYPATH("0:/boot/" + actualBootFile, "1:/").
RUNPATH("1:/" + actualBootFile).