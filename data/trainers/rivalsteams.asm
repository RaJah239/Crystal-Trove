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

; EXAMPLE
;	; RED (1)
;	db "Red@", TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM_MOVES
;	db 100, PIKACHU
;		db "CHU@"
;		db $EA, $AA ; atk|def dv, spd|spc dv
;		ds 6, MAX_EV ; hp, atk, def, spd, sat, sdf 
;		db LIGHT_BALL
;		db SILVER_WIND, QUICK_ATTACK, THUNDERBOLT, THUNDER
;	db 100, ESPEON
;		db "PAWS@"
;		db $EC, PERFECT_DV ; atk|def dv, spd|spc dv
;		db 12, 16, 12, 16, 16, 12 ; hp, atk, def, spd, sat, sdf 
;		db TWISTEDSPOON
;		db HIDDEN_POWER, REFLECT, HEALING_LIGHT, PSYCHIC_M
;	db -1 ; end

SECTION "Rival's Teams", ROMX

Rival1Group:
Rival2Group:
	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end

	; PLACE_HOLDER (1)
	db "Q@", TRAINERTYPE_NORMAL
	db  5, PIDGEY
	db -1 ; end
