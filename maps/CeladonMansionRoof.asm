	object_const_def
		const CELADONMANSIONROOF_TEAM_ROCKET

CeladonMansionRoof_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonMansionRoofGraffiti:
	jumptext CeladonMansionRoofGraffitiText

CeladonArcherScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CELADON_ARCHER
	iftrue .FightDone
	writetext ArcherIntroText
	waitbutton
	closetext
	winlosstext ArcherWinLossText, 0
	loadtrainer ARCHER, ARCHER2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CELADON_ARCHER
	opentext
	writetext ArcherMatchAfterText
	waitbutton
	closetext
	turnobject CELADONMANSIONROOF_TEAM_ROCKET, RIGHT
	end
	
.FightDone: 
	writetext ArcherMatchText
	yesorno
	iftrue .DoMatch
	; keep going if false 

.DontDoMatch:
	writetext ArcherMatchRefuseText
	waitbutton
	closetext
	end 

.DoMatch:
	checkevent EVENT_BEAT_RED
	iftrue .DoMatch2
	; player hasn't beaten Red yet
	writetext ArcherMatchAcceptText
	waitbutton
	closetext
	winlosstext ArcherWinLossText, 0
	loadtrainer ARCHER, ARCHER2
	startbattle
	reloadmapafterbattle
	opentext
	writetext ArcherMatch2AfterText
	waitbutton
	closetext
	end

.DoMatch2:
	writetext ArcherMatchAcceptText
	waitbutton
	closetext
	winlosstext ArcherWinLossText, 0
	loadtrainer ARCHER, ARCHER3
	startbattle
	reloadmapafterbattle
	opentext
	writetext ArcherMatch2AfterText
	waitbutton
	closetext
	turnobject CELADONMANSIONROOF_TEAM_ROCKET, RIGHT
	end

ArcherIntroText:
	text "ARCHER: On this"
	line "roof, I've been"
	para "reflecting and"
	line "clearing my mind…"
	
	para "Much has occurred."
	
	para "I had a feeling"
	line "you'd come to"

	para "KANTO eventually"
	line "and we'd meet"
	cont "again."
	
	para "Did you know our"
	line "hideout was here"
	cont "three years ago?"

	para "I started as a"
	line "grunt and worked"
	cont "my way up."

	para "I thought I grasp-"
	line "ed GIOVANNI's"
	cont "ideals."

	para "But after RED"
	line "shattered us,"

	para "like you did in"
	line "JOHTO, everything"

	para "changed and he"
	line "vanished."
	
	para "Were we right?"
	
	para "I guess not, or"
	line "our leader would"

	para "not have quit his"
	line "endeavor."
	
	para "Thanks <PLAY_G>."

	para "I could've gone"
	line "down that path"
	cont "much longer."
	
	para "I don't have all"
	line "all the answers,"

	para "but what I do"
	line "have is an urge"

	para "to battle you"
	line "again."
	
	para "Once more, shall"
	line "we?"
	done 
	
ArcherWinLossText:
	text "As expected…"
	done 
	
ArcherMatchAfterText:
	text "I knew it would"
	line "end this way…"
	
	para "It takes a special"
	line "trainer to" 

	para "singlehandedly"
	line "foil our plans."
	
	para "I've heard no word"
	line "about the other"

	para "TEAM ROCKET"
	line "members."

	para "Our dream has come"
	line "to an end and the"

	para "organization is"
	line "done, for good"
	cont "this time."

	para "But, this may be"
	line "the right step"
	cont "forward."

	para "Let's battle again"
	line "in the future."
	
	para "Until then, keep"
	line "good."
	done

ArcherMatchText:
    text "<PLAY_G>…"
  
	para "Here for for a"
	line "rematch right?"
	done 

ArcherMatchAcceptText:
	text "I shall oblige."
	done 

ArcherMatchRefuseText:
	text "Alright…"
	done 

ArcherMatch2AfterText:
	text "You're always a"
	line "blast!"
	done

CeladonMansionRoofGraffitiText:
	text "There's graffiti"
	line "on the wall…"

	para "<PLAYER> added a"
	line "moustache!"
	done

CeladonMansionRoof_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  1,  1, CELADON_MANSION_3F, 1
	warp_event  6,  1, CELADON_MANSION_3F, 4
	warp_event  2,  5, CELADON_MANSION_ROOF_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_LEFT, CeladonMansionRoofGraffiti

	def_object_events
	object_event  7,  8, SPRITE_ARCHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonArcherScript, -1
