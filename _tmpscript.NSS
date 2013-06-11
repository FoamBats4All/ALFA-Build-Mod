////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_od_fleshgolem
//
//  Description
//  This script is called whenever a troll is damaged. All damage that isn't
//  fire or acid is counted as nonlethal damage.
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_creature_i"
#include "acr_nonlethal_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const int ACR_DAMAGE_TYPE_ALL = DAMAGE_TYPE_ACID || DAMAGE_TYPE_BLUDGEONING || DAMAGE_TYPE_COLD || DAMAGE_TYPE_DIVINE || DAMAGE_TYPE_ELECTRICAL || DAMAGE_TYPE_FIRE || DAMAGE_TYPE_MAGICAL || DAMAGE_TYPE_NEGATIVE || DAMAGE_TYPE_PIERCING || DAMAGE_TYPE_POSITIVE || DAMAGE_TYPE_SLASHING || DAMAGE_TYPE_SONIC;

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
    ACR_CreatureOnDamaged();
	
	// Get our creatures.
	object oDamager = GetLastDamager();
	object oTroll = OBJECT_SELF;
	
    // If it's set to go hostile on attack, do so.
	if ( GetLocalInt( oTroll, "ACR_MAKE_HOSTILE" ) ) {
		ChangeToStandardFaction( oTroll, STANDARD_FACTION_HOSTILE );
	}
	
	// Creatures with this extraordinary ability recover from wounds quickly
	// and can even regrow or reattach severed body parts. Damage dealt to the
	// creature is treated as nonlethal damage, and the creature automatically
	// cures itself of nonlethal damage at a fixed rate per round, as given in
	// the creature’s entry.
	
	// First, get our damages.
	int nTotalDamage = GetTotalDamageDealt();
	int nAcidDamage = GetDamageDealtByType( DAMAGE_TYPE_ACID );
	int nFireDamage = GetDamageDealtByType( DAMAGE_TYPE_FIRE );
	int nPhysicalDamage = GetDamageDealtByType( DAMAGE_TYPE_BLUDGEONING || DAMAGE_TYPE_PIERCING || DAMAGE_TYPE_SLASHING );
	
	// Determine how much of it isn't from acid/fire.
	int nNonlethalDamage = nTotalDamage;
	if ( nAcidDamage != -1 ) nNonlethalDamage -= nAcidDamage;
	if ( nFireDamage != -1 ) nNonlethalDamage -= nFireDamage;
	
	// Deal our damage as nonlethal damage.
	if ( nNonlethalDamage > 0 ) {
		ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectHeal( nNonlethalDamage ), oTroll );
		ACR_ApplyNonlethalDamageToCreature( oTroll, nNonlethalDamage );
	}
	
	// A regenerating creature that has been rendered unconscious through
	// nonlethal damage can be killed with a coup de grace. The attack cannot
	// be of a type that automatically converts to nonlethal damage. 
	if ( GetCurrentHitPoints() < _GetNLDTotal( oTroll ) ) {
		SetImmortal( oTroll, FALSE );
		AssignCommand( oDamager, ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDeath(), oTroll ) );
		return;
	}
}