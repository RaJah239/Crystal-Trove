	db LUGIA ; 249

	db 106,  90, 130, 110,  90, 154
	evs  0,   0,   0,   0,   0,   3
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, FLYING ; type
	db 3 ; catch rate
	db 220 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_UNKNOWN ; gender ratio
	db 120 ; step cycles to hatch
	INCBIN "gfx/pokemon/lugia/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
