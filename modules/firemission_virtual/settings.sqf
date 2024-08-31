/*Ammo
"vn_mortar_m29_mag_he_x8" 81mm
"vn_mortar_m29_mag_wp_x8"
"vn_mortar_m29_mag_lume_x8"

"vn_mortar_m2_mag_he_x8"  60mm
"vn_mortar_m2_mag_wp_x8"
"vn_mortar_m2_mag_lume_x8"

"rhs_12Rnd_m821_HE" 81mm HE

"rhs_mag_m26a1_6" Cluster missile

"magazine_ShipCannon_120mm_HE_shells_x32"
"magazine_ShipCannon_120mm_HE_guided_shells_x2"
"magazine_ShipCannon_120mm_HE_LG_shells_x2"
"magazine_ShipCannon_120mm_HE_cluster_shells_x2"
"magazine_ShipCannon_120mm_mine_shells_x6"
"magazine_ShipCannon_120mm_smoke_shells_x6"
"magazine_ShipCannon_120mm_AT_mine_shells_x6"


"32Rnd_155mm_Mo_shells"
"4Rnd_155mm_Mo_guided"
"6Rnd_155mm_Mo_mine"
"2Rnd_155mm_Mo_Cluster"
"6Rnd_155mm_Mo_smoke"
"2Rnd_155mm_Mo_LG"
"6Rnd_155mm_Mo_AT_mine"
*/

#include "script_component.hpp"

["tin_var_artyObservers", [	//[OBJECT,"STRING",side]

]] call FUNC(publicVariable);

// Example
/* ["tin_var_artyObservers", [	//[OBJECT,"STRING",side]
	[test_unit, "Test Unit", blufor]
]] call FUNC(publicVariable); */

["tin_var_artyFreq_west", 1] call FUNC(publicVariable);
["tin_var_artyFreq_east", 0] call FUNC(publicVariable);
["tin_var_artyFreq_independent", 0] call FUNC(publicVariable);
["tin_var_artyFreq_civilian", 0] call FUNC(publicVariable);

["tin_var_artyBatteries", [	//[[name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side] - delayTime and calcTime can be an array [min,max]
	["ORCO", true, [
		["rhs_12Rnd_m821_HE", 80],
		["8Rnd_82mm_Mo_Smoke_white", 20]
	], 4, 180, 5, 60, 35, [0.1, 1.0], west]
]] call FUNC(publicVariable);

["tin_var_fireMissions_west", [

]] call FUNC(publicVariable);

["tin_var_fireMissions_east", [

]] call FUNC(publicVariable);

["tin_var_fireMissions_independent", [

]] call FUNC(publicVariable);

["tin_var_fireMissions_civilian", [

]] call FUNC(publicVariable);
