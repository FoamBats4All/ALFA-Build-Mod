#include "acr_resting_i"

void main()
{
	object oPC = GetLastUsedBy();
	ForceRest( oPC );
	ACR_NLD_HealAll( oPC );
}