	object_const_def
	const LAVRADIOTOWER1F_RECEPTIONIST
	const LAVRADIOTOWER1F_OFFICER
	const LAVRADIOTOWER1F_SUPER_NERD1
	const LAVRADIOTOWER1F_GENTLEMAN
	const LAVRADIOTOWER1F_SUPER_NERD2
	const LAVRADIOTOWER1F_AGATHA

LavRadioTower1F_MapScripts:
	def_scene_scripts

	def_callbacks

LavRadioTower1FReceptionistScript:
	jumptextfaceplayer LavRadioTower1FReceptionistText

LavRadioTower1FOfficerScript:
	jumptextfaceplayer LavRadioTower1FOfficerText

LavRadioTower1FSuperNerd1Script:
	jumptextfaceplayer LavRadioTower1FSuperNerd1Text

LavRadioTower1FGentlemanScript:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue .GotExpnCard
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext LavRadioTower1FGentlemanText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext LavRadioTower1FGentlemanText_ReturnedMachinePart
	promptbutton
	getstring STRING_BUFFER_4, .expncardname
	scall .receiveitem
	setflag ENGINE_EXPN_CARD
.GotExpnCard:
	writetext LavRadioTower1FGentlemanText_GotExpnCard
	waitbutton
	closetext
	end

.receiveitem:
	jumpstd ReceiveItemScript
	end

.expncardname
	db "EXPN CARD@"

LavRadioTower1FSuperNerd2Script:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue .GotExpnCard
	writetext LavRadioTower1FSuperNerd2Text
	waitbutton
	closetext
	end

.GotExpnCard:
	writetext LavRadioTower1FSuperNerd2Text_GotExpnCard
	waitbutton
	closetext
	end

LavRadioTower1FDirectory:
	jumptext LavRadioTower1FDirectoryText

LavRadioTower1FPokeFluteSign:
	jumptext LavRadioTower1FPokeFluteSignText

AgathaScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_LAVRADIOTOWER1F_AGATHA
	iftrue .FightDone
	writetext AgathaIntroText
	waitbutton
	closetext
	winlosstext AgathaMatchLossText, 0
    loadtrainer AGATHA, AGATHA1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LAVRADIOTOWER1F_AGATHA
    opentext
    writetext AgathaMatchAfterText1
    waitbutton
    closetext
    end
	
.FightDone: 
    writetext AgathaMatchAcceptText
    yesorno
    iftrue .DoMatch
    ; keep going if false 

.DontDoMatch:
    writetext AgathaMatchRefuseText
    waitbutton
    closetext
    end 

.DoMatch:
    checkevent EVENT_BEAT_RED
	iftrue .DoMatch2
; player hasn't beaten Red yet
    writetext AgathaMatchAcceptText2
    waitbutton
    closetext
	winlosstext AgathaMatchLossText, 0
    loadtrainer AGATHA, AGATHA1
	startbattle
	reloadmapafterbattle
	opentext
	writetext AgathaMatchAfterText
    waitbutton
    closetext
    end

.DoMatch2:
    writetext AgathaMatchAcceptText2
    waitbutton
    closetext
    winlosstext AgathaMatchLossText, 0
    loadtrainer AGATHA, AGATHA2
    startbattle
    reloadmapafterbattle
    opentext
    writetext AgathaMatchAfterText
    waitbutton
    closetext
    end  

AgathaIntroText:
    text "AGATHA: That look"
	line "in your eyes…"
	
	para "You're the one OAK's"
	line "been keen on…"

	para "Mm… <PLAY_G> is"
	line "it?"

	para "Let me introduce"
	line "myself. I'm AGATHA"

	para "and was part of"
	line "the ELITE FOUR."

	para "OAK used to be"
	line "tough and good-"

	para "looking, but now"
	line "he's all about his"
	cont "#DEX."
	
	para "#MON are for"
	line "battling!"
	
	para "<PLAY_G>, brace"
	line "yourself! You are"

	para "about to see true"
	line "battling skills!"
	done

AgathaMatchAcceptText:
	text "Would you like" 
	line "to battle me,"
	cont "<PLAY_G>?"
	done
	
AgathaMatchRefuseText:
	text "Speak to me when"
	line "you are prepared."
	done 
	
AgathaMatchLossText:
	text "Oh, my! You're"
	line "indeed special!" 
	done

AgathaMatchAcceptText2:
	text "Show me your"
	line "full potential"
	cont "<PLAY_G>!"
	done

AgathaMatchAfterText:
	text "Mm… Good job"
	line "on winning."

	para "The future of"
	line "battling is in"
	cont "good hands."
	done

AgathaMatchAfterText1:
	text "So that old duff"
	line "can still see"

	para "incredible talent"
	line "even after all"
	cont "these years."
	
	para "You really are"
	line "quite special."

	para "I haven't had a"
	line "battle like this"

	para "since I fought"
	line "those boys from"
	cont "PALLET."

	para "Do us both a favor"
	line "and complete that"
	cont "old duff's #DEX."
	
	para "I'd also like to"
	line "battle you again"

	para "when you reach"
	line "newer heights."
	done

LavRadioTower1FReceptionistText:
	text "Welcome!"
	line "Feel free to look"

	para "around anywhere on"
	line "this floor."
	done

LavRadioTower1FOfficerText:
	text "Sorry, but you can"
	line "only tour the"
	cont "ground floor."

	para "Ever since JOHTO's"
	line "RADIO TOWER was"

	para "taken over by a"
	line "criminal gang, we"

	para "have had to step"
	line "up our security."
	done

LavRadioTower1FSuperNerd1Text:
	text "Many people are"
	line "hard at work here"

	para "in the RADIO"
	line "TOWER."

	para "They must be doing"
	line "their best to put"
	cont "on good shows."
	done

LavRadioTower1FGentlemanText:
	text "Oh, no, no, no!"

	para "We've been off the"
	line "air ever since the"

	para "POWER PLANT shut"
	line "down."

	para "All my efforts to"
	line "start this station"

	para "would be wasted if"
	line "I can't broadcast."

	para "I'll be ruined!"
	done

LavRadioTower1FGentlemanText_ReturnedMachinePart:
	text "Ah! So you're the"
	line "<PLAY_G> who solved"

	para "the POWER PLANT's"
	line "problem?"

	para "Thanks to you, I"
	line "never lost my job."

	para "I tell you, you're"
	line "a real lifesaver!"

	para "Please take this"
	line "as my thanks."
	done

LavRadioTower1FGentlemanText_GotExpnCard:
	text "With that thing,"
	line "you can tune into"

	para "the radio programs"
	line "here in KANTO."

	para "Gahahahaha!"
	done

LavRadioTower1FSuperNerd2Text:
	text "Hey there!"

	para "I am the super"
	line "MUSIC DIRECTOR!"

	para "Huh? Your #GEAR"
	line "can't tune into my"

	para "music programs."
	line "How unfortunate!"

	para "If you get an EXPN"
	line "CARD upgrade, you"

	para "can tune in. You'd"
	line "better get one!"
	done

LavRadioTower1FSuperNerd2Text_GotExpnCard:
	text "Hey there!"

	para "I am the super"
	line "MUSIC DIRECTOR!"

	para "I'm responsible"
	line "for the gorgeous"

	para "melodies that go"
	line "out over the air."

	para "Don't be square."
	line "Grab your music"
	cont "off the air!"
	done

LavRadioTower1FDirectoryText:
	text "1F RECEPTION"
	line "2F SALES"

	para "3F PERSONNEL"
	line "4F PRODUCTION"

	para "5F DIRECTOR'S"
	line "   OFFICE"
	done

LavRadioTower1FPokeFluteSignText:
	text "Perk Up #MON"
	line "with Mellow Sounds"

	para "of the # FLUTE"
	line "on CHANNEL 20"
	done

LavRadioTower1FReferenceLibraryText:
	text "Wow! A full rack"
	line "of #MON CDs and"
	cont "videos."

	para "This must be the"
	line "reference library."
	done

LavRadioTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, LAVENDER_TOWN, 7
	warp_event  3,  7, LAVENDER_TOWN, 7

	def_coord_events

	def_bg_events
	bg_event 11,  0, BGEVENT_READ, LavRadioTower1FDirectory
	bg_event  5,  0, BGEVENT_READ, LavRadioTower1FPokeFluteSign

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FReceptionistScript, -1
	object_event 15,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FOfficerScript, -1
	object_event  1,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd1Script, -1
	object_event  9,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FGentlemanScript, -1
	object_event 14,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd2Script, -1
	object_event  4,  1, SPRITE_AGATHA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AgathaScript, -1
