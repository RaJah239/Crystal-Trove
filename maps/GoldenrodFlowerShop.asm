GoldenrodFlowerShop_MapEvents:
	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 7
	warp_event  3,  7, GOLDENROD_CITY, 7

	def_coord_events

	def_bg_events

	object_const_def
	const GOLDENRODFLOWERSHOP_TEACHER
	const GOLDENRODFLOWERSHOP_FLORIA

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShopTeacherScript, -1
	object_event  5,  6, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FlowerShopFloriaScript, EVENT_FLORIA_AT_FLOWER_SHOP

GoldenrodFlowerShop_MapScripts:
	def_scene_scripts

	def_callbacks

FlowerShopTeacherScript:
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .Lalala
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue .GotSquirtbottle
	checkevent EVENT_MET_FLORIA
	iffalse .HaventMetFloria
	checkevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	iffalse .Lalala
	checkflag ENGINE_PLAINBADGE
	iffalse .NoPlainBadge
	faceplayer
	opentext
	writetext GoldenrodFlowerShopTeacherHeresTheSquirtbottleText
	promptbutton
	verbosegiveitem SQUIRTBOTTLE
	setevent EVENT_GOT_SQUIRTBOTTLE
	closetext
	setevent EVENT_FLORIA_AT_SUDOWOODO
	clearevent EVENT_FLORIA_AT_FLOWER_SHOP
	end

.Lalala:
	turnobject GOLDENRODFLOWERSHOP_TEACHER, LEFT
	jumptext GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText

.GotSquirtbottle:
	jumptextfaceplayer GoldenrodFlowerShopTeacherDontDoAnythingDangerousText

.NoPlainBadge:
	jumptextfaceplayer GoldenrodFlowerShopTeacherAskWantToBorrowWaterBottleText

.HaventMetFloria:
	jumptextfaceplayer GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text

GoldenrodFlowerShopTeacherHeresTheSquirtbottleText:
	text "Oh, you're better"
	line "than WHITNEY…"

	para "You'll be OK,"
	line "then. Here's the"
	cont "SQUIRTBOTTLE!"
	done

GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText:
	text "Lalala lalalala."
	line "Have plenty of"
	cont "water, my lovely!"
	done

GoldenrodFlowerShopTeacherAskWantToBorrowWaterBottleText:
	text "Do you want to"
	line "borrow the water"

	para "bottle too?"
	line "I don't want you"

	para "doing anything"
	line "dangerous with it."
	done

GoldenrodFlowerShopTeacherDontDoAnythingDangerousText:
	text "Don't do anything"
	line "too dangerous!"
	done

GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text:
	text "Have you seen that"
	line "wiggly tree that's"

	para "growing on ROUTE"
	line "36?"

	para "My little sister"
	line "got all excited"

	para "and went to see"
	line "it…"

	para "I'm worried… Isn't"
	line "it dangerous?"
	done

FlowerShopFloriaScript:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .FoughtSudowoodo
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue .GotSquirtbottle
	setevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	setevent EVENT_FLORIA_AT_FLOWER_SHOP
	clearevent EVENT_FLORIA_AT_SUDOWOODO
	writetextend GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText

.GotSquirtbottle:
	writetextend GoldenrodFlowerShopFloriaYouBeatWhitneyText

.FoughtSudowoodo:
	writetextend GoldenrodFlowerShopFloriaItReallyWasAMonText

GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText:
	text "When I told my sis"
	line "about the jiggly"

	para "tree, she told me"
	line "it's dangerous."

	para "If I beat WHITNEY,"
	line "I wonder if she'll"

	para "lend me her water"
	line "bottle…"
	done

GoldenrodFlowerShopFloriaYouBeatWhitneyText:
	text "Wow, you beat"
	line "WHITNEY? Cool!"
	done

GoldenrodFlowerShopFloriaItReallyWasAMonText:
	text "So it really was a"
	line "#MON!"
	done
