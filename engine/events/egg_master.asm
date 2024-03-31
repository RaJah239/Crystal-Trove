EggMaster:
    ld hl, Text_EggMasterIntro
    call PrintText
    call JoyWaitAorB

    ld hl, Text_EggMasterPrompt
    call PrintText
    farcall PlaceMoneyTopRight
    call YesNoBox
    jp c, .cancel
    ld hl, .cost_to_relearn2
    ld de, hMoneyTemp
    ld bc, 3
    call CopyBytes
    ld bc, hMoneyTemp
    ld de, wMoney
    farcall CompareMoney
    jp c, .not_enough_money
    jp c, .cancel

    ld hl, Text_EggMasterWhichMon
    call PrintText
    call JoyWaitAorB

    ld b, $6
    farcall SelectMonFromParty
    jr c, .cancel

    ld a, [wCurPartySpecies]
    cp EGG
    jr z, .egg

    call IsAPokemon
    jr c, .no_mon

    call GetRemindableEggMoves
    jr z, .no_moves

    ld hl, Text_EggMasterWhichMove
    call PrintText
    call JoyWaitAorB

    call ChooseEggMoveToLearn
    jr c, .skip_learn

    ld a, [wMenuSelection]
    ld [wd265], a
    call GetMoveName
    ld hl, wStringBuffer1
    ld de, wStringBuffer2
    ld bc, wStringBuffer2 - wStringBuffer1
    call CopyBytes
    ld b, 0
    predef LearnMove
    ld a, b
    and a
    jr z, .skip_learn
    ld hl, .cost_to_relearn2
    ld de, hMoneyTemp
    ld bc, 3
    call CopyBytes
    ld bc, hMoneyTemp
    ld de, wMoney
    farcall TakeMoney
    ld de, SFX_TRANSACTION
    call PlaySFX
    call WaitSFX
.skip_learn
    call ReturnToMapWithSpeechTextbox
.cancel
    farcall PlaceMoneyTopRight
    ld hl, Text_EggMasterCancel
    jp PrintText

.egg
    ld hl, Text_EggMasterEgg
    jp PrintText

.no_mon
    ld hl, Text_EggMasterNoMon
    jp PrintText

.cost_to_relearn2
    dt 500000

.not_enough_money
    ld a, MOVERELEARNERTEXT_NOTENOUGHMONEY
    call PrintMoveRelearnerText
    ret

.no_moves
    ld hl, Text_EggMasterNoMoves
    jp PrintText

GetRemindableEggMoves:
; Get egg moves of CurPartyMon
; Returns z if it has no egg moves.

    ld hl, wd002
    xor a
    ld [hli], a
    ld [hl], $ff

    ld a, MON_SPECIES
    call GetPartyParamLocation
    ld a, [hl]
    ld [wCurPartySpecies], a

    push af
    ld b, 0
    ld de, wd002 + 1

; Based on GetEggMove in engine/pokemon/breeding.asm
    ld a, [wCurPartySpecies]
    dec a
    push bc
    ld b, 0
    ld c, a
    ld hl, EggMovePointers
    add hl, bc
    add hl, bc
    ld a, BANK(EggMovePointers)
    call GetFarWord

.loop_moves
    ld a, BANK("Egg Moves")
    call GetFarByte
    inc hl
    cp -1
    jr z, .done

    ld c, a
    call CheckAlreadyInMoveList
    jr c, .loop_moves
    call CheckPokemonAlreadyKnowsEggMove
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

.done
    pop bc
    pop af
    ld [wCurPartySpecies], a
    ld a, b
    ld [wd002], a
    and a
    ret

CheckAlreadyInMoveList:
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

CheckPokemonAlreadyKnowsEggMove:
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

ChooseEggMoveToLearn:
; Number of items stored in wd002
; List of items stored in wd002 + 1
    call FadeToMenu
    farcall BlankScreen
    call UpdateSprites
    ld hl, .MenuHeader
    call CopyMenuHeader
    xor a
    ld [wMenuCursorPosition], a
    ld [wMenuScrollPosition], a
    call ScrollingMenu
    call SpeechTextbox
    ld a, [wMenuJoypad]
    cp B_BUTTON
    jr z, .carry
    ld a, [wMenuSelection]
    ld [wPutativeTMHMMove], a
    and a
    ret

.carry
    scf
    ret

.MenuHeader:
    db MENU_BACKUP_TILES ; flags
    menu_coords 1, 1, SCREEN_WIDTH - 1, 11
    dw .MenuData
    db 1 ; default option

.MenuData:
    db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3 ; item format
    db 5, SCREEN_WIDTH + 2 ; rows, columns
    db SCROLLINGMENU_ITEMS_NORMAL
    dba  wd002
    dba .PrintMoveName
    dba .PrintDetails
    dba .PrintMoveDesc

.PrintMoveName
    push de
    ld a, [wMenuSelection]
    ld [wd265], a
    call GetMoveName
    pop hl
    jp PlaceString

.PrintDetails
    ld hl, wStringBuffer1
    ld bc, wStringBuffer2 - wStringBuffer1
    ld a, " "
    call ByteFill
    ld a, [wMenuSelection]
    inc a
    ret z
    dec a
    push de
    dec a

IF DEF(PSS)
    ld bc, MOVE_LENGTH
    ld hl, Moves
    call AddNTimes
    ld a, BANK(Moves)
    call GetFarByte

; bc = a * 4
    add a
    add a
    ld b, 0
    ld c, a
    ld hl, .Types
    add hl, bc
    ld d, h
    ld e, l
    ld hl, wStringBuffer1
    ld bc, 3
    call PlaceString
    ld hl, wStringBuffer1 + 3
    ld [hl], "/"

    ld a, [wMenuSelection]
    dec a
ENDC

    ld bc, MOVE_LENGTH
    ld hl, Moves + MOVE_TYPE
    call AddNTimes
    ld a, BANK(Moves)
    call GetFarByte
    ld [wd265], a

; bc = a * 4
    add a
    add a
    ld b, 0
    ld c, a
    ld hl, .Types
    add hl, bc
    ld d, h
    ld e, l
    ld hl, wStringBuffer1 + 4
    ld bc, 3
    call PlaceString
    ld hl, wStringBuffer1 + 7
    ld [hl], "/"

    ld a, [wMenuSelection]
    dec a
    
    ld bc, MOVE_LENGTH
    ld hl, Moves + MOVE_POWER
    call AddNTimes
    ld a, BANK(Moves)
    call GetFarByte
    ld hl, wStringBuffer1 + 8
    and a
    jr z, .no_power
    ld [wTempMonMoves], a
    ld de, wTempMonMoves
    lb bc, 1, 3
    call PrintNum
    jr .got_power
.no_power
    ld de, .ThreeDashes
    ld bc, 3
    call PlaceString
.got_power
    ld hl, wStringBuffer1 + 11
    ld [hl], "/"

    ld a, [wMenuSelection]
    dec a

; Print PP (works)
    ld a, [wMenuSelection]
    dec a
    ld bc, MOVE_LENGTH
    ld hl, Moves + MOVE_PP
    call AddNTimes
    ld a, BANK(Moves)
    call GetFarByte
    ld [wTempMonPP], a
    ld hl, wStringBuffer1 + 12
    ld de, wTempMonPP
    lb bc, 1, 2
    call PrintNum
    ld hl, wStringBuffer1 + 14
    ld [hl], "@"

    pop hl
    ld de, wStringBuffer1
    jp PlaceString
    
.ThreeDashes
    db "---@"

.Types
	db "NRM@"
	db "FGT@"
	db "FLY@"
	db "PSN@"
	db "GRD@"
	db "RCK@"
	db "BRD@"
	db "BUG@"
	db "GHT@"
	db "STL@"
	db "NRM@"
	db "NRM@"
	db "NRM@"
	db "NRM@"
	db "NRM@"
	db "NRM@"
	db "NRM@"
	db "NRM@"
	db "NRM@"
	db "???@"
	db "FIR@"
	db "WTR@"
	db "GRS@"
	db "ELC@"
	db "PSY@"
	db "ICE@"
	db "DRG@"
	db "DRK@"

.PrintMoveDesc
    push de
    call SpeechTextbox
    ld a, [wMenuSelection]
    inc a
    pop de
    ret z
    dec a
    ld [wCurSpecies], a
    hlcoord 1, 14
    predef_jump PrintMoveDescription

Text_EggMasterIntro:
    text_far _EggMasterIntroText
    text_end

Text_EggMasterPrompt:
    text_far _EggMasterPromptText
    text_end

Text_EggMasterWhichMon:
    text_far _EggMasterWhichMonText
    text_end

Text_EggMasterWhichMove:
    text_far _EggMasterWhichMoveText
    text_end

Text_EggMasterCancel:
    text_far _EggMasterCancelText
    text_end

Text_EggMasterEgg:
    text_far _EggMasterEggText
    text_end

Text_EggMasterNoMon:
    text_far _EggMasterNoMonText
    text_end

Text_EggMasterNoMoves:
    text_far _EggMasterNoMovesText
    text_end

_EggMasterIntroText::
    text "I'm the one and"
    line "only EGG TUTOR!"
    
    para "I can teach your"
    line "#MON moves that"
 
    para "they'd normally"
    line "need crossbreeding"
    cont "to inherit."
    
    para "My service fee is"
    line "¥500,000."
    done

_EggMasterPromptText:
    text "How about it?"
    done

_EggMasterWhichMonText::
    text "Which #MON do"
    line "you need tutoring?"
    done

_EggMasterCancelText::
    text "Do visit again."
    done

_EggMasterWhichMoveText::
    text "Select a move to"
    line "be taught."
    done

_EggMasterNoMovesText::
    text "Hmm… this #MON"
    line "has no EGG MOVES."
    done

_EggMasterEggText::
    text "EGGS needs to be"
    line "hatched first."
    done

_EggMasterNoMonText::
    text "No #MON has"
    line "been selected."
    done
