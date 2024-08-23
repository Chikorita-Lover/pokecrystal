MACRO landmark
; x, y, name
	db \1 + 8, \2 + 16
	dw \3
ENDM

Landmarks:
; entries correspond to constants/landmark_constants.asm
	table_width 4, Landmarks
	landmark  -8, -16, SpecialMapName
	landmark 140, 100, NewBarkTownName
	landmark 128, 100, Route29Name
	landmark 108, 100, CherrygroveCityName
	landmark 108,  80, Route30Name
	landmark 100,  68, Route31Name
	landmark  84,  68, VioletCityName
	landmark  86,  66, SproutTowerName
	landmark  84,  88, Route32Name
	landmark  76,  76, RuinsOfAlphName
	landmark  84, 108, UnionCaveName
	landmark  80, 116, Route33Name
	landmark  68, 116, AzaleaTownName
	landmark  70, 114, SlowpokeWellName
	landmark  60, 116, IlexForestName
	landmark  60, 104, Route34Name
	landmark  60,  92, GoldenrodCityName
	landmark  58,  92, RadioTowerName
	landmark  60,  80, Route35Name
	landmark  60,  68, NationalParkName
	landmark  72,  68, Route36Name
	landmark  68,  60, Route37Name
	landmark  68,  52, EcruteakCityName
	landmark  68,  44, BellTowerName
	landmark  66,  50, BurnedTowerName
	landmark  56,  52, Route38Name
	landmark  44,  56, Route39Name
	landmark  44,  68, OlivineCityName
	landmark  46,  70, LighthouseName
	landmark  36,  60, BattleTowerName
	landmark  36,  76, Route40Name
	landmark  36,  92, WhirlIslandsName
	landmark  28,  92, Route41Name
	landmark  20,  92, CianwoodCityName
	landmark  92,  52, Route42Name
	landmark  84,  52, MtMortarName
	landmark 100,  52, MahoganyTownName
	landmark 100,  44, Route43Name
	landmark 100,  36, LakeOfRageName
	landmark 116,  52, Route44Name
	landmark 140,  52, IcePathName
	landmark 132,  52, BlackthornCityName
	landmark 132,  50, DragonsDenName
	landmark 132,  70, Route45Name
	landmark 120,  68, DarkCaveName
	landmark 124,  88, Route46Name
	landmark 148,  68, MtSilverName
	assert_table_length KANTO_LANDMARK
	landmark  52,  92, PalletTownName
	landmark  52,  80, Route1Name
	landmark  52,  68, ViridianCityName
	landmark  52,  60, Route2Name
	landmark  52,  52, PewterCityName
	landmark  64,  52, Route3Name
	landmark  76,  52, MtMoonName
	landmark  92,  52, Route4Name
	landmark 108,  52, CeruleanCityName
	landmark 108,  40, Route24Name
	landmark 124,  36, Route25Name
	landmark 108,  60, Route5Name
	landmark 116,  76, UndergroundPathName
	landmark 108,  76, Route6Name
	landmark 108,  84, VermilionCityName
	landmark  84,  60, DiglettsCaveName
	landmark 100,  68, Route7Name
	landmark 120,  68, Route8Name
	landmark 120,  52, Route9Name
	landmark 132,  52, RockTunnelName
	landmark 132,  60, Route10Name
	landmark 134,  54, PowerPlantName
	landmark 132,  68, LavenderTownName
	landmark 134,  68, LavRadioTowerName
	landmark  92,  68, CeladonCityName
	landmark 108,  68, SaffronCityName
	landmark 120,  84, Route11Name
	landmark 132,  84, Route12Name
	landmark 124, 100, Route13Name
	landmark 116, 104, Route14Name
	landmark 104, 108, Route15Name
	landmark  80,  68, Route16Name
	landmark  76,  88, CyclingRoadName
	landmark  80, 108, Route18Name
	landmark  92, 108, FuchsiaCityName
	landmark  92, 120, Route19Name
	landmark  68, 124, Route20Name
	landmark  76, 124, SeafoamIslandsName
	landmark  52, 124, CinnabarIslandName
	landmark  52, 110, Route21Name
	landmark  36,  68, Route22Name
	landmark  20,  68, VictoryRoadName
	landmark  20,  60, Route23Name
	landmark  20,  52, IndigoPlateauName
	landmark  20,  88, Route26Name
	landmark  20, 100, Route27Name
	landmark  12, 100, TohjoFallsName
	landmark  12,  68, Route28Name
	landmark 140, 116, SSAquaName
	assert_table_length NUM_LANDMARKS

NewBarkTownName:     db "NEW BARK¯TOWN@"
CherrygroveCityName: db "CHERRYGROVE¯CITY@"
VioletCityName:      db "VIOLET CITY@"
AzaleaTownName:      db "AZALEA TOWN@"
GoldenrodCityName:   db "GOLDENROD¯CITY@"
EcruteakCityName:    db "ECRUTEAK¯CITY@"
OlivineCityName:     db "OLIVINE¯CITY@"
CianwoodCityName:    db "CIANWOOD¯CITY@"
MahoganyTownName:    db "MAHOGANY¯TOWN@"
BlackthornCityName:  db "BLACKTHORN¯CITY@"
LakeOfRageName:      db "LAKE OF¯RAGE@"
MtSilverName:        db "MT.SILVER@"
SproutTowerName:     db "SPROUT¯TOWER@"
RuinsOfAlphName:     db "RUINS¯OF ALPH@"
UnionCaveName:       db "UNION CAVE@"
SlowpokeWellName:    db "SLOWPOKE¯WELL@"
RadioTowerName:      db "RADIO TOWER@"
PowerPlantName:      db "POWER PLANT@"
NationalParkName:    db "NATIONAL¯PARK@"
BellTowerName:       db "BELL TOWER@"
LighthouseName:      db "LIGHTHOUSE@"
WhirlIslandsName:    db "WHIRL¯ISLANDS@"
MtMortarName:        db "MT.MORTAR@"
DragonsDenName:      db "DRAGON'S¯DEN@"
IcePathName:         db "ICE PATH@"
PalletTownName:      db "PALLET TOWN@"
ViridianCityName:    db "VIRIDIAN¯CITY@"
PewterCityName:      db "PEWTER CITY@"
CeruleanCityName:    db "CERULEAN¯CITY@"
LavenderTownName:    db "LAVENDER¯TOWN@"
VermilionCityName:   db "VERMILION¯CITY@"
CeladonCityName:     db "CELADON¯CITY@"
SaffronCityName:     db "SAFFRON¯CITY@"
FuchsiaCityName:     db "FUCHSIA¯CITY@"
CinnabarIslandName:  db "CINNABAR¯ISLAND@"
IndigoPlateauName:   db "INDIGO¯PLATEAU@"
VictoryRoadName:     db "VICTORY¯ROAD@"
MtMoonName:          db "MT.MOON@"
RockTunnelName:      db "ROCK TUNNEL@"
LavRadioTowerName:   db "LAV.RADIO¯TOWER@"
SilphCoName:         db "SILPH CO.@" ; unreferenced
SafariZoneName:      db "SAFARI ZONE@" ; unreferenced
SeafoamIslandsName:  db "SEAFOAM¯ISLANDS@"
PokemonMansionName:  db "#MON¯MANSION@" ; unreferenced
CeruleanCaveName:    db "CERULEAN¯CAVE@" ; unreferenced
Route1Name:          db "ROUTE 1@"
Route2Name:          db "ROUTE 2@"
Route3Name:          db "ROUTE 3@"
Route4Name:          db "ROUTE 4@"
Route5Name:          db "ROUTE 5@"
Route6Name:          db "ROUTE 6@"
Route7Name:          db "ROUTE 7@"
Route8Name:          db "ROUTE 8@"
Route9Name:          db "ROUTE 9@"
Route10Name:         db "ROUTE 10@"
Route11Name:         db "ROUTE 11@"
Route12Name:         db "ROUTE 12@"
Route13Name:         db "ROUTE 13@"
Route14Name:         db "ROUTE 14@"
Route15Name:         db "ROUTE 15@"
Route16Name:         db "ROUTE 16@"
CyclingRoadName:     db "CYCLING¯ROAD@"
Route18Name:         db "ROUTE 18@"
Route19Name:         db "ROUTE 19@"
Route20Name:         db "ROUTE 20@"
Route21Name:         db "ROUTE 21@"
Route22Name:         db "ROUTE 22@"
Route23Name:         db "ROUTE 23@"
Route24Name:         db "ROUTE 24@"
Route25Name:         db "ROUTE 25@"
Route26Name:         db "ROUTE 26@"
Route27Name:         db "ROUTE 27@"
Route28Name:         db "ROUTE 28@"
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
IlexForestName:      db "ILEX¯FOREST@"
BurnedTowerName:     db "BURNED¯TOWER@"
SSAquaName:          db "S.S.AQUA@"
ViridianForestName:  db "VIRIDIAN¯FOREST@" ; unreferenced
DiglettsCaveName:    db "DIGLETT'S¯CAVE@"
TohjoFallsName:      db "TOHJO FALLS@"
UndergroundPathName: db "UNDERGROUND¯PATH@"
BattleTowerName:     db "BATTLE¯TOWER@"
SpecialMapName:      db "SPECIAL@"
