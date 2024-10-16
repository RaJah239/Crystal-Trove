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

; EXAMPLE -: The Trainer's Group must be above RandomPartyLists::
MaximaGroup: 
	; MAXIMA (1)
	db "MAXIMA@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 3, OAKSRANDOMLIST ; OAKSRANDOMLIST matches const OAKSRANDOMLIST
	db -1 ; end

OakGroup:
	; OAK (1)
	db "OAK@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 3, OAKSRANDOMLIST ; OAKSRANDOMLIST matches const OAKSRANDOMLIST
	db -1 ; end

GiovanniGroup:
	; GIOVANNI1 (1)
	db "GIOVANNI@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 3, GIOVANNILIST1 ; GIOVANNILIST1 matches const GIOVANNILIST1
	db -1 ; end

	; GIOVANNI2 (2)
	db "GIOVANNI@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 2, GIOVANNILIST2 ; GIOVANNILIST2 matches const GIOVANNILIST2
	db -1 ; end

ProtonGroup:
	; PROTON1 (1)
	db "PROTON@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, PROTONLIST1 ; PROTONLIST1 matches const PROTONLIST1
	db -1 ; end

	; PROTON2 (2)
	db "PROTON@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, PROTONLIST2 ; PROTONLIST2 matches const PROTONLIST2
	db -1 ; end

PetrelGroup:
	; PETREL1 (1)
	db "PETREL@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, PETRELLIST1 ; PETRELLIST1 matches const PETRELLIST1
	db -1 ; end

	; PETREL2 (2)
	db "PETREL@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, PETRELLIST2 ; PETRELLIST2 matches const PETRELLIST2
	db -1 ; end

ArianaGroup:
	; ARIANA1 (1)
	db "ARIANA@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, ARIANALIST1 ; ARIANALIST1 matches const ARIANALIST1
	db -1 ; end

	; ARIANA2 (2)
	db "ARIANA@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, ARIANALIST2 ; ARIANALIST2 matches const ARIANALIST2
	db -1 ; end

ArcherGroup:
	; ARCHER1 (1)
	db "ARCHER@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, ARCHERLIST1 ; ARCHERLIST1 matches const ARCHERLIST1
	db -1 ; end

	; ARCHER2 (2)
	db "ARCHER@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, ARCHERLIST2 ; ARCHERLIST2 matches const ARCHERLIST2
	db -1 ; end

	; ARCHER3 (3)
	db "ARCHER@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, ARCHERLIST3 ; ARCHERLIST3 matches const ARCHERLIST3
	db -1 ; end

LoreleiGroup:
	; LORELEI1 (1)
	db "LORELEI@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, LORELEILIST1 ; LORELEILIST1 matches const LORELEILIST1
	db -1 ; end

	; LORELEI2 (2)
	db "LORELEI@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, LORELEILIST2 ; LORELEILIST2 matches const LORELEILIST2
	db -1 ; end

AgathaGroup:
	; AGATHA1 (1)
	db "AGATHA@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, AGATHALIST1 ; AGATHALIST1 matches const AGATHALIST1
	db -1 ; end

	; AGATHA2 (2)
	db "AGATHA@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, AGATHALIST2 ; AGATHALIST2 matches const AGATHALIST2
	db -1 ; end

ElderGroup:
	; ELDER_LI1 (1)
	db "LI@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, ELDERLILIST1 ; ELDERLILIST1 matches const ELDERLILIST1
	db -1 ; end

	; ELDER_LI2 (2)
	db "LI@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, ELDERLILIST2 ; ELDERLILIST2 matches const ELDERLILIST2
	db -1 ; end

RandomPartyLists::

; EXAMPLE from above continued -:
   ; MAXIMA1
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; OAK1
   db 3
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, TAUROS
			db "MUCY@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; GIOVANNI1
   db 3
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, TAUROS
			db "MUCY@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; GIOVANNI2
   db 3
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, TAUROS
			db "MUCY@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; PROTON1
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; PROTON2
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; PETREL1
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; PETREL2
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; ARIANA1
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; ARIANA2
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; ARCHER1
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; ARCHER2
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; ARCHER3
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; LORELEI1
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; LORELEI2
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; AGATHA1
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; AGATHA2
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; ELDER_LI1
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end

   ; ELDER_LI2
   db 2
	db 1, VENUSAUR
			db "DINO@"		; Nickname
			db $EA, $AA		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db 1, CHARIZARD
			db "ZARD@"		; Nickname
			db $DE, $DD		; atk|def dv, spd|spc dv
			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; NO_ITEM is a thing
			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
			db $fe ; End of Pokemon
	db -1 ; end
