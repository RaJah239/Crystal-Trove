BattleTowerRoomMenu:
; special
	call InitBattleTowerChallengeRAM
	farcall _BattleTowerRoomMenu
	ret

BattleTowerBattle:
	xor a ; FALSE
	ld [wBattleTowerBattleEnded], a
	call _BattleTowerBattle
	ret

InitBattleTowerChallengeRAM:
	xor a
	ld [wBattleTowerBattleEnded], a
	ld [wNrOfBeatenBattleTowerTrainers], a
	ld [wcf65], a
	ld [wcf66], a
	ret

_BattleTowerBattle:
.loop
	call .do_dw
	call DelayFrame
	ld a, [wBattleTowerBattleEnded]
	cp TRUE
	jr nz, .loop
	ret

.do_dw
	jumptable .dw, wBattleTowerBattleEnded

.dw
	dw RunBattleTowerTrainer

RunBattleTowerTrainer:
	ld a, [wOptions]
	push af
	ld hl, wOptions
	set BATTLE_SHIFT, [hl] ; SET MODE

	ld a, [wInBattleTowerBattle]
	push af
	or 1
	ld [wInBattleTowerBattle], a

	xor a
	ld [wLinkMode], a
	farcall StubbedTrainerRankings_Healings
	farcall HealParty
	call ReadBTTrainerParty
	call Clears5_a89a

	predef StartBattle

	farcall LoadPokemonData
	farcall HealParty
	ld a, [wBattleResult]
	ld [wScriptVar], a
	and a ; WIN?
	jr nz, .lost
	ld a, BANK(sNrOfBeatenBattleTowerTrainers)
	call OpenSRAM
	ld a, [sNrOfBeatenBattleTowerTrainers]
	ld [wNrOfBeatenBattleTowerTrainers], a
	call CloseSRAM
	ld hl, wStringBuffer3
	ld a, [wNrOfBeatenBattleTowerTrainers]
	add "1"
	ld [hli], a
	ld a, "@"
	ld [hl], a

.lost
	pop af
	ld [wInBattleTowerBattle], a
	pop af
	ld [wOptions], a
	ld a, TRUE
	ld [wBattleTowerBattleEnded], a
	ret

ReadBTTrainerParty:
; Initialise the BattleTower-Trainer and his mon
	call CopyBTTrainer_FromBT_OT_TowBT_OTTemp

; Check the nicknames for illegal characters, and replace bad nicknames
; with their species names.
	ld de, wBT_OTTempMon1Name
	ld c, MON_NAME_LENGTH
	farcall CheckStringForErrors
	jr nc, .skip_mon_1

	ld a, [wBT_OTTempMon1]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld l, e
	ld h, d
	ld de, wBT_OTTempMon1Name
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.skip_mon_1
	ld de, wBT_OTTempMon2Name
	ld c, MON_NAME_LENGTH
	farcall CheckStringForErrors
	jr nc, .skip_mon_2
	ld a, [wBT_OTTempMon2]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld l, e
	ld h, d
	ld de, wBT_OTTempMon2Name
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.skip_mon_2
	ld de, wBT_OTTempMon3Name
	ld c, MON_NAME_LENGTH
	farcall CheckStringForErrors
	jr nc, .skip_mon_3
	ld a, [wBT_OTTempMon3]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld l, e
	ld h, d
	ld de, wBT_OTTempMon3Name
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.skip_mon_3
; Add the terminator character to each of these names
	ld a, "@"
	ld [wBT_OTTempMon1Name + MON_NAME_LENGTH - 1], a
	ld [wBT_OTTempMon2Name + MON_NAME_LENGTH - 1], a
	ld [wBT_OTTempMon3Name + MON_NAME_LENGTH - 1], a
; Fix errors in the movesets
	call CheckBTMonMovesForErrors
; Repair the trainer name if needed, then copy it to wOTPlayerName
	ld de, wBT_OTTempName
	ld c, NAME_LENGTH - 1
	farcall CheckStringForErrors
	jr nc, .trainer_name_okay
	ld hl, BT_ChrisName
	jr .done_trainer_name

.trainer_name_okay
	ld hl, wBT_OTTempName

.done_trainer_name
	ld de, wOTPlayerName
	ld bc, NAME_LENGTH - 1
	call CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, wBT_OTTempTrainerClass
	ld a, [hli]
	ld [wOtherTrainerClass], a
	ld a, LOW(wOTPartyMonNicknames)
	ld [wBGMapBuffer], a
	ld a, HIGH(wOTPartyMonNicknames)
	ld [wBGMapBuffer + 1], a

	; Copy mon into Memory from the address in hl
	ld de, wOTPartyMon1Species
	ld bc, wOTPartyCount
	ld a, BATTLETOWER_PARTY_LENGTH
	ld [bc], a
	inc bc
.otpartymon_loop
	push af
	ld a, [hl]
	ld [bc], a
	inc bc
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	push de
	ld a, [wBGMapBuffer]
	ld e, a
	ld a, [wBGMapBuffer + 1]
	ld d, a
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld a, e
	ld [wBGMapBuffer], a
	ld a, d
	ld [wBGMapBuffer + 1], a
	pop de
	pop bc
	pop af
	dec a
	and a
	jr nz, .otpartymon_loop
	ld a, -1
	ld [bc], a
	ret

BT_ChrisName:
	db "CHRIS@"

INCLUDE "data/battle_tower/unknown_levels.asm"

CopyBTTrainer_FromBT_OT_TowBT_OTTemp:
; copy the BattleTower-Trainer data that lies at 'wBT_OTTrainer' to 'wBT_OTTemp'
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBT_OTTrainer)
	ldh [rSVBK], a

	ld hl, wBT_OTTrainer
	ld de, wBT_OTTemp
	ld bc, BATTLE_TOWER_STRUCT_LENGTH
	call CopyBytes

	pop af
	ldh [rSVBK], a

	ld a, BANK(sBattleTowerChallengeState)
	call OpenSRAM
	ld a, BATTLETOWER_CHALLENGE_IN_PROGRESS
	ld [sBattleTowerChallengeState], a
	ld hl, sNrOfBeatenBattleTowerTrainers
	inc [hl]
	call CloseSRAM
	ret

BattleTowerAction:
	jumptable .dw, wScriptVar

.dw
	dw BattleTowerAction_CheckExplanationRead
	dw BattleTowerAction_SetExplanationRead
	dw BattleTowerAction_GetChallengeState
	dw BattleTowerAction_SetByteToQuickSaveChallenge
	dw BattleTowerAction_SetByteToCancelChallenge
	dw BattleTowerAction_05
	dw BattleTowerAction_06
	dw SaveBattleTowerLevelGroup
	dw LoadBattleTowerLevelGroup
	dw BattleTower_CheckSaveFileExistsAndIsYours
	dw BattleTowerAction_0A
	dw BattleTowerAction_GSBall
	dw BattleTowerAction_EggTicket
	dw BattleTowerAction_0F
	dw BattleTowerAction_11
	dw BattleTowerAction_12
	dw BattleTowerAction_14
	dw BattleTowerAction_15
	dw BattleTowerAction_16
	dw BattleTowerAction_17
	dw BattleTowerAction_LevelCheck
	dw BattleTowerAction_UbersCheck
	dw ResetBattleTowerTrainersSRAM
	dw BattleTower_GiveReward
	dw BattleTowerAction_1C
	dw BattleTowerAction_1D
	dw BattleTower_SaveOptions

; Reset the save memory for BattleTower-Trainers (Counter and all 7 TrainerBytes)
ResetBattleTowerTrainersSRAM:
	ld a, BANK(sBTTrainers)
	call OpenSRAM

	ld a, $ff
	ld hl, sBTTrainers
	ld bc, BATTLETOWER_STREAK_LENGTH
	call ByteFill

	xor a
	ld [sNrOfBeatenBattleTowerTrainers], a

	call CloseSRAM

	ret

BattleTower_GiveReward:
	ld a, BANK(sBattleTowerReward)
	call OpenSRAM

	ld a, [sBattleTowerReward]
	call CloseSRAM
	ld [wScriptVar], a
	ld hl, wNumItems
	ld a, [hli]
	cp MAX_ITEMS
	ret c
	ld b, MAX_ITEMS
	ld a, [wScriptVar]
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr nz, .next
	ld a, [hl]
	cp 95
	ret c
.next
	inc hl
	dec b
	jr nz, .loop
	ld a, POTION
	ld [wScriptVar], a
	ret

BattleTowerAction_1C:
	ld a, BANK(sBattleTowerChallengeState)
	call OpenSRAM
	ld a, BATTLETOWER_WON_CHALLENGE
	ld [sBattleTowerChallengeState], a
	call CloseSRAM
	ret

BattleTowerAction_1D:
	ld a, BANK(sBattleTowerChallengeState)
	call OpenSRAM
	ld a, BATTLETOWER_RECEIVED_REWARD
	ld [sBattleTowerChallengeState], a
	call CloseSRAM
	ret

BattleTower_SaveOptions:
	farcall SaveOptions
	ret

BattleTowerAction_CheckExplanationRead:
	call BattleTower_CheckSaveFileExistsAndIsYours
	ld a, [wScriptVar]
	and a
	ret z

	ld a, BANK(sBattleTowerSaveFileFlags)
	call OpenSRAM
	ld a, [sBattleTowerSaveFileFlags]
	and 2
	ld [wScriptVar], a
	call CloseSRAM
	ret

BattleTowerAction_GetChallengeState:
	ld hl, sBattleTowerChallengeState
	ld a, BANK(sBattleTowerChallengeState)
	call OpenSRAM
	ld a, [hl]
	ld [wScriptVar], a
	call CloseSRAM
	ret

BattleTowerAction_SetExplanationRead:
	ld a, BANK(sBattleTowerSaveFileFlags)
	call OpenSRAM
	ld a, [sBattleTowerSaveFileFlags]
	or 2
	ld [sBattleTowerSaveFileFlags], a
	call CloseSRAM
	ret

BattleTowerAction_SetByteToQuickSaveChallenge:
	ld c, BATTLETOWER_SAVED_AND_LEFT
	jr SetBattleTowerChallengeState

BattleTowerAction_SetByteToCancelChallenge:
	ld c, BATTLETOWER_NO_CHALLENGE
SetBattleTowerChallengeState:
	ld a, BANK(sBattleTowerChallengeState)
	call OpenSRAM
	ld a, c
	ld [sBattleTowerChallengeState], a
	call CloseSRAM
	ret

BattleTowerAction_05:
	ld a, BANK(s5_aa8c) ; aka BANK(s5_be46)
	call OpenSRAM
	ld a, [s5_aa8c]
	ld b, a
	ld a, [s5_be46]
	ld [wScriptVar], a
	call CloseSRAM
	and a
	ret z
	ld a, b
	cp 2
	jr nc, .asm_1707ef
	push bc
	call UpdateTime
	pop bc
	ld a, BANK(s5_aa8c)
	call OpenSRAM
	ld a, [s5_aa8b]
	call CloseSRAM
	ld c, a
	ld a, [wCurDay]
	sub c
	jr c, .asm_1707e5
	cp 8
	jr nc, .asm_1707ef
	ld a, b
	and a
	jr nz, .asm_1707ef
	ret
.asm_1707e5
	ld hl, wCurDay
	ld a, $8c
	sub c
	add [hl]
	cp 8
	ret c
.asm_1707ef
	ld a, 8
	ld [wScriptVar], a

BattleTowerAction_06:
	ld a, BANK(s5_be46) ; aka BANK(s5_aa8b) and BANK(s5_aa8c)
	call OpenSRAM
	xor a
	ld [s5_be46], a
	ld [s5_aa8b], a
	ld [s5_aa8c], a
	call CloseSRAM
	ret

BattleTowerAction_16:
	call UpdateTime
	ld a, BANK(s5_b2f9) ; aka BANK(s5_b2fa)
	call OpenSRAM
	ld a, [wCurDay]
	ld [s5_b2f9], a
	xor a
	ld [s5_b2fa], a
	call CloseSRAM
	ret

BattleTowerAction_17:
	xor a
	ld [wScriptVar], a
	ld a, BANK(s5_b2f9) ; aka BANK(s5_b2fa)
	call OpenSRAM
	ld a, [s5_b2f9]
	ld c, a
	ld a, [s5_b2fa]
	ld b, a
	call CloseSRAM
	cp 2
	jr nc, .asm_170853
	push bc
	call UpdateTime
	pop bc
	ld a, [wCurDay]
	sub c
	jr c, .asm_170849
	cp 11
	jr nc, .asm_170853
	ld a, b
	and a
	jr nz, .asm_170853
	ret

.asm_170849
	ld hl, wCurDay
	ld a, 140
	sub c
	add [hl]
	cp 11
	ret c
.asm_170853
	ld a, 1
	ld [wScriptVar], a
	ld a, BANK(s5_b2f9) ; aka BANK(s5_b2fa)
	call OpenSRAM
	xor a
	ld [s5_b2f9], a
	ld [s5_b2fa], a
	call CloseSRAM
	ret

SaveBattleTowerLevelGroup:
	ld a, BANK(sBTChoiceOfLevelGroup)
	call OpenSRAM
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBTChoiceOfLvlGroup)
	ldh [rSVBK], a
	ld a, [wBTChoiceOfLvlGroup]
	ld [sBTChoiceOfLevelGroup], a
	pop af
	ldh [rSVBK], a
	call CloseSRAM
	ret

LoadBattleTowerLevelGroup: ; Load level group choice
	ld a, BANK(sBTChoiceOfLevelGroup)
	call OpenSRAM
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBTChoiceOfLvlGroup)
	ldh [rSVBK], a
	ld a, [sBTChoiceOfLevelGroup]
	ld [wBTChoiceOfLvlGroup], a
	pop af
	ldh [rSVBK], a
	call CloseSRAM
	ret

BattleTower_CheckSaveFileExistsAndIsYours:
	ld a, [wSaveFileExists]
	and a
	jr z, .nope
	farcall CompareLoadedAndSavedPlayerID
	jr z, .yes
	xor a ; FALSE
	jr .nope

.yes
	ld a, TRUE

.nope
	ld [wScriptVar], a
	ret

BattleTowerAction_0A:
	xor a
	ld [wMusicFade], a
	call MaxVolume
	ret

BattleTowerAction_GSBall:
	ld a, BANK(sGSBallFlag)
	call OpenSRAM
	ld a, [sGSBallFlag]
	ld [wScriptVar], a
	call CloseSRAM
	ret

BattleTowerAction_EggTicket:
	xor a ; FALSE
	ld [wScriptVar], a
	ld a, EGG_TICKET
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	ret nc
	ld a, [wPartyCount]
	ld b, 0
	ld c, a
	ld hl, wPartySpecies
.loop
	ld a, [hli]
	cp EGG
	jr nz, .not_egg
	push hl
	ld hl, wPartyMonOTs
	ld de, NAME_LENGTH_JAPANESE
	ld a, b
	and a
	jr z, .skip
.loop2
	add hl, de
	dec a
	jr nz, .loop2
.skip
	ld de, String_MysteryJP
	ld a, NAME_LENGTH_JAPANESE
.compare_loop
	push af
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .different
	pop af
	dec a
	jr nz, .compare_loop
rept 4
	dec hl
endr
	ld a, "@"
	ld [hli], a
	ld [hli], a
	pop hl
	ld a, EGG_TICKET
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChange], a
	ld a, -1
	ld [wCurItemQuantity], a
	ld hl, wNumItems
	call TossItem
	ld a, TRUE
	ld [wScriptVar], a
	ret

.different
	pop af
	pop hl
.not_egg
	inc b
	dec c
	jr nz, .loop
	ret

String_MysteryJP:
	db "!@@" ; MYSTERY

BattleTowerAction_0F:
	ldh a, [rSVBK]
	push af
	ld a, BANK(w3_d090)
	ldh [rSVBK], a
	ld a, [w3_d090]
	ld [wScriptVar], a
	pop af
	ldh [rSVBK], a
	ret

BattleTowerAction_11:
	ld c, FALSE
	jr Set_s5_aa8d

BattleTowerAction_12:
	ld c, TRUE
Set_s5_aa8d:
	ld a, BANK(s5_aa8d)
	call OpenSRAM
	ld a, c
	ld [s5_aa8d], a
	call CloseSRAM
	ret

BattleTowerAction_14:
	call BattleTower_CheckSaveFileExistsAndIsYours
	ld a, [wScriptVar]
	and a
	ret z

	ld a, BANK(sBattleTowerSaveFileFlags)
	call OpenSRAM
	ld a, [sBattleTowerSaveFileFlags]
	and 1
	ld [wScriptVar], a
	call CloseSRAM
	ret

BattleTowerAction_15:
	ld a, BANK(sBattleTowerSaveFileFlags)
	call OpenSRAM
	ld a, [sBattleTowerSaveFileFlags]
	or 1
	ld [sBattleTowerSaveFileFlags], a
	call CloseSRAM
	ret

BattleTowerAction_LevelCheck:
	ld a, BANK(s5_b2fb)
	call OpenSRAM
	ld a, [s5_b2fb]
	call CloseSRAM
	ld c, 10
	call SimpleDivide
	ld a, b
	ld [wcd4f], a
	xor a
	ld [wScriptVar], a
	farcall BattleTower_LevelCheck
	ret nc
	ld a, BANK(s5_b2fb)
	call OpenSRAM
	ld a, [s5_b2fb]
	call CloseSRAM
	ld [wScriptVar], a
	ret

BattleTowerAction_UbersCheck:
	ld a, BANK(s5_b2fb)
	call OpenSRAM
	ld a, [s5_b2fb]
	call CloseSRAM
	ld c, 10
	call SimpleDivide
	ld a, b
	ld [wcd4f], a
	xor a
	ld [wScriptVar], a
	farcall BattleTower_UbersCheck
	ret nc
	ld a, BANK(s5_b2fb)
	call OpenSRAM
	ld a, [s5_b2fb]
	call CloseSRAM
	ld [wScriptVar], a
	ret

LoadOpponentTrainerAndPokemonWithOTSprite:
	farcall LoadOpponentTrainerAndPokemon
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBT_OTTrainerClass)
	ldh [rSVBK], a
	ld hl, wBT_OTTrainerClass
	ld a, [hl]
	dec a
	ld c, a
	ld b, 0
	pop af
	ldh [rSVBK], a
	ld hl, BTTrainerClassSprites
	add hl, bc
	ld a, [hl]
	ld [wBTTempOTSprite], a

; Load sprite of the opponent trainer
; because s/he is chosen randomly and appears out of nowhere
	ld a, [wScriptVar]
	dec a
	sla a
	ld e, a
	sla a
	sla a
	sla a
	ld c, a
	ld b, 0
	ld d, 0
	ld hl, wMapObjects
	add hl, bc
	inc hl
	ld a, [wBTTempOTSprite]
	ld [hl], a
	ld hl, wUsedSprites
	add hl, de
	ld [hli], a
	ldh [hUsedSpriteIndex], a
	ld a, [hl]
	ldh [hUsedSpriteTile], a
	farcall GetUsedSprite
	ret

INCLUDE "data/trainers/sprites.asm"

CheckForBattleTowerRules:
	farcall _CheckForBattleTowerRules
	jr c, .ready
	xor a ; FALSE
	jr .end

.ready
	ld a, TRUE

.end
	ld [wScriptVar], a
	ret
