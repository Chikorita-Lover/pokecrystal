	; MainMenuItems indexes
	const_def
	const MAINMENU_NEW_GAME               ; 0
	const MAINMENU_CONTINUE               ; 1

	; MainMenu.Strings and MainMenu.Jumptable indexes
	const_def
	const MAINMENUITEM_CONTINUE       ; 0
	const MAINMENUITEM_NEW_GAME       ; 1
	const MAINMENUITEM_OPTION         ; 2
	const MAINMENUITEM_RESET_CLOCK    ; 3
	const MAINMENUITEM_DEBUG_ROOM     ; 4

MobileMenuGFX:
INCBIN "gfx/mobile/mobile_menu.2bpp"

MainMenu:
.loop
	xor a
	ld [wDisableTextAcceleration], a
	call ClearTilemapEtc
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetPalettes
	ld hl, wGameTimerPaused
	res GAME_TIMER_PAUSED_F, [hl]
	call MainMenu_GetWhichMenu
	ld [wWhichIndexSet], a
	call MainMenu_PrintCurrentTimeAndDay
	ld hl, .MenuHeader
	call LoadMenuHeader
	call MainMenuJoypadLoop
	call CloseWindow
	jr c, .quit
	call ClearTilemap
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	rst JumpTable
	jr .loop

.quit
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 16, 7
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 0 ; items
	dw MainMenuItems
	dw PlaceMenuStrings
	dw .Strings

.Strings:
; entries correspond to MAINMENUITEM_* constants
	db "CONTINUE@"
	db "NEW GAME@"
	db "OPTION@"
	db "RESET CLOCK@"
if DEF(_DEBUG)
	db "DEBUG ROOM@"
endc

.Jumptable:
; entries correspond to MAINMENUITEM_* constants
	dw MainMenu_Continue
	dw MainMenu_NewGame
	dw MainMenu_Option
	dw MainMenu_ResetClock
if DEF(_DEBUG)
	dw MainMenu_DebugRoom
endc

MainMenuItems:
; entries correspond to MAINMENU_* constants

	; MAINMENU_NEW_GAME
	db 2
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db -1

	; MAINMENU_CONTINUE
	db 4 + DEF(_DEBUG)
	db MAINMENUITEM_CONTINUE
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db MAINMENUITEM_RESET_CLOCK
if DEF(_DEBUG)
	db MAINMENUITEM_DEBUG_ROOM
endc
	db -1

MainMenu_GetWhichMenu:
	nop
	nop
	nop
	ld a, [wSaveFileExists]
	and a
	jr nz, .next
	ld a, MAINMENU_NEW_GAME
	ret
.next
	ldh a, [hCGB]
	cp TRUE
	ld a, MAINMENU_CONTINUE
	ret

MainMenuJoypadLoop:
	call SetUpMenu
.loop
	call MainMenu_PrintCurrentTimeAndDay
	ld a, [w2DMenuFlags1]
	set 5, a
	ld [w2DMenuFlags1], a
	call GetScrollingMenuJoypad
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b_button
	cp A_BUTTON
	jr z, .a_button
	jr .loop

.a_button
	call PlayClickSFX
	and a
	ret

.b_button
	scf
	ret

MainMenu_PrintCurrentTimeAndDay:
	ld a, [wSaveFileExists]
	and a
	ret z
	xor a
	ldh [hBGMapMode], a
	call .PlaceBox
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .PlaceTime
	pop af
	ld [wOptions], a
	ld a, $1
	ldh [hBGMapMode], a
	ret

.PlaceBox:
	hlcoord 0, 14
	ld b, 2
	ld c, 18
	call Textbox
	ret

.PlaceTime:
	ld a, [wSaveFileExists]
	and a
	ret z
	call CheckRTCStatus
	and $80
	jp nz, .PrintTimeNotSet
	call UpdateTime
	call GetWeekday
	ld b, a
	decoord 1, 16
	call .PrintDayOfWeek
	decoord 11, 16
	ldh a, [hHours]
	ld b, a
	ld a, [hMinutes]
	ld c, a
	farcall PrintHoursMins
	ret

.PrintTimeNotSet:
	hlcoord 1, 16
	ld de, .TimeNotSetString
	call PlaceString
	ret

.TimeNotSetString:
	db "TIME NOT SET@"

.PrintDayOfWeek:
	push de
	ld hl, .Days
	ld a, b
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ld h, b
	ld l, c
	ld de, .Day
	call PlaceString
	ret

.Days:
	db "SUN@"
	db "MON@"
	db "TUES@"
	db "WEDNES@"
	db "THURS@"
	db "FRI@"
	db "SATUR@"
.Day:
	db "DAY@"

ClearTilemapEtc:
	xor a
	ldh [hMapAnims], a
	call ClearTilemap
	call LoadFontsExtra
	call LoadStandardFont
	call ClearWindowData
	ret

MainMenu_NewGame:
	farcall NewGame
	ret

MainMenu_Option:
	farcall Option
	ret

MainMenu_Continue:
	farcall Continue
	ret

MainMenu_ResetClock:
	farcall _ResetClock
	ret

MainMenu_MysteryGift:
	farcall MysteryGift
	ret
