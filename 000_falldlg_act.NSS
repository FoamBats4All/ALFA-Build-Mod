#include "acr_hazards_i"

void main () {
	// Harvest data.
	object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	int nDistance = GetLocalInt( OBJECT_SELF, "distance" );
	location lLocation = GetLocation( oPC );
	int nWilling = GetLocalInt( OBJECT_SELF, "willing" );
	int nWaterDepth = GetLocalInt( OBJECT_SELF, "depth" );
	int bYieldingSurface = GetLocalInt( OBJECT_SELF, "yielding" );
	
	// Output debug info.
	SendMessageToPC( oPC, "nDistance = " + IntToString( nDistance ) );
	SendMessageToPC( oPC, "nWilling = " + IntToString( nWilling ) );
	SendMessageToPC( oPC, "nWaterDepth = " + IntToString( nWaterDepth ) );
	SendMessageToPC( oPC, "bYieldingSurface = " + IntToString( bYieldingSurface ) );
	
	// Fall.
	ACR_FallToLocation( oPC, nDistance, lLocation, nWilling, nWaterDepth, bYieldingSurface );
}