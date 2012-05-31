/* --------------------------------------------------- *\
| fireplace_onuse.nss									|
| Version: 2012-04-30, Revision 2						|
| Author: FoamBats4All									|
| Variable Prefix: ABR_RELOCATE_						|
|-------------------------------------------------------|
|														|
|-------------------------------------------------------|
| Change Log:											|
|	2012-04-30	Foam	Initial version.				|
\* --------------------------------------------------- */

const string FIREPLACE_TAG = "FIREPLACE_TAG";
const string FIREPLACE_EFFECT = "FIREPLACE_STATE";

const string FIREPLACE_STATE = "FIREPLACE_STATE";
const int FIREPLACE_STATE_ENABLED = 0;
const int FIREPLACE_STATE_DISABLED = 1;

#include "acr_placeable_i"

void main() {
	// Hook ACR OnUsed events.
	ACR_PlaceableOnUsed();
	
	// Often used variables.
	object oUser = GetLastUsedBy();
	int iState = GetLocalInt( OBJECT_SELF, FIREPLACE_STATE );
	string sFireplaceTag = GetLocalString( OBJECT_SELF, FIREPLACE_TAG );
	
	// Toggle fireplace.
	if ( iState == FIREPLACE_STATE_ENABLED ) {
		// Destroy all related effects.
		int n = 0;
		object oEffect = GetObjectByTagAndType( sFireplaceTag, OBJECT_TYPE_PLACED_EFFECT, n );
		while ( GetIsObjectValid( oEffect )  ) {
			DestroyObject( oEffect, 1.0f, FALSE );
			n++;
			oEffect = GetObjectByTagAndType( sFireplaceTag, OBJECT_TYPE_PLACED_EFFECT, n );
		}
		
		// Turn off the light.
		object oLight = GetObjectByTagAndType( sFireplaceTag, OBJECT_TYPE_LIGHT, 0 );
		SetLightActive( oLight, FALSE );
		
		
		iState = FIREPLACE_STATE_DISABLED;
	} else if ( iState == FIREPLACE_STATE_DISABLED ) {
		// Turn on the light.
		object oLight = GetObjectByTagAndType( sFireplaceTag, OBJECT_TYPE_LIGHT, 0 );
		SetLightActive( oLight, TRUE );
		
		// Create a fireplace effect.
		CreateObject( OBJECT_TYPE_PLACED_EFFECT, "", GetLocation( oLight ), TRUE );
		
		iState = FIREPLACE_STATE_ENABLED;
	} else {
		SendMessageToPC( oUser, "<c=red>This fireplace is incorrectly configured.</c>" );
	}
	
	// Save state.
	SetLocalInt( OBJECT_SELF, FIREPLACE_STATE, iState );
}