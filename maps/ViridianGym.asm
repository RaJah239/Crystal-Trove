	object_const_def
	const VIRIDIANGYM_BLUE
	const VIRIDIANGYM_GYM_GUIDE

ViridianGym_MapScripts:
	def_scene_scripts

	def_callbacks

ViridianGymBlueScript:
	faceplayer
	opentext
	checkflag ENGINE_EARTHBADGE
	iftrue .FightDone
	writetext LeaderBlueBeforeText
	waitbutton
	closetext
	winlosstext LeaderBlueWinText, 0
	loadtrainer BLUE, BLUE1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLUE
	opentext
	writetext Text_ReceivedEarthBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_EARTHBADGE
.FightDone:
	iftrue .GotBluesTM
	writetext LeaderBlueAfterText
	waitbutton
	verbosegiveitem TM_SANDSTORM
	iffalse .GotBluesTM
.GotBluesTM:
	checkevent EVENT_BEAT_RED
	iftrue .OfferRematch
	; player hasn't beaten RED yet
	writetext LeaderBlueEpilogueText
	waitbutton
	closetext
	end

.OfferRematch:
	writetext BlueRematchText
	yesorno
	iftrue .DoRematch
	; keep going if false
	
.DontDoRematch:
	writetext BlueRematchRefuseText
	waitbutton
	closetext
	end

.DoRematch:
	writetext BlueRematchAcceptText
	waitbutton
	closetext
	winlosstext BlueRematchLossText, 0
	loadtrainer BLUE, BLUE2
	startbattle
	reloadmapafterbattle
	opentext
	writetext BlueRematchAfterText
	waitbutton
	closetext
	end

ViridianGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BLUE
	iftrue .ViridianGymGuideWinScript
	writetext ViridianGymGuideText
	waitbutton
	closetext
	end

.ViridianGymGuideWinScript:
	writetext ViridianGymGuideWinText
	waitbutton
	closetext
	end

ViridianGymStatue:
	checkflag ENGINE_EARTHBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script

.Beaten:
	gettrainername STRING_BUFFER_4, BLUE, BLUE1
	jumpstd GymStatue2Script

LeaderBlueBeforeText:
	text "BLUE: Yo! Finally"
	line "got here, huh?"

	para "I wasn't in the"
	line "mood at CINNABAR,"

	para "but now I'm ready"
	line "to battle you."

	para "…"

	para "You're telling me"
	line "you conquered all"
	cont "the GYMS in JOHTO?"

	para "Heh! JOHTO's GYMS"
	line "must be pretty"
	cont "pathetic then."

	para "Hey, don't worry"
	line "about it."

	para "I'll know if you"
	line "are good or not by"

	para "battling you right"
	line "now."

	para "Ready, JOHTO"
	line "CHAMP?"
	done

LeaderBlueWinText:
	text "BLUE: What?"

	para "How the heck did I"
	line "lose to you?"

	para "…"

	para "Tch, all right…"
	line "Here, take this--"
	cont "it's EARTHBADGE."
	done

Text_ReceivedEarthBadge:
	text "<PLAYER> received"
	line "EARTHBADGE."

	para "TRADED #MON"
	line "OBEDIENCE & LEVEL"
	cont "CAP UPDATE: L100"
	done

LeaderBlueAfterText:
	text "BLUE: …"

	para "All right, I was"
	line "wrong. You're the"

	para "real deal. You are"
	line "a good trainer."

	para "As a GYM LEADER I"
	line "must confer a TM"
	cont "to you as well."
	
	para "Take this."
	done

LeaderBlueEpilogueText:
	text "BLUE: Listen, you."

	para "You'd better not"
	line "lose until I beat"
	cont "you. Got it?"
	done

BlueRematchText:
 	text "BLUE: So you've"
	line "gone and beaten"
	cont "RED too!"

	para "You're no joke!"

	para "<PLAY_G>, I now"
	line "consider you a"
	cont "rival of mine!"
	
	para "I've become a lot"
	line "stronger compared"

	para "to our previous"
	line "battle."

	para "And I'll prove it"
	line "right now."

	para "How about it,"
	line "CHAMP?"
	done 
	
BlueRematchAcceptText:
	text "I'm gonna use"
	line "everything against"
	cont "you <PLAY_G>!"
 	
	para "Prepare to be"
	line "knocked down!"
	done 

BlueRematchRefuseText:
	text "Tch. Whatever. You"
	line "sound busy anyway."
	done 

BlueRematchLossText:
	text "You're tough, I'll"
	line "give you that."
	done

BlueRematchAfterText:
	text "As I expected!"

	para "No wonder you're"
	line "the CHAMP."
	done

ViridianGymGuideText:
	text "Yo, CHAMP in"
	line "making!"

	para "How's it going?"
	line "Looks like you're"
	cont "on a roll."

	para "The GYM LEADER is"
	line "a guy who battled"

	para "the CHAMPION three"
	line "years ago."

	para "He's no pushover."

	para "Give it everything"
	line "you've got!"
	done

ViridianGymGuideWinText:
	text "Man, you are truly"
	line "tough…"

	para "That was a heck of"
	line "an inspirational"

	para "battle. It brought"
	line "tears to my eyes."
	done

ViridianGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, VIRIDIAN_CITY, 1
	warp_event  5, 17, VIRIDIAN_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, ViridianGymStatue
	bg_event  6, 13, BGEVENT_READ, ViridianGymStatue

	def_object_events
	object_event  5,  3, SPRITE_BLUE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianGymBlueScript, EVENT_VIRIDIAN_GYM_BLUE
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianGymGuideScript, EVENT_VIRIDIAN_GYM_BLUE
