; C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; Secret hotkey to end: Ctrl + Esc

#SingleInstance, force
#NoTrayIcon

RShift::

	; Limit framerate
	SetWinDelay, 10

	; Initialize variables
	WinGetPos,,, screen_width, screen_height, Program Manager
	Random, image_width, 50, 100
	Random, image_height, 100, 200
	x := 0
	y := 0

	; Display image
	Gui, +AlwaysOnTop +Disabled -SysMenu +HwndGuiHwnd -0xC00000 +E0x00080000 +Owner
	DllCall("SetLayeredWindowAttributes", UInt, GuiHwnd, UInt, 0, UChar, 0, UInt, 0x1)
	Gui, Add, Picture, x%x% y%y% w%image_width% h%image_height%, rosen.png
	Gui, Color, 000000, f50000
	Gui, Show

	loop
	{
		; Randomize for every new destination
		Random, x_destination, 0, %screen_width%
		Random, y_destination, 0, %screen_height%
		Random, x_velocity, 50, 100
		Random, y_velocity, 20, 80
		Random, truth, 1, 10

		; Nice sound
		if (truth = 1)
		{
			SoundPlay, nice.mp3
		}

		; Increment image towards destination
		while (x != x_destination && y != y_destination)
		{
			if (x < x_destination) ; If to the left
			{
				if (x + image_width > x_destination - x_velocity) ; If within close vacinity
				{
					x_velocity := 1
				}

				x += x_velocity
			}
			else if (x > x_destination) ; If to the right
			{
				if (x < x_destination + (x_velocity * 2)) ; If within close vacinity
				{
					x_velocity := 1
				}

				x -= x_velocity
			}

			if (y < y_destination) ; If below
			{
				if (y + image_height > y_destination - y_velocity) ; If within close vacinity
				{
					y_velocity := 1
				}

				y += y_velocity
			}
			else if (y > y_destination) ; If above
			{
				if (y < y_destination + (y_velocity * 2)) ; If within close vacinity
				{
					y_velocity := 1
				}

				y -= y_velocity
			}

			WinMove, rosen,, %x%, %y%
		}
	}

^Esc::ExitApp