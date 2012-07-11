#include "acr_resting_i"

void main()
{
	object oTarget = GetLastUsedBy();
	
	if (GetHasFeat(3500, oTarget)) {
		FeatRemove(oTarget, 3500);
		// make sure the change "sticks"
		ExportSingleCharacter(oTarget);
		SendMessageToPC(oTarget, "PrC Validation feat has been removed.");
	} else {
		// PC doesn't have PrC Validation feat, so add it.
		FeatAdd(oTarget, 3500, FALSE, FALSE, TRUE);
		// make sure the change "sticks"
		ExportSingleCharacter(oTarget);
		SendMessageToPC(oTarget, "You have now been validated to allow leveling into a Prestige Class, once you meet the other formal requirements.");
	}
}