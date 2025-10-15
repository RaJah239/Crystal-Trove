TalkToTrainerScript::
	faceplayer
	trainerflagaction CHECK_FLAG
	iftrue RematchScript
	loadtemptrainer
	encountermusic
	sjump StartBattleWithMapTrainerScript

SeenByTrainerScript::
	loadtemptrainer
	encountermusic
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	callasm TrainerWalkToPlayer
	applymovementlasttalked wMovementBuffer
	writeobjectxy LAST_TALKED
	faceobject PLAYER, LAST_TALKED
	sjump StartBattleWithMapTrainerScript

StartBattleWithMapTrainerScript:
	opentext
	trainertext TRAINERTEXT_SEEN
	waitbutton
	closetext
	loadtemptrainer
	startbattle
	reloadmapafterbattle
	trainerflagaction SET_FLAG
	loadmem wRunningTrainerBattleScript, -1

AlreadyBeatenTrainerScript:
	scripttalkafter

RematchScript:
    scall AlreadyBeatenTrainerScript
	opentext
	writetext RematchText
	yesorno
	iffalse .refused
    loadtemptrainer
	encountermusic
	sjump StartBattleWithMapTrainerScript
.refused:
	closetext
	end

RematchText:
    text "How about a"
    line "rematch?"
    done
