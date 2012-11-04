void main( string sVar, int nAmount ) {
	int nValue = GetLocalInt( OBJECT_SELF, sVar ) + nAmount;

	// And another edit in another file!

	SetLocalInt( OBJECT_SELF, sVar, nValue );
}