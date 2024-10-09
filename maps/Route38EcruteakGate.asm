	object_const_def
	const ROUTE38ECRUTEAKGATE_OFFICER
	const ROUTE38ECRUTEAKGATE_OFFICER_BLOCKER

Route38EcruteakGate_MapScripts:
	def_scene_scripts
	scene_script Route38EcruteakGateScene1, SCENE_ROUTE38ECRUTEAKGATE_OFFICER_BLOCKER
	scene_script Route38EcruteakGateFNoop1, SCENE_ROUTE38ECRUTEAKGATE_NOOP

	def_callbacks

Route38EcruteakGateScene1:
	end

Route38EcruteakGateFNoop1:
	end

Route38EcruteakGateOfficerSceneScript:
	showemote EMOTE_SHOCK, ROUTE38ECRUTEAKGATE_OFFICER_BLOCKER, 15
	applymovement ROUTE38ECRUTEAKGATE_OFFICER_BLOCKER, Route38EcruteakGateOfficerWalksInfrontPlayer
	turnobject ROUTE38ECRUTEAKGATE_OFFICER_BLOCKER, RIGHT
	opentext
	writetext HoldUpTrainerText
	promptbutton
	writetext Route38EcruteakGateOfficerBlockerText
	waitbutton
	closetext
	applymovement PLAYER, PlayerTakesAStepRight
	applymovement ROUTE38ECRUTEAKGATE_OFFICER_BLOCKER, Route38EcruteakGateOfficerWalksBackInSpot
	turnobject ROUTE38ECRUTEAKGATE_OFFICER_BLOCKER, DOWN
	end

Route38EcruteakGateOfficerWalksInfrontPlayer:
	step LEFT
	step DOWN
	step_end

PlayerTakesAStepRight:
	step RIGHT
	step_end

Route38EcruteakGateOfficerWalksBackInSpot:
	step UP
	step RIGHT
	step_end

Route38EcruteakGateOfficerScript:
	jumptextfaceplayer Route38EcruteakGateOfficerText

Route38EcruteakGateOfficerBlockerScript:
	jumptextfaceplayer Route38EcruteakGateOfficerBlockerText

HoldUpTrainerText:
	text "Hold up trainer!"
	done

Route38EcruteakGateOfficerBlockerText:
	text "It's unsafe to go"
	line "this way."
	
	para "There's a drove of"
	line "TAUROS rampaging"
	cont "out there."
	
	para "Come back when"
	line "things cool down."
	done

Route38EcruteakGateOfficerText:
	text "All's clear now."
	line "Go on through."
	done

Route38EcruteakGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, ROUTE_38, 1
	warp_event  0,  5, ROUTE_38, 2
	warp_event  9,  4, ECRUTEAK_CITY, 14
	warp_event  9,  5, ECRUTEAK_CITY, 15

	def_coord_events
	coord_event  2,  5, SCENE_ROUTE38ECRUTEAKGATE_OFFICER_BLOCKER, Route38EcruteakGateOfficerSceneScript


	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route38EcruteakGateOfficerScript, EVENT_ROUTE_38_ECRUTEAKGATE_OFFICER
	object_event  2,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route38EcruteakGateOfficerBlockerScript, EVENT_ROUTE_38_ECRUTEAKGATE_OFFICER_BLOCKER
