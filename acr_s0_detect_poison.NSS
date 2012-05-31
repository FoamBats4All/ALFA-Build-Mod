// Detect Poison
// Created for ALFA by FoamBats4All 2012-05-30

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "acr_skills_i"

const string ACR_POISON_2DA = "poison";
const string ACR_POISON_2DA_COL_NAME = "Name";

const int ACR_POISON_DETAIL_DC = 20;

// Make a DC20 Wisdom or Craft (Alchemy) check.
int _MakePoisonCheck( object oPC, int nDC );

// Parse a poison effect.
void _HandlePoisonEffect( object oPC, effect ePoison );

// Parse a poison item property.
void _HandlePoisonProperty( object oPC, itemproperty ePoison );

void main() {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell.
    if ( !X2PreSpellCastCode() ) return;
	
	// Get the caster.
	object oCaster = OBJECT_SELF;
	object oTarget = GetSpellTargetObject();
	
	// Search for poison effects.
	if ( GetObjectType( oTarget ) == OBJECT_TYPE_CREATURE ) {
		effect e = GetFirstEffect( oTarget );
		while ( GetIsEffectValid( e ) ) {
			if ( GetEffectType( e ) == EFFECT_TYPE_POISON ) {
				_HandlePoisonEffect( oCaster, e );
			}
			e = GetNextEffect( oTarget );
		}
	}
	
	// Check for poison item properties.
	if ( GetObjectType( oTarget ) == OBJECT_TYPE_ITEM ) {
		itemproperty ip = GetFirstItemProperty( oTarget );
		while ( GetIsItemPropertyValid( ip ) ) {
			if ( GetItemPropertyType( ip ) == ITEM_PROPERTY_POISON ) {
				_HandlePoisonProperty( oCaster, ip );
			}
			ip = GetNextItemProperty( oTarget );
		}
	}
}

int _MakePoisonCheck( object oPC, int nDC ) {
	if ( ACR_StatCheck( ABILITY_WISDOM, oPC, nDC ) ) return TRUE;
	if ( ACR_SkillCheck( SKILL_CRAFT_ALCHEMY, oPC, nDC ) ) return TRUE;
	return FALSE;
}

void _HandlePoisonEffect( object oPC, effect ePoison ) {
	if ( !_MakePoisonCheck( oPC, ACR_POISON_DETAIL_DC ) ) {
		SendMessageToPC( oPC, "You detect poison, though you cannot divine the specifics." );
		return;	 
	}
	
	int nPoisonType = GetEffectType( ePoison );
	string sPoisonName = Get2DAString( ACR_POISON_2DA, ACR_POISON_2DA_COL_NAME, nPoisonType );
	SendMessageToPC( oPC, "You detect '" + sPoisonName + "' poison." );
}

void _HandlePoisonProperty( object oPC, itemproperty ePoison ) {
	if ( !_MakePoisonCheck( oPC, ACR_POISON_DETAIL_DC ) ) {
		SendMessageToPC( oPC, "You detect poison, though you cannot divine the specifics." );
		return;	 
	}
	
	int nPoisonType = GetItemPropertySubType( ePoison );
	string sPoisonName = Get2DAString( ACR_POISON_2DA, ACR_POISON_2DA_COL_NAME, nPoisonType );
	SendMessageToPC( oPC, "You detect '" + sPoisonName + "' poison." );
}