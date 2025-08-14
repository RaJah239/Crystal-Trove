Core2_NewTurnEndEffects:
	call HandleLeftovers
	call HandleMysteryberry
	call HandleSafeguard
	call HandleScreens
	call HandleTrickRoom
	ret

HandleTrickRoom:
	ld hl, wTrickRoomCount
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret nz
	ld hl, TrickRoomEndedText
	jp StdBattleTextbox

HandleLeftovers:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .DoEnemyFirst
	call SetPlayerTurn
	call .do_it
	call SetEnemyTurn
	jp .do_it

.DoEnemyFirst:
	call SetEnemyTurn
	call .do_it
	call SetPlayerTurn
.do_it

	callfar GetUserItem
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetItemName
	ld a, b
	cp HELD_LEFTOVERS
	ret nz

	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP

.got_hp
; Don't restore if we're already at max HP
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp b
	jr nz, .restore
	ld a, [hl]
	cp c
	ret z

.restore
	farcall GetSixteenthMaxHP
	farcall SwitchTurnCore
	farcall RestoreHP
	ld hl, BattleText_TargetRecoveredWithItem
	jp StdBattleTextbox

HandleMysteryberry:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .DoEnemyFirst
	call SetPlayerTurn
	call .do_it
	call SetEnemyTurn
	jp .do_it

.DoEnemyFirst:
	call SetEnemyTurn
	call .do_it
	call SetPlayerTurn

.do_it
	callfar GetUserItem
	ld a, b
	cp HELD_RESTORE_PP
	jr nz, .quit
	ld hl, wPartyMon1PP
	ld a, [wCurBattleMon]
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, wPartyMon1Moves
	ld a, [wCurBattleMon]
	call GetPartyLocation
	ldh a, [hBattleTurn]
	and a
	jr z, .wild
	ld de, wWildMonPP
	ld hl, wWildMonMoves
	ld a, [wBattleMode]
	dec a
	jr z, .wild
	ld hl, wOTPartyMon1PP
	ld a, [wCurOTMon]
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, wOTPartyMon1Moves
	ld a, [wCurOTMon]
	call GetPartyLocation

.wild
	ld c, $0
.loop
	ld a, [hl]
	and a
	jr z, .quit
	ld a, [de]
	and PP_MASK
	jr z, .restore
	inc hl
	inc de
	inc c
	ld a, c
	cp NUM_MOVES
	jr nz, .loop

.quit
	ret

.restore
	; lousy hack
	ld a, [hl]
	cp SKETCH
	ld b, 1
	jr z, .sketch
	ld b, 5
.sketch
	ld a, [de]
	add b
	ld [de], a
	push bc
	push bc
	ld a, [hl]
	ld [wTempByteValue], a
	ld de, wBattleMonMoves - 1
	ld hl, wBattleMonPP
	ldh a, [hBattleTurn]
	and a
	jr z, .player_pp
	ld de, wEnemyMonMoves - 1
	ld hl, wEnemyMonPP
.player_pp
	inc de
	pop bc
	ld b, 0
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	pop de
	pop bc

	ld a, [wTempByteValue]
	cp [hl]
	jr nz, .skip_checks
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSubStatus5]
	jr z, .check_transform
	ld a, [wEnemySubStatus5]
.check_transform
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .skip_checks
	ld a, [de]
	add b
	ld [de], a
.skip_checks
	callfar GetUserItem
	ld a, [hl]
	ld [wNamedObjectIndex], a
	xor a
	ld [hl], a
	farcall GetPartymonItem
	ldh a, [hBattleTurn]
	and a
	jr z, .consume_item
	ld a, [wBattleMode]
	dec a
	jr z, .skip_consumption
	farcall GetOTPartymonItem

.consume_item
	xor a
	ld [hl], a

.skip_consumption
	call GetItemName
	farcall SwitchCoreItemRecoveryAnim
	ld hl, BattleText_UserRecoveredPPUsing
	jp StdBattleTextbox

CheckAmuletCoin:
	ld a, [wBattleMonItem]
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_AMULET_COIN
	ret nz
	ld a, 1
	ld [wAmuletCoin], a
	ret

GetWeatherImage:
	ld a, [wBattleWeather]
	ld de, ClearWeatherImage
	lb bc, PAL_BATTLE_OB_BLUE, 4
	cp WEATHER_NONE
	jr z, .done
	ld de, RainWeatherImage
	lb bc, PAL_BATTLE_OB_BLUE, 4
	dec a
	jr z, .done
	ld de, SunWeatherImage
	ld b, PAL_BATTLE_OB_YELLOW
	dec a
	jr z, .done
	ld de, SandstormWeatherImage
	ld b, PAL_BATTLE_OB_BROWN
	dec a
	jr z, .done
	ld de, HailWeatherImage
	ld b, PAL_BATTLE_OB_BLUE
	dec a
	ret nz
	
.done
	push bc
	ld b, BANK(WeatherImages) ; c = 4
	ld hl, vTiles0
	call Request2bpp
	pop bc
	ld hl, wShadowOAMSprite00
	ld de, .WeatherImageOAMData
.loop
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	jr nz, .loop
	ret

.WeatherImageOAMData
; positions are backwards since
; we load them in reverse order
	db $88, $1c ; y/x - bottom right
	db $88, $14 ; y/x - bottom left
	db $80, $1c ; y/x - top right
	db $80, $14 ; y/x - top left

GetTimeOfDayImage:
	ld a, [wTimeOfDay]
	cp MORN_F
	jr z, .MornImage

	cp DAY_F
	jr z, .DayImage
	
	cp EVE_F
	jr z, .EveImage

	cp NITE_F
	jr z, .NightImage

.MornImage:
 ld de, MorningTimeImage
 lb bc, PAL_BATTLE_OB_BLUE, 4
 jr .done

.DayImage:
 ld de, DayTimeImage
 lb bc, PAL_BATTLE_OB_YELLOW, 4
 jr .done	

 .EveImage:
 ld de, EveningTimeImage
 lb bc, PAL_BATTLE_OB_RED, 4
 jr .done

 .NightImage:
 ld de, NightTimeImage
 lb bc, PAL_BATTLE_OB_GRAY, 4

.done
	push bc
	ld b, BANK(TimeOfDayImages) ; c = 4
	ld hl, vTiles0
	call Request2bpp
	pop bc
	ld hl, wShadowOAMSprite00
	ld de, .TimeOfDayImageOAMData
.loop
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	jr nz, .loop
	ret

.TimeOfDayImageOAMData
; positions are backwards since
; we load them in reverse order
	db $88, $1c ; y/x - bottom right
	db $88, $14 ; y/x - bottom left
	db $80, $1c ; y/x - top right
	db $80, $14 ; y/x - top left

HandleSafeguard:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .player1
	call .CheckPlayer
	jr .CheckEnemy

.player1
	call .CheckEnemy
.CheckPlayer:
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	ret z
	ld hl, wPlayerSafeguardCount
	dec [hl]
	ret nz
	res SCREENS_SAFEGUARD, a
	ld [wPlayerScreens], a
	xor a
	jr .print

.CheckEnemy:
	ld a, [wEnemyScreens]
	bit SCREENS_SAFEGUARD, a
	ret z
	ld hl, wEnemySafeguardCount
	dec [hl]
	ret nz
	res SCREENS_SAFEGUARD, a
	ld [wEnemyScreens], a
	ld a, $1

.print
	ldh [hBattleTurn], a
	ld hl, BattleText_SafeguardFaded
	jp StdBattleTextbox

HandleScreens:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .Both
	call .CheckPlayer
	jr .CheckEnemy

.Both:
	call .CheckEnemy

.CheckPlayer:
	call SetPlayerTurn
	ld de, .Your
	call .Copy
	ld hl, wPlayerScreens
	ld de, wPlayerLightScreenCount
	jr .TickScreens

.CheckEnemy:
	call SetEnemyTurn
	ld de, .Enemy
	call .Copy
	ld hl, wEnemyScreens
	ld de, wEnemyLightScreenCount

.TickScreens:
	bit SCREENS_LIGHT_SCREEN, [hl]
	call nz, .LightScreenTick
	bit SCREENS_REFLECT, [hl]
	call nz, .ReflectTick
	ret

.Copy:
	ld hl, wStringBuffer1
	jp CopyName2

.Your:
	db "Your@"
.Enemy:
	db "Foe@"

.LightScreenTick:
	ld a, [de]
	dec a
	ld [de], a
	ret nz
	res SCREENS_LIGHT_SCREEN, [hl]
	push hl
	push de
	farcall SwitchTurnCore
	ld hl, BattleText_MonsLightScreenFell
	call StdBattleTextbox
	pop de
	pop hl
	ret

.ReflectTick:
	inc de
	ld a, [de]
	dec a
	ld [de], a
	ret nz
	res SCREENS_REFLECT, [hl]
	farcall SwitchTurnCore
	ld hl, BattleText_MonsReflectFaded
	jp StdBattleTextbox

ExitBattle:
	farcall UpdatePartyStats
	call .HandleEndOfBattle
	farcall CleanUpBattleRAM
	ret

.HandleEndOfBattle:
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	farcall ShowLinkBattleParticipantsAfterEnd
	ld c, 150
	call DelayFrames
	farcall DisplayLinkBattleResult
	ret

.not_linked
	ld a, [wBattleResult]
	and $f
	ret nz
	xor a
	ld [wForceEvolution], a
	predef EvolveAfterBattle
	farcall GivePokerusAndConvertBerries
	ret

GetTrainerBackpic:
; Load the player character's backpic (6x6) into VRAM starting from vTiles2 tile $31.

; Special exception for Dude.
	ld b, BANK(DudeBackpic)
	ld hl, DudeBackpic
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .Decompress

; What gender are we?
	ld a, [wPlayerSpriteSetupFlags]
	bit PLAYERSPRITESETUP_FEMALE_TO_MALE_F, a
	jr nz, .Chris
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .Chris

; It's a girl.
	farcall GetKrisBackpic
	ret

.Chris:
; It's a boy.
	ld b, BANK(ChrisBackpic)
	ld hl, ChrisBackpic

.Decompress:
	ld de, vTiles2 tile $31
	ld c, 7 * 7
	predef DecompressGet2bpp
	ret

; Handling Abilities

PlayAnimationIfNotFirstTurn:
; assume animation in de
    call ShouldPlayAnim
    jr nc, .skipAnim
	farcall Call_PlayBattleAnim
	scf
	ret
.skipAnim
    xor a
    ret

ShouldPlayAnim:
	call ClearSprites
	ld a, [wBattleMode]
	dec a
	jr nz, .checkEnemyPresent
	ld a, [wBattleHasJustStarted]
	and a
	jr nz, .no
	jr .yes
.checkEnemyPresent
    ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonSpecies]
	jr nz, .gotEnemy
	ld a, [wEnemyMonSpecies]
.gotEnemy
    and a
    jr z, .no
.yes
    scf
    ret
.no
    xor a
    ret

HasWildBattleBegun:
    ld a, [wBattleMode]
	dec a
	jr nz, .no
	ld a, [wBattleMonSpecies]
	and a
	jr nz, .no
	scf
	ret
.no
    xor a
    ret

NaturalCureSwitch:
    ld de, RECOVER
    call PlayAnimationIfNotFirstTurn
    callfar BattleCommand_NaturalCure
	ret

RainSwitch:
	ld a, WEATHER_RAIN
	ld [wBattleWeather], a
	ld a, 255
	ld [wWeatherCount], a
    ld a, [wBattleHasJustStarted]
    and a
    ret nz
    ld de, RAIN_DANCE
	farcall Call_PlayBattleAnim
	ld hl, DownpourText
	jp StdBattleTextbox

SunSwitch:
    ld a, WEATHER_SUN
	ld [wBattleWeather], a
	ld a, 255
	ld [wWeatherCount], a
    ld a, [wBattleHasJustStarted]
    and a
    ret nz
    ld de, SUNNY_DAY
	farcall Call_PlayBattleAnim
	ld hl, SunGotBrightText
	jp StdBattleTextbox

SandSwitch:
    ld a, WEATHER_SANDSTORM
	ld [wBattleWeather], a
	ld a, 255
	ld [wWeatherCount], a
    ld a, [wBattleHasJustStarted]
    and a
    ret nz
    ld de, ANIM_IN_SANDSTORM
	farcall Call_PlayBattleAnim
	ld hl, SandstormBrewedText
	jp StdBattleTextbox

AirLockSwitch:
	ld a, WEATHER_NONE
	ld [wBattleWeather], a
	ld hl, WeatherClearedUpText
	jp StdBattleTextbox

StickyWebSwitch:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
    bit SCREENS_STICKY_WEB, [hl]
    ret nz
	set SCREENS_STICKY_WEB, [hl]
    ld de, STICKY_WEB
    call PlayAnimationIfNotFirstTurn
	ld hl, StickyWebText
	jp StdBattleTextbox

SpikesSwitch:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
    bit SCREENS_SPIKES, [hl]
    ret nz
	set SCREENS_SPIKES, [hl]
    ld de, SPIKES
    call PlayAnimationIfNotFirstTurn
	ld hl, SpikesText
	jp StdBattleTextbox

StealthRockSwitch:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
    bit SCREENS_STEALTH_ROCK, [hl]
    ret nz
	set SCREENS_STEALTH_ROCK, [hl]
    ld de, STEALTH_ROCK
    call PlayAnimationIfNotFirstTurn
	ld hl, StealthRockText
	jp StdBattleTextbox

ToxicSpikesSwitch:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
    bit SCREENS_TOXIC_SPIKES, [hl]
    ret nz
	set SCREENS_TOXIC_SPIKES, [hl]
    ld de, TOXIC_SPIKES
    call PlayAnimationIfNotFirstTurn
	ld hl, ToxicSpikesText
	jp StdBattleTextbox

DefogSwitch:
    ld de, DEFOG
    call PlayAnimationIfNotFirstTurn
    callfar BattleCommand_Defog
	ret

TrickRoomSwitch:
    ld a, 5
    ld [wTrickRoomCount], a
    ld de, TRICK_ROOM
    call PlayAnimationIfNotFirstTurn
	ld hl, TrickRoomText
	jp StdBattleTextbox

ReflectSwitch:
    ld hl, wPlayerScreens
	ld bc, wPlayerReflectCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens_pointer
	ld hl, wEnemyScreens
	ld bc, wEnemyReflectCount
.got_screens_pointer
	set SCREENS_REFLECT, [hl]
	ld a, FIELD_EFFECT_DURATION
	ld [bc], a
    ld de, REFLECT
    call PlayAnimationIfNotFirstTurn
    ld hl, ReflectEffectText
	jp StdBattleTextbox

LightScreenSwitch:
    ld hl, wPlayerScreens
	ld bc, wPlayerLightScreenCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens_pointer
	ld hl, wEnemyScreens
	ld bc, wEnemyLightScreenCount
.got_screens_pointer
	set SCREENS_LIGHT_SCREEN, [hl]
	ld a, FIELD_EFFECT_DURATION
	ld [bc], a
    ld de, LIGHT_SCREEN
    call PlayAnimationIfNotFirstTurn
    ld hl, LightScreenEffectText
	jp StdBattleTextbox

SafeguardSwitch:
    ld hl, wPlayerScreens
	ld bc, wPlayerSafeguardCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens_pointer
	ld hl, wEnemyScreens
	ld bc, wEnemySafeguardCount
.got_screens_pointer
	set SCREENS_SAFEGUARD, [hl]
	ld a, FIELD_EFFECT_DURATION
	ld [bc], a
    ld de, SAFEGUARD
    call PlayAnimationIfNotFirstTurn
    ld hl, CoveredByVeilText
	jp StdBattleTextbox

SpecialAttackUpSwitch:
    call PlayBoostAnimation
    callfar BattleCommand_SpecialAttackUp
	call PrintSpecialAttackUpMessage
	ret

AttackUpSwitch:
    call PlayBoostAnimation
    callfar BattleCommand_AttackUp
	call PrintAttackUpMessage
	ret

SpecialDefenseUpSwitch:
    call PlayBoostAnimation
    callfar BattleCommand_SpecialDefenseUp
	call PrintSpecialDefenseUpMessage
	ret

DefenseUpSwitch:
    call PlayBoostAnimation
    callfar BattleCommand_DefenseUp
	call PrintDefenseUpMessage
	ret

SpeedUpSwitch:
    call PlayBoostAnimation
    callfar BattleCommand_SpeedUp
	call PrintSpeedUpMessage
	ret

DefenseModeSwitch:
    call PlayBoostAnimation
    callfar BattleCommand_DefenseUp2
    call PrintDefenseUpMessage
    callfar BattleCommand_SpecialDefenseUp2
    call PrintSpecialDefenseUpMessage
    ret

EvasionUpSwitch:
    call PlayBoostAnimation
    callfar BattleCommand_EvasionUp
	call PrintEvasionUpMessage
	ret

; For all Stat Drop Abilities:
; Doesn't work on first turn on either side of the field in a wild battle
; Since the foe trainer sends out first without a target,
; Only the player's pokemon stat drops the opponent
AttackDownSwitch:
    callfar BattleCommand_AttackDown
    call PlayDropAnimation
	ret

SpecialAttackDownSwitch:
    callfar BattleCommand_SpecialAttackDown
    call PlayDropAnimation
	ret

AccuracyDownSwitch:
    callfar BattleCommand_AccuracyDown
    call PlayDropAnimation
	ret

PrintAttackUpMessage:
    call HasWildBattleBegun
    jr c, .wild
	farcall BattleCommand_StatUpMessage
	ret
.wild
    ld hl, WildAttackUpText
    jp BattleTextbox

WildAttackUpText:
    text "<TARGET>'s"
    line "Attack went up!"
    prompt

PrintDefenseUpMessage:
    call HasWildBattleBegun
    jr c, .wild
	farcall BattleCommand_StatUpMessage
	ret
.wild
    ld hl, WildDefenseUpText
    jp BattleTextbox

WildDefenseUpText:
    text "<TARGET>'s"
    line "Defense went up!"
    prompt

PrintSpeedUpMessage:
    call HasWildBattleBegun
    jr c, .wild
	farcall BattleCommand_StatUpMessage
	ret
.wild
    ld hl, WildSpeedUpText
    jp BattleTextbox

WildSpeedUpText:
    text "<TARGET>'s"
    line "Speed went up!"
    prompt

PrintSpecialAttackUpMessage:
    call HasWildBattleBegun
    jr c, .wild
	farcall BattleCommand_StatUpMessage
	ret
.wild
    ld hl, WildSpecialAttackUpText
    jp BattleTextbox

WildSpecialAttackUpText:
    text "<TARGET>'s"
    line "Spcl.Atk went up!"
    prompt

PrintSpecialDefenseUpMessage:
    call HasWildBattleBegun
    jr c, .wild
	farcall BattleCommand_StatUpMessage
	ret
.wild
    ld hl, WildSpecialDefenseUpText
    jp BattleTextbox

WildSpecialDefenseUpText:
    text "<TARGET>'s"
    line "Spcl.Def went up!"
    prompt

PrintEvasionUpMessage:
    call HasWildBattleBegun
    jr c, .wild
	farcall BattleCommand_StatUpMessage
	ret
.wild
    ld hl, WildEvasionUpText
    jp BattleTextbox

WildEvasionUpText:
    text "<TARGET>'s"
    line "Evasion went up!"
    prompt

PlayDropAnimation:
    ld de, ANIM_ENEMY_STAT_DOWN
    call PlayAnimationIfNotFirstTurn
    ret nc
    callfar BattleCommand_StatDownMessage
    ret

PlayBoostAnimation:
    ld de, ANIM_STAT_UP
    call PlayAnimationIfNotFirstTurn
    ret

ShadowTag:
	ld a, [wEnemyMonSpecies]
	cp WOBBUFFET
	jr z, .trap
;	cp GENGAR
;	jr z, .trap
    ret
.trap
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_CANT_RUN, [hl]
	ret nz
	set SUBSTATUS_CANT_RUN, [hl]
	ret

GetRoamMonMapGroup:
	ld a, [wTempEnemyMonSpecies]
	ld b, a
	ld a, [wRoamMon1Species]
	cp b
	ld hl, wRoamMon1MapGroup
	ret z
	ld a, [wRoamMon2Species]
	cp b
	ld hl, wRoamMon2MapGroup
	ret z
	ld hl, wRoamMon3MapGroup
	ret

GetRoamMonMapNumber:
	ld a, [wTempEnemyMonSpecies]
	ld b, a
	ld a, [wRoamMon1Species]
	cp b
	ld hl, wRoamMon1MapNumber
	ret z
	ld a, [wRoamMon2Species]
	cp b
	ld hl, wRoamMon2MapNumber
	ret z
	ld hl, wRoamMon3MapNumber
	ret

GetRoamMonHP:
; output: hl = wRoamMonHP
	ld a, [wTempEnemyMonSpecies]
	ld b, a
	ld a, [wRoamMon1Species]
	cp b
	ld hl, wRoamMon1HP
	ret z
	ld a, [wRoamMon2Species]
	cp b
	ld hl, wRoamMon2HP
	ret z
	ld hl, wRoamMon3HP
	ret

GetRoamMonDVs:
; output: hl = wRoamMonDVs
	ld a, [wTempEnemyMonSpecies]
	ld b, a
	ld a, [wRoamMon1Species]
	cp b
	ld hl, wRoamMon1DVs
	ret z
	ld a, [wRoamMon2Species]
	cp b
	ld hl, wRoamMon2DVs
	ret z
	ld hl, wRoamMon3DVs
	ret

GetRoamMonSpecies:
	ld a, [wTempEnemyMonSpecies]
	ld hl, wRoamMon1Species
	cp [hl]
	ret z
	ld hl, wRoamMon2Species
	cp [hl]
	ret z
	ld hl, wRoamMon3Species
	ret

ShouldIgniteFlameOrb:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	and a
	jr nz, .no

    ldh a, [hBattleTurn]
	and a
	jr z, .playerTurn
	ld a, [wEnemyMonType1]
	ld b, a
	ld a, [wEnemyMonType2]
	ld c, a
	ld a, [wEnemyMonSpecies]
	jr .checkDetails
.playerTurn
	ld a, [wBattleMonType1]
	ld b, a
	ld a, [wBattleMonType2]
	ld c, a
	ld a, [wBattleMonSpecies]
.checkDetails
;	cp ARCEUS
;	jr z, .no
;	cp SYLVEON
;	jr z, .no
    cp DUNSPARCE
    ld a, b
    cp FIRE
    jr z, .no
    ld a, c
    cp FIRE
    jr z, .no
.yes
    scf
    ret
.no
    xor a
    ret

XAccuracy:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_X_ACCURACY, a
	ret

ThunderRain:
; Return z if the current move always hits in rain, and it is raining.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_THUNDER
	ret nz

	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	ret

BlizzardHail:
; Return z if the current mova always hits in hail, and it is hailing
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_BLIZZARD
	ret nz
	
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	ret

DreamEaterMiss:
; Return z if we're trying to eat the dream of
; a monster that isn't sleeping.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_DREAM_EATER
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and SLP_MASK
	ret

ProtectMiss:
; Return nz if the opponent is protected.
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_PROTECT, a
	ret z
	ld c, 40
	call DelayFrames
; 'protecting itself!'
	ld hl, ProtectingItselfText
	call StdBattleTextbox
	ld c, 40
	call DelayFrames
	ld a, 1
	and a
	ret

FlyDigMovesMiss:
; Check for moves that can hit underground/flying opponents.
; Return z if the current move can hit the opponent.
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z
	bit SUBSTATUS_FLYING, a
	jr z, .DigMoves
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp GUST
	ret z
	cp WHIRLWIND
	ret z
	cp THUNDER
	ret z
	cp HURRICANE
	ret z
	ret

.DigMoves:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp EARTHQUAKE
	ret

HurricaneRain:
; Return z if the current move always hits in rain, and it is raining.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_HURRICANE
	ret nz

	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	ret

ToxicPoison:
; Return z if the used move is Toxic, and the user is Poison type.
; Which means Toxic should always hit.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_TOXIC
	ret nz

	ld hl, wBattleMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .cur_mon_own_type_found
	ld hl, wEnemyMonType1
.cur_mon_own_type_found
	ld a, [hli]
	cp POISON
	ret z

	ld a, [hl]
	cp POISON
	ret

; used by trainer SELF to set DVS in bc
SetUpSelfDVs:
    ld a, [wOtherTrainerClass]
    cp CAL
    ret nz
    ld a, [wCurPartyMon]
	ld hl, wOTPartyMon1DVs
	call GetPartyLocation
	ld b, [hl]
	inc hl
	ld c, [hl]
    ret

TrainerBattleInfo::
	push hl
	push de
	push bc
	xor a
	ld [wTrainerInfoPage], a
	call UpdatePageText
	call StatsInfoBox ; StatChangesInfoBox
	call WaitButtonInfoTrainer
	pop bc
	pop de
	pop hl
	ret
	
StatChangesInfoBox:
	hlcoord 0, 0
	ld b, 14
	ld c, 8
	call Textbox
	ld b, 14
	ld c, 8
	hlcoord 10, 0
	call Textbox
	
	hlcoord 1, 0
	ld de, MainText.player
	call PlaceString
	ld de, StatTexts.attack
	ld b, 1
	ld c, 2
	ld hl, wPlayerStatLevels
	call StatChangesInfoBoxLoop
	
	hlcoord 11, 0
	ld de, MainText.enemy
	call PlaceString
	ld de, StatTexts.attack
	ld b, 11
	ld c, 2
	ld hl, wEnemyStatLevels
	; fallthrough
	
StatChangesInfoBoxLoop:
	push hl
	call CoordsBCtoHL
	ld a, c
	cp 16
	jr nc, .finish
	push bc
	call PlaceString
	pop bc
	ld a, b
	add 6				; b = 7 or 17
	ld b, a
	pop hl
	call PrintStatChangeValue
	inc hl				; hl = StatLevel + 1
	inc de				; de gets increased to the end of the string in PlaceString, so increase it 1 more for the next string
	ld a, b
	sub 6
	ld b, a
	inc c
	inc c
	jr StatChangesInfoBoxLoop
.finish
	pop hl
	ret

PrintStatChangeValue: ; Input is hl (either wPlayerStatX or wEnemyStatX) and bc (coords to place text)
	push de
	push hl
	push bc
	ld de, wStringBuffer4
	ld a, TX_START
	ld [de], a
	inc de
	ld a, [hl]  	; Stat
	ld c, a
	cp 7			; 7 = no changes
	jr c, .lowered
	jr z, .same
	ld a, "▲"
	ld [de], a
	inc de
	ld a, c
	sub 7			; a = a - 7
	jr .insert
.same
	ld a, "▲"
	ld [de], a
	inc de
	xor a
	jr .insert
.lowered
	ld a, "▼"
	ld [de], a
	inc de
	ld a, 7
	sub c
.insert
	add "0"
	ld [de], a
	ld a, TX_END
	inc de
	ld [de], a		; Terminate string
	inc de
	ld [de], a		; Terminate string
	ld hl, wStringBuffer4
	pop bc
	push bc
	push hl
	call CoordsBCtoHL
	ld b, h
	ld c, l
	pop hl
	call PrintTextboxTextAt
	pop bc
	pop hl
	pop de
	ret

StatsInfoBox:
	hlcoord 0, 0
	ld b, 14
	ld c, 8
	call Textbox
	ld b, 14
	ld c, 8
	hlcoord 10, 0
	call Textbox

	hlcoord 1, 0
	ld de, MainText.player
	call PlaceString
	ld de, StatTexts
	ld b, 1
	ld c, 2
	ld hl, wBattleMonMaxHP
	call StatsInfoBoxLoop
	
	hlcoord 11, 0
	ld de, MainText.enemy
	call PlaceString
	ld de, StatTexts
	ld b, 11
	ld c, 2
	ld hl, wEnemyMonMaxHP
	jp StatsInfoBoxLoop

FoeAbilityPageInfoBox:
	hlcoord 0, 0
	ld b, 14
	ld c, 18
	call Textbox
	ld b, 14
	ld c, 18

	hlcoord 0, 0
	ld b, 2
	ld c, 18
	call Textbox

	farcall DisplayFoeNameAndAbility

	ld de, .FoeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AbilitiesString
	hlcoord 1, 5
	jp PlaceString

.FoeString:
	db "Foe:@"
.AbilitiesString:
	db "Ability Info:@"

StatsInfoBoxLoop:
	push hl
	call CoordsBCtoHL
	ld a, c
	cp 14
	jr nc, .finish
	push bc
	call PlaceString
	pop bc
	ld a, b
	add 4				; b = 6 or 16
	ld b, a
	pop hl
	push de
	ld d, h
	ld e, l
	push hl
	call CoordsBCtoHL
	push bc
	lb bc, 2, 4
	call PrintNum
	pop bc
	pop hl
	pop de
	inc hl
	inc hl
	inc de				; de gets increased to the end of the string in PlaceString, so increase it 1 more for the next string
	ld a, b
	sub 4
	ld b, a
	inc c
	inc c
	jr StatsInfoBoxLoop
.finish
	pop hl
	ret

FieldStatusPagesLayout:
	hlcoord 0, 0
	ld b, 2
	ld c, 18
	call Textbox
	ld b, 10
	ld c, 8
	hlcoord 0, 4
	call Textbox
	ld b, 10
	ld c, 8
	hlcoord 10, 4
	call Textbox
.weather
	hlcoord 6, 0
	ld de, FieldTexts.weather
	call PlaceString
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	ld de, FieldTexts.hail
	jr z, .done
	cp WEATHER_SUN
	ld de, FieldTexts.sun
	jr z, .done
	cp WEATHER_RAIN
	ld de, FieldTexts.rain
	jr z, .done
	cp WEATHER_SANDSTORM
	ld de, FieldTexts.sand
	jr z, .done
	ld de, FieldTexts.none
.done
	hlcoord 1, 1
	call PlaceString
	ld a, [wBattleWeather]
	cp WEATHER_NONE
	jr z, .skip_weather_turns
	ld de, wStringBuffer5
	ld a, [wWeatherCount]
	cp 10
	ld de, FieldTexts.infinite
	jr nc, .not_1_turn
	ld a, [wWeatherCount]
	add "0"
	ld [de], a
	ld a, TX_END
	inc de
	ld [de], a
	ld de, wStringBuffer5
	hlcoord 1, 2
	call PlaceString
	ld a, [wWeatherCount]
	cp 1
	ld de, FieldTexts.turnsleft
	jr nz, .not_1_turn
	ld de, FieldTexts.turnleft
.not_1_turn
	hlcoord 2, 2
	call PlaceString
.skip_weather_turns
	hlcoord 1, 4
	ld de, MainText.player
	call PlaceString	
	hlcoord 11, 4
	ld de, MainText.enemy
	call PlaceString
	lb bc, 1, 5
	ret

FieldInfoBox1:
	call FieldStatusPagesLayout

; spikes
	lb bc, 1, 5
	ld de, FieldTexts.spikes
	call FieldInfoBox1Spikes

; toxic spikes
	lb bc, 1, 6
	ld de, FieldTexts.toxicspikes
	call FieldInfoBox1ToxicSpikes

; sticky web
	lb bc, 1, 7
	ld de, FieldTexts.stickyweb
	call FieldInfoBox1StickyWeb

; stealth rock
	lb bc, 1, 8
	ld de, FieldTexts.stealthrock
	call FieldInfoBox1StealthRock

; toxic
.player_toxic
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr z, .enemy_toxic
	lb bc, 1, 9
	ld de, wPlayerToxicCount
	call FieldInfoBox1Toxic
.enemy_toxic
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr z, .handle_reflect
	lb bc, 11, 9
	ld de, wEnemyToxicCount
	call FieldInfoBox1Toxic

.handle_reflect
; reflect
	lb bc, 1, 11
	call FieldInfoBox1Reflect
; light screen
	lb bc, 1, 13
	jp FieldInfoBox1LScreen

FieldInfoBox2:
	call FieldStatusPagesLayout

; trick room
	lb bc, 1, 5
	call FieldInfoBox2TrickRoom

; safeguard
	lb bc, 1, 7
	call FieldInfoBox2Safeguard

; confused
	ld de, FieldTexts.confused
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr z, .enemy_confuse
	lb bc, 1, 9
	call FieldInfoBoxStatus
.enemy_confuse
	ld a, [wEnemySubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr z, .player_encore
	lb bc, 11, 9
	call FieldInfoBoxStatus

; encored
.player_encore
	ld de, FieldTexts.encored
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_ENCORED, a
	jr z, .enemy_encore
	lb bc, 1, 10
	call FieldInfoBoxStatus
.enemy_encore
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_ENCORED, a
	jr z, .player_disable
	lb bc, 11, 10
	call FieldInfoBoxStatus

; disabled
.player_disable
	ld de, FieldTexts.disabled
	ld a, [wDisabledMove]
	and a
	jr z, .enemy_disable
	lb bc, 1, 11
	call FieldInfoBoxStatus
.enemy_disable
	ld a, [wEnemyDisabledMove]
	and a
	ret z
;	jr z, .player_destiny_bond
	lb bc, 11, 11
	call FieldInfoBoxStatus

; destiny bond
;.player_destiny_bond
	ret
	
	; not working..need to fix	
;	ld de, FieldTexts.destinybond
;	ld a, [wPlayerSubStatus5]
;	bit SUBSTATUS_DESTINY_BOND, a
;	and a
;	jr z, .enemy_destiny_bond
;	lb bc, 1, 12
;	call FieldInfoBoxStatus
;.enemy_destiny_bond
;	ld a, [wEnemySubStatus5]
;	bit SUBSTATUS_DESTINY_BOND, a
;	and a
;	ret z
;	lb bc, 11, 12
;	jp FieldInfoBoxStatus

FieldInfoBox1Reflect: ; input: bc -> coords
	ld hl, wPlayerScreens
	ld de, wPlayerReflectCount
	bit 4, [hl]
	jr z, .enemy
	ld hl, FieldTexts.reflect
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
.enemy
	ld hl, wEnemyScreens
	ld de, wEnemyReflectCount
	bit 4, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	ld hl, FieldTexts.reflect
	jp FieldInfoBoxPlaceElement
	
FieldInfoBox1LScreen: ; input: bc -> coords
	ld hl, wPlayerScreens
	ld de, wPlayerLightScreenCount
	bit 3, [hl]
	jr z, .enemy
	ld hl, FieldTexts.lightscreen
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
.enemy
	ld hl, wEnemyScreens
	ld de, wEnemyLightScreenCount
	bit 3, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	ld hl, FieldTexts.lightscreen
	jp FieldInfoBoxPlaceElement

FieldInfoBox1Spikes: ; input: bc -> coords
	ld hl, wPlayerScreens
	bit 0, [hl]
	jr z, .enemy
	push de
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	pop de
.enemy
	ld hl, wEnemyScreens
	bit 0, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	call CoordsBCtoHL
	jp PlaceString

FieldInfoBox1ToxicSpikes: ; input: bc -> coords
	ld hl, wPlayerScreens
	bit 6, [hl]
	jr z, .enemy
	push de
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	pop de
.enemy
	ld hl, wEnemyScreens
	bit 6, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	call CoordsBCtoHL
	jp PlaceString

FieldInfoBox1StickyWeb: ; input: bc -> coords
	ld hl, wPlayerScreens
	bit 7, [hl]
	jr z, .enemy
	push de
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	pop de
.enemy
	ld hl, wEnemyScreens
	bit 7, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	call CoordsBCtoHL
	jp PlaceString

FieldInfoBox1StealthRock: ; input: bc -> coords
	ld hl, wPlayerScreens
	bit 5, [hl]
	jr z, .enemy
	push de
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	pop de
.enemy
	ld hl, wEnemyScreens
	bit 5, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	call CoordsBCtoHL
	jp PlaceString

FieldInfoBox2TrickRoom: ; input: bc -> coords
	ld de, wTrickRoomCount
	ld a, [de]
    and a
	ret z
	ld hl, FieldTexts.trickroom
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
.enemy
	ld a, b
	add 10
	ld b, a
	ld de, wTrickRoomCount
	ld hl, FieldTexts.trickroom
	jp FieldInfoBoxPlaceElement

FieldInfoBox2Safeguard:
	ld hl, wPlayerScreens
	ld de, wPlayerSafeguardCount
	bit 2, [hl]
	jr z, .enemy
	ld hl, FieldTexts.safeguard
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
.enemy
	ld hl, wEnemyScreens
	ld de, wEnemySafeguardCount
	bit 2, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	ld hl, FieldTexts.safeguard
	jp FieldInfoBoxPlaceElement

FieldInfoBoxStatus: ; input: bc -> coords, de -> text
	push de
	call CoordsBCtoHL
	call PlaceString
	pop de
	ret
	
FieldInfoBox1Toxic: ; input: bc -> coords , de -> count
	ld hl, FieldTexts.toxic
	push hl
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
	pop hl
	ret
	
FieldInfoBoxPlaceElement: ; input: bc -> coords, hl -> Field text, de -> Count
	push de
	ld d, h
	ld e, l
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	inc c
	call CoordsBCtoHL
	pop de
	push de
	ld a, [de]
	ld de, wStringBuffer5
	add "0"
	ld [de], a
	ld a, TX_END
	inc de
	ld [de], a
	dec de
	push bc
	call PlaceString
	pop bc
	pop de
	ld a, [de]
	cp 1
	ld de, FieldTexts.turns
	jr nz, .not_1_turn
	ld de, FieldTexts.turn
.not_1_turn
	inc b
	call CoordsBCtoHL
	jp PlaceString

MainText:
.page1:
	db "  Page 1/5 ▶@" ; first page has no ◀
.page1_content:
	db " Stat Changes @"

.page2:
	db "◀ Page 2/5 ▶@"
.page2_content:
	db " Actual Stats @"

.page3:
	db "◀ Page 3/5 ▶@"
.page3_content:
	db "Field/Status 1@"

.page4:
	db "◀ Page 4/5 ▶@"
.page4_content:
	db "Field/Status 2@"

.page5:
	db "◀ Page 5/5  @" ; last page has no ▶
.page5_content:
	db "   Ability    @"

.player:
	db " Player @"
	
.enemy:
	db " Enemy @"

StatTexts:
.health:
	db "HP:  @"

.attack:
	db "Atk: @"

.defense:
	db "Def: @"

.speed:
	db "Spe: @"
	
.sattack:
	db "SAtk:@"
	
.sdefense:
	db "SDef:@"
	
.accuracy:
	db "Acc: @"
	
.evasiveness:
	db "Eva:@"

FieldTexts:
.weather:
	db " Weather @"
	
.none:
	db "Normal@"
	
.sun:
	db "Sunny@"

.rain:
	db "Rain@"
	
.sand:
	db "Sandstorm@"
	
.hail:
	db "Hail@"
	
.spikes:
	db "Spikes@"

.toxicspikes:
	db "T.Spikes@"

.stickyweb:
	db "S.Web@"

.stealthrock:
	db "S.Rock@"

.toxic:
	db "Toxic@"

.reflect:
	db "Reflect@"
	
.lightscreen:
	db "L.Screen@"

.trickroom:
	db "T.Room@"

.safeguard:
	db "S.Guard@"

.confused:
	db "Confused@"
	
.encored:
	db "Encored@"
	
.disabled:
	db "Disabled@"

;.destinybond:
;	db "D.Bonded@"

.turnsleft:
	db " turns left@"

.turnleft:
	db " turn left@"

.infinite:
	db "@"
	
.turns:
	db " turns@"

.turn:
	db " turn@"

JoyWaitAorBorDPADInfoTrainer:
.loop
	call DelayFrame
	call GetJoypad
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON
	ret nz
	ldh a, [hJoyPressed]
	and D_RIGHT
	call nz, InfoBoxRightPress
	ldh a, [hJoyPressed]
	and D_LEFT
	call nz, InfoBoxLeftPress
	call UpdateTimeAndPals
	jr .loop

WaitButtonInfoTrainer:
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call WaitBGMap
	call JoyWaitAorBorDPADInfoTrainer
	pop af
	ldh [hOAMUpdate], a
	ret
	
; ========================
; Left button navigation
; ========================
InfoBoxLeftPress:
	ld a, [wTrainerInfoPage]
	cp 0
	ret z                    ; On page 1, pressing left does nothing
	cp 1
	jr z, .jump_to_page_1
	cp 2
	jr z, .jump_to_page_2
	cp 3
	jr z, .jump_to_page_3
	cp 4
	ret nz
	call DecreasePage
	call UpdatePageText
	jp FieldInfoBox2

.jump_to_page_1
	call DecreasePage
	call UpdatePageText
	jp StatsInfoBox

.jump_to_page_2
	call DecreasePage
	call UpdatePageText
	jp StatChangesInfoBox

.jump_to_page_3
	call DecreasePage
	call UpdatePageText
	jp FieldInfoBox1

; ========================
; Right button navigation
; ========================
InfoBoxRightPress:
	ld a, [wTrainerInfoPage]
	cp 0
	jr z, .jump_to_page_2
	cp 1
	jr z, .jump_to_page_3
	cp 2
	jr z, .jump_to_page_4
	cp 3
	ret nz
	call IncreasePage
	call UpdatePageText
	jp FoeAbilityPageInfoBox		; On page 5, pressing right does nothing

.jump_to_page_2
	call IncreasePage
	call UpdatePageText
	jp StatChangesInfoBox

.jump_to_page_3
	call IncreasePage
	call UpdatePageText
	jp FieldInfoBox1

.jump_to_page_4
	call IncreasePage
	call UpdatePageText
	jp FieldInfoBox2
	
; ========================
; Page counter functions
; ========================
IncreasePage:
	ld a, [wTrainerInfoPage]
	inc a
	cp 5                     ; Pages 0..5 (inclusive)
	jr c, .store
	xor a                    ; Wrap to page 0
.store
	ld [wTrainerInfoPage], a
	ret

DecreasePage:
	ld a, [wTrainerInfoPage]
	or a
	jr nz, .dec
	ld a, 5                  ; Wrap to last page
.dec
	dec a
	ld [wTrainerInfoPage], a
	ret

; ========================
; Update text for each page
; ========================
UpdatePageText:
	hlcoord 4, 17
	ld a, [wTrainerInfoPage]

	cp 1
	jr z, .page_2
	cp 2
	jr z, .page_3
	cp 3
	jr z, .page_4
	cp 4
	jr z, .page_5

; Default: page 0
	ld de, MainText.page1
	call PlaceString
	ld de, MainText.page1_content
	jr .done

.page_2
	ld de, MainText.page2
	call PlaceString
	ld de, MainText.page2_content
	jr .done

.page_3
	ld de, MainText.page3
	call PlaceString
	ld de, MainText.page3_content
	jr .done

.page_4
	ld de, MainText.page4
	call PlaceString
	ld de, MainText.page4_content
	jr .done

.page_5
	ld de, MainText.page5
	call PlaceString
	ld de, MainText.page5_content
.done
	hlcoord 4, 16
	jp PlaceString

CoordsBCtoHL:
	ld hl, wTilemap
	ld a, c
	push bc
	ld c, SCREEN_WIDTH
	call HLMultiply
	pop bc
	ld a, b
	add l
	ld l, a
	ret nc
	inc h
	ret

HLMultiply:
; Returns hl + a * c
	and a
	ret z
	
	push bc
	ld b, a
	xor a
.loop
	add c
	jr nc, .nocarry
	inc h
.nocarry
	dec b
	jr nz, .loop
	ld c, a
	add hl, bc
	pop bc
	ret
