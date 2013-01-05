#include "acr_area_i"
#include "003_silverymoon_i"

void main() {
	// Get our entering object.
	object oPC = GetEnteringObject();
	
	// Hook our ACR area enter script.
    ACR_AreaOnEnter();
	
	// Remove Silverymoon's wards.
	RemoveSilverymoonWards( oPC );
}