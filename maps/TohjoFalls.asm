	object_const_def
	const TOHJOFALLS_POKE_BALL
	const TOHJOFALLS_GIOVANNI

TohjoFalls_MapScripts:
	def_scene_scripts

	def_callbacks

TohjoFallsMoonStone:
	itemball MOON_STONE

GiovanniScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_TOHJOFALLS_GIOVANNI
	iftrue .FightDone
	writetext GiovanniIntroText
	waitbutton
	closetext
	winlosstext GiovanniMatchLossText, 0
    loadtrainer GIOVANNI, GIOVANNI1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_TOHJOFALLS_GIOVANNI
    opentext
    writetext GiovanniMatchAfterText1
    waitbutton
    closetext
    end
	
.FightDone: 
    writetext GiovanniMatchAcceptText
    yesorno
    iftrue .DoMatch
    ; keep going if false 

.DontDoMatch:
    writetext GiovanniMatchRefuseText
    waitbutton
    closetext
    end 

.DoMatch:
    checkevent EVENT_BEAT_RED
	iftrue .DoMatch2
; player hasn't beaten Red yet
    writetext GiovanniMatchAcceptText2
    waitbutton
    closetext
	winlosstext GiovanniMatchLossText, 0
    loadtrainer GIOVANNI, GIOVANNI1
	startbattle
	reloadmapafterbattle
	opentext
	writetext GiovanniMatchAfterText
    waitbutton
    closetext
    end

.DoMatch2:
    writetext GiovanniMatchAcceptText2
    waitbutton
    closetext
    winlosstext GiovanniMatchLossText, 0
    loadtrainer GIOVANNI, GIOVANNI2
    startbattle
    reloadmapafterbattle
    opentext
    writetext GiovanniMatchAfterText
    waitbutton
    closetext
    end  

GiovanniIntroText:
	text "GIOVANNI: You…"
	line "You're not an"
	cont "ordinary trainer,"
	cont "are you?"
	
	para "I am known as"
	line "GIOVANNI."
	
	para "I once was at the"
	line "helm of a mighty"

	para "but very corrupt"
	line "organization."
	
	para "But thanks to a"
	line "young boy and his"

	para "loyal #MON,"
	line "much like you, it"
	cont "fell apart."
	
	para "I realized my"
	line "faults and dis-"
	cont "banded it."
	
	para "I sense a similar"
	line "aura about you."

	para "We shall engage"
	line "in battle!"
	done

GiovanniMatchAcceptText:
	text "Shall we engage"
	line "in battle once"
	cont "more <PLAY_G>?"
	done
	
GiovanniMatchRefuseText:
	text "Hm. Very well."
	done 
	
GiovanniMatchLossText:
	text "Splendid! That was"
	line "perfect!" 
	done

GiovanniMatchAcceptText2:
	text "I extend my"
	line "sincere gratitude."
	done

GiovanniMatchAfterText:
	text "Fascinating! Just"
	line "as I thought!"
	done
	
GiovanniMatchAfterText1:
	text "I was right about"
	line "you. The world is"

	para "vast. Pursue all"
	line "you are able to."
 
	para "And when the time"
	line "comes…"
 
	para "Let us battle once"
	line "more, when you've"

	para "conquered the"
	line "highest peaks and"

	para "faced unbeatable"
	line "challenges."

	para "I shall await you"
	line "right here until"
	cont "you do."

	para "Keep striving"
	line "until then."
	done

TohjoFalls_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13, 15, ROUTE_27, 2
	warp_event 25, 15, ROUTE_27, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TohjoFallsMoonStone, EVENT_TOHJO_FALLS_MOON_STONE
	object_event 22, 12, SPRITE_GIOVANNI, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GiovanniScript, EVENT_TOHJO_FALLS_GIOVANNI
