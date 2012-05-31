#include "acr_xp_i"

void main() {
	object oPC = GetLastUsedBy();
	int xp = GetLocalInt( OBJECT_SELF, "xp" );
	ACR_GiveXPToPC( oPC, xp );
}