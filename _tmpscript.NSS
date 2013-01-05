void main() {
	// Get our entering object.
	object oPC = GetEnteringObject();
	
	SetOwnersControlledCompanion( oUser, GetFactionLeader( oUser ) );
}