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
    jr nz, .notSelf
    ld a, [wCurPartyMon]
	ld hl, wOTPartyMon1DVs
	call GetPartyLocation
	ld b, [hl]
	inc hl
	ld c, [hl]
.notSelf
    ret
