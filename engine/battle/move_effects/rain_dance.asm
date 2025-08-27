BattleCommand_StartRain:

	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	jr z, .failed

	ld a, WEATHER_RAIN
	ld [wBattleWeather], a
	call GetWeatherMoveDuration
	ld [wWeatherCount], a
	call AnimateCurrentMove
	ld hl, DownpourText
	jmp StdBattleTextbox

.failed
	call AnimateFailedMove
	jmp PrintButItFailed
