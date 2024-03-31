	object_const_def
	const MOVEDELETERSHOUSE_SUPER_NERD
	const MOVEDELETERSHOUSE_EGG_TUTOR
	const MOVEDELETERSHOUSE_OFFENSE_TUTOR

MoveDeletersHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MoveDeleterScript:
	faceplayer
	opentext
	special MoveDeletion
	waitbutton
	closetext
	end


EggTutorScript:
	faceplayer
	opentext
	special EggMaster
	waitbutton
	closetext
	turnobject MOVEDELETERSHOUSE_EGG_TUTOR, RIGHT
	end

BlackthornTutorScript:
	faceplayer
	opentext
	writetext ShowAMoveText
	special DisplayCoinCaseBalance
	yesorno
	iffalse .Refused
	checkcoins 9999
	ifequal HAVE_LESS, .NotEnoughMoney
	writetext WhatMoveShouldITeachText
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .RockSlide
	ifequal 2, .Submission
	ifequal 3, .Outrage
	sjump .Incompatible

.RockSlide:
	setval ROCK_SLIDE
	writetext BlackthornTutorMoveText
	special MoveTutor
	ifequal FALSE, .TeachMove
	sjump .Incompatible

.Submission:
	setval SUBMISSION
	writetext BlackthornTutorMoveText
	special MoveTutor
	ifequal FALSE, .TeachMove
	sjump .Incompatible

.Outrage:
	setval OUTRAGE 
	writetext BlackthornTutorMoveText
	special MoveTutor
	ifequal FALSE, .TeachMove
	sjump .Incompatible

.Refused:
	writetext ComeAgainText
	waitbutton
	closetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end
	
.Incompatible:
	writetext IncompatibleorCancelText
	waitbutton
	closetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end
	
.NotEnoughMoney:
	writetext BlackthornMoveTutorYouDontHaveEnoughMoneyText
	waitbutton
	closetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end

.TeachMove:
	playsound SFX_TRANSACTION
	takecoins 9999
	special DisplayCoinCaseBalance
	writetext ThankYouText
	waitbutton
	closetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end 
	
.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "ROCK SLIDE@"
	db "SUBMISSION@"
	db "OUTRAGE@"
	db "CANCEL@"
	
ShowAMoveText:
	text "Hello. I am a"
	line "MOVE TUTOR."
	
	para "For 9,999 coins,"
	line "I'll teach your"

	para "#MON some very"
	line "powerful attacks!"
	
	para "Interested?"
	done 

ComeAgainText:
	text "Come again if you"
	line "change your mind."
	done

WhatMoveShouldITeachText:
	text "You won't regret"
	line "it!"
	
	para "Which move should"
	line "I teach?"
	done

ThankYouText:
	text "Come visit as much"
	line "as you want."
	done 

IncompatibleorCancelText:
	text "Maybe next time?"
	done 
	
BlackthornMoveTutorYouDontHaveEnoughMoneyText:
	text "You don't have"
	line "enough coins…"
	done

BlackthornTutorMoveText:
	text_start
	done

MoveDeletersHouseBookshelf:
	jumpstd DifficultBookshelfScript

MoveDeletersHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, BLACKTHORN_CITY, 6
	warp_event  3,  7, BLACKTHORN_CITY, 6

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, MoveDeletersHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, MoveDeletersHouseBookshelf

	def_object_events

	object_event  2,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MoveDeleterScript, -1
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EggTutorScript, -1
	object_event  5,  4, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BlackthornTutorScript, -1

