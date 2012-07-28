int StartingConditional( string variable, string comparison, int nValue ) {
    object oPC = GetPCSpeaker();
	
	if ( comparison == "==" ) {
		return ( GetLocalInt( OBJECT_SELF, variable ) == nValue );
	} else if ( comparison == "!=" ) {
		return ( GetLocalInt( OBJECT_SELF, variable ) != nValue );
	} else if ( comparison == "<" ) {
		return ( GetLocalInt( OBJECT_SELF, variable ) < nValue );
	} else if ( comparison == "<=" ) {
		return ( GetLocalInt( OBJECT_SELF, variable ) <= nValue );
	} else if ( comparison == ">" ) {
		return ( GetLocalInt( OBJECT_SELF, variable ) > nValue );
	} else if ( comparison == ">=" ) {
		return ( GetLocalInt( OBJECT_SELF, variable ) >= nValue );
	} else {
		SendMessageToPC( oPC, "Invalid comparison type: " + comparison );
	}

	return FALSE;
}