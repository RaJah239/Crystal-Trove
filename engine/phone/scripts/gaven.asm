GavenPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, COOLTRAINERM, GAVEN3
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftrue .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	farsjump GavenHangUpNotThursdayScript

.WantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_26
	farsjump GavenReminderScript

GavenPhoneCallerScript:
	gettrainername STRING_BUFFER_3, COOLTRAINERM, GAVEN3
	farscall PhoneScript_GreetPhone_Male
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_26
	setflag ENGINE_GAVEN_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male
