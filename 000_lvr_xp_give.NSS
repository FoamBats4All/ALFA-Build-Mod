void main() {
	object oUser = GetLastUsedBy();
	
	int nXP = GetLocalInt( OBJECT_SELF, "xp_amount" );
	if ( nXP == 0 ) nXP = 1000;
	
	GiveXPToCreature( oUser, nXP );
}