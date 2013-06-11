const string LVAR_SCENE = "scene";
const string LVAR_FILE = "file";

void main() {
	object oPC = GetLastUsedBy();
	
	string sScene = GetLocalString( OBJECT_SELF, LVAR_SCENE );
	string sFileName = GetLocalString( OBJECT_SELF, LVAR_FILE );
	
	SendMessageToPC( oPC, "DisplayGuiScreen( " + GetName(oPC) + ", " + sScene + ", FALSE, " + sFileName + " );" );
	
	DisplayGuiScreen( oPC, sScene, FALSE, sFileName );
}