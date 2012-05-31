////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onspawnin
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnSpawnIn event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//    2010/11/17  AcadiusLost - Autodisabled flocking on creatures without a "parent" spawn point.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_fam_i"
#include "acr_creature_i"
#include "NW_I0_GENERIC"
#include "NW_O2_CONINCLUDE"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

int USE_SPECIAL_ABILITY=75;


////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


void main() {
	WriteTimestampedLogEntry( "acf_cre_onspawnin_fam called." );
	// ACR Hooks.
	ACR_CreatureOnSpawnIn();
	ACR_FamiliarOnSpawnIn();
	
    // Run this campaign's standard creature spawn modifications script (set in module load)
    string sScriptSpawnCreature = GetGlobalString("N2_SCRIPT_SPAWN_CREATURE");
    if (sScriptSpawnCreature != "")
    {
		ExecuteScript(sScriptSpawnCreature, OBJECT_SELF);
    }

    // ***** Spawn-In Conditions ***** //
    // See x2_inc_switches for more information about these
    
    // Enable stealth mode by setting a variable on the creature
    // Great for ambushes
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_STEALTH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_STEALTH);
    }
    
    // Make creature enter search mode after spawning by setting a variable
    // Great for guards, etc
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_SEARCH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_SEARCH);
    }

    // Enable immobile ambient animations by setting a variable
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT_IMMOBILE) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    }

    // Enable mobile ambient animations by setting a variable
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
    }

    // ***** DEFAULT GENERIC BEHAVIOR ***** //
    // * Goes through and sets up which shouts the NPC will listen to.
    SetListeningPatterns();

    // * Walk among a set of waypoints if they exist.
    // * 1. Find waypoints with the tag "WP_" + NPC TAG + "_##" and walk
    // *    among them in order.
    // * 2. If the tag of the Way Point is "POST_" + NPC TAG, stay there
    // *    and return to it after combat.
    //
    // * If "NW_FLAG_DAY_NIGHT_POSTING" is set, you can also
    // * create waypoints with the tags "WN_" + NPC Tag + "_##"
    // * and those will be walked at night. (The standard waypoints
    // * will be walked during the day.)
    // * The night "posting" waypoint tag is simply "NIGHT_" + NPC tag.
    WalkWayPoints(FALSE, "spawn");
    
    // encounter creatures use ambient animations
    if (GetIsEncounterCreature())
		SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, TRUE);

    // * If Incorporeal, apply changes
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) == TRUE)
    {
        effect eConceal = EffectConcealment(50, MISS_CHANCE_TYPE_NORMAL);
        eConceal = ExtraordinaryEffect(eConceal);
        effect eGhost = EffectCutsceneGhost();
        eGhost = ExtraordinaryEffect(eGhost);
        effect eImmuneToNonMagicWeapons = EffectDamageReduction(1000, DAMAGE_POWER_PLUS_ONE, 0, DR_TYPE_MAGICBONUS);
        eImmuneToNonMagicWeapons = ExtraordinaryEffect(eImmuneToNonMagicWeapons);
		
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmuneToNonMagicWeapons, OBJECT_SELF);
    }	
	
	if (GetLocalInt(OBJECT_SELF, "NX2_NO_ORIENT_ON_DIALOG"))
		SetOrientOnDialog(OBJECT_SELF, FALSE);
    	
	//DBR 2/03/06 - added option for a spawn script (ease of AI hookup)
	string sSpawnScript=GetLocalString(OBJECT_SELF,"SpawnScript");
	if (sSpawnScript!="")
		ExecuteScript(sSpawnScript,OBJECT_SELF);
	
}