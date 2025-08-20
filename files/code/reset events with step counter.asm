

=======================================================================================

engien\overworld\event.asm file

```
	; Count the step for poison and total steps
	ld hl, wPoisonStepCount
	inc [hl]
	ld hl, wStepCount
	inc [hl]

	; Every 256 steps, increase the happiness of all your Pokemon.
	jr nz, .skip_happiness

	farcall StepHappiness
	
	; Reset multiple event flags every 256 steps
	ResetEventFlag EVENT_RED_IN_MT_SILVER
	
.skip_happiness
```

=======================================================================================

macros\scripts\events file:

```
MACRO ResetEventFlag
	ld de, \1 ; load into de EVENT_FLAG
	ld b, RESET_FLAG ; reset flag/ clearevent
	call EventFlagAction
ENDM
```

=======================================================================================

the flag EVENT_RED_IN_MT_SILVER gets resets after 256 steps