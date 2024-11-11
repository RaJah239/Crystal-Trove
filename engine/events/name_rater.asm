_NameRater:
; Introduce himself
	ld hl, NameRaterHelloText
	call PrintText
	call YesNoBox
	jp c, .cancel
; Select a Pokemon from your party
	ld hl, NameRaterWhichMonText
	call PrintText
.loop_party_menu
	farcall SelectMonFromParty
	jr c, .cancel
; He can't rename an egg...
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	call GetCurNickname
; This name is good, but we can do better.  How about it?
	ld hl, NameRaterBetterNameText
	call PrintText
	call YesNoBox
	jr c, .cancel
; What name shall I give it then?
	ld hl, NameRaterWhatNameText
	call PrintText
; Load the new nickname into wStringBuffer2
	xor a ; PARTYMON
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	ld [wCurSpecies], a
	call GetBaseData
	ld b, NAME_MON
	ld de, wStringBuffer2
	farcall _NamingScreen
; If the new name is empty, treat it as unchanged.
	call IsNewNameEmpty
	ld hl, NameRaterSameNameText
	jr c, .samename
; If the new name is the same as the old name, treat it as unchanged.
	call CompareNewToOld
	ld hl, NameRaterSameNameText
	jr c, .samename
; Copy the new name from wStringBuffer2
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wStringBuffer2
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld hl, NameRaterFinishedText
	call PrintText
	jr .loop_party_menu

.samename
	push hl
	call GetCurNickname
	ld hl, NameRaterNamedText
	call PrintText
	pop hl
	jr .loop_party_menu

.cancel
	ld hl, NameRaterComeAgainText
	jr .done

.egg
	ld hl, NameRaterEggText
	call PrintText
	jp .loop_party_menu

.done
	call PrintText
	ret

IsNewNameEmpty:
; Checks to see if the nickname loaded in wStringBuffer2 is empty.  If so, return carry.
	ld hl, wStringBuffer2
	ld c, MON_NAME_LENGTH - 1
.loop
	ld a, [hli]
	cp "@"
	jr z, .terminator
	cp " "
	jr nz, .nonspace
	dec c
	jr nz, .loop

.terminator
	scf
	ret

.nonspace
	and a
	ret

CompareNewToOld:
; Compares the nickname in wStringBuffer2 to the previous nickname.  If they are the same, return carry.
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	push hl
	call GetNicknamenameLength
	ld b, c
	ld hl, wStringBuffer2
	call GetNicknamenameLength
	pop hl
	ld a, c
	cp b
	jr nz, .different
	ld de, wStringBuffer2
.loop
	ld a, [de]
	cp "@"
	jr z, .terminator
	cp [hl]
	jr nz, .different
	inc hl
	inc de
	jr .loop

.different
	and a
	ret

.terminator
	scf
	ret

GetNicknamenameLength:
; Gets the length of the name starting at hl and returns it in c.
	ld c, 0
.loop
	ld a, [hli]
	cp "@"
	ret z
	inc c
	ld a, c
	cp MON_NAME_LENGTH - 1
	jr nz, .loop
	ret

NameRaterHelloText:
	text_far _NameRaterHelloText
	text_end

NameRaterWhichMonText:
	text_far _NameRaterWhichMonText
	text_end

NameRaterBetterNameText:
	text_far _NameRaterBetterNameText
	text_end

NameRaterWhatNameText:
	text_far _NameRaterWhatNameText
	text_end

NameRaterFinishedText:
	text_far _NameRaterFinishedText
	text_end

NameRaterComeAgainText:
	text_far _NameRaterComeAgainText
	text_end

NameRaterEggText:
	text_far _NameRaterEggText
	text_end

NameRaterSameNameText:
	text_far _NameRaterSameNameText
	text_end

NameRaterNamedText:
	text_far _NameRaterNamedText
	text_end
