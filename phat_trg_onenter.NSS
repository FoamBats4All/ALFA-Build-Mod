////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 237        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix: <N/A>
//
//  Dependencies:
//	Relies on the ACR spawn system for determining if content is available.
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007-01-20	Cipher	Inception
//	2012-04-17	Foam	Cleaned code, added comments/made readable.
////////////////////////////////////////////////////////////////////////////////

#include "acr_trigger_i"
#include "acr_quest_i"

void main() {
	// Hook ACR.
    ACR_TriggerOnEnter();
	
	// Get objects.
	object oEnterer = GetEnteringObject();
	object oChest = GetLocalObject( OBJECT_SELF, "oChest" );
	
	// Get 'power' of the chest (0-4).
	int iPower = Random( 5 );
	
	// Get the trap power.
	int iTrap_Power = 0;
	if( iPower == 4 ) iTrap_Power = 1;
	
	// Has this character been parsed before?
	if ( GetLocalString( oChest, GetName( oEnterer ) ) == GetName( oEnterer ) ) {
		return;
	}
	SetLocalString( oChest, GetName( oEnterer ), GetName( oEnterer ) );
	
	// If it's not already usable...
	if ( GetUseableFlag( oChest ) == FALSE ) {
		// Find the usability DC.
		int iUseableDC = GetLocalInt( oChest, "iUseableDC" );
		if ( iUseableDC == 0 ) {
			iUseableDC = 20 + Random(11) - Random(11);
			SetLocalInt( oChest, "iUseableDC", iUseableDC );
		}
		
		// If the entering character has a chance of searching the chest...
		if ( GetIsSkillSuccessful( oEnterer, SKILL_SEARCH, iUseableDC, FALSE ) == TRUE ) {
			// Make the spawn usable.
			SetUseableFlag( oChest, TRUE );
			
			// Set the unlock DC.
			int iUnlockDC = GetLocalInt( oChest, "iUnlockDC" );
			if ( iUnlockDC == 0 ) {
				iUnlockDC = 30 + Random(11) - Random(11) + ( 5 * iTrap_Power );
				SetLocalInt( oChest, "iUnlockDC", iUnlockDC );
			}
			if ( GetLockLockable( oChest ) == TRUE ) SetLocked( oChest, TRUE );
			SetLockUnlockDC( oChest, iUnlockDC );
			
			// If it is trappable, determine the trap.
			if ( GetLocalInt( oChest, "Trappable" ) == 1 ) {
				// 50% chance of a trap...
				if ( Random(2) == 1 ) {
					// Create the trap.
					if ( iPower == 4 ) {
						CreateTrapOnObject( 4 * Random(11) + 1, oChest, STANDARD_FACTION_HOSTILE, "1sc_plc_ontrapdisarm" );
						SetLocalInt(oChest, "Average_Trap", 1);
					} else {
						CreateTrapOnObject( 4 * Random(11), oChest, STANDARD_FACTION_HOSTILE, "1sc_plc_ontrapdisarm" );
					}
					object oTrap = GetNearestTrapToObject( OBJECT_SELF, FALSE );
					
					// Set detection DC.
					int iDetectDC = GetLocalInt( oChest, "iDetectDC" );
					if ( iDetectDC == 0 ) {
						iDetectDC = 20 + Random(11) - Random(11) + ( 5 * iTrap_Power );
						SetLocalInt( oChest, "iDetectDC", iDetectDC );
					}
					SetTrapDetectDC( oChest, iDetectDC );
					SetTrapDetectDC( oTrap, iDetectDC );
					
					// Set disable DC.
					int iDisableDC = GetLocalInt( oChest, "iDisableDC" );
					if ( iDisableDC == 0 ) {
						iDisableDC = 25 + Random(11) - Random(11) + (5 * iTrap_Power);
						SetLocalInt(oChest, "iDisableDC", iDisableDC);
					}
					SetTrapDisarmDC( oChest, iDisableDC );
					SetTrapDisarmDC( oTrap, iDisableDC );
					
					// Finish up the trapping.
					SetTrapDisarmable( oTrap, TRUE );
					SetTrapDisarmable( oChest, TRUE );
					SetLocalInt( oChest, "DM_Trapped", 1 );
				}
			}	
		}
	}
}