//  System Name : ALFA Core Rules
//     Filename : i_abr_dmquarantine_ac
//    $Revision:: 1           $ current version of the file
//        $Date:: 2012-04-24  $ date the file was created or modified
//       Author : FoamBats4All
//
//    Var Prefix: ABR_LOCK
//
//	Dependencies:
//		None
//
//	Description:
//		This script handles activation of the DM Quarantine Wand.
//
//	History:
//		2012-04-24	Foam	Initial version.
//
////////////////////////////////////////////////////////////////////////////////

// Constants.
const string ABR_LOCK_DC = "ABR_LOCK_DC";	// Custom door lock DC constant.

void main()
{
	// Get targets.
	object oLock = GetItemActivated();
	object oDoor =  GetItemActivatedTarget();
	object oPC = GetItemActivator();
	string sLockRef = GetResRef( oLock );
	int iDC = 0;
	
	// Is our target a door?
	if ( GetObjectType( oDoor ) != OBJECT_TYPE_DOOR ) {
		SendMessageToPC( oPC, "Locks may only be used on doors!" );
		return;
	}
	
	// Can the door be locked?
	if ( !GetLockLockable( oDoor ) ) {
		SendMessageToPC( oPC, "This door is not lockable." );
		return;
	}
	
	// Is the door already locked?
	if ( GetLocked( oDoor ) ) {
		SendMessageToPC( oPC, "This door is already locked." );
		return;
	}
	
	// Does the door already have a better lock on it?
	if ( GetLockKeyRequired( oDoor ) ) {
		SendMessageToPC( oPC, "This door cannot be locked." );
		return;
	}
	
	// Get the lock DC. First try to get it from a local variable.
	if ( GetLocalInt( oLock, ABR_LOCK_DC ) > 0 ) {
		iDC = GetLocalInt( oPC, ABR_LOCK_DC );
		
	// No? Then try to get it from the object's resref.
	} else if ( sLockRef == "abr_it_gr_lock_01" ) {
		iDC = 20;
	} else if ( sLockRef == "abr_it_gr_lock_02" ) {
		iDC = 25;
	} else if ( sLockRef == "abr_it_gr_lock_03" ) {
		iDC = 30;
	} else if ( sLockRef == "abr_it_gr_lock_04" ) {
		iDC = 40;
	
	// All else fails, this lock is not usable.
	} else {
		SendMessageToPC( oPC, "This lock appears to be unusable." );
		return;
	}
	
	// Lock the door.
	DestroyObject( oLock );
	SetLockUnlockDC( oDoor, iDC );
	AssignCommand( oPC, ActionLockObject( oDoor ) );
	FloatingTextStringOnCreature( "A lock has been fitted onto the door.", oPC, TRUE, 1.0f );
}
	