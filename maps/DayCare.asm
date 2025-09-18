DayCare_MapEvents:
	def_warp_events
	warp_event  0,  5, ROUTE_34, 3
	warp_event  0,  6, ROUTE_34, 4
	warp_event  2,  7, ROUTE_34, 5
	warp_event  3,  7, ROUTE_34, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, DayCareBookshelf
	bg_event  1,  1, BGEVENT_READ, DayCareBookshelf

	object_const_def
	const DAYCARE_GRAMPS
	const DAYCARE_GRANNY
	const DAYCARE_GRANDDAUGHTER

	def_object_events
	object_event  2,  4, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareManScript_Inside, EVENT_DAY_CARE_MAN_IN_DAY_CARE
	object_event  5,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, DayCareLadyScript, -1
	object_event  7,  5, SPRITE_TWIN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, DayCareGrandDaughterScript, -1

DayCare_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, DayCareEggCheckCallback

DayCareEggCheckCallback:
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .PutDayCareManOutside
	clearevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	setevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

.PutDayCareManOutside:
	setevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	clearevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

DayCareBookshelf:
	jumpstd DifficultBookshelfScript

DayCareManScript_Inside:
	faceplayer
	opentext
	checkevent EVENT_GOT_ODD_EGG
	iftrue .AlreadyHaveOddEgg
	writetext DayCareManText_GiveOddEgg
	promptbutton
	closetext
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull
	special GiveOddEgg
	opentext
	writetext DayCareText_GotOddEgg
	playsound SFX_KEY_ITEM
	waitsfx
	setevent EVENT_GOT_ODD_EGG
	writetextend DayCareText_DescribeOddEgg

.PartyFull:
	jumptext DayCareText_PartyFull

.AlreadyHaveOddEgg:
	special DayCareMan
	waitbutton
	closetext
	end

DayCareText_PartyFull:
	text "You've no room for"
	line "this."
	done

DayCareText_DescribeOddEgg:
	text "I found that when"
	line "I was caring for"

	para "someone's #MON"
	line "before."

	para "But the trainer"
	line "didn't want the"

	para "EGG, so I'd kept"
	line "it around."
	done

DayCareManText_GiveOddEgg:
	text "I'm the DAY-CARE"
	line "MAN."

	para "Do you know about"
	line "EGGS?"

	para "I was raising"
	line "#MON with my"
	cont "wife, you see."

	para "We were shocked to"
	line "find an EGG!"

	para "How incredible is"
	line "that?"

	para "You know, your"
 	line "#DEX shows EGG"
 	cont "groups, and how"
 
 	para "long they take to"
 	line "hatch!"

	para "Well, wouldn't you"
	line "like this EGG?"

	para "Then fine, this is"
	line "yours to keep!"
	done

DayCareText_GotOddEgg:
	text "<PLAYER> received"
	line "ODD EGG!"
	done

DayCareLadyScript:
	faceplayer
	opentext
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .HusbandWasLookingForYou
	special DayCareLady
	waitbutton
	closetext
	end

.HusbandWasLookingForYou:
	writetextend Text_GrampsLookingForYou

Text_GrampsLookingForYou:
	text "Gramps was looking"
	line "for you."
	done

DayCareGrandDaughterScript:
	faceplayer
	opentext
	clearevent EVENT_DAY_CARE_GRANDDAUGHTER_THIS_IS_NOT_AN_EGG
	clearevent EVENT_DAY_CARE_GRANDDAUGHTER_ADOPTS_AN_EGG
	checkevent EVENT_DAY_CARE_GRANDDAUGHTER_HAS_A_TINYMUSHROOM_FOR_PLAYER
	iftrue .DayCareGrandDaughterGiveATinyMushroom
	checkevent EVENT_MET_DAY_CARE_GRANDDAUGHTER
	iftrue .PutUpAnEggForAdoptionForATinyMushroom
	writetext DayCareDaughterIntroText
	setevent EVENT_MET_DAY_CARE_GRANDDAUGHTER
	sjump .FirstTimeEggAdoption
.PutUpAnEggForAdoptionForATinyMushroom:
	writetext DayCareDaughterWantToDonateAMonText
.FirstTimeEggAdoption:
	yesorno
	iffalse .DontHaveAnEggThatNeedsAdopting
	special PlayerGivesAwayAnEggForAdoption
	checkevent EVENT_DAY_CARE_GRANDDAUGHTER_THIS_IS_NOT_AN_EGG
	iftrue .ThisIsNotAnEgg
	checkevent EVENT_DAY_CARE_GRANDDAUGHTER_ADOPTS_AN_EGG
	iffalse .DontHaveAnEggThatNeedsAdopting
	writetext DayCareDaughterIllTakeGoodCareOfItTakeThisText
	promptbutton
	verbosegiveitem TINYMUSHROOM
	iffalse .YouDontHaveSpace
	writetext DayCareDaughterImAlwaysHereToHelpText
	waitbutton
	closetext
	end

.DontHaveAnEggThatNeedsAdopting:
	writetextend DayCareDaughterHappyYourEggsHaveAGreatHomeText

.ThisIsNotAnEgg:
	writetextend DayCareDaughterThisIsNotAnEggText

.YouDontHaveSpace:
	setevent EVENT_DAY_CARE_GRANDDAUGHTER_HAS_A_TINYMUSHROOM_FOR_PLAYER
	writetextend DayCareDaughterYouDontHaveSpaceText

.DayCareGrandDaughterGiveATinyMushroom:
	writetext DayCareDaughterHaveYouMadeSpaceText
	promptbutton
	verbosegiveitem TINYMUSHROOM
	iffalse .YouDontHaveSpace
	clearevent EVENT_DAY_CARE_GRANDDAUGHTER_HAS_A_TINYMUSHROOM_FOR_PLAYER
	writetextend DayCareDaughterImAlwaysHereToHelpText

DayCareDaughterIntroText:
	text "Salutations!"

	para "Huh? I sound old?"

	para "Well, I live with"
	line "my Mamaw and Papaw"
	cont "here so they are"

	para "bound to rub off"
	line "on me. Hehe."

	para "Thing is, trainers"
	line "may not always be"

	para "able to care for"
	line "an Egg, so those"
	cont "need a home."

	para "That's where I can"
	line "help!"

	para "I will adopt any"
	line "Egg you want."

	para "Living near the"
	line "Ilex Forest, I've"

	para "a collection of"
	line "Tiny Mushrooms!"

	para "I'll give you one"
	line "for each!"

	para "Do you have any"
	line "Eggs in need"
	cont "of a new home?"
	done

DayCareDaughterHappyYourEggsHaveAGreatHomeText:
	text "No? Stop by if"
	line "ever you do."
	done

DayCareDaughterThisIsNotAnEggText:
	text "I'm sorry. This is"
	line "not an Egg."
	done

DayCareDaughterIllTakeGoodCareOfItTakeThisText:
	text "I'll take care of"
	line "this! And for you…"
	done

DayCareDaughterYouDontHaveSpaceText:
	text "You don't have any"
	line "room for this."

	para "Come back when you"
	line "do."
	done

DayCareDaughterImAlwaysHereToHelpText:
	text "Stop by if ever an"
	line "Egg needs a home."
	done

DayCareDaughterWantToDonateAMonText:
	text "Salutations! Hehe."

	para "Do you have an Egg"
	line "in need of a home?"

	para "You can take this"
	line "Tiny Mushroom in"
	cont "return?"
	done

DayCareDaughterHaveYouMadeSpaceText:
	text "Are you ready for"
	line "a Tiny Mushroom?"
	done
