#include "acr_hazards_i"

void main() {
	object oPC = GetLastUsedBy();
	
	AssignCommand( oPC, ClearAllActions( TRUE ) );
	AssignCommand( oPC, ActionStartConversation( oPC, "000_falldlg", TRUE, FALSE, TRUE, TRUE ) );
}