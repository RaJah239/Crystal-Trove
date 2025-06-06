MACRO landmark
; x, y, name
	db \1 + 8, \2 + 16
	dw \3
ENDM

Landmarks:
; entries correspond to constants/landmark_constants.asm
	table_width 4, Landmarks
	landmark  -8, -16, SpecialMapName
	landmark 132, 100, NewBarkTownName
	landmark 116, 100, Route29Name
	landmark  92, 100, CherrygroveCityName
	landmark  92,  84, Route30Name
	landmark 100,  60, DarkCaveName
	landmark  88,  60, Route31Name
	landmark  76,  60, VioletCityName
	landmark  76,  56, SproutTowerName
	landmark  68,  76, RuinsOfAlphName
	landmark  76,  92, Route32Name
	landmark  76, 124, UnionCaveName
	landmark  72, 124, Route33Name
	landmark  60, 124, AzaleaTownName
	landmark  62, 122, SlowpokeWellName
	landmark  44, 124, IlexForestName
	landmark  44, 108, Route34Name
	landmark  44,  92, GoldenrodCityName
	landmark  42,  92, RadioTowerName
	landmark  44,  76, Route35Name
	landmark  44,  60, NationalParkName
	landmark  60,  60, Route36Name
	landmark  60,  52, Route37Name
	landmark  60,  44, EcruteakCityName
	landmark  62,  42, TinTowerName
	landmark  58,  42, BurnedTowerName
	landmark  44,  44, Route38Name
	landmark  36,  28, SilverCaveName
	landmark  28,  48, Route39Name
	landmark  28,  60, OlivineCityName
	landmark  30,  62, LighthouseName
	landmark  20,  60, Route40Name
	landmark  20,  52, BattleTowerName
	landmark  20,  92, WhirlIslandsName
	landmark  20, 100, Route41Name
	landmark  12, 100, CianwoodCityName
	landmark  76,  44, MtMortarName
	landmark  84,  44, Route42Name
	landmark 100,  44, MahoganyTownName
	landmark 100,  36, Route43Name
	landmark 100,  28, LakeOfRageName
	landmark 112,  44, Route44Name
	landmark 124,  36, IcePathName
	landmark 124,  44, BlackthornCityName
	landmark 124,  40, DragonsDenName
	landmark 124,  64, Route45Name
	landmark 116,  88, Route46Name
	landmark 140, 100, TohjoFallsName
	landmark 148, 100, Route27Name
	landmark 148,  84, Route26Name
	landmark 148,  52, VictoryRoadName
	landmark 148,  44, Route23Name
	landmark 148,  36, IndigoPlateauName		
	assert_table_length KANTO_LANDMARK
	landmark  52, 108, PalletTownName
	landmark 108,  76, UndergroundName
	landmark 140, 116, FastShipName
	assert_table_length NUM_LANDMARKS

NewBarkTownName:     db "NEW BARK<BSP>TOWN@"
CherrygroveCityName: db "CHERRYGROVE<BSP>CITY@"
VioletCityName:      db "VIOLET CITY@"
AzaleaTownName:      db "AZALEA TOWN@"
GoldenrodCityName:   db "GOLDENROD<BSP>CITY@"
EcruteakCityName:    db "ECRUTEAK<BSP>CITY@"
OlivineCityName:     db "OLIVINE<BSP>CITY@"
CianwoodCityName:    db "CIANWOOD<BSP>CITY@"
MahoganyTownName:    db "MAHOGANY<BSP>TOWN@"
BlackthornCityName:  db "BLACKTHORN<BSP>CITY@"
LakeOfRageName:      db "LAKE OF<BSP>RAGE@"
SilverCaveName:      db "MT. SILVER@"
SproutTowerName:     db "SPROUT<BSP>TOWER@"
RuinsOfAlphName:     db "RUINS<BSP>OF ALPH@"
UnionCaveName:       db "UNION CAVE@"
SlowpokeWellName:    db "SLOWPOKE<BSP>WELL@"
RadioTowerName:      db "RADIO TOWER@"
NationalParkName:    db "NATIONAL<BSP>PARK@"
TinTowerName:        db "TIN TOWER@"
LighthouseName:      db "LIGHTHOUSE@"
WhirlIslandsName:    db "WHIRL<BSP>ISLANDS@"
MtMortarName:        db "MT.MORTAR@"
DragonsDenName:      db "DRAGON'S<BSP>DEN@"
IcePathName:         db "ICE PATH@"
PalletTownName:      db "PALLET TOWN@"
IndigoPlateauName:   db "INDIGO<BSP>PLATEAU@"
VictoryRoadName:     db "VICTORY<BSP>ROAD@"
Route23Name:         db "ROUTE 23@"
Route26Name:         db "ROUTE 26@"
Route27Name:         db "ROUTE 27@"
Route29Name:         db "ROUTE 29@"
Route30Name:         db "ROUTE 30@"
Route31Name:         db "ROUTE 31@"
Route32Name:         db "ROUTE 32@"
Route33Name:         db "ROUTE 33@"
Route34Name:         db "ROUTE 34@"
Route35Name:         db "ROUTE 35@"
Route36Name:         db "ROUTE 36@"
Route37Name:         db "ROUTE 37@"
Route38Name:         db "ROUTE 38@"
Route39Name:         db "ROUTE 39@"
Route40Name:         db "ROUTE 40@"
Route41Name:         db "ROUTE 41@"
Route42Name:         db "ROUTE 42@"
Route43Name:         db "ROUTE 43@"
Route44Name:         db "ROUTE 44@"
Route45Name:         db "ROUTE 45@"
Route46Name:         db "ROUTE 46@"
DarkCaveName:        db "DARK CAVE@"
IlexForestName:      db "ILEX<BSP>FOREST@"
BurnedTowerName:     db "BURNED<BSP>TOWER@"
FastShipName:        db "FAST SHIP@"
TohjoFallsName:      db "TOHJO FALLS@"
UndergroundName:     db "UNDERGROUND@"
BattleTowerName:     db "BATTLE<BSP>TOWER@"
SpecialMapName:      db "SPECIAL@"
