////////////////////////////////////////////////////////////////////////////////
//
//  System Name : Phat Loot
//     Filename : phat_plc_ontrapdisarm.nss
//    $Revision:: 184        $ current version of the file
//        $Date:: 2012-04-15#$ date the file was created or modified
//       Author : Ronan, FoamBats4All
//
//  Local Variable Prefix: <N/A>
//
//  Dependencies:
//  Current version of the ACR.
//
//  Description:
//  This script hooks the ACR's OnDisarm code for pleaceables, and awards static
//	quest experience based on the DC.
//
//  Revision History:
//  2006-11-01	Ronan	Initial version.
//  2012-04-15	Foam	Added hook to the ACR's OnDisarm function.
////////////////////////////////////////////////////////////////////////////////

#include "acr_placeable_i"
#include "acr_xp_i"

/*
 * OnTrapDisarm trigger event.
 *
 * Rewards experience for the disarm to the disarmer, and hooks the ACR OnDisarm event.
 */
void main() {
	// Run the ACR OnDisarm code.
	ACR_PlaceableOnDisarm();

	// Reward static experience for the disarm.
    int iXP = GetTrapDisarmDC( OBJECT_SELF );
	ACR_AwardStaticQuestXP( GetLastDisarmed(), "Disarm Chest", iXP );
}