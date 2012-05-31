
#include "x2_inc_itemprop"

void main() {
	object oUser = GetLastUsedBy();
	SendMessageToPC( oUser, "000_echo_item_prop_data executed." );

	int iInventorySlot = 0;
	for ( iInventorySlot = 0; iInventorySlot < NUM_INVENTORY_SLOTS; iInventorySlot++ ) {
		object oEquipment = GetItemInSlot( iInventorySlot, oUser );
		if ( GetIsObjectValid( oEquipment ) ) {
			SendMessageToPC( oUser, "Properties for '" + GetName( oEquipment ) + "' (" + IntToString(iInventorySlot) + ") :" );
			itemproperty iProp = GetFirstItemProperty( oEquipment );
			while ( GetIsItemPropertyValid( iProp ) ) {
				SendMessageToPC( oUser, "-- Property: " + IntToString( GetItemPropertyType( iProp ) ) );
				SendMessageToPC( oUser, "---- GetItemPropertyCostTable = " + IntToString( GetItemPropertyCostTable( iProp ) ) );
				SendMessageToPC( oUser, "---- GetItemPropertyCostTableValue = " + IntToString( GetItemPropertyCostTableValue( iProp ) ) );
				SendMessageToPC( oUser, "---- GetItemPropertyDurationType = " + IntToString( GetItemPropertyDurationType( iProp ) ) );
				SendMessageToPC( oUser, "---- GetItemPropertyParam1 = " + IntToString( GetItemPropertyParam1( iProp ) ) );
				SendMessageToPC( oUser, "---- GetItemPropertyParam1Value = " + IntToString( GetItemPropertyParam1Value( iProp ) ) );
				SendMessageToPC( oUser, "---- GetItemPropertySubType = " + IntToString( GetItemPropertySubType( iProp ) ) );
				iProp = GetNextItemProperty( oEquipment );
			}
		}
	}

}