MoveReminder:
	ld hl, MoveReminderIntroText
	call PrintText
    farcall PlaceMoneyTopRight
	call YesNoBox
	jr c, .cancel

    call CheckCostAgainstPlayerMoney
	jr c, .not_enough_money

	ld hl, MoveReminderWhichMonText
	call PrintText

	farcall SelectMonFromParty
	jr c, .cancel

	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .is_an_egg

	call GetRemindableMoves
	jr z, .no_moves_to_learn

	; Loads and prints the "MoveReminderWhichMoveText" text.
	ld hl, MoveReminderWhichMoveText
	call PrintText

	; Generates the Move Reminder's menu. Relative jump to the
	; ".exit_menu" local jump if the player leaves
	; the menu and continue if they do not.
	call ChooseMoveToLearn
	jr c, .exit_menu

	; If the player selects a move, load the move's name and copy
	; it for later. This is used for displaying the move's
	; name in some of the text boxes while learning a move.
	ld a, [wMenuSelection]
	ld [wNamedObjectIndex], a
	call GetMoveName
	call CopyName1

; Begins the process of learning a move.

	; The "LearnMove" label sets the value of the "b" register to "1"
	; when a move is successfully learned and sets it to "0" if
	; cancelled at any point in the move learning process.
	predef LearnMove

	; Relative jump to the ".move_learned" local jump if
	; a move has been learned and continue if not.
	ld a, b
	dec a
	jr z, .move_learned
.exit_menu
    call ClearSprites
	call ReturnToMapWithSpeechTextbox
.cancel
	ld hl, MoveReminderCancelText
	jp PrintText

.is_an_egg
	ld hl, MoveReminderEggText
	jp PrintText

.no_moves_to_learn
	ld hl, MoveReminderNoMovesText
	jp PrintText

.not_enough_money
	ld hl, MoveReminderNotEnoughMoneyText
	jp PrintText

.move_learned
    call ClearSprites
	call ReturnToMapWithSpeechTextbox
	ld hl, MoveReminderMoveLearnedText
	call PrintText
.pay_for_move
	farcall PlaceMoneyTopRight
	ld hl, MoveCost
	ld de, hMoneyTemp
	ld bc, 3
	call CopyBytes
	call ApplyTilemap
	call PromptButton
	call WaitSFX
	ld bc, hMoneyTemp
	ld de, wMoney
	farcall TakeMoney
	farcall PlaceMoneyTopRight
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	ld hl, MoveReminderPaymentReceivedText
	call PrintText
	jr .cancel

CheckCostAgainstPlayerMoney:
	ld hl, MoveCost
	ld de, hMoneyTemp
	ld bc, 3
	call CopyBytes
	ld bc, hMoneyTemp
	ld de, wMoney
	farcall CompareMoney
	ret

MoveCost:
	dt 5000

GetRemindableMoves:

	; The "wd002" wram label is being used to store
	; the moves for placement in the move list.
	ld hl, wd002
	xor a
	ld [hli], a
	ld [hl], $ff

	; Retrieves and stores the species of
	; the currently selected Pokémon.
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartySpecies], a

	; Retrieves and stores the level of the
	; currently selected Pokémon.
	push af
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartyLevel], a

	; The "b" register will contain the number of
	; moves in the move list and "wd002 + 1"
	; is where the move list begins.
	ld b, 0
	ld de, wd002 + 1

	; Retrieves the currently selected Pokémon's evolution
	; and attack address from the "EvosAttacksPointers"
	; table that is located in another bank. This is the
	; list of evolutions and learnset of every Pokémon.
	ld a, [wCurPartySpecies]
	dec a
	push bc
	ld c, a
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord

; Skips the evolution data to start at the learnset for the
; currently selected Pokémon in the "EvosAttacksPointers"
; table. This is "db 0 ; no more evolutions".
.skip_evos
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	and a
	jr nz, .skip_evos

; Loops through the move list until it reaches
; the end of the "EvosAttacksPointers" table
; for the currently selected Pokémon. This is
; "db 0 ; no more level-up moves".

; It then compares the currently selected Pokémon's
; level with the level the move is learned at and
; if the Pokémon's level is higher, it will
; attempt to add the move to the move list.
.loop_moves
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	and a
	jr z, .done
	ld c, a
	ld a, [wCurPartyLevel]
	cp c
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	jr c, .loop_moves

	; Checks if the move is already in the
	; move list or already learned by the
	; Pokémon. If both are false, then the
	; move will be added to the move list.
	ld c, a
	call CheckAlreadyInList
	jr c, .loop_moves
	call CheckPokemonAlreadyKnowsMove
	jr c, .loop_moves
	ld a, c
	ld [de], a
	inc de
	ld a, $ff
	ld [de], a
	pop bc
	inc b
	push bc
	jr .loop_moves

; Adds all the possible moves the currently
; selected Pokémon can learn into "wd002".
; Which is the move list.
.done
	pop bc
	pop af
	ld [wCurPartySpecies], a
	ld a, b
	ld [wd002], a
	and a
	ret

; Checks if there is a move already placed
; in the move list. This prevents
; duplicate entries in the move list.
CheckAlreadyInList:
	push hl
	ld hl, wd002 + 1
.loop
	ld a, [hli]
	inc a
	jr z, .nope
	dec a
	cp c
	jr nz, .loop
	pop hl
	scf
	ret
.nope
	pop hl
	and a
	ret

; Checks if a Pokémon already knows a move. This
; prevents the player teaching the currently
; selected Pokémon a move it already knows.
CheckPokemonAlreadyKnowsMove:
	push hl
	push bc
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld b, 4
.loop
	ld a, [hli]
	cp c
	jr z, .yes
	dec b
	jr nz, .loop
	pop bc
	pop hl
	and a
	ret
.yes
	pop bc
	pop hl
	scf
	ret

; Creates a scrolling menu and sets up the menu gui.
; The number of items is stored in "wd002"
; The list of items is stored in "wd002 + 1"
ChooseMoveToLearn:
	farcall FadeOutPalettes
	farcall BlankScreen
    farcall SetUpMoveScreenBG
	ld hl, .MenuHeader
	call CopyMenuHeader
	xor a
	ld [wMenuCursorPosition], a
	ld [wMenuScrollPosition], a
    
    call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b_button
	ld a, [wMenuSelection]
	ld [wPutativeTMHMMove], a
	and a
	ret

.b_button
	scf
	ret

.MenuHeader:
	db MENU_SPRITE_ANIMS | MENU_BACKUP_TILES
	menu_coords 1, 2, SCREEN_WIDTH - 2, 10
	dw .MenuData
	db 1

; This sets up the menu's contents, including the amount
; of entries displayed before scrolling is required.

; Vertical scroll arrows and the move's
; details will be displayed.

; This menu is populated with an item and three functions.
; The item is "wd002".
; Function 1 is the ".print_move_name" local jump.
; Function 2 is the ".print_pp" local jump.
; Function 3 is the ".print_move_details" local jump.
.MenuData:
	db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3
	db 4, SCREEN_WIDTH + 2
	db SCROLLINGMENU_ITEMS_NORMAL
	dba  wd002
	dba .print_move_name
	dba .print_pp
	dba .print_move_details

; This prints the move's name in the menu.
; This is purely visual as the actual
; entry is stored in "wd002".
.print_move_name
	push de
	ld a, [wMenuSelection]
	ld [wNamedObjectIndex], a
	call GetMoveName
	pop hl
	jp PlaceString

; This prints the move's pp offset by one
; line with some spacing from the left.
.print_pp
	ld hl, wStringBuffer1
	ld bc, wStringBuffer2 - wStringBuffer1
	ld a, " "
	call ByteFill
	ld a, [wMenuSelection]
	inc a
	ret z
	dec a
	push de

	ld a, [wMenuSelection]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_PP) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld [wBuffer1], a
	ld hl, wStringBuffer1 + 9
	ld de, wBuffer1
	lb bc, 1, 2
	call PrintNum
	ld hl, wStringBuffer1 + 11
	ld [hl], "/"
	ld hl, wStringBuffer1 + 12
	call PrintNum
	
	ld hl, wStringBuffer1 + 14
	ld [hl], "@"

	pop hl
	ld de, wStringBuffer1
	call PlaceString

	; This prints the pp gfx before the move's pp.
	ld bc, 6
	add hl, bc
	ld a, $3e
	ld [hli], a
	ld [hl], a
	ret

; This adds a text box border line to the description
; box that replaces a leftover piece of the notch
; that remains when the cancel option is highlighted.
.cancel_border_fix
	hlcoord 0, 10
	ld [hl], "│"
	inc hl
	ret

.print_move_details

	; This creates a border around the description.
	hlcoord 0, 11
	lb bc, 5, 18
	call TextboxBorder

	; This code will relative jump to the
	; ".cancel_border_fix" local jump if
	; the cancel entry is highlighted.
	ld a, [wMenuSelection]
	cp -1
	jr z, .cancel_border_fix
.print_move_desc
	push de
	ld a, [wMenuSelection]
	inc a
	pop de
	ret z
	dec a
	ld [wCurSpecies], a
	hlcoord 1, 14
	predef PrintMoveDescription
.print_move_type
	ld a, [wCurSpecies]
	ld b, a
	hlcoord 2, 12
	predef PrintMoveType
.print_move_stat_strings
	hlcoord 0, 10
	ld de, MoveTypeTopString
	call PlaceString
	hlcoord 0, 11
	ld de, MoveTypeString
	call PlaceString
	hlcoord 12, 12
	ld de, MoveAttackString
	call PlaceString
.print_move_attack
	ld a, [wMenuSelection]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_POWER) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	cp 2
	jr c, .print_move_null_attack
	ld [wBuffer1], a
	ld de, wBuffer1
	lb bc, 1, 3
	hlcoord 16, 12
	jp PrintNum

.print_move_null_attack
	hlcoord 16, 12
	ld de, MoveNullValueString
	ld bc, 3
	jp PlaceString

MoveTypeTopString:
	db "┌─────┐@"

MoveTypeString:
	db "│TYPE/└@"

MoveAttackString:
	db "ATK/@"

MoveNullValueString:
	db "---@"

MoveReminderIntroText:
	text "Everyone calls me"
	line "the MOVE REMINDER."

	para "If you pay me"
	line "¥5000, I can"

    para "make a #MON"
    line "remember a move."

	para "Should a move be"
	line "remembered?"
	done

MoveReminderWhichMonText:
	text "Which #MON?"
	prompt

MoveReminderWhichMoveText:
	text "Which move should"
	line "it remember?"
	prompt

MoveReminderCancelText:
	text "Ok! Come visit me"
	line "again."
	done

MoveReminderEggText:
	text "An EGG can't learn"
	line "any moves!"
	done

MoveReminderNoMovesText:
	text "This #MON can't"
	line "remember a move."
	done

MoveReminderNotEnoughMoneyText:
	text "Hm… You don't have"
	line "enough money."

	para "Please come back"
	line "when you do."
	done

MoveReminderMoveLearnedText:
	text "Done! Your #MON"
	line "remembered the"
	cont "move."
	done

MoveReminderPaymentReceivedText:
	text "Pleasure doing"
	line "business with"
	cont "you!"
	prompt
