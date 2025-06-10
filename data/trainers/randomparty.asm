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
	db 6
	db 50, PIKACHU
			db "PIKA@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LIGHT_BALL	; ITEM/ NO_ITEM is a thing
			db THUNDERBOLT, SURF, EXTREMESPEED, SWAGGER ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, MEWTWO
			db "TWO@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db RECOVER, PSYCHIC_M, FIRE_BLAST, SUBMISSION ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, SNORLAX
			db "LAX@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db REST, SLEEP_TALK, BODY_SLAM, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, VENUSAUR
			db "SAUR@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, CHARIZARD
			db "ZARD@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db FLAMETHROWER, WING_ATTACK, EARTHQUAKE, SWAGGER ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 50, BLASTOISE
			db "TORPEDO@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db SURF, BLIZZARD, EARTHQUAKE, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end
