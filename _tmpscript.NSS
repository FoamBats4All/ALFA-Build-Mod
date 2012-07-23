#include "acr_skills_i"

void main() {
	// Get our entering PC, and the hidden object.
	object oPC = GetEnteringObject();
	object oHiddenObject = GetObjectByTag( GetLocalString( OBJECT_SELF, "HIDDEN_OBJ_TAG" ) );
	int nDetectDC = GetLocalInt( OBJECT_SELF, "HIDDEN_DC" );
	
	// Have the player roll a search check.
	if ( ACR_SkillCheck( SKILL_SEARCH, oPC, nDetectDC ) ) {
		SetUseableFlag( oHiddenObject, TRUE );
	}
}