	object_const_def
	const ROUTE24_ROCKET

Route24_MapScripts:
	def_scene_scripts

	def_callbacks

Route24RocketScript:
	faceplayer
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext Route24RocketSeenText
	waitbutton
	closetext
	winlosstext Route24RocketBeatenText, -1
	loadtrainer GRUNTM, GRUNTM_31
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext Route24RocketAfterBattleText
	waitbutton
	verbosegiveitem MACHINE_PART
	setevent EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM
	clearevent EVENT_CELADON_MANSION_ROOF_TEAM_ROCKET_ARCHER
	promptbutton
	special FadeOutMusic
	writetext Route24RocketDisappearsText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear ROUTE24_ROCKET
	pause 25
	special FadeInFromBlack
	playmapmusic
	end

Route24RocketSeenText:
	text "Hey, kid! So you"
	line "tracked me down"
	cont "have you?"

	para "Seems like you're"
	line "not easy to shake."
	
	para "You must not know"
	line "that I'm a member"
	
	para "of the dreadful"
	line "TEAM ROCKET."

	para "So you want this"
	line "MACHINE PART that"
	cont "badly do you?"
	
	para "Then you'll have"
	line "to play by TEAM"
	cont "ROCKET's rules and"
	cont "take it by force!"
	done

Route24RocketBeatenText:
	text "Arrgh!! Strong!"
	done

Route24RocketAfterBattleText:
	text "You're truly"
	line "powerful kid!"

	para "I gave my all and"
	line "then some!"

	para "By TEAM ROCKET's"
	line "rules, you have"

	para "usurped this by"
	line "force."

	para "Take it!"
	done

Route24RocketDisappearsText:
	text "…"

	para "What's this you"
	line "you say?"
	
	para "TEAM ROCKET has"
	line "has been broken"

	para "up? Again? And by"
	line "you no less?"
	
	para "No wonder I stood"
	line "no chance!"
	
	para "That'd explain why"
	line "I have not been"

	para "given orders for"
	line "some time now."
	
	para "There's been some"
	line "rumors of ARCHER"
	
	para "in CELADON but I"
	line "haven't fond him…"

	para "I've been talking"
	line "aloud again…"

	para "Hmm…"

	para "I better get gone"
	line "before someone"
	cont "else spots me."

	para "Good luck kid!"
	line "Peace out!"
	done

Route24_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  7, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route24RocketScript, EVENT_ROUTE_24_ROCKET
