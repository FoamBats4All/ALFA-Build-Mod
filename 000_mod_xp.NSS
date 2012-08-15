#include "acr_xp_i"

void main() {
	object oPC = GetLastUsedBy();
	int xp = GetLocalInt( OBJECT_SELF, "xp" ) + GetXP( oPC );
	_SetALFAXp( oPC, xp );
}