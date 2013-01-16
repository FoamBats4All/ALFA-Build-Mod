////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Core Rules
//     Filename : acr_interface_i.nss
//      Version : 1.0
//         Date : 2012-01-08
//       Author : FoamBats4All
//
//  Local Variable Prefix:
//	ACR_CMD
//
//  Description:
//  This module defines interaction with a user. Multiple inputs (GUI, text,
//  etc.) share the same functionality. This provides a single library to use
//  them all. 
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_nonlethal_i"
#include "acr_tradescroll_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Prefix for text commands.
const string ACR_FI_CMD_TEXT_PREFIX = "#";
const int ACR_FI_CMD_TEXT_PREFIX_LENGTH = 1;

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//! Mines the parameter at given position from the command.
//!  - sCommand : The command input to get the parameter from.
//!  - nParamNumber : Parameter number to fetch.
//! Returns: Parameter if found, empty string on error.
string ACR_FI_GetParameter( string sCommand, int nParamNumber );

object ACR_FI_ParameterToObject( object oPC, string sParam );

void ACR_FI_RunCommand( object oPC, string sCommand, string sParam0 = "", string sParam1 = "", string sParam2 = "" );

void ACR_FI_ParseAndRunCommand( object oPC, string sCommand );

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


void ACR_FI_SetSubdualMode( object oPC, string sState ) {
	if ( sState == "on" ) {
		_SetNLDMode( oPC, TRUE );
	} else if ( sState == "off" ) {
		_SetNLDMode( oPC, FALSE );
	} else {
		_SetNLDMode( oPC, !_GetNLDMode( oPC ) );
	}
}


void ACR_FI_Pray( object oPC ) {
	
}


void ACR_FI_MemorizeSpells( object oPC ) {
	
}


void ACR_FI_ListKnownSpells( object oPC, string sClass ) {
	
}


void ACR_FI_ListPreparedSpells( object oPC, string sClass ) {
	
}


void ACR_FI_Craft( object oPC, object oTarget ) {
	
}


void ACR_FI_ScribeScroll( object oPC ) {
	
}


void ACR_FI_MakeTradescroll( object oPC, string sSpell ) {
	ACR_CreateTradeScroll( oPC, StringToInt( sSpell ) );
}


void ACR_FI_BrewPotion( object oPC ) {
	
}


void ACR_FI_CraftWand( object oPC ) {
	
}


string ACR_FI_GetParameter( string sCommand, int nParamNumber ) {
	// Reusable variables.
	int i;
	
	// Parameter data.
	int iStartPosition = -1;
	int iParamLength = -1;
	
	// Find the parameter and its length.
	for ( i = 0; i < nParamNumber; i++ ) {
		iStartPosition = FindSubString( sCommand, " ", iStartPosition + 1 );
		if ( iStartPosition == -1 ) return "";
	}
	iStartPosition++;
	iParamLength = FindSubString( sCommand, " ", iStartPosition ) - iStartPosition;
	
	// Verify output and return.
	if ( iStartPosition < 1 || iParamLength < 1 ) {
		return "";
	}
	return GetSubString( sCommand, iStartPosition, iParamLength );
}


object ACR_FI_ParameterToObject( object oPC, string sParam ) {
	// Allow self-referencing.
	if ( sParam == "$self" ) return oPC;
	
	// Allow selecting our current target.
	if ( sParam == "$target" ) return GetPlayerCurrentTarget( oPC );
	
	// Allow targetting our animal companion/familiar.
	if ( sParam == "$companion" ) return GetHenchman( oPC );
	
	// All other posibilities are invalid.
	return OBJECT_INVALID;
}


void ACR_FI_RunCommand( object oPC, string sCommand, string sParam0 = "", string sParam1 = "", string sParam2 = "" ) {
	// First, we lowercase everything.
	sCommand = GetStringLowerCase( sCommand );
	sParam0 = GetStringLowerCase( sParam0 );
	sParam1 = GetStringLowerCase( sParam1 );
	sParam2 = GetStringLowerCase( sParam2 );

	// Debug message
	SendMessageToPC( oPC, sCommand + "( " + sParam0 + ", " + sParam1 + ", " + sParam2 + " )" );
	
	// Actual commands.
	if ( sCommand == "subdual" ) ACR_FI_SetSubdualMode( oPC, sParam0 );
	else if ( sCommand == "pray" ) ACR_FI_Pray( oPC );
	else if ( sCommand == "memorize" ) ACR_FI_MemorizeSpells( oPC );
	else if ( sCommand == "knownspells" ) ACR_FI_ListKnownSpells( oPC, sParam0 );
	else if ( sCommand == "preparedspells" ) ACR_FI_ListPreparedSpells( oPC, sParam0 );
	else if ( sCommand == "craft" ) ACR_FI_Craft( oPC, GetPlayerCurrentTarget( oPC ) );
	else if ( sCommand == "scribescroll" ) ACR_FI_ScribeScroll( oPC );
	else if ( sCommand == "tradescroll" ) ACR_FI_MakeTradescroll( oPC, sParam0 );
	else if ( sCommand == "brewpotion" ) ACR_FI_BrewPotion( oPC );
	else if ( sCommand == "craftwand" ) ACR_FI_CraftWand( oPC );
}


void ACR_FI_ParseAndRunCommand( object oPC, string sCommand ) {
	// Find our parameters.
	string sParam0 = ACR_FI_GetParameter( sCommand, 1 );
	string sParam1 = ACR_FI_GetParameter( sCommand, 2 );
	string sParam2 = ACR_FI_GetParameter( sCommand, 3 );
	
	// Isolate our command.
	string sCommand = ACR_FI_GetParameter( sCommand, 0 );
	
	// Call our parent method.
	ACR_FI_RunCommand( oPC, sCommand, sParam0, sParam1, sParam2 );
}