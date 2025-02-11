@lazyglobal off.
LOCAL actualBootFile to "boot0001Actual.ks".
COPYPATH("0:/boot/" + actualBootFile, "1:/").
RUNPATH("1:/" + actualBootFile).