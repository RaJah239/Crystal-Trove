AIScoring: ; used only for BANK(AIScoring)

SubstituteImmuneEffects:
	db $01 ; unused sleep effect
	db EFFECT_SLEEP
	db EFFECT_POISON
	db EFFECT_PARALYZE
	db EFFECT_CONFUSE
	db EFFECT_LEECH_SEED
	db EFFECT_ACCURACY_DOWN
	db EFFECT_DEFENSE_DOWN
	db EFFECT_DEFENSE_DOWN_2
	db EFFECT_ATTACK_DOWN
	db EFFECT_SPEED_DOWN_2
	db EFFECT_TRANSFORM
	db EFFECT_TOXIC
	db EFFECT_BURN
	db $FF

AI_UberImmunePokemon:
    db MEWTWO
    db LUGIA
    db HO_OH
    db WOBBUFFET
    db $FF

;===============================+
; Add the remainder if missing  |
;===============================+
BoostingMoveEffects:
	db EFFECT_ATTACK_UP_2
	db EFFECT_SP_ATK_UP
	db EFFECT_SP_ATK_UP_2
	db EFFECT_SUBSTITUTE
	db EFFECT_CURSE
	db EFFECT_CALM_MIND
	db EFFECT_BULK_UP
	db EFFECT_DRAGON_DANCE
	db EFFECT_QUIVER_DANCE
	db -1

AI_SturdyPokemon:
    db SKARMORY
    db GEODUDE
    db GRAVELER
    db GOLEM
    db MAGNEMITE
    db MAGNETON
    db ONIX
    db STEELIX
    db SQUIRTLE
    db WARTORTLE
    db BLASTOISE
    db METAPOD
    db LARVITAR
    db PUPITAR
    db PINSIR
    db $FF

AI_MagicGuardPokemon:
    db CLEFAIRY
    db CLEFABLE
    db ABRA
    db KADABRA
    db ALAKAZAM
    db $FF

; Needs to be the same as `Core_LevitatePokemon` and `FloatMons`
AI_LevitatePokemon:
	db BEEDRILL
	db BUTTERFREE
	db VENOMOTH
	db MAGNEMITE
	db MAGNETON
	db GASTLY
	db HAUNTER
	db GENGAR
	db KOFFING
	db WEEZING
	db MEW
	db MISDREAVUS
	db UNOWN
	db CELEBI
	db CHARIZARD
    db $FF

AI_WaterAbsorbPokemon:
    db VAPOREON
    db POLIWAG
    db POLIWHIRL
    db POLIWRATH
    db LAPRAS
    db $FF

AI_VoltAbsorbPokemon:
    db CHINCHOU
    db LANTURN
    db ELECTABUZZ
    db ZAPDOS
    db JOLTEON
    db PIKACHU
    db RAICHU
    db MAREEP
    db FLAAFFY
    db AMPHAROS
    db RAIKOU
    db $FF

AI_FireAbsorbPokemon:
    db MAGMAR
    db FLAREON
    db MOLTRES
    db VULPIX
    db NINETALES
    db HOUNDOUR
    db HOUNDOOM
    db GROWLITHE
    db ARCANINE
    db $FF

AI_Basic:
; Don't do anything redundant:
;  -Using status-only moves if the player can't be statused
;  -Using moves that fail if they've already been used

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b ; b is num moves on 1st pass
	ret z ; if b os 0 return we are done

	inc hl ; increment score to next move score
	ld a, [de] ; load the move struct
	and a
	ret z ; return if no move

	inc de ; increment to next move
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld c, a ; load move effect into c

; Dismiss moves with special effects if they are
; useless or not a good choice right now.
; For example, healing moves, weather moves, Dream Eater...

; if move locked dismiss all moves except the last one used
; this shouldn't be needed but for some reason AI enemies can switch moves when locked
    push hl
    ld hl, wEnemySubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	pop hl
	jr z, .checkRedundant
    ld a, [wLastEnemyMove]
    and a
    jr z, .checkRedundant
    push bc
    ld b, a
    ld a, [wEnemyMoveStruct + MOVE_ANIM]
    cp b
    pop bc
    jp nz, .checkRedundant
    xor a
    ld [hl], a ; set priority for last used move to max - which is 0
    jp .checkmove

.checkRedundant
	push hl
	push de
	push bc
	farcall AI_Redundant
	pop bc
	pop de
	pop hl
	jp nz, .discourage ; discourage if AI_Redundant - loop bck to check move

; DevNote - Taunt - Check enemy is taunted or holding assault vest and discourage 0 power moves
    ld a, [wEnemyTauntCount]
    and a
    jr nz, .discourageNonDamagingMoves
    ld a, [wEnemyMonItem]
    cp ASSAULT_VEST
    jr nz, .checkStatusImmunity
.discourageNonDamagingMoves
    ld a, [wEnemyMoveStruct + MOVE_POWER]
    and a
    jp z, .discourage

; Dismiss status-only moves if the player can't be statused.
.checkStatusImmunity
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	push hl
	push de
	push bc
	ld hl, StatusOnlyEffects
	ld de, 1
	call IsInArray ; is the move status only
	pop bc
	pop de
	pop hl
	jr nc, .checkSub ; if not skip following

	ld a, [wBattleMonStatus]
	and a
	jp nz, .discourage ; discourage if the player is already statused - loop back to check move

; don't use if enemy is immune to status
    ld a, [wBattleMonSpecies]
;	cp ARCEUS
;	jp z, .discourage
;	cp SYLVEON
;	jp z, .discourage
	cp DUNSPARCE
	jp z, .discourage

.checkSub
; dismiss moves blocked by sub if sub is up
    ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a	;check for substitute bit
	jr z, .checkLevitate	;if the substitute bit is not set, then skip out of this block
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	push hl
	push de
	push bc
	ld hl, SubstituteImmuneEffects
	ld de, 1
	call IsInArray	;see if a is found in the hl array (carry flag set if true)
	pop bc
	pop de
	pop hl
	jp c, .discourage ; discourage if sub is up and blocks move - loop back to check move

.checkLevitate
; Dismiss ground move if the player has levitate
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	cp GROUND
	jr nz, .checkWaterAbsorb
	ld a, [wBattleMonSpecies]
    call DoesPokemonHaveLevitate
    jp c, .discourage

.checkWaterAbsorb
    cp WATER
	jr nz, .checkVoltAbsorb

	ld a, [wBattleMonSpecies]
    call DoesPokemonHaveWaterAbsorb
    jp c, .discourage

.checkVoltAbsorb
    cp ELECTRIC
	jr nz, .checkFireAbsorb
	ld a, [wBattleMonSpecies]
    call DoesPokemonHaveVoltAbsorb
    jp c, .discourage

.checkFireAbsorb
    cp FIRE
	jp nz, .checkKO
	ld a, [wBattleMonSpecies]
    call DoesPokemonHaveFireAbsorb
    jp c, .discourage

; Dismiss Safeguard if it's already active.
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jp z, .checkmove

.checkKO
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jp z, .checkmove

; if we are faster and player is flying or underground then don't encourage attacks
    call DoesAIOutSpeedPlayer
    jr nc, .calcDamage
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jp nz, .checkmove

.calcDamage
    ld a, 1
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wBattleMonHP + 1]
	cp c ; compare upper
	ld a, [wBattleMonHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
    jp nc, .checkmove

; don't encourage explosion as much
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .explodeOrHeal

; Rock Head users
; don't encourage recoil moves as much
    ld a, [wEnemyMonSpecies]
    cp AERODACTYL
    jr z, .skipRecoilCheck
    cp MOLTRES
    jr z, .skipRecoilCheck
;	cp REGIGIGAS
;	jr z, .skipRecoilCheck
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_RECOIL_HIT
	jr z, .recoil

.skipRecoilCheck
; if we are below 1/4 hp and have a healing move then lesser encourage so we can use it
    call AICheckEnemyQuarterHP
    jr c, .checkAcc
	ld b, EFFECT_HEAL
	call AIHasMoveEffect
	jr c, .explodeOrHeal

.checkAcc
; encourage more accurate moves if they can kill
	ld a, [wEnemyMoveStruct + MOVE_ACC]
	cp 100 percent
	jr c, .notAcc

; encouragements to KO enemy
; standard attack = 9
; recoil attack = 7
; inaccurate attack = 5
; explode attack = 3
	dec [hl]
	dec [hl]
.recoil
	dec [hl]
	dec [hl]
.notAcc
	dec [hl]
    dec [hl]
.explodeOrHeal
    dec [hl]
    dec [hl]
    dec [hl]
    jp .checkmove

.discourage
	call AIDiscourageMove
	jp .checkmove

INCLUDE "data/battle/ai/status_only_effects.asm"

AI_Smart_Switch:
; Enemies can switch intelligently under certain conditions
; switch if unboosted enemy is SLP and player sets up
; 50% chance to switch if unboosted enemy is SLP and player sets up
; switch if choice locked into a Not Very Effective move
; switch if locked into a move with 0 pp
; switch if enemy accuracy at -2 or lower
; switch if enemy attack at -2 or lower and has unboosted special attack
; switch if enemy is cursed
; 50% chance to switch if enemy afflicted with toxic
; 50% chance to switch if enemy afflicted with leech seed

; possibly switch if enemy is setup bait
	ld a, [wEnemyMonStatus]
	and SLP_MASK
	jp nz, .checkSetupAndSwitchIfPlayerSetsUp

; switch if choice locked into a NVE move
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	jr z, .not_encored
    push hl
	ld a, 1
	ldh [hBattleTurn], a
	ld a, [wCurEnemyMove]
	call AIGetEnemyMove
	callfar BattleCheckTypeMatchup
	pop hl
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	jp c, .switch
	and a
	jp z, .switch

; switch if locked into a move with 0 pp
	ld hl, wEnemyMonPP
	ld a, [wCurEnemyMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jr z, .switch
.not_encored

; don't switch if enemy is weakened, just let it die
	call AICheckEnemyQuarterHP
	ret nc

; switch if enemy accuracy at -2 or lower
    ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .switch

; switch if enemy attack or special attack at -2 or lower, unless the other offense is boosted
    ld a, [wEnemyAtkLevel]
    cp BASE_STAT_LEVEL + 1
    jr nc, .magicGuard
    ld a, [wEnemySAtkLevel]
    cp BASE_STAT_LEVEL + 1
    jr nc, .magicGuard
    ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .checkSetupAndSwitchIfWeCantKO
    ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .checkSetupAndSwitchIfWeCantKO

.magicGuard
; Pokemon who are immune to residual damage (magic guard) should not be considered
    ld a, [wEnemyMonSpecies]
    call DoesPokemonHaveMagicGuard
	ret c

; switch if enemy is cursed
    ld a, [wEnemySubStatus1]
	bit SUBSTATUS_CURSE, a
	jr nz, .checkSetupAndSwitchIfWeCantKO

; if enemy afflicted with toxic
; 50% chance to switch when above 50% hp if not set up
; switch when below 50% hp
    ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TOXIC, a
    jr z, .checkLeechSeed
	call AICheckEnemyHalfHP
	jr nc, .checkSetupAndSwitchIfWeCantKO
	call AI_50_50
	jr c, .checkLeechSeed
	jr .checkSetupAndSwitchIfWeCantKO

.checkLeechSeed
; 30% chance to switch per turn if enemy afflicted with leech seed
    ld a, [wEnemySubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	ret z
	call Random
	cp 70 percent + 1
	ret c
	jr .checkSetupAndSwitchIfWeCantKO

.checkSetupAndSwitchIfPlayerSetsUp
; don't switch if enemy mon is already set up
    call IsAISetup
    ret c
; switch if player attempts to set up
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
    push hl
    push de
	push bc
	ld hl, BoostingMoveEffects
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr c, .switch
	ret
	
.checkSetupAndSwitchIfWeCantKO
    call CanAIKO
    ret c
    call IsAISetup
    ret c
    ; fallthrough
.switch
; can't switch if trapped
	ld a, [wBattleMonSpecies]

; Shadow Tag users
	cp WOBBUFFET
	ret z
;	cp CHANDELURE
;	ret z
;	cp SPIRITOMB
;	ret z
;	cp GIRATINA
;	ret z

    ld a, $1
    ld [wEnemyIsSwitching], a
	ret

; DevNote - this is removed because this was stupid and will not be used
AI_Setup:
	ret

; DevNote - this is commented out because this is made redundant by AI_Aggressive
AI_Types:
; Dismiss any move that the player is immune to.
; Encourage super-effective moves.
; Discourage not very effective moves unless
; all damaging moves are of the same type.
;
;	ld hl, wEnemyAIMoveScores - 1
;	ld de, wEnemyMonMoves
;	ld b, NUM_MOVES + 1
;.checkmove
;	dec b
;	ret z
;
;	inc hl
;	ld a, [de]
;	and a
;	ret z
;
;	inc de
;	call AIGetEnemyMove
;
;	push hl
;	push bc
;	push de
;	ld a, 1
;	ldh [hBattleTurn], a
;	callfar BattleCheckTypeMatchup
;	pop de
;	pop bc
;	pop hl
;
;	ld a, [wTypeMatchup]
;	and a
;	jr z, .immune
;	cp EFFECTIVE
;	jr z, .checkmove
;	jr c, .noteffective
;
; effective
;	ld a, [wEnemyMoveStruct + MOVE_POWER]
;	and a
;	jr z, .checkmove
;	dec [hl]
;	jr .checkmove
;
;.noteffective
; Discourage this move if there are any moves
; that do damage of a different type.
;	push hl
;	push de
;	push bc
;	ld a, [wEnemyMoveStruct + MOVE_TYPE]
;	and TYPE_MASK
;	ld d, a
;	ld hl, wEnemyMonMoves
;	ld b, NUM_MOVES + 1
;	ld c, 0
;.checkmove2
;	dec b
;	jr z, .movesdone
;
;	ld a, [hli]
;	and a
;	jr z, .movesdone
;
;	call AIGetEnemyMove
;	ld a, [wEnemyMoveStruct + MOVE_TYPE]
;	and TYPE_MASK
;	cp d
;	jr z, .checkmove2
;	ld a, [wEnemyMoveStruct + MOVE_POWER]
;	and a
;	jr nz, .damaging
;	jr .checkmove2
;
;.damaging
;	ld c, a
;.movesdone
;	ld a, c
;	pop bc
;	pop de
;	pop hl
;	and a
;	jr z, .checkmove
;	inc [hl]
;	jr .checkmove
;
;.immune
;	call AIDiscourageMove
;	jr .checkmove

; DevNote - this is commented out because it is stupid and wont be used
AI_Offensive:
	ret
; Greatly discourage non-damaging moves.
;
;	ld hl, wEnemyAIMoveScores - 1
;	ld de, wEnemyMonMoves
;	ld b, NUM_MOVES + 1
;.checkmove
;	dec b
;	ret z
;
;	inc hl
;	ld a, [de]
;	and a
;	ret z
;
;	inc de
;	call AIGetEnemyMove
;
;	ld a, [wEnemyMoveStruct + MOVE_POWER]
;	and a
;	jr nz, .checkmove
;
;	inc [hl]
;	inc [hl]
;	jr .checkmove


AI_Smart:
; Context-specific scoring.

	ld hl, wEnemyAIMoveScores
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push de
	push bc
	push hl
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld hl, AI_Smart_EffectHandlers
	ld de, 3
	call IsInArray

	inc hl
	jr nc, .nextmove

	ld a, [hli]
	ld e, a
	ld d, [hl]

	pop hl
	push hl

	ld bc, .nextmove
	push bc

	push de
	ret

.nextmove
	pop hl
	pop bc
	pop de
	inc hl
	jr .checkmove

AI_Smart_EffectHandlers:
	dbw EFFECT_SLEEP,            AI_Smart_Sleep ; updated
	dbw EFFECT_LEECH_HIT,        AI_Smart_LeechHit
	dbw EFFECT_SELFDESTRUCT,     AI_Smart_Selfdestruct ; updated
	dbw EFFECT_DREAM_EATER,      AI_Smart_DreamEater
	dbw EFFECT_EVASION_UP,       AI_Smart_EvasionUp
	dbw EFFECT_ALWAYS_HIT,       AI_Smart_AlwaysHit
	dbw EFFECT_ACCURACY_DOWN,    AI_Smart_AccuracyDown
	dbw EFFECT_RESET_STATS,      AI_Smart_ResetStats
	dbw EFFECT_FORCE_SWITCH,     AI_Smart_ForceSwitch
	dbw EFFECT_HEAL,             AI_Smart_Heal
	dbw EFFECT_TOXIC,            AI_Smart_Toxic
	dbw EFFECT_LIGHT_SCREEN,     AI_Smart_LightScreen
	dbw EFFECT_OHKO,             AI_Smart_Ohko
	dbw EFFECT_RAZOR_WIND,       AI_Smart_RazorWind
	dbw EFFECT_SUPER_FANG,       AI_Smart_SuperFang
	dbw EFFECT_TRAP_TARGET,      AI_Smart_TrapTarget
	dbw EFFECT_UNUSED_2B,        AI_Smart_Unused2B
	dbw EFFECT_CONFUSE,          AI_Smart_Confuse
	dbw EFFECT_SP_DEF_UP_2,      AI_Smart_SpDefenseUp2
	dbw EFFECT_REFLECT,          AI_Smart_Reflect
	dbw EFFECT_PARALYZE,         AI_Smart_Paralyze
	dbw EFFECT_SPEED_DOWN_HIT,   AI_Smart_SpeedDownHit
	dbw EFFECT_SUBSTITUTE,       AI_Smart_Substitute
	dbw EFFECT_HYPER_BEAM,       AI_Smart_HyperBeam
	dbw EFFECT_RAGE,             AI_Smart_Rage
	dbw EFFECT_MIMIC,            AI_Smart_Mimic
	dbw EFFECT_LEECH_SEED,       AI_Smart_LeechSeed
	dbw EFFECT_DISABLE,          AI_Smart_Disable
	dbw EFFECT_COUNTER,          AI_Smart_Counter
	dbw EFFECT_ENCORE,           AI_Smart_Encore
	dbw EFFECT_PAIN_SPLIT,       AI_Smart_PainSplit
	dbw EFFECT_SNORE,            AI_Smart_Snore
	dbw EFFECT_CONVERSION2,      AI_Smart_Conversion2
	dbw EFFECT_LOCK_ON,          AI_Smart_LockOn
	dbw EFFECT_SLEEP_TALK,       AI_Smart_SleepTalk
	dbw EFFECT_DESTINY_BOND,     AI_Smart_DestinyBond
	dbw EFFECT_REVERSAL,         AI_Smart_Reversal
	dbw EFFECT_SPITE,            AI_Smart_Spite
	dbw EFFECT_HEAL_BELL,        AI_Smart_HealBell
	dbw EFFECT_PRIORITY_HIT,     AI_Smart_PriorityHit
	dbw EFFECT_THIEF,            AI_Smart_Thief
	dbw EFFECT_MEAN_LOOK,        AI_Smart_MeanLook
	dbw EFFECT_NIGHTMARE,        AI_Smart_Nightmare
	dbw EFFECT_CURSE,            AI_Smart_Curse
	dbw EFFECT_PROTECT,          AI_Smart_Protect
	dbw EFFECT_FORESIGHT,        AI_Smart_Foresight
	dbw EFFECT_PERISH_SONG,      AI_Smart_PerishSong
	dbw EFFECT_SANDSTORM,        AI_Smart_Sandstorm
	dbw EFFECT_ENDURE,           AI_Smart_Endure
	dbw EFFECT_ROLLOUT,          AI_Smart_Rollout
	dbw EFFECT_SWAGGER,          AI_Smart_Swagger
	dbw EFFECT_ATTRACT,          AI_Smart_Attract
	dbw EFFECT_SAFEGUARD,        AI_Smart_Safeguard
	dbw EFFECT_MAGNITUDE,        AI_Smart_Magnitude
	dbw EFFECT_BATON_PASS,       AI_Smart_BatonPass
	dbw EFFECT_PURSUIT,          AI_Smart_Pursuit
	dbw EFFECT_RAPID_SPIN,       AI_Smart_RapidSpin
	dbw EFFECT_WEATHER_HEAL,     AI_Smart_Heal
	dbw EFFECT_HIDDEN_POWER,     AI_Smart_HiddenPower
	dbw EFFECT_RAIN_DANCE,       AI_Smart_RainDance
	dbw EFFECT_SUNNY_DAY,        AI_Smart_SunnyDay
	dbw EFFECT_BELLY_DRUM,       AI_Smart_BellyDrum
	dbw EFFECT_MIRROR_COAT,      AI_Smart_MirrorCoat
	dbw EFFECT_EARTHQUAKE,       AI_Smart_Earthquake
	dbw EFFECT_GUST,             AI_Smart_Gust
	dbw EFFECT_STOMP,            AI_Smart_Stomp
	dbw EFFECT_SOLARBEAM,        AI_Smart_Solarbeam
	dbw EFFECT_THUNDER,          AI_Smart_Thunder
	dbw EFFECT_FLY,              AI_Smart_Fly
	dbw EFFECT_HAIL,             AI_Smart_Hail
	dbw EFFECT_FACADE,           AI_Smart_Facade
	dbw EFFECT_HEX,              AI_Smart_Hex
	dbw EFFECT_HURRICANE,        AI_Smart_Hurricane
	db -1 ; end

AI_Smart_Facade:
; Greatly encourage this move if the player has a status condition.

	ld a, [wEnemyMonStatus]
	and a
	ret z
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_Hex:
; Greatly encourage this move if the player has a status condition.

	ld a, [wBattleMonStatus]
	and a
	ret z
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_Sleep:
; don't use if there already is a status
    ld a, [wBattleMonStatus]
    and a
    jp nz, .discourage

; never use if player has substitute
    ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jp nz, .discourage

; never use if player has safeguard
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jr nz, .discourage

; don't use against status immune pokemon
    ld a, [wBattleMonSpecies]
    cp DUNSPARCE
    jp z, .discourage
    cp SMEARGLE
    jp z, .discourage

; does player have a held item that would heal sleep
	push hl
	push de
	ld a, [wBattleMonItem]
	ld [wNamedObjectIndex], a
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_HEAL_STATUS
	pop de
	pop hl
	jr nz, .noItem

; if faster than the player, don't sleep if the player can 1hko
    call DoesAIOutSpeedPlayer
    jr nc, .playerMovesFirst
    call CanPlayerKO
    jr c, .discourage
    jr .noItem

; if slower than the player, don't sleep if player can 2hko
.playerMovesFirst
    call CanPlayer2HKO
    jr c, .discourage

.noItem
; check if the move is Spore
	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	cp SPORE
	jr nz, .notSpore
	jr .useMove

.notSpore
; if faster then continue
	call DoesAIOutSpeedPlayer
	jr c, .continue

; discourage if faster player has picked substitute
	ld a, [wCurPlayerMove]
	cp SUBSTITUTE
	jr nc, .continue
	inc [hl]
	inc [hl]
	inc [hl]
	ret

.continue
	ld b, EFFECT_DREAM_EATER
	call AIHasMoveEffect
	jr c, .encourage50

	ld b, EFFECT_NIGHTMARE
	call AIHasMoveEffect
	ret nc

; Pokemon with Bad Dreams ability should prioritise sleep more
    ld a, [wEnemyMonSpecies]
;	cp DARKRAI
;	jr z, .encourage50
    cp JYNX
    jr z, .encourage50

.discourage
    inc [hl]
    inc [hl]
    ret
.encourage50
	call AI_50_50
	ret c
.useMove
rept 12
    dec [hl]
endr
    ret

AI_Smart_LeechHit:
	push hl
	ld a, 1
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup
	pop hl

; 60% chance to discourage this move if not very effective.
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	jr c, .discourage

; Do nothing if effectiveness is neutral.
	ret z

; Do nothing if enemy's HP is full.
	call AICheckEnemyMaxHP
	ret c

; 80% chance to encourage this move otherwise.
	call AI_80_20
	ret c

	dec [hl]
	ret

.discourage
	call Random
	cp 39 percent + 1
	ret c

	inc [hl]
	ret

AI_Smart_LockOn:
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_LOCK_ON, a
	jr nz, .player_locked_on

	push hl
	call AICheckEnemyQuarterHP
	jr nc, .discourage

	call AICheckEnemyHalfHP
	jr c, .skip_speed_check

	call AICompareSpeed
	jr nc, .discourage

.skip_speed_check
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 3
	jr nc, .maybe_encourage
	cp BASE_STAT_LEVEL + 1
	jr nc, .do_nothing

	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL - 2
	jr c, .maybe_encourage
	cp BASE_STAT_LEVEL
	jr c, .do_nothing

	ld hl, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.checkmove
	dec c
	jr z, .discourage

	ld a, [hli]
	and a
	jr z, .discourage

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_ACC]
	cp 71 percent - 1
	jr nc, .checkmove

	ld a, 1
	ldh [hBattleTurn], a

	push hl
	push bc
	farcall BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	pop bc
	pop hl
	jr c, .checkmove

.do_nothing
	pop hl
	ret

.discourage
	pop hl
	inc [hl]
	ret

.maybe_encourage
	pop hl
	call AI_50_50
	ret c

	dec [hl]
	dec [hl]
	ret

.player_locked_on
	push hl
	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1

.checkmove2
	inc hl
	dec c
	jr z, .dismiss

	ld a, [de]
	and a
	jr z, .dismiss

	inc de
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_ACC]
	cp 71 percent - 1
	jr nc, .checkmove2

	dec [hl]
	dec [hl]
	jr .checkmove2

.dismiss
	pop hl
	jp AIDiscourageMove

AI_Smart_Selfdestruct:
; Selfdestruct, Explosion

; never use against ghost types
    ld a, [wBattleMonType1]
	cp GHOST
	jr z, .discourage
	ld a, [wBattleMonType2]
	cp GHOST
	jr z, .discourage

; Unless this is the enemy's last Pokemon...
	push hl
	farcall FindAliveEnemyMons
	pop hl
	jr nc, .notlastmon

; ...greatly discourage this move unless this is the player's last Pokemon too.
	push hl
	call AICheckLastPlayerMon
	pop hl
	jr nz, .discourage

.notlastmon
; don't use if player is behind a sub
    ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a	;check for substitute bit
	jr nz, .discourage

; don't use if player has protect
	ld b, EFFECT_PROTECT
	call PlayerHasMoveEffect
	jr c, .discourage

; don't use if player is faster and has - substitute, fly, dig
	call DoesAIOutSpeedPlayer
	jr c, .faster
	ld b, EFFECT_SUBSTITUTE
	call PlayerHasMoveEffect
	jr c, .discourage
	ld b, EFFECT_FLY
	call PlayerHasMoveEffect
	jr c, .discourage

.faster
; if enemy's HP is below 25% just boom
	call AICheckEnemyQuarterHP
	jr nc, .encourage

; use if we are about to be KOd
    call ShouldAIBoost
    jr nc, .encourage

.continue
; Greatly discourage this move if enemy's HP is above 50%.
	call AICheckEnemyHalfHP
	jr c, .discourage

; if we are here we are below 1/2 hp and player is non boosted
; if we have no other move that can ko the player just boom

.encourage
    dec [hl]
    ret
.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_DreamEater:
; 90% chance to greatly encourage this move.
; The AI_Basic layer will make sure that
; Dream Eater is only used against sleeping targets.
	call Random
	cp 10 percent
	ret c
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_EvasionUp:
; Dismiss this move if enemy's evasion can't raise anymore.
	ld a, [wEnemyEvaLevel]
	cp MAX_STAT_LEVEL
	jp nc, AIDiscourageMove

; If enemy's HP is full...
	call AICheckEnemyMaxHP
	jr nc, .hp_mismatch_1

; ...greatly encourage this move if player is badly poisoned.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .greatly_encourage

; ...70% chance to greatly encourage this move if player is not badly poisoned.
	call Random
	cp 70 percent
	jr nc, .not_encouraged

.greatly_encourage
	dec [hl]
	dec [hl]
	ret

.hp_mismatch_1

; Greatly discourage this move if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	jr nc, .hp_mismatch_2

; If enemy's HP is above 25% but not full, 4% chance to greatly encourage this move.
	call Random
	cp 4 percent
	jr c, .greatly_encourage

; If enemy's HP is between 25% and 50%,...
	call AICheckEnemyHalfHP
	jr nc, .hp_mismatch_3

; If enemy's HP is above 50% but not full, 20% chance to greatly encourage this move.
	call AI_80_20
	jr c, .greatly_encourage
	jr .not_encouraged

.hp_mismatch_3
; ...50% chance to greatly discourage this move.
	call AI_50_50
	jr c, .not_encouraged

.hp_mismatch_2
	inc [hl]
	inc [hl]

; 30% chance to end up here if enemy's HP is full and player is not badly poisoned.
; 77% chance to end up here if enemy's HP is above 50% but not full.
; 96% chance to end up here if enemy's HP is between 25% and 50%.
; 100% chance to end up here if enemy's HP is below 25%.
; In other words, we only end up here if the move has not been encouraged or dismissed.
.not_encouraged
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .maybe_greatly_encourage

	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .maybe_encourage

; Discourage this move if enemy's evasion level is higher than player's accuracy level.
	ld a, [wEnemyEvaLevel]
	ld b, a
	ld a, [wPlayerAccLevel]
	cp b
	jr c, .discourage

	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_ROLLOUT, a
	jr nz, .greatly_encourage

.discourage
	inc [hl]
	ret

; Player is badly poisoned.
; 70% chance to greatly encourage this move.
; This would counter any previous discouragement.
.maybe_greatly_encourage
	call Random
	cp 31 percent + 1
	ret c

	dec [hl]
	dec [hl]
	ret

; Player is seeded.
; 50% chance to encourage this move.
; This would partly counter any previous discouragement.
.maybe_encourage
	call AI_50_50
	ret c

	dec [hl]
	ret

AI_Smart_AlwaysHit:
; 80% chance to greatly encourage this move if either...

; ...enemy's accuracy level has been lowered three or more stages
	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL - 2
	jr c, .encourage

; ...or player's evasion level has been raised three or more stages.
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 3
	ret c

.encourage
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_AccuracyDown:
; If player's HP is full...
	call AICheckPlayerMaxHP
	jr nc, .hp_mismatch_1

; ...and enemy's HP is above 50%...
	call AICheckEnemyHalfHP
	jr nc, .hp_mismatch_1

; ...greatly encourage this move if player is badly poisoned.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .greatly_encourage

; ...70% chance to greatly encourage this move if player is not badly poisoned.
	call Random
	cp 70 percent
	jr nc, .not_encouraged

.greatly_encourage
	dec [hl]
	dec [hl]
	ret

.hp_mismatch_1

; Greatly discourage this move if player's HP is below 25%.
	call AICheckPlayerQuarterHP
	jr nc, .hp_mismatch_2

; If player's HP is above 25% but not full, 4% chance to greatly encourage this move.
	call Random
	cp 4 percent
	jr c, .greatly_encourage

; If player's HP is between 25% and 50%,...
	call AICheckPlayerHalfHP
	jr nc, .hp_mismatch_3

; If player's HP is above 50% but not full, 20% chance to greatly encourage this move.
	call AI_80_20
	jr c, .greatly_encourage
	jr .not_encouraged

; ...50% chance to greatly discourage this move.
.hp_mismatch_3
	call AI_50_50
	jr c, .not_encouraged

.hp_mismatch_2
	inc [hl]
	inc [hl]

; We only end up here if the move has not been already encouraged.
.not_encouraged
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .maybe_greatly_encourage

	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .encourage

; Discourage this move if enemy's evasion level is higher than player's accuracy level.
	ld a, [wEnemyEvaLevel]
	ld b, a
	ld a, [wPlayerAccLevel]
	cp b
	jr c, .discourage

	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_ROLLOUT, a
	jr nz, .greatly_encourage

.discourage
	inc [hl]
	ret

; Player is badly poisoned.
; 70% chance to greatly encourage this move.
; This would counter any previous discouragement.
.maybe_greatly_encourage
	call Random
	cp 31 percent + 1
	ret c

	dec [hl]
	dec [hl]
	ret

; Player is seeded.
; 50% chance to encourage this move.
; This would partly counter any previous discouragement.
.encourage
	call AI_50_50
	ret c

	dec [hl]
	ret

AI_Smart_ResetStats:
; 85% chance to encourage this move if any of enemy's stat levels is lower than -2.
	push hl
	ld hl, wEnemyAtkLevel
	ld c, NUM_LEVEL_STATS
.enemystatsloop
	dec c
	jr z, .enemystatsdone
	ld a, [hli]
	cp BASE_STAT_LEVEL - 2
	jr c, .encourage
	jr .enemystatsloop

; 85% chance to encourage this move if any of player's stat levels is higher than +2.
.enemystatsdone
	ld hl, wPlayerAtkLevel
	ld c, NUM_LEVEL_STATS
.playerstatsloop
	dec c
	jr z, .discourage
	ld a, [hli]
	cp BASE_STAT_LEVEL + 3
	jr c, .playerstatsloop

.encourage
	pop hl
	call Random
	cp 16 percent
	ret c
	dec [hl]
	ret

; Discourage this move if neither:
; Any of enemy's stat levels is lower than -2.
; Any of player's stat levels is higher than +2.
.discourage
	pop hl
	inc [hl]
	ret

AI_Smart_ForceSwitch:
; Whirlwind, Roar.

; Strongly encourage this move if the player has
; a stat buff of at least 2 in any stat
	push hl
	ld hl, wPlayerAtkLevel
	ld c, $8
.check_next_stat
	dec c
	jr z, .no_stat_buff
	ld a, [hli]
	cp $9
	jr c, .check_next_stat
	pop hl
; player has a stat buffed by at least 2
	dec [hl]
	cp $a
	ret c
; encourage more if buffed by >2
	dec [hl]
	ret

; Discourage this move if the player has not shown
; a super-effective move against the enemy.
; Consider player's type(s) if its moves are unknown.

.no_stat_buff
	pop hl
	push hl
	callfar CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp 10 ; neutral // forely BASE_AI_SWITCH_SCORE
	pop hl
	ret c
	inc [hl]
	ret

AI_Smart_Heal:
; 90% chance to greatly encourage this move if enemy's HP is below 25%.
; Discourage this move if enemy's HP is higher than 50%.
; Do nothing otherwise.

	call AICheckEnemyQuarterHP
	jr nc, .encourage
	call AICheckEnemyHalfHP
	ret nc
	inc [hl]
	ret

.encourage
	call Random
	cp 10 percent
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_Toxic:
; never use if player has substitute
    ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .discourage

; never use if player has safeguard
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jr nz, .discourage

; never use against steel types
    ld a, [wBattleMonType1]
	cp STEEL
	jr z, .discourage
	ld a, [wBattleMonType2]
	cp STEEL
	jr z, .discourage

; never use against poison types
    ld a, [wBattleMonType1]
	cp POISON
	jr z, .discourage
	ld a, [wBattleMonType2]
	cp POISON
	jr z, .discourage

; never use against Pokemon immune to status
;	ld a, [wBattleMonSpecies]
;	cp ARCEUS
;	jr z, .discourage
;	cp SYLVEON
;	jr z, .discourage
;	cp DUNSPARCE
;	jp z, .discourage

; never use against Pokemon with magic guard
    ld a, [wBattleMonSpecies]
    call DoesPokemonHaveMagicGuard
   	jr c, .discourage

; don't use if player below 50% HP
    call AICheckPlayerHalfHP
    jr nc, .discourage

; encourage slightly if we get here
    dec [hl]
	ret

.discourage
    inc [hl]
    inc [hl]
    inc [hl]
    ret

AI_Smart_LeechSeed:
; never use against grass types
    ld a, [wBattleMonType1]
	cp GRASS
	jr z, .discourage
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .discourage

; don't use on foes twice our level
	ld a, [wBattleMonLevel]
	srl a
	ld b, a
	ld a, [wEnemyMonLevel]
	sub b
	jr c, .discourage

; never use against Pokemon with magic guard
    ld a, [wBattleMonSpecies]
    call DoesPokemonHaveMagicGuard
   	jr c, .discourage

; don't use on already seeded player
    ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .discourage

; don't use if we will be koed
;	call ShouldAIBoost
;	jr nc, .discourage

; don't use if we can just 2hko the player
;	call CanAI2HKO
;	jr c, .discourage

; otherwise use
rept 5
    dec [hl]
endr
    ret

.discourage
    inc [hl]
    inc [hl]
    ret

; DevNote - functions which check if the player can KO the AI and decide to use boosting moves

AI_Smart_LightScreen:
AI_Smart_Reflect:
; Over 90% chance to discourage this move unless enemy's HP is full.

	call AICheckEnemyMaxHP
	ret c
	call Random
	cp 8 percent
	ret c
	inc [hl]
	ret

AI_Smart_Ohko:
; Dismiss this move if player's level is higher than enemy's level.
; Else, discourage this move is player's HP is below 50%.

	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wEnemyMonLevel]
	cp b
	jp c, AIDiscourageMove
	call AICheckPlayerHalfHP
	ret c
	inc [hl]
	ret

AI_Smart_TrapTarget:
; Wrap, Fire Spin

; 50% chance to discourage this move if the player is already trapped.
	ld a, [wPlayerWrapCount]
	and a
	jr nz, .discourage

; 50% chance to greatly encourage this move if player is either
; badly poisoned, in love, identified, stuck in Rollout, or has a Nightmare.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .encourage

	ld a, [wPlayerSubStatus1]
	and 1 << SUBSTATUS_IN_LOVE | 1 << SUBSTATUS_ROLLOUT | 1 << SUBSTATUS_IDENTIFIED | 1 << SUBSTATUS_NIGHTMARE
	jr nz, .encourage

; Else, 50% chance to greatly encourage this move if it's the player's Pokemon first turn.
	ld a, [wPlayerTurnsTaken]
	and a
	jr z, .encourage

; 50% chance to discourage this move otherwise.
.discourage
	call AI_50_50
	ret c
	inc [hl]
	ret

.encourage
	call AICheckEnemyQuarterHP
	ret nc
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_RazorWind:
AI_Smart_Unused2B:
	ld a, [wEnemySubStatus1]
	bit SUBSTATUS_PERISH, a
	jr z, .no_perish_count

	ld a, [wEnemyPerishCount]
	cp 3
	jr c, .discourage

.no_perish_count
	push hl
	ld hl, wPlayerUsedMoves
	ld c, NUM_MOVES

.checkmove
	ld a, [hli]
	and a
	jr z, .movesdone

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_PROTECT
	jr z, .dismiss
	dec c
	jr nz, .checkmove

.movesdone
	pop hl
	ld a, [wEnemySubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr nz, .maybe_discourage

	call AICheckEnemyHalfHP
	ret c

.maybe_discourage
	call Random
	cp 79 percent - 1
	ret c

.discourage
	inc [hl]
	ret

.dismiss
	pop hl
	ld a, [hl]
	add 6
	ld [hl], a
	ret

AI_Smart_Confuse:
; 90% chance to discourage this move if player's HP is between 25% and 50%.
	call AICheckPlayerHalfHP
	ret c
	call Random
	cp 10 percent
	jr c, .skipdiscourage
	inc [hl]

.skipdiscourage
; Discourage again if player's HP is below 25%.
	call AICheckPlayerQuarterHP
	ret c
	inc [hl]
	ret

AI_Smart_SpDefenseUp2:
; Discourage this move if enemy's HP is lower than 50%.
	call AICheckEnemyHalfHP
	jr nc, .discourage

; Discourage this move if enemy's special defense level is higher than +3.
	ld a, [wEnemySDefLevel]
	cp BASE_STAT_LEVEL + 4
	jr nc, .discourage

; 80% chance to greatly encourage this move if
; enemy's Special Defense level is lower than +2,
; and the player's Pokémon is Special-oriented.
	cp BASE_STAT_LEVEL + 2
	ret nc

	push hl
; Get the pointer for the player's Pokémon's base Attack
	ld a, [wBattleMonSpecies]
	ld hl, BaseData + BASE_ATK
	ld bc, BASE_DATA_SIZE
	call AddNTimes
; Get the Pokémon's base Attack
	ld a, BANK(BaseData)
	call GetFarByte
	ld d, a
; Get the pointer for the player's Pokémon's base Special Attack
	ld bc, BASE_SAT - BASE_ATK
	add hl, bc
; Get the Pokémon's base Special Attack
	ld a, BANK(BaseData)
	call GetFarByte
	pop hl
; If its base Attack is greater than its base Special Attack,
; don't encourage this move.
	cp d
	ret c

.encourage
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	ret

AI_Smart_Fly:
; Fly, Dig

; Greatly encourage this move if the player is
; flying or underground, and slower than the enemy.

	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z

	call AICompareSpeed
	ret nc

	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_SuperFang:
; Discourage this move if player's HP is below 25%.

	call AICheckPlayerQuarterHP
	ret c
	inc [hl]
	ret

AI_Smart_Paralyze:
; 50% chance to discourage this move if player's HP is below 25%.
	call AICheckPlayerQuarterHP
	jr nc, .discourage

; 80% chance to greatly encourage this move
; if enemy is slower than player and its HP is above 25%.
	call AICompareSpeed
	ret c
	call AICheckEnemyQuarterHP
	ret nc
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

.discourage
	call AI_50_50
	ret c
	inc [hl]
	ret

AI_Smart_SpeedDownHit:
; Icy Wind

; Almost 90% chance to greatly encourage this move if the following conditions all meet:
; Enemy's HP is higher than 25%.
; It's the first turn of player's Pokemon.
; Player is faster than enemy.

	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	cp ICY_WIND
	ret nz
	call AICheckEnemyQuarterHP
	ret nc
	ld a, [wPlayerTurnsTaken]
	and a
	ret nz
	call AICompareSpeed
	ret c
	call Random
	cp 12 percent
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_Substitute:
; Dismiss this move if enemy's HP is below 50%.

	call AICheckEnemyHalfHP
	ret c
	jp AIDiscourageMove

AI_Smart_HyperBeam:
	call AICheckEnemyHalfHP
	jr c, .discourage

; 50% chance to encourage this move if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	ret c
	call AI_50_50
	ret c
	dec [hl]
	ret

.discourage
; If enemy's HP is above 50%, discourage this move at random
	call Random
	cp 16 percent
	ret c
	inc [hl]
	call AI_50_50
	ret c
	inc [hl]
	ret

AI_Smart_Rage:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_RAGE, a
	jr z, .notbuilding

; If enemy's Rage is building, 50% chance to encourage this move.
	call AI_50_50
	jr c, .skipencourage

	dec [hl]

; Encourage this move based on Rage's counter.
.skipencourage
	ld a, [wEnemyRageCounter]
	cp 2
	ret c
	dec [hl]
	ld a, [wEnemyRageCounter]
	cp 3
	ret c
	dec [hl]
	ret

.notbuilding
; If enemy's Rage is not building, discourage this move if enemy's HP is below 50%.
	call AICheckEnemyHalfHP
	jr nc, .discourage

; 20% chance to encourage this move otherwise.
	call AI_80_20
	ret nc
	dec [hl]
	ret

.discourage
	inc [hl]
	ret

AI_Smart_Mimic:
; Discourage this move if the player did not use any move last turn.
	ld a, [wLastPlayerCounterMove]
	and a
	jr z, .dismiss

	call AICheckEnemyHalfHP
	jr nc, .discourage

	push hl
	ld a, [wLastPlayerCounterMove]
	call AIGetEnemyMove

	ld a, 1
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup

	ld a, [wTypeMatchup]
	cp EFFECTIVE
	pop hl
	jr c, .discourage
	jr z, .skip_encourage

	call AI_50_50
	jr c, .skip_encourage

	dec [hl]

.skip_encourage
	ld a, [wLastPlayerCounterMove]
	push hl
	ld hl, UsefulMoves
	ld de, 1
	call IsInArray

	pop hl
	ret nc
	call AI_50_50
	ret c
	dec [hl]
	ret

.dismiss
; Dismiss this move if the enemy is faster than the player.
	call AICompareSpeed
	jp c, AIDiscourageMove

.discourage
	inc [hl]
	ret

AI_Smart_Counter:
	push hl
	ld hl, wPlayerUsedMoves
	ld c, NUM_MOVES
	ld b, 0

.playermoveloop
	ld a, [hli]
	and a
	jr z, .skipmove

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .skipmove

	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	jr nc, .skipmove

	inc b

.skipmove
	dec c
	jr nz, .playermoveloop

	pop hl
	ld a, b
	and a
	jr z, .discourage

	cp 3
	jr nc, .encourage

	ld a, [wLastPlayerCounterMove]
	and a
	jr z, .done

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .done

	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	jr nc, .done

.encourage
	call Random
	cp 39 percent + 1
	jr c, .done

	dec [hl]

.done
	ret

.discourage
	inc [hl]
	ret

AI_Smart_Encore:
	call AICompareSpeed
	jr nc, .discourage

	ld a, [wLastPlayerMove]
	and a
	jp z, AIDiscourageMove

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .weakmove

	push hl
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	ld hl, wEnemyMonType1
	predef CheckTypeMatchup

	pop hl
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	jr nc, .weakmove

	and a
	ret nz
	jr .encourage

.weakmove
	push hl
	ld a, [wLastPlayerCounterMove]
	ld hl, EncoreMoves
	ld de, 1
	call IsInArray
	pop hl
	jr nc, .discourage

.encourage
	call Random
	cp 28 percent - 1
	ret c
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	ret

INCLUDE "data/battle/ai/encore_moves.asm"

AI_Smart_PainSplit:
; Discourage this move if [enemy's current HP * 2 > player's current HP].

	push hl
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	ld hl, wBattleMonHP + 1
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret nc
	inc [hl]
	ret

AI_Smart_Snore:
AI_Smart_SleepTalk:
; Greatly encourage this move if enemy is fast asleep.
; Greatly discourage this move otherwise.

	ld a, [wEnemyMonStatus]
	and SLP_MASK
	cp 1
	jr z, .discourage

	dec [hl]
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_Spite:
	ld a, [wLastPlayerCounterMove]
	and a
	jr nz, .usedmove

	call AICompareSpeed
	jp c, AIDiscourageMove

	call AI_50_50
	ret c
	inc [hl]
	ret

.usedmove
	push hl
	ld b, a
	ld c, NUM_MOVES
	ld hl, wBattleMonMoves
	ld de, wBattleMonPP

.moveloop
	ld a, [hli]
	cp b
	jr z, .foundmove

	inc de
	dec c
	jr nz, .moveloop

	pop hl
	ret

.foundmove
	pop hl
	ld a, [de]
	cp 6
	jr c, .encourage
	cp 15
	jr nc, .discourage

	call Random
	cp 39 percent + 1
	ret nc

.discourage
	inc [hl]
	ret

.encourage
	call Random
	cp 39 percent + 1
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_DestinyBond:
AI_Smart_Reversal:
; Discourage this move if enemy's HP is above 25%.

	call AICheckEnemyQuarterHP
	ret nc
	inc [hl]
	ret

AI_Smart_HealBell:
; Dismiss this move if none of the opponent's Pokemon is statused.
; Encourage this move if the enemy is statused.
; 50% chance to greatly encourage this move if the enemy is fast asleep.

	push hl
	ld a, [wOTPartyCount]
	ld b, a
	ld c, 0
	ld hl, wOTPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH

.loop
	push hl
	ld a, [hli]
	or [hl]
	jr z, .next

	; status
	dec hl
	dec hl
	dec hl
	ld a, [hl]
	or c
	ld c, a

.next
	pop hl
	add hl, de
	dec b
	jr nz, .loop

	pop hl
	ld a, c
	and a
	jr z, .no_status

	ld a, [wEnemyMonStatus]
	and a
	jr z, .ok
	dec [hl]
.ok
	and SLP_MASK
	ret z
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

.no_status
	ld a, [wEnemyMonStatus]
	and a
	ret nz
	jp AIDiscourageMove


AI_Smart_PriorityHit:
	call AICompareSpeed
	ret c

; Dismiss this move if the player is flying or underground.
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jp nz, AIDiscourageMove

; Greatly encourage this move if it will KO the player.
	ld a, 1
	ldh [hBattleTurn], a
	push hl
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	pop hl
	ld a, [wCurDamage + 1]
	ld c, a
	ld a, [wCurDamage]
	ld b, a
	ld a, [wBattleMonHP + 1]
	cp c
	ld a, [wBattleMonHP]
	sbc b
	ret nc
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_Thief:
; Don't use Thief unless it's the only move available.

	ld a, [hl]
	add $1e
	ld [hl], a
	ret

AI_Smart_Conversion2:
	ld a, [wLastPlayerMove]
	and a
	jr z, .discourage

	push hl
	dec a
	ld hl, Moves + MOVE_TYPE
	ld bc, MOVE_LENGTH
	call AddNTimes

	ld a, BANK(Moves)
	call GetFarByte
	ld [wPlayerMoveStruct + MOVE_TYPE], a

	xor a
	ldh [hBattleTurn], a

	callfar BattleCheckTypeMatchup

	ld a, [wTypeMatchup]
	cp EFFECTIVE
	pop hl
	jr c, .discourage
	ret z

	call AI_50_50
	ret c

	dec [hl]
	ret

.discourage
	call Random
	cp 10 percent
	ret c
	inc [hl]
	ret

AI_Smart_Disable:
	call AICompareSpeed
	jr nc, .discourage

	push hl
	ld a, [wLastPlayerCounterMove]
	ld hl, UsefulMoves
	ld de, 1
	call IsInArray

	pop hl
	jr nc, .notencourage

	call Random
	cp 39 percent + 1
	ret c
	dec [hl]
	ret

.notencourage
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	ret nz

.discourage
	call Random
	cp 8 percent
	ret c
	inc [hl]
	ret

AI_Smart_MeanLook:
	call AICheckEnemyHalfHP
	jr nc, .discourage

	push hl
	call AICheckLastPlayerMon
	pop hl
	jp z, AIDiscourageMove

; 80% chance to greatly encourage this move if the enemy is badly poisoned.
    ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .encourage

; 80% chance to greatly encourage this move if the player is either
; in love, identified, stuck in Rollout, or has a Nightmare.
	ld a, [wPlayerSubStatus1]
	and 1 << SUBSTATUS_IN_LOVE | 1 << SUBSTATUS_ROLLOUT | 1 << SUBSTATUS_IDENTIFIED | 1 << SUBSTATUS_NIGHTMARE
	jr nz, .encourage

; Otherwise, discourage this move unless the player only has not very effective moves against the enemy.
	push hl
	callfar CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp BASE_AI_SWITCH_SCORE + 1 ; not very effective
	pop hl
	ret nc

.discourage
	inc [hl]
	ret

.encourage
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AICheckLastPlayerMon:
	ld a, [wPartyCount]
	ld b, a
	ld c, 0
	ld hl, wPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH

.loop
	ld a, [wCurBattleMon]
	cp c
	jr z, .skip

	ld a, [hli]
	or [hl]
	ret nz
	dec hl

.skip
	add hl, de
	inc c
	dec b
	jr nz, .loop

	ret

AI_Smart_Nightmare:
; 50% chance to encourage this move.
; The AI_Basic layer will make sure that
; Dream Eater is only used against sleeping targets.

	call AI_50_50
	ret c
	dec [hl]
	ret

AI_Smart_Curse:
	ld a, [wEnemyMonType1]
	cp GHOST
	jr z, .ghost_curse
	ld a, [wEnemyMonType2]
	cp GHOST
	jr z, .ghost_curse

	call AICheckEnemyHalfHP
	jr nc, .encourage

	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 4
	jr nc, .encourage
	cp BASE_STAT_LEVEL + 2
	ret nc

	ld a, [wBattleMonType1]
	cp GHOST
	jr z, .greatly_encourage
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

.approve
	inc [hl]
	inc [hl]
.greatly_encourage
	inc [hl]
.encourage
	inc [hl]
	ret

.ghost_curse
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_CURSE, a
	jp nz, AIDiscourageMove

	push hl
	farcall FindAliveEnemyMons
	pop hl
	jr nc, .notlastmon

	push hl
	call AICheckLastPlayerMon
	pop hl
	jr nz, .approve

	jr .ghost_continue

.notlastmon
	push hl
	call AICheckLastPlayerMon
	pop hl
	jr z, .maybe_greatly_encourage

.ghost_continue
	call AICheckEnemyQuarterHP
	jp nc, .approve

	call AICheckEnemyHalfHP
	jr nc, .greatly_encourage

	call AICheckEnemyMaxHP
	ret nc

	ld a, [wPlayerTurnsTaken]
	and a
	ret nz

.maybe_greatly_encourage
	call AI_50_50
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_Protect:
; Greatly discourage this move if the enemy already used Protect.
	ld a, [wEnemyProtectCount]
	and a
	jr nz, .greatly_discourage

; Discourage this move if the player is locked on.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_LOCK_ON, a
	jr nz, .discourage

; Encourage this move if the player has charged a two-turn move.
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CHARGED, a
	jr nz, .encourage

; Encourage this move if the player is affected by Toxic, Leech Seed, or Curse.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .encourage
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .encourage
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_CURSE, a
	jr nz, .encourage

; Discourage this move if the player's Rollout count is not boosted enough.
	bit SUBSTATUS_ROLLOUT, a
	jr z, .discourage
	ld a, [wPlayerRolloutCount]
	cp 3
	jr c, .discourage

; 80% chance to encourage this move otherwise.
.encourage
	call AI_80_20
	ret c

	dec [hl]
	ret

.greatly_discourage
	inc [hl]

.discourage
	call Random
	cp 8 percent
	ret c

	inc [hl]
	inc [hl]
	ret

AI_Smart_Foresight:
; 60% chance to encourage this move if the enemy's accuracy is sharply lowered.
	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL - 2
	jr c, .encourage

; 60% chance to encourage this move if the player's evasion is sharply raised.
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 3
	jr nc, .encourage

; 60% chance to encourage this move if the player is a Ghost type.
	ld a, [wBattleMonType1]
	cp GHOST
	jr z, .encourage
	ld a, [wBattleMonType2]
	cp GHOST
	jr z, .encourage

; 92% chance to discourage this move otherwise.
	call Random
	cp 8 percent
	ret c

	inc [hl]
	ret

.encourage
	call Random
	cp 39 percent + 1
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_PerishSong:
	push hl
	callfar FindAliveEnemyMons
	pop hl
	jr c, .no

	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .yes

	push hl
	callfar CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp BASE_AI_SWITCH_SCORE
	pop hl
	ret c

	call AI_50_50
	ret c

	inc [hl]
	ret

.yes
	call AI_50_50
	ret c

	dec [hl]
	ret

.no
	ld a, [hl]
	add 5
	ld [hl], a
	ret

AI_Smart_Sandstorm:
; Greatly discourage this move if the player is immune to Sandstorm damage.
	ld a, [wBattleMonType1]
	push hl
	ld hl, .SandstormImmuneTypes
	ld de, 1
	call IsInArray
	pop hl
	jr c, .greatly_discourage

	ld a, [wBattleMonType2]
	push hl
	ld hl, .SandstormImmuneTypes
	ld de, 1
	call IsInArray
	pop hl
	jr c, .greatly_discourage

; Discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	jr nc, .discourage

; 50% chance to encourage this move otherwise.
	call AI_50_50
	ret c

	dec [hl]
	ret

.greatly_discourage
	inc [hl]
.discourage
	inc [hl]
	ret

.SandstormImmuneTypes:
	db ROCK
	db GROUND
	db STEEL
	db -1 ; end

AI_Smart_Hail:
; Greatly discourage this move if the player is immune to Hail damage.
	ld a, [wBattleMonType1]
	cp ICE
	jr z, .greatly_discourage

	ld a, [wBattleMonType2]
	cp ICE
	jr z, .greatly_discourage

; Discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	jr nc, .discourage

; Encourage move if AI has good Hail moves
	push hl
	ld hl, .GoodHailMoves
	call AIHasMoveInArray
	pop hl
	jr c, .encourage

; ...80% chance to greatly encourage this move.
	call AI_80_20
	ret c

.encourage
	dec [hl]
	ret

.greatly_discourage
	inc [hl]
.discourage
	inc [hl]
	ret

.GoodHailMoves
	db BLIZZARD
	db -1 ; end

AI_Smart_Endure:
; Greatly discourage this move if the enemy already used Protect.
	ld a, [wEnemyProtectCount]
	and a
	jr nz, .greatly_discourage

; Greatly discourage this move if the enemy's HP is full.
	call AICheckEnemyMaxHP
	jr c, .greatly_discourage

; Discourage this move if the enemy's HP is at least 25%.
	call AICheckEnemyQuarterHP
	jr c, .discourage

; If the enemy has Reversal...
	ld b, EFFECT_REVERSAL
	call AIHasMoveEffect
	jr nc, .no_reversal

; ...80% chance to greatly encourage this move.
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	dec [hl]
	ret

.no_reversal
; If the enemy is not locked on, do nothing.
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_LOCK_ON, a
	ret z

; 50% chance to greatly encourage this move.
	call AI_50_50
	ret c

	dec [hl]
	dec [hl]
	ret

.greatly_discourage
	inc [hl]
.discourage
	inc [hl]
	ret

AI_Smart_Rollout:
; Rollout, Fury Cutter

; 80% chance to discourage this move if the enemy is in love, confused, or paralyzed.
	ld a, [wEnemySubStatus1]
	bit SUBSTATUS_IN_LOVE, a
	jr nz, .maybe_discourage

	ld a, [wEnemySubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr nz, .maybe_discourage

	ld a, [wEnemyMonStatus]
	bit PAR, a
	jr nz, .maybe_discourage

; 80% chance to discourage this move if the enemy's HP is below 25%,
; or if accuracy or evasion modifiers favour the player.
	call AICheckEnemyQuarterHP
	jr nc, .maybe_discourage

	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL
	jr c, .maybe_discourage
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 1
	jr nc, .maybe_discourage

; If the mon has Defense Curl, and hasn't used it yet,
; don't encourage Rollout
	ld b, EFFECT_DEFENSE_CURL
	call AIHasMoveEffect
	jr nc, .no_defense_curl
	ld a, [wEnemySubStatus2]
	bit SUBSTATUS_CURLED, a
	ret z

.no_defense_curl
; 80% chance to greatly encourage this move otherwise.
	call Random
	cp 79 percent - 1
	ret nc
	dec [hl]
	dec [hl]
	ret

.maybe_discourage
	call AI_80_20
	ret c
	inc [hl]
	ret

AI_Smart_Swagger:
AI_Smart_Attract:
; 80% chance to encourage this move during the first turn of player's Pokemon.
; 80% chance to discourage this move otherwise.

	ld a, [wPlayerTurnsTaken]
	and a
	jr z, .first_turn

	call AI_80_20
	ret c
	inc [hl]
	ret

.first_turn
	call Random
	cp 79 percent - 1
	ret nc
	dec [hl]
	ret

AI_Smart_Safeguard:
; 80% chance to discourage this move if player's HP is below 50%.

	call AICheckPlayerHalfHP
	ret c
	call AI_80_20
	ret c
	inc [hl]
	ret

AI_Smart_Magnitude:
AI_Smart_Earthquake:
; Greatly encourage this move if the player is underground and the enemy is faster.
	ld a, [wLastPlayerCounterMove]
	cp DIG
	ret nz

	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_UNDERGROUND, a
	jr z, .could_dig

	call AICompareSpeed
	ret nc
	dec [hl]
	dec [hl]
	ret

.could_dig
	; Try to predict if the player will use Dig this turn.

	; 50% chance to encourage this move if the enemy is slower than the player.
	call AICompareSpeed
	ret c

	call AI_50_50
	ret c

	dec [hl]
	ret

AI_Smart_BatonPass:
; Discourage this move if the player hasn't shown super-effective moves against the enemy.
; Consider player's type(s) if its moves are unknown.

	push hl
	callfar CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp BASE_AI_SWITCH_SCORE
	pop hl
	ret c
	inc [hl]
	ret

AI_Smart_Pursuit:
; 50% chance to greatly encourage this move if player's HP is below 25%.
; 80% chance to discourage this move otherwise.

	call AICheckPlayerQuarterHP
	jr nc, .encourage
	call AI_80_20
	ret c
	inc [hl]
	ret

.encourage
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_RapidSpin:
; 80% chance to greatly encourage this move if the enemy is
; trapped (Bind effect), seeded, or scattered with spikes.

	ld a, [wEnemyWrapCount]
	and a
	jr nz, .encourage

	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .encourage

	ld a, [wEnemyScreens]
	bit SCREENS_SPIKES, a
	ret z

.encourage
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_HiddenPower:
	push hl
	ld a, 1
	ldh [hBattleTurn], a

; Calculate Hidden Power's type based on enemy's DVs
	callfar HiddenPowerDamage
	callfar BattleCheckTypeMatchup
	pop hl

; Discourage Hidden Power if not very effective, encourage it if super-effective. 
; Otherwise do nothing.
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	ret z
	jr c, .bad

	dec [hl]
	ret

.bad
	inc [hl]
	ret

AI_Smart_RainDance:
; Greatly discourage this move if it would favour the player type-wise.
; Particularly, if the player is a Water-type.
	ld a, [wBattleMonType1]
	cp WATER
	jr z, AIBadWeatherType
	cp FIRE
	jr z, AIGoodWeatherType

	ld a, [wBattleMonType2]
	cp WATER
	jr z, AIBadWeatherType
	cp FIRE
	jr z, AIGoodWeatherType

	push hl
	ld hl, RainDanceMoves
	jr AI_Smart_WeatherMove

INCLUDE "data/battle/ai/rain_dance_moves.asm"

AI_Smart_SunnyDay:
; Greatly discourage this move if it would favour the player type-wise.
; Particularly, if the player is a Fire-type.
	ld a, [wBattleMonType1]
	cp FIRE
	jr z, AIBadWeatherType
	cp WATER
	jr z, AIGoodWeatherType

	ld a, [wBattleMonType2]
	cp FIRE
	jr z, AIBadWeatherType
	cp WATER
	jr z, AIGoodWeatherType

	push hl
	ld hl, SunnyDayMoves

	; fallthrough

AI_Smart_WeatherMove:
; Rain Dance, Sunny Day

; Greatly discourage this move if the enemy doesn't have
; one of the useful Rain Dance or Sunny Day moves.
	call AIHasMoveInArray
	pop hl
	jr nc, AIBadWeatherType

; Greatly discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	jr nc, AIBadWeatherType

; 50% chance to encourage this move otherwise.
	call AI_50_50
	ret c

	dec [hl]
	ret

AIBadWeatherType:
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AIGoodWeatherType:
; Rain Dance, Sunny Day

; Greatly encourage this move if it would disfavour the player type-wise and player's HP is above 50%...
	call AICheckPlayerHalfHP
	ret nc

; ...as long as one of the following conditions meet:
; It's the first turn of the player's Pokemon.
	ld a, [wPlayerTurnsTaken]
	and a
	jr z, .good

; Or it's the first turn of the enemy's Pokemon.
	ld a, [wEnemyTurnsTaken]
	and a
	ret nz

.good
	dec [hl]
	dec [hl]
	ret

INCLUDE "data/battle/ai/sunny_day_moves.asm"

AI_Smart_BellyDrum:
; Dismiss this move if enemy's attack is higher than +2 or if enemy's HP is below 50%.
; Else, discourage this move if enemy's HP is not full.

	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 3
	jr nc, .discourage

	call AICheckEnemyMaxHP
	ret c

	inc [hl]

	call AICheckEnemyHalfHP
	ret c

.discourage
	ld a, [hl]
	add 5
	ld [hl], a
	ret

AI_Smart_MirrorCoat:
	push hl
	ld hl, wPlayerUsedMoves
	ld c, NUM_MOVES
	ld b, 0

.playermoveloop
	ld a, [hli]
	and a
	jr z, .skipmove

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .skipmove

	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	jr c, .skipmove

	inc b

.skipmove
	dec c
	jr nz, .playermoveloop

	pop hl
	ld a, b
	and a
	jr z, .discourage

	cp 3
	jr nc, .encourage

	ld a, [wLastPlayerCounterMove]
	and a
	jr z, .done

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .done

	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	jr c, .done

.encourage
	call Random
	cp 39 percent + 1
	jr c, .done
	dec [hl]

.done
	ret

.discourage
	inc [hl]
	ret

AI_Smart_Gust:
; Greatly encourage this move if the player is flying and the enemy is faster.
	ld a, [wLastPlayerCounterMove]
	cp FLY
	ret nz

	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_FLYING, a
	jr z, .couldFly

	call AICompareSpeed
	ret nc

	dec [hl]
	dec [hl]
	ret

; Try to predict if the player will use Fly this turn.
.couldFly

; 50% chance to encourage this move if the enemy is slower than the player.
	call AICompareSpeed
	ret c
	call AI_50_50
	ret c
	dec [hl]
	ret

AI_Smart_Stomp:
; 80% chance to encourage this move if the player has used Minimize.

	ld a, [wPlayerMinimized]
	and a
	ret z

	call AI_80_20
	ret c

	dec [hl]
	ret

AI_Smart_Solarbeam:
; 80% chance to encourage this move when it's sunny.
; 90% chance to discourage this move when it's raining.

	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .encourage

	cp WEATHER_RAIN
	ret nz

	call Random
	cp 10 percent
	ret c

	inc [hl]
	inc [hl]
	ret

.encourage
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_Thunder:
AI_Smart_Hurricane:
; 90% chance to discourage this move when it's sunny.

	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret nz

	call Random
	cp 10 percent
	ret c

	inc [hl]
	ret

AICompareSpeed:
; Return carry if enemy is faster than player.

	push bc
	ld a, [wEnemyMonSpeed + 1]
	ld b, a
	ld a, [wBattleMonSpeed + 1]
	cp b
	ld a, [wEnemyMonSpeed]
	ld b, a
	ld a, [wBattleMonSpeed]
	sbc b
	pop bc
	ret

AICheckPlayerMaxHP:
	push hl
	push de
	push bc
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	jr AICheckMaxHP

AICheckEnemyMaxHP:
	push hl
	push de
	push bc
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	; fallthrough

AICheckMaxHP:
; Return carry if hp at de matches max hp at hl.

	ld a, [de]
	inc de
	cp [hl]
	jr nz, .not_max

	inc hl
	ld a, [de]
	cp [hl]
	jr nz, .not_max

	pop bc
	pop de
	pop hl
	scf
	ret

.not_max
	pop bc
	pop de
	pop hl
	and a
	ret

AICheckPlayerHalfHP:
	push hl
	ld hl, wBattleMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret

AICheckEnemyHalfHP:
	push hl
	push de
	push bc
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop bc
	pop de
	pop hl
	ret

AICheckEnemyQuarterHP:
	push hl
	push de
	push bc
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop bc
	pop de
	pop hl
	ret

AICheckPlayerQuarterHP:
	push hl
	ld hl, wBattleMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret

AIHasMoveEffect:
; Return carry if the enemy has move b.

	push hl
	ld hl, wEnemyMonMoves
	ld c, NUM_MOVES

.checkmove
	ld a, [hli]
	and a
	jr z, .no

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp b
	jr z, .yes

	dec c
	jr nz, .checkmove

.no
	pop hl
	and a
	ret

.yes
	pop hl
	scf
	ret

AIHasMoveInArray:
; Return carry if the enemy has a move in array hl.

	push hl
	push de
	push bc

.next
	ld a, [hli]
	cp -1
	jr z, .done

	ld b, a
	ld c, NUM_MOVES + 1
	ld de, wEnemyMonMoves

.check
	dec c
	jr z, .next

	ld a, [de]
	inc de
	cp b
	jr nz, .check

	scf

.done
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/battle/ai/useful_moves.asm"

AI_Opportunist:
; Discourage stall moves when the enemy's HP is low.

; Do nothing if enemy's HP is above 50%.
	call AICheckEnemyHalfHP
	ret c

; Discourage stall moves if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	jr nc, .lowhp

; 50% chance to discourage stall moves if enemy's HP is between 25% and 50%.
	call AI_50_50
	ret c

.lowhp
	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.checkmove
	inc hl
	dec c
	jr z, .done

	ld a, [de]
	inc de
	and a
	jr z, .done

	push hl
	push de
	push bc
	ld hl, StallMoves
	ld de, 1
	call IsInArray

	pop bc
	pop de
	pop hl
	jr nc, .checkmove

	inc [hl]
	jr .checkmove

.done
	ret

INCLUDE "data/battle/ai/stall_moves.asm"


AI_Aggressive:
; Use whatever does the most damage.

; Discourage all damaging moves but the one that does the most damage.
; If no damaging move deals damage to the player (immune),
; no move will be discouraged

; Also greatly discourages ineffective moves since this overrides the
; regular type matchup layer

	ld hl, wEnemyMonMoves
	ld bc, 0
	ld de, 0
.checkmove
	inc b
	ld a, b
	cp NUM_MOVES + 1
	jr z, .gotstrongestmove

	ld a, [hli]
	and a
	jr z, .gotstrongestmove

	push hl
	push de
	push bc
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .nodamage
	call AIDamageCalc
	pop bc
	pop de
	pop hl

; Update current move if damage is highest so far
	ld a, [wCurDamage + 1]
	cp e
	ld a, [wCurDamage]
	sbc d
	jr c, .checkmove

	ld a, [wCurDamage + 1]
	ld e, a
	ld a, [wCurDamage]
	ld d, a
	ld c, b
	jr .checkmove

.nodamage
	pop bc
	pop de
	pop hl
	jr .checkmove

.gotstrongestmove
; Nothing we can do if no attacks did damage.
	ld a, c
	and a
	ret z

; Discourage moves that do less damage unless they're reckless too.
	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, 0
.checkmove2
	inc b
	ld a, b
	cp NUM_MOVES + 1
	ret z

; Ignore this move if it is the highest damaging one.
	cp c
	ld a, [de]
	inc de
	inc hl
	jr z, .checkmove2

	call AIGetEnemyMove
	
; This routine overrides the type matchup AI layer, since it's typically
; superior to it. As a result, deal with ineffective moves here too which
; is discouraged far more than other less damaging moves.
	push hl
	push de
	push bc
	farcall BattleCheckTypeMatchup
	pop bc
	pop de
	pop hl
	ld a, [wTypeMatchup]
	and a
	call z, AIDiscourageMove

; Ignore this move if its power is 0 or 1.
; Moves such as Seismic Toss, Hidden Power,
; Counter and Fissure have a base power of 1.
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	cp 2
	jr c, .checkmove2

; 50% chance to ignore this move if it is reckless.
	push hl
	push de
	push bc
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld hl, RecklessMoves
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr c, .checkmove2

; If we made it this far, discourage this move.
.discourage
	inc [hl]
	jr c, .maybe_discourage

.maybe_discourage
	call AI_50_50
	jr c, .discourage
	jr .checkmove2

INCLUDE "data/battle/ai/reckless_moves.asm"

AIDamageCalc:
	ld a, 1
	ldh [hBattleTurn], a
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld de, 1
	ld hl, ConstantDamageEffects
	call IsInArray
	jr nc, .notconstant
	callfar BattleCommand_ConstantDamage
	ret

.notconstant
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	ret

INCLUDE "data/battle/ai/constant_damage_effects.asm"

AI_Cautious:
; 90% chance to discourage moves with residual effects after the first turn.

	ld a, [wEnemyTurnsTaken]
	and a
	ret z

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.loop
	inc hl
	dec c
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push hl
	push de
	push bc
	ld hl, ResidualMoves
	ld de, 1
	call IsInArray

	pop bc
	pop de
	pop hl
	jr nc, .loop

	call Random
	cp 90 percent + 1
	ret nc

	inc [hl]
	jr .loop

INCLUDE "data/battle/ai/residual_moves.asm"


AI_Status:
; Dismiss status moves that don't affect the player.

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

; Check if the opponent is immune to powder/spore moves.      
	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	push bc
	push de
	push hl
	ld hl, PowderMoves
	call IsInByteArray
	pop hl
	pop de
	pop bc
	jr nc, .normal_check

	ld a, [wBattleMonType1]
	cp GRASS
	jr z, .immune
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .immune

.normal_check

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_TOXIC
	jr z, .poisonimmunity
	cp EFFECT_POISON
	jr z, .poisonimmunity
	cp EFFECT_LEECH_SEED
	jr z, .leechseedimmunity
	cp EFFECT_PARALYZE
	jr z, .typeimmunity

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .checkmove

	jr .typeimmunity

.poisonimmunity
	ld a, [wBattleMonType1]
	cp POISON
	jr z, .immune
	cp STEEL
	jr z, .immune
	ld a, [wBattleMonType2]
	cp POISON
	jr z, .immune
	cp STEEL
	jr z, .immune
	jr .typeimmunity

.leechseedimmunity
	ld a, [wBattleMonType1]
	cp GRASS
	jr z, .immune
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .immune

.typeimmunity
	push hl
	push bc
	push de
	ld a, 1
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup
	pop de
	pop bc
	pop hl

	ld a, [wTypeMatchup]
	and a
	jr nz, .checkmove

.immune
	call AIDiscourageMove
	jp .checkmove


AI_Risky:
; Use any move that will KO the target.
; Selfdestructing moves will often be an exception (see below).

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.checkmove
	inc hl
	dec c
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push de
	push bc
	push hl
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .nextmove

; Don't use selfdestructing moves at max hp.
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr nz, .checkko

	call AICheckEnemyMaxHP
	jr c, .nextmove

; Else, 80% chance to exclude them.
	call Random
	cp 79 percent - 1
	jr c, .nextmove

.checkko
	call AIDamageCalc

	ld a, [wCurDamage + 1]
	ld e, a
	ld a, [wCurDamage]
	ld d, a
	ld a, [wBattleMonHP + 1]
	cp e
	ld a, [wBattleMonHP]
	sbc d
	jr nc, .nextmove

	pop hl
rept 5
	dec [hl]
endr
	push hl

.nextmove
	pop hl
	pop bc
	pop de
	jr .checkmove

AI_None:
	ret

AIDiscourageMove:
	ld a, [hl]
	add 10
	ld [hl], a
	ret

AIGetEnemyMove:
; Load attributes of move a into ram

	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes

	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes

	pop bc
	pop de
	pop hl
	ret

AI_95_5:
	call Random
	cp 5 percent - 1
	ret

AI_80_20:
	call Random
	cp 20 percent - 1
	ret

AI_50_50:
	call Random
	cp 50 percent + 1
	ret

DoesPokemonHaveMagicGuard:
    push hl
    push de
   	push bc
   	ld hl, AI_MagicGuardPokemon
   	ld de, 1
   	call IsInArray
   	pop bc
   	pop de
   	pop hl
   	jr c, .yes
   	xor a
   	ret
.yes
    scf
    ret

Levitate:
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp GROUND
    jr z, .getPokemon
	ret
.getPokemon
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .checkLevitate
	ld a, [wBattleMonSpecies]
.checkLevitate
	ld hl, AI_LevitatePokemon
	ld de, 1
	call IsInArray
    jr c, .found
    ret
.found
	ld hl, LevitateText
	call StdBattleTextbox
    ret z

DoesPokemonHaveLevitate:
    push hl
    push de
   	push bc
   	ld hl, AI_LevitatePokemon
   	ld de, 1
   	call IsInArray
   	pop bc
   	pop de
   	pop hl
   	jr c, .yes
   	xor a
   	ret
.yes
    scf
    ret

WaterAbsorb:
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp WATER
    jr z, .getPokemon
	ret
.getPokemon
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check
	ld a, [wBattleMonSpecies]
.check
	ld hl, AI_WaterAbsorbPokemon
	ld de, 1
	call IsInArray
    jr c, .found
    ret
.found
	ld hl, WaterAbsorbText
	call StdBattleTextbox
    ret z

DoesPokemonHaveWaterAbsorb:
    push hl
    push de
   	push bc
   	ld hl, AI_WaterAbsorbPokemon
   	ld de, 1
   	call IsInArray
   	pop bc
   	pop de
   	pop hl
   	jr c, .yes
   	xor a
   	ret
.yes
    scf
    ret

VoltAbsorb:
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp ELECTRIC
    jr z, .getPokemon
	ret
.getPokemon
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check
	ld a, [wBattleMonSpecies]
.check
	ld hl, AI_VoltAbsorbPokemon
	ld de, 1
	call IsInArray
    jr c, .found
    ret
.found
	ld hl, VoltAbsorbText
	call StdBattleTextbox
    ret z

DoesPokemonHaveVoltAbsorb:
    push hl
    push de
   	push bc
   	ld hl, AI_VoltAbsorbPokemon
   	ld de, 1
   	call IsInArray
   	pop bc
   	pop de
   	pop hl
   	jr c, .yes
   	xor a
   	ret
.yes
    scf
    ret

FireAbsorb:
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp FIRE
    jr z, .getPokemon
	ret
.getPokemon
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check
	ld a, [wBattleMonSpecies]
.check
	ld hl, AI_FireAbsorbPokemon
	ld de, 1
	call IsInArray
    jr c, .found
    ret
.found
	ld hl, FireAbsorbText
	call StdBattleTextbox
    ret z

DoesPokemonHaveFireAbsorb:
    push hl
    push de
   	push bc
   	ld hl, AI_FireAbsorbPokemon
   	ld de, 1
   	call IsInArray
   	pop bc
   	pop de
   	pop hl
   	jr c, .yes
   	xor a
   	ret
.yes
    scf
    ret

DoesAIOutSpeedPlayer:
; lots of extra logic for the weather speed boosting abilities since they don't actually increase speed
    ld a, [wEnemyMonStatus]
	and 1 << PAR
	jp nz, .checkPlayer
    ld a, [wPlayerSpdLevel]
    cp BASE_STAT_LEVEL + 2
    jr nc, .checkPlayer

	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	jr nz, .checkSun
	ld a, [wEnemyMonSpecies]

; Swift Swimm users
	cp POLIWRATH
	jp z, .yes
	cp KINGDRA
	jp z, .yes
.checkSun
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr nz, .checkSand
	ld a, [wEnemyMonSpecies]

; Chorophyll users
	cp VENUSAUR
	jr z, .yes
	cp EXEGGUTOR
	jr z, .yes
.checkSand
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr nz, .checkPlayer
	ld a, [wEnemyMonSpecies]

; Sand Rush users
;	cp EXCADRILL
;	jr z, .yes
	cp GOLEM
	jr z, .yes

.checkPlayer
    ld a, [wBattleMonStatus]
	and 1 << PAR
	jp nz, .speedCheck
    ld a, [wEnemySpdLevel]
    cp BASE_STAT_LEVEL + 2
    jr nc, .speedCheck

	ld a, [wBattleWeather]

; Swift Swimm users
	cp WEATHER_RAIN
	jr nz, .checkSunPlayer
	ld a, [wBattleMonSpecies]
	cp POLIWRATH
	jr z, .no
	cp KINGDRA
	jr z, .no
.checkSunPlayer
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr nz, .checkSandPlayer
	ld a, [wBattleMonSpecies]

; Chorophyll users
	cp VENUSAUR
	jr z, .no
	cp EXEGGUTOR
	jr z, .no
.checkSandPlayer
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr nz, .speedCheck
	ld a, [wBattleMonSpecies]

; Sand Rush users
;	cp EXCADRILL
;	jr z, .no
	cp GOLEM
	jr z, .no

.speedCheck
; Return carry if enemy is faster than player.
	push bc
	ld a, [wEnemyMonSpeed + 1]
	ld b, a
	ld a, [wBattleMonSpeed + 1]
	cp b
	ld a, [wEnemyMonSpeed]
	ld b, a
	ld a, [wBattleMonSpeed]
	sbc b
	pop bc
	jr nc, .no
.yes
    ld a, [wTrickRoomCount]
    and a
    jr z, .doYes
    xor a
    ret
.doYes
    scf
    ret
.no
    ld a, [wTrickRoomCount]
    and a
    jr z, .doNo
    scf
    ret
.doNo
    xor a
    ret

; return carry if the AI has a move that can 1HKO the player Pokemon from current HP
CanAIKO:
    ld de, wEnemyMonMoves ; load player moves
	ld b, NUM_MOVES + 1
.loopAIKOMoves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .loopAIKOMoves ; skip moves with 0 power

    ld a, 1
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wBattleMonHP + 1]
	cp c ; compare upper
	ld a, [wBattleMonHP]
    sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
    jp nc, .loopAIKOMoves
; skip moves that can't be used on consecutive turns, except hyper beam
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loopAIKOMoves

; Remove this when Solarbeam is updated
	cp EFFECT_SOLARBEAM
	jr z, .loopAIKOMoves
    scf
    ret
.done
    xor a ; clear carry flag
    ret

IsAISetup:
; don't switch if enemy mon is already set up
    ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .yes
    ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .yes
    ;ld a, [wEnemyDefLevel]
	;cp BASE_STAT_LEVEL + 2
	;jr nc, .yes
    ;ld a, [wEnemySDefLevel]
	;cp BASE_STAT_LEVEL + 2
	;jr nc, .yes
    xor a
    ret
.yes
    scf
    ret

; return carry if the player has a move that can 1HKO the AI Pokemon from current HP
; used to decide if the AI should use setup moves
CanPlayerKO:
    ld de, wBattleMonMoves ; load player moves
	ld b, NUM_MOVES + 1
.loopPlayerKOMoves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .loopPlayerKOMoves ; skip moves with 0 power
    ld a, 0
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wEnemyMonHP + 1]
	cp c ; compare upper
	ld a, [wEnemyMonHP]
    sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
    jp nc, .loopPlayerKOMoves
; skip moves that can't be used on consecutive turns, except hyper beam
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loopPlayerKOMoves
	cp EFFECT_SOLARBEAM
	jr z, .loopPlayerKOMoves
    scf
    ret
.done
    xor a ; clear carry flag
    ret

; return carry if the player has a move that can 2HKO the AI Pokemon from current HP
; used to decide if the AI should use setup moves
CanPlayer2HKO:
    ld de, wBattleMonMoves ; load player moves
	ld b, NUM_MOVES + 1
.loopPlayer2HKOMoves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .loopPlayer2HKOMoves ; skip moves with 0 power
    ld a, 0
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; double current damage
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	add hl, hl
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
; continue
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wEnemyMonHP + 1]
	cp c ; compare upper
	ld a, [wEnemyMonHP]
    sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
    jp nc, .loopPlayer2HKOMoves
; skip moves that can't be used on consecutive turns - exception for Porygon2 which can use Hyper Beam consecutively
    ld a, [wBattleMonSpecies]
    cp PORYGON2
    jr z, .setFlag
;	cp URSALUNA_B
;	jr z, .setFlag
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loopPlayer2HKOMoves
	cp EFFECT_HYPER_BEAM
	jr z, .loopPlayer2HKOMoves
	cp EFFECT_SOLARBEAM
	jr z, .loopPlayer2HKOMoves
.setFlag
	scf
    ret
.done
    xor a ; clear carry flag
    ret

AIGetPlayerMove:
; Load attributes of move a into ram

	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes

	ld de, wPlayerMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes

	pop bc
	pop de
	pop hl
	ret

; decide if AI should use boosting moves
; generally don't boost if player will just KO anyway
; returns carry if the AI can boost
ShouldAIBoost:
    call IsAttackMaxed
    jp c, .dontBoost
    call IsSpecialAttackMaxed
    jp c, .dontBoost

; don't boost if choice locked
    call DoesEnemyHaveChoiceItem
    jp c, .dontBoost

;================================
;    Maybe add Sucker Punch?
;================================
; if players last move was sucker punch - 50% chance to boost
;	ld a, [wCurPlayerMove]
;	call AIGetPlayerMove
;   ld a, [wPlayerMoveStruct + MOVE_EFFECT]
;    cp EFFECT_SUCKER_PUNCH
;   jr nz, .notUsingSuckerPunch
;	call AI_50_50
;	ret c
;
;.notUsingSuckerPunch
; if we are faster and player is flying or underground just boost
    call DoesAIOutSpeedPlayer
    jr nc, .checkEvasion
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jp nz, .boost

.checkEvasion
; if AI evasion is >= +2 then go for the boost - only used by Patches
	ld a, [wEnemyEvaLevel]
	cp BASE_STAT_LEVEL + 2
	jp nc, .boost

.checkHaze
; if the player has roar/whirlwind/haze and we aren't immune to it then 50% to not boost
    ld a, [wEnemyMonSpecies]
    call DoesPokemonHaveUberImmunity
   	jr c, .noForceSwitch

    ld a, [wCurPlayerMove]
	call AIGetPlayerMove
    ld a, [wPlayerMoveStruct + MOVE_EFFECT]
    cp EFFECT_FORCE_SWITCH
    jp z, .dontBoost

    ld b, EFFECT_FORCE_SWITCH
	call PlayerHasMoveEffect
	jr c, .maybeDontBoost
    ld b, EFFECT_RESET_STATS
	call PlayerHasMoveEffect
	jr c, .maybeDontBoost
	jr .noForceSwitch
.maybeDontBoost
	call Random
	cp 50 percent
	jp c, .decideNotToBoost
.noForceSwitch

; if our offence is already at or over +1 and either side can 2HKO, just attack
; this is to prevent the AI from boosting until it only gets one attack off, should attack earlier for more damage
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 1
	jr c, .checkSpecialAttack
    jr .checkMutual2HKO
.checkSpecialAttack
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 1
	jr c, .checkSpeed
.checkMutual2HKO

; if AI is Zygarde and player is physical then skip mutual 2HKO check
;    ld a, [wEnemyMonSpecies]
;    cp ZYGARDE
;    jr nz, .checkAsUsual
;    call IsPlayerPhysicalOrSpecial
;   jr c, .checkSpeed
;.checkAsUsual

	call CanAI2HKO
	jp c, .decideNotToBoost
	call CanPlayer2HKO
	jr c, .decideNotToBoost

.checkSpeed
; who moves first
    call DoesAIOutSpeedPlayer
    jr nc, .playerMovesFirst

.enemyMovesFirst
; if AI moves first consider if player can 1HKO
; first if the AI has an intact focus sash or sturdy it can boost, unless player has priority move
; does player have priority move
	ld b, EFFECT_PRIORITY_HIT
	call PlayerHasMoveEffect
	jr c, .skipSturdySashCheck

    call DoesEnemyHaveIntactFocusSashOrSturdy
    jp c, .boost

.skipSturdySashCheck
    call CanPlayerKO
    jr c, .decideNotToBoost
    jp .boost

.playerMovesFirst
; does the boost increase speed, these moves are treated differently
	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	cp DRAGON_DANCE
	jr z, .enemyMovesFirst
	cp QUIVER_DANCE
	jr z, .enemyMovesFirst

; if player moves first consider if they can 2HKO
    call CanPlayer2HKO
    jr c, .decideNotToBoost
    jp .boost

.decideNotToBoost
; if player is SLP and we get more than one turn before they wake up, then boost
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .keepgoing

    call DoesAIOutSpeedPlayer
    jr nc, .playerFaster
    ld b, 1
    jr .checkSleep
.playerFaster
    ld b, 2

.checkSleep
    ld a, [wBattleMonStatus]
	and SLP_MASK
    cp b
	jr z, .keepgoing
	jr .boost

.keepgoing
; is the player behind a sub, if so don't boost, just attack
; unless we have baton pass, in which case boost up
    ld b, EFFECT_BATON_PASS
	call AIHasMoveEffect
	jr c, .skipSubCheck
    ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a	;check for substitute bit
	jr nz, .dontBoost
.skipSubCheck

; is the player setting up - if so we may want to boost to force them to stop and attack
; if the player already has +4 attack or special attack then they have already set up, just attack
; if the AI already has +2 attack or special attack then just attack
; if the players last move was a healing move 50% chance to set up if we can't already 2HKO from max HP
; otherwise if the players last move was non-damaging 50% chance to set up if we can't already 3HKO from current HP
	ld a, [wPlayerAtkLevel]
	cp BASE_STAT_LEVEL + 4
	jr nc, .dontBoost
	ld a, [wPlayerSAtkLevel]
	cp BASE_STAT_LEVEL + 4
	jr nc, .dontBoost

	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .dontBoost
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .dontBoost

    ld a, [wCurPlayerMove]
	call AIGetPlayerMove
    ld a, [wPlayerMoveStruct + MOVE_EFFECT]
    cp EFFECT_HEAL
    jr z, .check2HKOMaxHp
    cp EFFECT_WEATHER_HEAL
    jr z, .check2HKOMaxHp

    push hl
    push de
    push bc
	ld hl, BoostingMoveEffects
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr c, .check2HKO
	jr .dontBoost
.check2HKO
	call CanAI2HKO
	jr c, .dontBoost
    call Random
    cp 25 percent + 1
    jr c, .dontBoost
	jr .boost
.check2HKOMaxHp
	call CanAI2HKOMaxHP
	jr c, .dontBoost
    call Random
    cp 25 percent + 1
    jr c, .dontBoost

.boost
    scf ; set carry flag
    ret
.dontBoost
    xor a ; clear carry flag
    ret

PlayerHasMoveEffect:
; Return carry if the player has move b.

	push hl
	ld hl, wBattleMonMoves
	ld c, NUM_MOVES

.checkmove
	ld a, [hli]
	and a
	jr z, .no

	call AIGetPlayerMove

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp b
	jr z, .yes

	dec c
	jr nz, .checkmove

.no
	pop hl
	and a
	ret

.yes
	pop hl
	scf
	ret

; return carry if the AI has a move that can 2HKO the player Pokemon from current HP
CanAI2HKOMaxHP:
    ld de, wEnemyMonMoves ; load AI moves
	ld b, NUM_MOVES + 1
.loopMoves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .loopMoves ; skip moves with 0 power

    ld a, 1
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; double current damage
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	add hl, hl
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
; continue
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wBattleMonMaxHP + 1]
	cp c ; compare upper
	ld a, [wBattleMonMaxHP]
    sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
    jp nc, .loopMoves
; skip moves that can't be used on consecutive turns, except hyper beam
    ld a, [wEnemyMonSpecies]
    cp PORYGON2
    jr z, .setFlag
;    cp URSALUNA_B
;    jr z, .setFlag
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loopMoves
	cp EFFECT_HYPER_BEAM
	jr z, .loopMoves
	cp EFFECT_SOLARBEAM
	jr z, .loopMoves
.setFlag
    scf
    ret
.done
    xor a ; clear carry flag
    ret

; return carry if the AI has a move that can 2HKO the player Pokemon from current HP
CanAI2HKO:
    ld de, wEnemyMonMoves ; load AI moves
	ld b, NUM_MOVES + 1
.loopMoves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .loopMoves ; skip moves with 0 power

    ld a, 1
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; double current damage
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	add hl, hl
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
; continue
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wBattleMonHP + 1]
	cp c ; compare upper
	ld a, [wBattleMonHP]
    sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
    jp nc, .loopMoves
; skip moves that can't be used on consecutive turns, except hyper beam
    ld a, [wEnemyMonSpecies]
    cp PORYGON2
;    jr z, .setFlag
;    cp URSALUNA_B
    jr z, .setFlag
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loopMoves
	cp EFFECT_HYPER_BEAM
	jr z, .loopMoves
	cp EFFECT_SOLARBEAM
	jr z, .loopMoves
.setFlag
    scf
    ret
.done
    xor a ; clear carry flag
    ret

DoesEnemyHaveIntactFocusSashOrSturdy:
; Is the AI at full HP
    call AICheckEnemyMaxHP
    jr nc, .no

; focus sash
	push hl
	push de
	ld a, [wEnemyMonItem]
	ld [wNamedObjectIndex], a
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_FOCUS_BAND
	pop de
	pop hl
	jr z, .yes

; sturdy
    ld a, [wEnemyMonSpecies]
    push bc
    push hl
    push de
	ld hl, AI_SturdyPokemon
	ld de, 1
	call IsInArray
	pop de
	pop hl
	pop bc
	jr c, .yes

.no
    xor a ; clear carry flag
    ret
.yes
    scf
    ret

DoesPokemonHaveUberImmunity:
    push hl
    push de
   	push bc
   	ld hl, AI_UberImmunePokemon
   	ld de, 1
   	call IsInArray
   	pop bc
   	pop de
   	pop hl
   	jr c, .yes
   	xor a
   	ret
.yes
    scf
    ret

DoesEnemyHaveChoiceItem:
	push hl
	push de
	ld a, [wEnemyMonItem]
	ld [wNamedObjectIndex], a
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_CHOICE_BAND
	jr z, .yes
	cp HELD_CHOICE_SPECS
	jr z, .yes
	pop de
	pop hl
	xor a
	ret
.yes
	pop de
	pop hl
	scf
	ret

IsSpecialAttackMaxed:
    ld a, [wEnemySAtkLevel]
    cp BASE_STAT_LEVEL + 6
    jr z, .yes

    ld a, [wEnemyMonSpclAtk + 1]
    sub LOW(MAX_STAT_VALUE)
	jr nz, .no
	ld a, [wEnemyMonSpclAtk]
	sbc HIGH(MAX_STAT_VALUE)
	jr z, .yes
.no
    xor a
    ret
.yes
    scf
    ret

IsSpecialDefenseMaxed:
    ld a, [wEnemySDefLevel]
    cp BASE_STAT_LEVEL + 6
    jr z, .yes

    ld a, [wEnemyMonSpclDef + 1]
    sub LOW(MAX_STAT_VALUE)
	jr nz, .no
	ld a, [wEnemyMonSpclDef]
	sbc HIGH(MAX_STAT_VALUE)
	jr z, .yes
.no
    xor a
    ret
.yes
    scf
    ret

IsAttackMaxed:
    ld a, [wEnemyAtkLevel]
    cp BASE_STAT_LEVEL + 6
    jr z, .yes

    ld a, [wEnemyMonAttack + 1]
    sub LOW(MAX_STAT_VALUE)
	jr nz, .no
	ld a, [wEnemyMonAttack]
	sbc HIGH(MAX_STAT_VALUE)
	jr z, .yes
.no
    xor a
    ret
.yes
    scf
    ret

IsDefenseMaxed:
    ld a, [wEnemyDefLevel]
    cp BASE_STAT_LEVEL + 6
    jr z, .yes

    ld a, [wEnemyMonDefense + 1]
    sub LOW(MAX_STAT_VALUE)
	jr nz, .no
	ld a, [wEnemyMonDefense]
	sbc HIGH(MAX_STAT_VALUE)
	jr z, .yes
.no
    xor a
    ret
.yes
    scf
    ret
