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
	db "RED2@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, RANDOMLIST_1
	db -1 ; end

RandomPartyLists::

   ; RANDOMLIST_0
	db 1
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DD, $DD		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			db SACRED_FIRE, NO_MOVE, NO_MOVE, NO_MOVE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

	; RANDOMLIST_1
	db 1
	db 50, MEWTWO
			db "Test@"		; Nickname
			db $11, $11		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db FOCUS_SASH	; ITEM/ NO_ITEM is a thing
			db EARTHQUAKE, NO_MOVE, NO_MOVE, NO_MOVE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end
