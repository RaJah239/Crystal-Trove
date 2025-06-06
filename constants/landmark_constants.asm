; Landmarks indexes (see data/maps/landmarks.asm)
	const_def
	const LANDMARK_SPECIAL           ; 00
; Johto landmarks
	const LANDMARK_NEW_BARK_TOWN     ; 01
	const LANDMARK_ROUTE_29          ; 02
	const LANDMARK_CHERRYGROVE_CITY  ; 03
	const LANDMARK_ROUTE_30          ; 04
	const LANDMARK_DARK_CAVE         ; 2c
	const LANDMARK_ROUTE_31          ; 05
	const LANDMARK_VIOLET_CITY       ; 06
	const LANDMARK_SPROUT_TOWER      ; 07
	const LANDMARK_RUINS_OF_ALPH     ; 09
	const LANDMARK_ROUTE_32          ; 08
	const LANDMARK_UNION_CAVE        ; 0a
	const LANDMARK_ROUTE_33          ; 0b
	const LANDMARK_AZALEA_TOWN       ; 0c
	const LANDMARK_SLOWPOKE_WELL     ; 0d
	const LANDMARK_ILEX_FOREST       ; 0e
	const LANDMARK_ROUTE_34          ; 0f
	const LANDMARK_GOLDENROD_CITY    ; 10
	const LANDMARK_RADIO_TOWER       ; 11
	const LANDMARK_ROUTE_35          ; 12
	const LANDMARK_NATIONAL_PARK     ; 13
	const LANDMARK_ROUTE_36          ; 14
	const LANDMARK_ROUTE_37          ; 15
	const LANDMARK_ECRUTEAK_CITY     ; 16
	const LANDMARK_TIN_TOWER         ; 17
	const LANDMARK_BURNED_TOWER      ; 18
	const LANDMARK_ROUTE_38          ; 19
	const LANDMARK_SILVER_CAVE       ; 2e
	const LANDMARK_ROUTE_39          ; 1a
	const LANDMARK_OLIVINE_CITY      ; 1b
	const LANDMARK_LIGHTHOUSE        ; 1c
	const LANDMARK_ROUTE_40          ; 1e
	const LANDMARK_BATTLE_TOWER      ; 1d
	const LANDMARK_WHIRL_ISLANDS     ; 1f
	const LANDMARK_ROUTE_41          ; 20
	const LANDMARK_CIANWOOD_CITY     ; 21
	const LANDMARK_MT_MORTAR         ; 23
	const LANDMARK_ROUTE_42          ; 22
	const LANDMARK_MAHOGANY_TOWN     ; 24
	const LANDMARK_ROUTE_43          ; 25
	const LANDMARK_LAKE_OF_RAGE      ; 26
	const LANDMARK_ROUTE_44          ; 27
	const LANDMARK_ICE_PATH          ; 28
	const LANDMARK_BLACKTHORN_CITY   ; 29
	const LANDMARK_DRAGONS_DEN       ; 2a
	const LANDMARK_ROUTE_45          ; 2b
	const LANDMARK_ROUTE_46          ; 2d
	const LANDMARK_TOHJO_FALLS       ; 5d
	const LANDMARK_ROUTE_27          ; 5c
	const LANDMARK_ROUTE_26          ; 5b
	const LANDMARK_VICTORY_ROAD      ; 58
	const LANDMARK_ROUTE_23          ; 59
	const LANDMARK_INDIGO_PLATEAU    ; 5a
DEF KANTO_LANDMARK EQU const_value
	const LANDMARK_PALLET_TOWN       ; 2f
	const LANDMARK_UNDERGROUND_PATH  ; 3b
	const LANDMARK_FAST_SHIP         ; 58
DEF NUM_LANDMARKS EQU const_value

; used in CaughtData
	const_def $7f, -1
	const LANDMARK_EVENT             ; $7f
	const LANDMARK_GIFT              ; $7e

; Regions
	const_def
	const JOHTO_REGION ; 0
	const KANTO_REGION ; 1
DEF NUM_REGIONS EQU const_value
