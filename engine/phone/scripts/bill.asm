BillPhoneCalleeScript:
	farwritetext BillPhoneDayGreetingText
	promptbutton
	farwritetext BillPhoneGenericText
	promptbutton
	readvar VAR_BOXSPACE
	getnum STRING_BUFFER_3
	ifequal 0, .full
	ifless PARTY_LENGTH, .nearlyfull
	farwritetext BillPhoneNotFullText
	end

.nearlyfull
	farwritetext BillPhoneNearlyFullText
	end

.full
	farwritetext BillPhoneFullText
	end

BillPhoneCallerScript:
	farwritetext BillPhoneNewlyFullText
	waitbutton
	end
