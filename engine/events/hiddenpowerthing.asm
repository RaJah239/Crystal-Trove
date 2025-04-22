; constants
DEF SPDSPCDV_15			EQU $FF ; Dark and must use for Shiny DVs on Speed and Special Attack
DEF MALE_ATKDEFDV_HP_ELECTRIC	EQU $11 ; Electric
DEF MALE_ATKDEFDV_HP_WATER	EQU $AA ; Water

SetMonHiddenPowerDVs:
	ld hl, ChangeDVText
	call PrintText

	call YesNoBox
	jp c, .cancel

	farcall SelectMonFromParty
	jp c, .cancel

	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg

	call IsAPokemon
	jr c, .cancel

	farcall GetGender
	jr z, .cancel ; if it is female, then cancel. This is temporary and will have to add a second section for females so this won't change their genders and still get shinys + all hidden power types

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1DVs
	call GetPartyLocation

	call Random
	and %00000011 ; limits the result to 0–3 (adjust depending on how many options you have)
	; Now select based on the result
	cp 0
	jp z, .HP_Dark
	cp 1
	jp z, .HP_Electric
	cp 2
	jp z, .HP_Water
	; else fall through to default

.HP_Dark:
	ld a, SPDSPCDV_15
	ld b, SPDSPCDV_15 ; Speed and Special Attack set at 15 for Shinys
	jr .WriteDVs

.HP_Electric:
	ld a, MALE_ATKDEFDV_HP_ELECTRIC
	ld b, SPDSPCDV_15 ; Speed and Special Attack set at 15 for Shinys
	jr .WriteDVs

.HP_Water:
	ld a, MALE_ATKDEFDV_HP_WATER
	ld b, SPDSPCDV_15 ; Speed and Special Attack set at 15 for Shinys
	jr .WriteDVs

.WriteDVs:
	ld [hli], a ; Atk/Def DVs
	ld [hl], b  ; Spd/Spc DVs

	ld de, SFX_MASTER_BALL
	call PlaySFX
	call WaitSFX

	ld hl, HiddenPowerDVsSetText
	call PrintText
	ret

.egg
	ld de, SFX_WRONG
	call PlaySFX
	call WaitSFX

	ld hl, EggSelectedText
	call PrintText
	call WaitPressAorB_BlinkCursor
	scf
	ret

.cancel
	ld hl, CancelText
	call PrintText
	scf
	ret

ChangeDVText:
	text "Change DV's now?"
	prompt

HiddenPowerDVsSetText:
	text "DV's changed!"
	prompt

EggSelectedText:
	text "EGG selected!"
	prompt

CancelText:
	text "Cancelled!"
	prompt

HiddenPowerDVTable:
	db $CC ; Fighting
	db $CD ; Flying
	db $CE ; Poison
	db $CF ; Ground
	db $DC ; Rock
	db $DD ; Bug
	db $DE ; Ghost
	db $DF ; Steel
	db $EC ; Fire
	db $ED ; Water
	db $EE ; Grass
	db $EF ; Electric
	db $FC ; Psychic
	db $FD ; Ice
	db $FE ; Dragon
	db $FF ; Dark
