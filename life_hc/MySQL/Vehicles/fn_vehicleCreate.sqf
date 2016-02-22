/*
	File: fn_vehicleCreate.sqf
	Author: Bryan "Tonic" Boardwine
	
	This file is for Nanou's HeadlessClient.
	
	Description:
	Answers the query request to create the vehicle in the database.
*/
diag_log "Script VehicleCreate HC";
private["_uid","_side","_type","_classname","_color","_plate"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
_side = [_this,1,sideUnknown,[west]] call BIS_fnc_param;
_vehicle = [_this,2,ObjNull,[ObjNull]] call BIS_fnc_param;
_color = [_this,3,-1,[0]] call BIS_fnc_param;

//Error checks
if(_uid == "" OR _side == sideUnknown OR isNull _vehicle) exitWith {};
if(!alive _vehicle) exitWith {};
_className = typeOf _vehicle;
_type = switch(true) do {
	case (_vehicle isKindOf "Car"): {"Car"};
	case (_vehicle isKindOf "Air"): {"Air"};
	case (_vehicle isKindOf "Ship"): {"Ship"};
};

_side = switch(_side) do {
	case west:{"cop"};
	case civilian: {"civ"};
	case independent: {"med"};
	default {"Error"};
};

_plate = round(random(1000000));

[_uid,_side,_type,_classname,_color,_plate] call HC_fnc_insertVehicle;

_vehicle setVariable["dbInfo",[_uid,_plate]];

/*------------------------------------------------------------------

So here, i have a problem, all vehicles created never die (alive=0)
because i think addEventHandler doesnt work in the HC.... 
So we should find an other way to die this fxxxxxing _vehicle !!!!

?????? THIS
_vehicle addEventHandler["Killed", {_this spawn HC_fnc_vehicleDead}];
?????? Doesnt work

------------------------------------------------------------------*/