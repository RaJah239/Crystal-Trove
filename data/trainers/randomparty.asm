; Trainer data structure:
; - db "NAME@", TRAINERTYPE_* constants |ed together
; - 1 to 6 Pokémon:
;    * in all cases:              db level, species
;    * with TRAINERTYPE_NICKNAME: db "NICKNAME@"
;    * with TRAINERTYPE_DVS:      db atk|def dv, spd|spc dv
;    * with TRAINERTYPE_EVS: 	  db hp, atk, def, spd, sat, sdf 
;    * with TRAINERTYPE_ITEM:     db item
;    * with TRAINERTYPE_MOVES:    db move 1, move 2, move 3, move 4
;    (TRAINERTYPE_ITEM_MOVES is just TRAINERTYPE_ITEM | TRAINERTYPE_MOVES)
; - db -1 ; end

SECTION "Random Party Lists", ROMX


RedGroup:
	; RED (1)
	db "RED1@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, RANDOMLIST_0
	db -1 ; end

	; RED (1)
	db "RED2@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 6, RANDOMLIST_1
	db -1 ; end

RandomPartyLists::

   ; RANDOMLIST_0
	db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DD, $DD		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

	; RANDOMLIST_1
	db 18
	db 50, TYRANITAR
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db FOCUS_SASH	; ITEM/ NO_ITEM is a thing
			db EARTHQUAKE, ROCK_SLIDE, DRAGON_DANCE, THROAT_CHOP ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, MEWTWO
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db AURA_SPHERE, PSYCHIC_M, RECOVER, CALM_MIND ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, SNORLAX
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db CURSE, REST, ROCK_SLIDE, BODY_SLAM ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, RAIKOU
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db SCALD, THUNDERBOLT, CRUNCH, EXTREMESPEED ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, DRAGONITE
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db DRAGON_CLAW, WATERFALL, DRAGON_DANCE, FIRE_BLAST ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, AERODACTYL
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LIFE_ORB	; ITEM/ NO_ITEM is a thing
			db EARTHQUAKE, IRON_HEAD, SKY_ATTACK, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, LUGIA
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db CALM_MIND, RECOVER, AEROBLAST, SCALD ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, HO_OH
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db SACRED_FIRE, DRILL_PECK, RECOVER, BULK_UP ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, QUAGSIRE
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db QUICK_CLAW	; ITEM/ NO_ITEM is a thing
			db SCALD, PROTECT, RECOVER, TOXIC ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, CHARIZARD
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LIFE_ORB	; ITEM/ NO_ITEM is a thing
			db DRAGON_CLAW, SACRED_FIRE, DRAGON_DANCE, SOLARBEAM ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, MEGANIUM
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db SEED_BOMB, PLAY_ROUGH, HEALING_LIGHT, AGILITY ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, QUAGSIRE
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db QUICK_CLAW	; ITEM/ NO_ITEM is a thing
			db SCALD, PROTECT, RECOVER, TOXIC ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, CHARIZARD
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LIFE_ORB	; ITEM/ NO_ITEM is a thing
			db DRAGON_CLAW, SACRED_FIRE, DRAGON_DANCE, SOLARBEAM ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, MEWTWO
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db AURA_SPHERE, PSYCHIC_M, RECOVER, CALM_MIND ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, SNORLAX
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db CURSE, REST, ROCK_SLIDE, BODY_SLAM ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, AERODACTYL
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LIFE_ORB	; ITEM/ NO_ITEM is a thing
			db EARTHQUAKE, IRON_HEAD, SKY_ATTACK, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, LUGIA
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db CALM_MIND, RECOVER, AEROBLAST, SCALD ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, HO_OH
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db SACRED_FIRE, DRILL_PECK, RECOVER, BULK_UP ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end
