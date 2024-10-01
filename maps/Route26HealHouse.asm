	object_const_def
	const ROUTE26HEALHOUSE_TEACHER
	const ROUTE26HEALHOUSE_PORYGON_PC

Route26HealHouse_MapScripts:
	def_scene_scripts

	def_callbacks

Route26HealHouseTeacherScript:
	faceplayer
	opentext
	writetext Route26HealHouseRestAWhileText
	waitbutton
	closetext
	special FadeOutToWhite
	special StubbedTrainerRankings_Healings
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInFromWhite
	opentext
	writetext Route26HealHouseKeepAtItText
	waitbutton
	closetext
	end

Route26HealHouseBookshelf:
	jumpstd PictureBookshelfScript

Route26HealHouseRestAWhileText:
	text "Your #MON look"
	line "a little tired."

	para "You should rest"
	line "them a while."
	done

Route26HealHouseKeepAtItText:
	text "There!"
	line "Keep at it!"
	done

Route26HealHousePorygonPCScript:
	faceplayer
	opentext
	writetext Route26HealHousePorygonPCText
	cry PORYGON
	pause 10
	special PokemonCenterPC
	reloadmappart
	end

Route26HealHousePorygonPCText:
	text "#MON Storage"
	line "System opened."
	done

Route26HealHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_26, 2
	warp_event  3,  7, ROUTE_26, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, Route26HealHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, Route26HealHouseBookshelf

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route26HealHouseTeacherScript, -1
	object_event  4,  1, SPRITE_PORYGON_OW, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route26HealHousePorygonPCScript, -1
