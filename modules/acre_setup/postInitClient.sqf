#include "script_component.hpp"
#include "settings.sqf"

params ["_unit"];

if (!hasInterface) exitWith {};
if (GETVAR(_unit,Spectating,false)) exitWith {}; // If the unit is spectating, don't run this, it will overwrite their access to all languages
LOG_1("Running ACRE setup for %1", _unit);

GVAR(ACRE_Presets) = ["default2", "default3", "default4", "default"];

[{!isNull acre_player}, {
	private _customSide = player getVariable ["ACRE_CustomScramble", sideEmpty];
    private _side = if (_customSide isNotEqualTo sideEmpty) then {
		_side = _customSide;
	} else {
        side player
    };

	if ((abs GVAR(ACRE_Volume_Value)) > 2) then {
	  GVAR(ACRE_Volume_Value) = 0;
	};
	private _v = 0.7;
	switch (GVAR(ACRE_Volume_Value)) do {
		case -2: {_v = 0.1;};
		case -1: {_v = 0.2;};
		case 0: {_v = 0.4;};
		case 1: {_v = 0.7;};
		case 2: {_v = 1.0;};
		default {_v = 0.4;};
	};
	[_v] call acre_api_fnc_setSelectableVoiceCurve;
	acre_sys_gui_VolumeControl_Level = GVAR(ACRE_Volume_Value);

	private _volumeDelay = 1;
	[{
		acre_sys_gui_VolumeControl_Level = GVAR(ACRE_Volume_Value);
	}, [], _volumeDelay] call CBA_fnc_waitAndExecute;

	private _side_i = switch (_side) do {
		case west: {
			0
		};
		case east: {
            1
		};
		case independent: {
			2
		};
		default {
			3
		};
	};

	if (GVAR(ACRE_Enable_Scramble)) then {
		private _preset = GVAR(ACRE_Presets) select _side_i;

		["ACRE_PRC343", _preset ] call acre_api_fnc_setPreset;
		["ACRE_PRC77", _preset ] call acre_api_fnc_setPreset;
		["ACRE_PRC117F", _preset ] call acre_api_fnc_setPreset;
		["ACRE_PRC152", _preset ] call acre_api_fnc_setPreset;
		["ACRE_PRC148", _preset ] call acre_api_fnc_setPreset;
		["ACRE_SEM52SL", _preset ] call acre_api_fnc_setPreset;
		["ACRE_SEM70", _preset ] call acre_api_fnc_setPreset;
	};

	if (GVAR(ACRE_Enable_Babel)) then {
		GVAR(ACRE_All_Languages) apply {_x call acre_api_fnc_babelAddLanguageType;};

		(GVAR(ACRE_Languages_Babel) select _side_i) call acre_api_fnc_babelSetSpokenLanguages;

		private _languages = player getVariable ["ACRE_Languages", []];

		if (count _languages > 0) then {
			_languages call acre_api_fnc_babelSetSpokenLanguages;
		};
	};

	[{[] call acre_api_fnc_isInitialized}, {
		private _channels = player getVariable ["ACRE_Channels", []];

		_channels apply {
			_x params [
				["_radio", ""],
				["_channel", 1],
				["_spatial", "CENTER"]
			];
			private _radioID = [_radio] call acre_api_fnc_getRadioByType;
			if (isNil "_radioID") then {
				ERROR_2("unit does not have radio that acre module is trying to set!",_unit,_radio);
			} else {
                [_radioID, _channel] call acre_api_fnc_setRadioChannel;
				[_radioID, _spatial] call acre_api_fnc_setRadioSpatial;
            };
		};
	}, []] call CBA_fnc_waitUntilAndExecute;
}, []] call CBA_fnc_waitUntilAndExecute;
