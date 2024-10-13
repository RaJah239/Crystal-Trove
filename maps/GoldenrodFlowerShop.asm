	object_const_def
	const GOLDENRODFLOWERSHOP_TEACHER
	const GOLDENRODFLOWERSHOP_FLORIA

GoldenrodFlowerShop_MapScripts:
	def_scene_scripts

	def_callbacks

FlowerShopTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_FLOWER_SHOP_FLORINA_GIVES_BERRIES
	iffalse .SoItWasAPokemon
	writetext MySisterWentToTheWeirdTreeText
	waitbutton
	closetext
	end

.SoItWasAPokemon:
	writetext SoItWasAPokemonText
	waitbutton
	closetext
	end

MySisterWentToTheWeirdTreeText:
	text "FIONA: Where's my"
	line "sister gone…"
	done

SoItWasAPokemonText:
	text "FIONA: I'm happy"
	line "she's safe!"

	para "So it really was a"
	line "#MON then?"
	done

FlowerShopBerryGiverScript:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_GIFT_BERRY
	iftrue .CheckBackTomorrow
	writetext YoureJustInTimeText
   	waitbutton
   	random 10
	ifequal 0, .berry
	ifequal 1, .goldberry
	ifequal 2, .psncureberry
	ifequal 3, .przcureberry
	ifequal 4, .burntberry
	ifequal 5, .iceberry
	ifequal 6, .bitterberry
	ifequal 7, .mintberry
	ifequal 8, .mysteryberry
	ifequal 9, .miracleberry	

.berry:
	verbosegiveitem BERRY
	jump .ThatsItForToday
	end

.goldberry:
	verbosegiveitem GOLD_BERRY
	jump .ThatsItForToday
	end

.psncureberry:
	verbosegiveitem PSNCUREBERRY
	jump .ThatsItForToday
	end

.przcureberry:
	verbosegiveitem PRZCUREBERRY
	jump .ThatsItForToday
	end

.burntberry:
	verbosegiveitem BURNT_BERRY
	jump .ThatsItForToday
	end

.iceberry:
	verbosegiveitem ICE_BERRY
	jump .ThatsItForToday
	end

.bitterberry:
	verbosegiveitem BITTER_BERRY
	jump .ThatsItForToday
	end

.mintberry:
	verbosegiveitem MINT_BERRY
	jump .ThatsItForToday
	end

.mysteryberry:
	verbosegiveitem MYSTERYBERRY
	jump .ThatsItForToday
	end

.miracleberry:
	verbosegiveitem MIRACLEBERRY
	jump .ThatsItForToday
	end

.ThatsItForToday:
	writetext VisitTomorrowText
	setflag ENGINE_DAILY_GIFT_BERRY
	waitbutton
	closetext
	end

.CheckBackTomorrow
	writetext VisitTomorrowText
	waitbutton
	closetext
	end

YoureJustInTimeText:
	text "FLORIA: You're"
	line "just in time!"
	
	para "Take this!"
	done

VisitTomorrowText:
	text "Come back tomorrow"
	line "for another berry."
	done

GoldenrodFlowerShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 6
	warp_event  3,  7, GOLDENROD_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShopTeacherScript, -1
	object_event  3,  4, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 1, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, FlowerShopBerryGiverScript, EVENT_FLOWER_SHOP_FLORINA_GIVES_BERRIES
