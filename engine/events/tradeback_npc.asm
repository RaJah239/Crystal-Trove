	; Fun fact, the 'trade' part of a trade isn't checked to evolve a Pokémon.
	; It seems that just the trade animation and the link state are enough.
	; No Pokémon is actualy ever moved to or from your party because of that fact.

TradebackKid::
	ld hl, TradebackKidCanceledText
	jr c, .done

; Select a Pokémon from the party.
	ld b, PARTYMENUACTION_GIVE_MON
	farcall SelectTradeOrDayCareMon
	ld a, [wCurPartyMon]
	ld hl, TradebackKidCanceledText
	jr c, .done

	ld hl, NPCTradeCableText
	call PrintText

	call TradeWithTradebackKid
	call RestartMapMusic

	; here we set an event to tell the Trade Back Kid
	; yes we did trade so take a Silver Leaf
	ld de, EVENT_COMPLETED_TRADE_WITH_TRADE_BACK_KID
	ld b, SET_FLAG
	call EventFlagAction
	ret

.done
	call PrintText
	ret

; Loads the appropriate data to perform the trade animation.
TradeWithTradebackKid:
; Sets the link state to trading so that evolution is possible.
	ld a, LINK_TRADECENTER
	ld [wLinkMode], a

; Establish names of trading trainers
	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	ld bc, NAME_LENGTH
	call CopyBytes

	ld hl, .tradeback_kid_name
	ld de, wOTTrademonSenderName
	ld bc, NAME_LENGTH
	call CopyBytes
.tradeback_kid_name:
	db "TRADE KID@"

; Establish the Pokémon's species.
	ld a, [wCurPartyMon]
	ld hl, wPartySpecies
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wPlayerTrademonSpecies], a
	ld [wOTTrademonSpecies], a

; Establish Pokémon's ID number.
	ld hl, wPartyMon1ID
	ld a, [wCurPartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonID], a
	ld [wOTTrademonID], a
	ld a, [hl]
	ld [wPlayerTrademonID + 1], a
	ld [wOTTrademonID + 1], a

; Correctly display Pokémon shiny status on the trade screen.
	ld hl, wPartyMon1DVs
	ld a, [wCurPartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonDVs], a
	ld [wOTTrademonDVs], a
	ld a, [hl]
	ld [wPlayerTrademonDVs + 1], a
	ld [wOTTrademonDVs + 1], a 

; Establish Pokémon's OT's name
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	call SkipNames
	ld de, wPlayerTrademonOTName
	ld bc, NAME_LENGTH
	call CopyBytes

	ld hl, wPartyMonOTs
	ld de, wOTTrademonOTName
	ld bc, NAME_LENGTH
	call CopyBytes

; Makes it so that pressing B will not cancel the evolution.
	; This is standard for trade based evolution.
	ld a, 1
	ld [wForceEvolution], a

; Run the trade animation/ evolves the mon if applicable.
	call DisableSpriteUpdates
; wTradeDialog aliases wFrameCounter, which TradeAnimation uses.
	ld a, [wTradeDialog]
	push af
	predef TradeAnimation
	callfar EvolvePokemon
	pop af
	ld [wTradeDialog], a
	call ReturnToMapWithSpeechTextbox

; Changes the link mode back to not linked, battles won't work right otherwise.
	ld a, LINK_NULL
	ld [wLinkMode], a
	ret

TradebackKidCanceledText::
	text "Oh, ok then."

	para "Come back if you"
	line "change your mind."
	done
