Change := 5
Display := true

SoundGet, OldVolume

Volume_Up::
SoundSet, +%Change%
SoundGet, OldVolume
Gosub, OSD
return

Volume_Down::
SoundSet, -%Change%
SoundGet, OldVolume
Gosub, OSD
return

Volume_Mute::
SoundGet, Old
if (Old = 0) {
	SoundSet, %OldVolume%
} else {
	SoundGet, OldVolume
	SoundSet, 0
}
Gosub, OSD
return

OSD:
if (Display) {
	try if ((shellProvider := ComObjCreate("{C2F03A33-21F5-47FA-B4BB-156362A2F239}", "{00000000-0000-0000-C000-000000000046}"))) {
		try if ((flyoutDisp := ComObjQuery(shellProvider, "{41f9d2fb-7834-4ab6-8b1b-73e74064b465}", "{41f9d2fb-7834-4ab6-8b1b-73e74064b465}"))) {
			 DllCall(NumGet(NumGet(flyoutDisp+0)+3*A_PtrSize), "Ptr", flyoutDisp, "Int", 0, "UInt", 0)
			,ObjRelease(flyoutDisp)
		}
		ObjRelease(shellProvider)
	}
}