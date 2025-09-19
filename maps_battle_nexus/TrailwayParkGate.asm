TrailwayParkGate_MapEvents:
	def_warp_events
	warp_event  0,  4, NATIONAL_PARK, 1
	warp_event  0,  5, NATIONAL_PARK, 3
	warp_event  9,  4, TRAILWAY, 10
	warp_event  9,  5, TRAILWAY, 11

	def_coord_events

	def_bg_events
	bg_event  6,  0, BGEVENT_READ, BugCatchingContestExplanationSign

	object_const_def
	const TRAILWAYPARKGATE_OFFICER1
	const TRAILWAYPARKGATE_YOUNGSTER1
	const TRAILWAYPARKGATE_YOUNGSTER2
	const TRAILWAYPARKGATE_ROCKER
	const TRAILWAYPARKGATE_POKEFAN_M
	const TRAILWAYPARKGATE_YOUNGSTER3
	const TRAILWAYPARKGATE_YOUNGSTER4
	const TRAILWAYPARKGATE_LASS
	const TRAILWAYPARKGATE_YOUNGSTER5
	const TRAILWAYPARKGATE_YOUNGSTER6
	const TRAILWAYPARKGATE_YOUNGSTER7
	const TRAILWAYPARKGATE_OFFICER2

	def_object_events
	object_event  0,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route36OfficerScriptContest, EVENT_TRAILWAY_PARK_GATE_OFFICER_CONTEST_DAY
	object_event  2,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant1BScript, EVENT_BUG_CATCHING_CONTESTANT_1B
	object_event  4,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant2BScript, EVENT_BUG_CATCHING_CONTESTANT_2B
	object_event  2,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant3BScript, EVENT_BUG_CATCHING_CONTESTANT_3B
	object_event  6,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant4BScript, EVENT_BUG_CATCHING_CONTESTANT_4B
	object_event  2,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant5BScript, EVENT_BUG_CATCHING_CONTESTANT_5B
	object_event  5,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant6BScript, EVENT_BUG_CATCHING_CONTESTANT_6B
	object_event  3,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant7BScript, EVENT_BUG_CATCHING_CONTESTANT_7B
	object_event  4,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant8BScript, EVENT_BUG_CATCHING_CONTESTANT_8B
	object_event  6,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant9BScript, EVENT_BUG_CATCHING_CONTESTANT_9B
	object_event  6,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant10BScript, EVENT_BUG_CATCHING_CONTESTANT_10B
	object_event  3,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TrailwayParkGateOfficerScript, EVENT_TRAILWAY_PARK_GATE_OFFICER_NOT_CONTEST_DAY

TrailwayParkGate_MapScripts:
	def_scene_scripts
	scene_script TrailwayParkGateNoop1Scene,             SCENE_TRAILWAYPARKGATE_NOOP
	scene_script TrailwayParkGateNoop2Scene,             SCENE_TRAILWAYPARKGATE_UNUSED
	scene_script TrailwayParkGateLeaveContestEarlyScene, SCENE_TRAILWAYPARKGATE_LEAVE_CONTEST_EARLY

	def_callbacks
	callback MAPCALLBACK_NEWMAP, TrailwayParkGateCheckIfContestRunningCallback
	callback MAPCALLBACK_OBJECTS, TrailwayParkGateCheckIfContestAvailableCallback

TrailwayParkGateNoop1Scene:
	; fallthrough
TrailwayParkGateNoop2Scene:
	end

TrailwayParkGateLeaveContestEarlyScene:
	sdefer TrailwayParkGateLeavingContestEarlyScript
	end

TrailwayParkGateCheckIfContestRunningCallback:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugContestIsRunning
	setscene SCENE_TRAILWAYPARKGATE_NOOP
	endcallback

.BugContestIsRunning:
	setscene SCENE_TRAILWAYPARKGATE_LEAVE_CONTEST_EARLY
	endcallback

TrailwayParkGateCheckIfContestAvailableCallback:
	checkevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	iftrue .Return
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .SetContestOfficer
	ifequal THURSDAY, .SetContestOfficer
	ifequal SATURDAY, .SetContestOfficer
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .SetContestOfficer
	disappear TRAILWAYPARKGATE_OFFICER1
	appear TRAILWAYPARKGATE_OFFICER2
	endcallback

.SetContestOfficer:
	appear TRAILWAYPARKGATE_OFFICER1
	disappear TRAILWAYPARKGATE_OFFICER2
.Return:
	endcallback

TrailwayParkGateLeavingContestEarlyScript:
	turnobject PLAYER, UP
	opentext
	readvar VAR_CONTESTMINUTES
	addval 1
	getnum STRING_BUFFER_3
	writetext TrailwayParkGateOfficer1WantToFinishText
	yesorno
	iffalse .GoBackToContest
	writetext TrailwayParkGateOfficer1WaitHereForAnnouncementText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	scall .CopyContestants
	disappear TRAILWAYPARKGATE_OFFICER1
	appear TRAILWAYPARKGATE_OFFICER2
	applymovement PLAYER, TrailwayParkGatePlayerWaitWithContestantsMovement
	pause 15
	special FadeInFromBlack
	jumpstd BugContestResultsScript

.GoBackToContest:
	writetext TrailwayParkGateOfficer1OkGoFinishText
	waitbutton
	closetext
	turnobject PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, 33, 18
	end

.CopyContestants:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_1A
	iftrue .Not1
	appear TRAILWAYPARKGATE_YOUNGSTER1
.Not1:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_2A
	iftrue .Not2
	appear TRAILWAYPARKGATE_YOUNGSTER2
.Not2:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_3A
	iftrue .Not3
	appear TRAILWAYPARKGATE_ROCKER
.Not3:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_4A
	iftrue .Not4
	appear TRAILWAYPARKGATE_POKEFAN_M
.Not4:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_5A
	iftrue .Not5
	appear TRAILWAYPARKGATE_YOUNGSTER3
.Not5:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_6A
	iftrue .Not6
	appear TRAILWAYPARKGATE_YOUNGSTER4
.Not6:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_7A
	iftrue .Not7
	appear TRAILWAYPARKGATE_LASS
.Not7:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_8A
	iftrue .Not8
	appear TRAILWAYPARKGATE_YOUNGSTER5
.Not8:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_9A
	iftrue .Not9
	appear TRAILWAYPARKGATE_YOUNGSTER6
.Not9:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_10A
	iftrue .Not10
	appear TRAILWAYPARKGATE_YOUNGSTER7
.Not10:
	special UpdateSprites
	end

Route36OfficerScriptContest:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, _ContestNotOn
	ifequal MONDAY, _ContestNotOn
	ifequal WEDNESDAY, _ContestNotOn
	ifequal FRIDAY, _ContestNotOn
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	scall Route36ParkGate_DayToText
	writetext TrailwayParkGateOfficer1AskToParticipateText
	yesorno
	iffalse .DecidedNotToJoinContest
	readvar VAR_PARTYCOUNT
	ifgreater 1, .LeaveMonsWithOfficer
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
.ResumeStartingContest:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writetext TrailwayParkGateOfficer1GiveParkBallsText
	promptbutton
	waitsfx
	writetext TrailwayParkGatePlayerReceivedParkBallsText
	playsound SFX_ITEM
	waitsfx
	writetext TrailwayParkGateOfficer1ExplainsRulesText
	waitbutton
	closetext
	setflag ENGINE_BUG_CONTEST_TIMER
	special GiveParkBalls
	turnobject PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	special SelectRandomBugContestContestants
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, 33, 18
	end

.LeaveMonsWithOfficer:
	readvar VAR_PARTYCOUNT
	ifless PARTY_LENGTH, .ContinueLeavingMons
	readvar VAR_BOXSPACE
	ifequal 0, .BoxFull
.ContinueLeavingMons:
	special CheckFirstMonIsEgg
	ifequal TRUE, .FirstMonIsEgg
	writetext TrailwayParkGateOfficer1AskToUseFirstMonText
	yesorno
	iffalse .RefusedToLeaveMons
	special ContestDropOffMons
	iftrue .FirstMonIsFainted
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writetext TrailwayParkGateOfficer1WellHoldYourMonText
	promptbutton
	writetext TrailwayParkGatePlayersMonLeftWithHelperText
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	promptbutton
	sjump .ResumeStartingContest

.DecidedNotToJoinContest:
	writetextend TrailwayParkGateOfficer1TakePartInFutureText

.RefusedToLeaveMons:
	writetextend TrailwayParkGateOfficer1ChooseMonAndComeBackText

.FirstMonIsFainted:
	writetextend TrailwayParkGateOfficer1FirstMonCantBattleText

.BoxFull:
	writetextend TrailwayParkGateOfficer1MakeRoomText

.FirstMonIsEgg:
	writetextend TrailwayParkGateOfficer1EggAsFirstMonText

Route36Officer_ContestHasConcluded:
	checkevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	iftrue .Sunstone
	checkevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	iftrue .Everstone
	checkevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	iftrue .GoldBerry
	checkevent EVENT_CONTEST_OFFICER_HAS_BERRY
	iftrue .Berry
	writetextend TrailwayParkGateOfficer1ContestIsOverText

.Sunstone:
	writetext TrailwayParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem SUN_STONE
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	closetext
	end

.Everstone:
	writetext TrailwayParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem EVERSTONE
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	closetext
	end

.GoldBerry:
	writetext TrailwayParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem GOLD_BERRY
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	closetext
	end

.Berry:
	writetext TrailwayParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem BERRY
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_BERRY
	closetext
	end

.BagFull:
	writetextend TrailwayParkGateOfficer1WellHoldPrizeText

_ContestNotOn:
	jumptextfaceplayer TrailwayParkGateOfficer1SomeMonOnlySeenInParkText

TrailwayParkGateOfficerScript:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	writetextend TrailwayParkGateOfficer1SomeMonOnlySeenInParkText

Route36ParkGate_DayToText:
	jumpstd DayToTextScript
	end

BugCatchingContestant1BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant1BText

.StillCompeting:
	writetextend BugCatchingContestant1BStillCompetingText

BugCatchingContestant2BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant2BText

.StillCompeting:
	writetextend BugCatchingContestant2BStillCompetingText

BugCatchingContestant3BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant3BText

.StillCompeting:
	writetextend BugCatchingContestant3BStillCompetingText

BugCatchingContestant4BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant4BText

.StillCompeting:
	writetextend BugCatchingContestant4BStillCompetingText

BugCatchingContestant5BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant5BText

.StillCompeting:
	writetextend BugCatchingContestant5BStillCompetingText

BugCatchingContestant6BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant6BText

.StillCompeting:
	writetextend BugCatchingContestant6BStillCompetingText

BugCatchingContestant7BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant7BText

.StillCompeting:
	writetextend BugCatchingContestant7BStillCompetingText

BugCatchingContestant8BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant8BText

.StillCompeting:
	writetextend BugCatchingContestant8BStillCompetingText

BugCatchingContestant9BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant9BText

.StillCompeting:
	writetextend BugCatchingContestant9BStillCompetingText

BugCatchingContestant10BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetextend BugCatchingContestant10BText

.StillCompeting:
	writetextend BugCatchingContestant10BStillCompetingText

TrailwayParkGatePlayerWaitWithContestantsMovement:
	big_step DOWN
	big_step RIGHT
	turn_head UP
	step_end

TrailwayParkGateOfficer1AskToParticipateText:
	text "Today's @"
	text_ram wStringBuffer3
	text "."
	line "That means the"

	para "Bug-Catching Con-"
	line "test is on today."

	para "The rules are sim-"
	line "ple."

	para "Using one of your"
	line "#mon, catch a"

	para "bug #mon to be"
	line "judged."

	para "Would you like to"
	line "give it a try?"
	done

TrailwayParkGateOfficer1GiveParkBallsText:
	text "Here are the Park"
	line "Balls for the"
	cont "Contest."
	done

TrailwayParkGatePlayerReceivedParkBallsText:
	text "<PLAYER> received"
	line "{d:BUG_CONTEST_BALLS} Park Balls."
	done

TrailwayParkGateOfficer1ExplainsRulesText:
	text "The person who"
	line "gets the strong-"
	cont "est bug #mon"
	cont "is the winner."

	para "You have {d:BUG_CONTEST_MINUTES}"
	line "minutes."

	para "If you run out of"
	line "Park Balls, you're"
	cont "done."

	para "You can keep the"
	line "last #mon you"
	cont "catch as your own."

	para "Go out and catch"
	line "the strongest bug"

	para "#mon you can"
	line "find!"
	done

TrailwayParkGateOfficer1AskToUseFirstMonText:
	text "Uh-oh…"

	para "You have more than"
	line "one #mon."

	para "You'll have to use"
	line "@"
	text_ram wStringBuffer3
	text ", the"

	para "first #mon in"
	line "your party."

	para "Is that OK with"
	line "you?"
	done

TrailwayParkGateOfficer1WellHoldYourMonText:
	text "Fine, we'll hold"
	line "your other #mon"
	cont "while you compete."
	done

TrailwayParkGatePlayersMonLeftWithHelperText:
	text "<PLAYER>'s #mon"
	line "were left with the"
	cont "Contest Helper."
	done

TrailwayParkGateOfficer1ChooseMonAndComeBackText:
	text "Please choose the"
	line "#mon to be used"

	para "in the Contest,"
	line "then come see me."
	done

TrailwayParkGateOfficer1TakePartInFutureText:
	text "OK. We hope you'll"
	line "take part in the"
	cont "future."
	done

TrailwayParkGateOfficer1FirstMonCantBattleText:
	text "Uh-oh…"
	line "The first #Mon"

	para "in your party"
	line "can't battle."

	para "Please switch it"
	line "with the #Mon"

	para "you want to use,"
	line "then come see me."
	done

TrailwayParkGateOfficer1MakeRoomText:
	text "Uh-oh…"
	line "Both your party"

	para "and your PC Box"
	line "are full."

	para "You have no room"
	line "to put the bug"
	cont "#Mon you catch."

	para "Please make room"
	line "in your party or"

	para "your PC Box, then"
	line "come see me."
	done

TrailwayParkGateOfficer1EggAsFirstMonText:
	text "Uh-oh…"
	line "You have an Egg as"

	para "the first #mon"
	line "in your party."

	para "Please switch it"
	line "with the #mon"

	para "you want to use,"
	line "then come see me."
	done

TrailwayParkGateOfficer1WantToFinishText:
	text "You still have @"
	text_ram wStringBuffer3
	text_start
	line "minute(s) left."

	para "Do you want to"
	line "finish now?"
	done

TrailwayParkGateOfficer1WaitHereForAnnouncementText:
	text "OK. Please wait"
	line "here for the"

	para "announcement of"
	line "the winners."
	done

TrailwayParkGateOfficer1OkGoFinishText:
	text "OK. Please go back"
	line "outside and finish"
	cont "up."
	done

TrailwayParkGateOfficer1ContestIsOverText:
	text "Today's Contest is"
	line "over. We hope you"

	para "will participate"
	line "in the future."
	done

TrailwayParkGateOfficer1SomeMonOnlySeenInParkText:
	text "Some #mon can"
	line "only be seen in"
	cont "the Park."
	done

BugCatchingContestant1BText:
	text "Don: Wow, you beat"
	line "me. You're pretty"
	cont "good."
	done

BugCatchingContestant1BStillCompetingText:
	text "Don: Luck plays a"
	line "big part in this."

	para "You never know"
	line "what #mon will"
	cont "appear."
	done

BugCatchingContestant2BText:
	text "Al: I envy you."
	line "I just couldn't"
	cont "do it this time."
	done

BugCatchingContestant2BStillCompetingText:
	text "Al: Maybe you win"
	line "with big #mon?"
	done

BugCatchingContestant3BText:
	text "Nick: Well done!"
	line "I'm going to raise"
	cont "my #mon better."
	done

BugCatchingContestant3BStillCompetingText:
	text "Nick: Maybe you"
	line "get a higher score"

	para "for a #mon of"
	line "an unusual color."
	done

BugCatchingContestant4BText:
	text "William: You're"
	line "the winner? What"
	cont "did you catch?"
	done

BugCatchingContestant4BStillCompetingText:
	text "William: Well, I'm"
	line "satisfied because"

	para "I caught a #mon"
	line "that I wanted."
	done

BugCatchingContestant5BText:
	text "Benny: Congrats!"
	line "You have earned my"
	cont "respect!"
	done

BugCatchingContestant5BStillCompetingText:
	text "Benny: I caught a"
	line "Scyther before,"
	cont "but I didn't win."
	done

BugCatchingContestant6BText:
	text "Ted: That #-"
	line "mon you caught…"
	cont "it's awesome!"
	done

BugCatchingContestant6BStillCompetingText:
	text "Ted: It's easier"
	line "to win if you get"

	para "a high-level bug"
	line "#mon."

	para "But I think they"
	line "also consider some"
	cont "other points."
	done

BugCatchingContestant7BText:
	text "Erin: You won?"
	line "That's great!"

	para "Do you feel like"
	line "looking for bug"
	cont "#mon with me?"
	done

BugCatchingContestant7BStillCompetingText:
	text "Erin: I really"
	line "love bug #mon!"
	done

BugCatchingContestant8BText:
	text "Josh: I… I can't"
	line "believe I lost at"
	cont "bug-catching…"
	done

BugCatchingContestant8BStillCompetingText:
	text "Josh: I heard that"
	line "somebody won with"
	cont "a Wurmple!"
	done

BugCatchingContestant9BText:
	text "Samuel: Next time,"
	line "I'm going to win."
	done

BugCatchingContestant9BStillCompetingText:
	text "Samuel: Darn."
	line "I thought I would"
	cont "score higher…"
	done

BugCatchingContestant10BText:
	text "Alan: Could you"
	line "give me some tips?"

	para "I want to study"
	line "your style."
	done

BugCatchingContestant10BStillCompetingText:
	text "Alan: I study a"
	line "lot, but that's"

	para "not good enough to"
	line "win."
	done

TrailwayParkGateOfficer1WellHoldPrizeText:
	text "Uh-oh… Your Bag"
	line "is full."

	para "We'll hold on to"
	line "your prize, but"
	cont "only for today."

	para "Please make room,"
	line "then come see me."
	done

TrailwayParkGateOfficer1HeresThePrizeText:
	text "<PLAYER>?"

	para "Here's the prize"
	line "we were holding"
	cont "for you."
	done
