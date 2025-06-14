CopyBGGreenToOBPal7:
; Some overworld effects (Fly leaves, Cut leaves, Cut trees, Headbutt trees)
; have hard-coded OB palette 7 in their OAM data.
	ld a, PAL_OW_COPY_BG_GREEN
	ld c, a
	; fallthrough
CopySpritePalToOBPal7:
	ld a, c
	ld [wNeededPalIndex], a
	ld [wLoadedObjPal7], a
	ld de, wOBPals1 palette 7
	; fallthrough
CopySpritePal::
	push af
	push bc
	push hl
	push de
	ld a, [wNeededPalIndex]
	sub FIRST_COPY_BG_PAL
	jr c, .not_copy_bg
	ld hl, wBGPals1
	ld bc, 1 palettes
	call AddNTimes
	jr .got_pal

.not_copy_bg
	; check darkness
	push hl
	push de
	call GetMapTimeOfDay
	pop de
	pop hl
	or ~IN_DARKNESS
	inc a
	jr nz, .not_darkness
	ld a, [wStatusFlags]
	bit STATUSFLAGS_FLASH_F, a ; Flash
	jr nz, .not_darkness
	ld a, [wPalFlags]
	bit USE_DAYTIME_PAL_F, a
	jr nz, .not_darkness
	ld a, [wNeededPalIndex]
	cp NUM_OW_TIME_OF_DAY_PALS
	jr nc, .not_darkness
	ld hl, DarknessOBPalette
	ld bc, 1 palettes
	call AddNTimes
	jr .got_pal

.not_darkness
	ld a, [wNeededPalIndex]
	cp NUM_OW_TIME_OF_DAY_PALS
	jr c, .time_of_day_pal
	ld hl, SingleObjectPals - NUM_OW_TIME_OF_DAY_PALS palettes
	ld bc, 1 palettes
	call AddNTimes
	jr .got_pal

.time_of_day_pal
	ld hl, MapObjectPals
	ld bc, 1 palettes
	call AddNTimes
.check_daytimes
	ld a, [wPalFlags]
	bit USE_DAYTIME_PAL_F, a
	ld a, 1
	jr nz, .daytime
	ld a, [wTimeOfDayPal]
.daytime
	maskbits NUM_DAYTIMES
	ld bc, NUM_OW_TIME_OF_DAY_PALS palettes
	call AddNTimes
.got_pal
	pop de
	ld bc, 1 palettes
	call FarCopyColorWRAM
	ld hl, wPalFlags
	bit NO_DYN_PAL_APPLY_F, [hl]
	jr nz, .skip_apply
	call ApplyOBPals
	ld a, TRUE
	ldh [hCGBPalUpdate], a
.skip_apply
	pop af
	pop bc
	pop hl
	ret

ApplyOBPals:
	ld hl, wOBPals1
	ld de, wOBPals2
	ld bc, 8 palettes
	ld a, BANK(wGBCPalettes)
	jp FarCopyColorWRAM

MapObjectPals:
	table_width 1 palettes, MapObjectPals
INCLUDE "gfx/overworld/npc_sprites.pal"
	assert_table_length NUM_OW_TIME_OF_DAY_PALS * NUM_DAYTIMES ; morn, day, nite, eve

SingleObjectPals:
	table_width 1 palettes, SingleObjectPals
INCLUDE "gfx/overworld/npc_single_object.pal"
	assert_table_length NUM_OW_INDIVIDUAL_PALS

DarknessOBPalette:
	table_width 1 palettes, DarknessOBPalette
INCLUDE "gfx/overworld/npc_sprites_darkness.pal"
	assert_table_length NUM_OW_TIME_OF_DAY_PALS + NUM_OW_INDIVIDUAL_PALS