	object_const_def
	const ROUTE42ECRUTEAKGATE_OFFICER
	const ROUTE42ECRUTEAKGATE_OFFICER_BLOCKER

Route42EcruteakGate_MapScripts:
	def_scene_scripts
	scene_script Route42EcruteakGateScene1, SCENE_ROUTE42ECRUTEAKGATE_OFFICER_BLOCKER
	scene_script Route42EcruteakGateFNoop1, SCENE_ROUTE42ECRUTEAKGATE_NOOP

	def_callbacks

Route42EcruteakGateScene1:
	end

Route42EcruteakGateFNoop1:
	end

Route42EcruteakGateOfficerSceneScript:
	showemote EMOTE_SHOCK, ROUTE42ECRUTEAKGATE_OFFICER_BLOCKER, 15
	applymovement ROUTE42ECRUTEAKGATE_OFFICER_BLOCKER, Route42EcruteakGateOfficerWalksInfrontPlayer
	turnobject ROUTE42ECRUTEAKGATE_OFFICER_BLOCKER, LEFT
	opentext
	writetext MtMortarLandslideText
	waitbutton
	closetext
	applymovement PLAYER, PlayerForecedAStepLeft
	applymovement ROUTE42ECRUTEAKGATE_OFFICER_BLOCKER, Route42EcruteakGateOfficerWalksBackInSpot
	turnobject ROUTE42ECRUTEAKGATE_OFFICER_BLOCKER, DOWN
	end

Route42EcruteakGateOfficerWalksInfrontPlayer:
	step RIGHT
	step DOWN
	step_end

PlayerForecedAStepLeft:
	step LEFT
	step_end

Route42EcruteakGateOfficerWalksBackInSpot:
	step UP
	step LEFT
	step_end

Route42EcruteakGateOfficerScript:
	jumptextfaceplayer Route42EcruteakGateOfficerText

Route42EcruteakGateOfficerBlockerScript:
	jumptextfaceplayer MtMortarLandslideText

MtMortarLandslideText:
	text "Sorry, you can't"
	line "come this way."

	para "There's been an"
	line "avalanche on"
	cont "MT.MORTAR."

	para "The rubble's still"
	line "being cleared."
	done

Route42EcruteakGateOfficerText:
	text "MT.MORTAR is like"
	line "a maze inside."

	para "Be careful. Don't"
	line "get lost in there."
	done

Route42EcruteakGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, ECRUTEAK_CITY, 1
	warp_event  0,  5, ECRUTEAK_CITY, 2
	warp_event  9,  4, ROUTE_42, 1
	warp_event  9,  5, ROUTE_42, 2

	def_coord_events
	coord_event  5,  5, SCENE_ROUTE42ECRUTEAKGATE_OFFICER_BLOCKER, Route42EcruteakGateOfficerSceneScript

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route42EcruteakGateOfficerScript, EVENT_ROUTE_42_ECRUTEAKGATE_OFFICER
	object_event  5,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route42EcruteakGateOfficerBlockerScript, EVENT_ROUTE_42_ECRUTEAKGATE_OFFICER_BLOCKER
