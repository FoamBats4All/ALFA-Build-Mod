void main( string sVar, int nAmount ) {
	int nValue = GetLocalInt( OBJECT_SELF, sVar ) + nAmount;
	SetLocalInt( OBJECT_SELF, sVar, nValue );
}