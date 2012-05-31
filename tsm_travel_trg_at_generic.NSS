////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2009/08/6  Wynna
//  2010/9/22  AcadiusLost - Bardsong disable
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"



////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

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


void main()
{
    ACR_TriggerOnEnter();

    // ATing out of or into Travel Map areas
	object oTraveller = GetEnteringObject();
    object oArea = GetArea(OBJECT_SELF);
	string sTravelArea = GetLocalString(GetArea(OBJECT_SELF), "sTravelArea");
	object oDestination = GetLocalObject(OBJECT_SELF, "oDestination");
	if(oDestination == OBJECT_INVALID)
		{string sDestination = GetLocalString(OBJECT_SELF, "sDestination");
	     oDestination = GetWaypointByTag(sDestination);
		 SetLocalObject(OBJECT_SELF, "oDestination", oDestination);
		 }
		 
	//Destroy NPCs (except kis_escort_03)
	if((!GetIsPC(oTraveller)) && (!GetIsDM(oTraveller))&& (!GetIsOwnedByPlayer(oTraveller)) && (GetTag(oTraveller) != "003_cr_argent_marilee_stallings")) 
	   {DestroyObject(oTraveller);
	    return;
	   }

	 //Let oHench through. oHench is set on escort statics  
	 if((GetLocalObject(GetEnteringObject(), "oHench") != OBJECT_INVALID) && (GetIsPC(GetEnteringObject())))
		{object oHench = GetLocalObject(GetEnteringObject(), "oHench");
		 object oMaster = GetLocalObject(GetEnteringObject(), "oMaster");
		 AssignCommand(oHench, ClearAllActions(TRUE));
		 AssignCommand(oHench, ActionJumpToObject(oMaster, FALSE));
		 AssignCommand(oHench, ActionForceFollowObject(oMaster, 0.5, 0));
		 }
	
	   
//First run a proximity check on party members
	object oPartyMember = GetFirstFactionMember(oTraveller);
	while(oPartyMember != OBJECT_INVALID)
	{if((GetDistanceBetween(oPartyMember, oTraveller) > 20.0) || (GetArea(oTraveller) != GetArea(oPartyMember)))
		{FloatingTextStringOnCreature("You must gather your party together before going on.", oTraveller, TRUE);
		 return;
		}
		oPartyMember = GetNextFactionMember(oTraveller);
	}		
	
	
	//Begin Generic Area functions	
	//When the PC jumped into this generic area, s/he stored a local location on the area to jump back out to	
	//If the local location fails, check a variable on the PC for the last area they were in
	//If both fail, check the trigger for a rougher sDestination string.
	//If all fail, use a generic fallback exit, even though it may be pretty far from where 
	//they entered.
	
	if(GetTag(OBJECT_SELF) == "Generic_TM")
		{	
		
		//First look for the party location stored on the area, supposedly
		location lStartFrom = GetLocalLocation(oArea, "lStartFrom");
		 if(GetIsLocationValid(lStartFrom) == TRUE)
		 	{object oPartyMember = GetFirstFactionMember(oTraveller);
			 while(oPartyMember != OBJECT_INVALID)
					{SetCommandable(TRUE, oPartyMember);
					 //AssignCommand(oPartyMember, ActionJumpToLocation(lStartFrom));
					 WriteTimestampedLogEntry(GetName(oPartyMember) + " ATing through " + GetName(OBJECT_SELF) + " to generic area-cached destination with " + GetName(oTraveller) + " as party leader.");
					 int iType = 2;
						 object oAssociate = GetAssociate(iType, oPartyMember, 1);
						 while(iType < 4)
							{oAssociate = GetAssociate(iType, oPartyMember, 1);
					         if(GetIsObjectValid(oAssociate))
						 			{AssignCommand(oAssociate, ActionJumpToLocation(lStartFrom));
									 WriteTimestampedLogEntry(GetName(oAssociate) + " is an associate of Type " + IntToString(iType) + " owned by " + GetName(oPartyMember) + " ATing with them.");
						 			}
							else { WriteTimestampedLogEntry(GetName(oPartyMember)+" Has no associates of type " + IntToString(iType)); }
						 	iType++;
						 	}
					if (GetHasFeat(FEAT_BARDSONG_INSPIRE_COURAGE, oPartyMember)) {
		 				// bard found- force-deactivate any inspirations, head off crashes
						SetActionMode(oPartyMember, 15, FALSE);
						SetActionMode(oPartyMember, 16, FALSE);	
						SetActionMode(oPartyMember, 17, FALSE);	
						SetActionMode(oPartyMember, 18, FALSE);	
						SetActionMode(oPartyMember, 19, FALSE);	
						SetActionMode(oPartyMember, 20, FALSE);	
						SetActionMode(oPartyMember, 21, FALSE);	
					}							
					 oPartyMember = GetNextFactionMember(oTraveller, TRUE);
					}		
		     JumpPartyToArea(oTraveller, oDestination);
			 return;
			}
		 else if(GetIsLocationValid(lStartFrom) != TRUE)
		 	{//Then try a fall-back object
			 object oReturn = GetLocalObject(oArea, "ReturnTo");
			 if(GetIsObjectValid(oReturn) == TRUE)
			 	{oPartyMember = GetFirstFactionMember(oTraveller, TRUE);		
				 while(oPartyMember != OBJECT_INVALID)
					{SetCommandable(TRUE, oPartyMember);
					 //AssignCommand(oPartyMember, ActionJumpToObject(oReturn));
					 WriteTimestampedLogEntry(GetName(oPartyMember) + " ATing through " + GetName(OBJECT_SELF) + " to fallback destination " + GetName(oReturn) + " with " + GetName(oTraveller) + " as party leader.");
					 int iType = 2;
						 object oAssociate = GetAssociate(iType, oPartyMember, 1);
						 while(iType < 4)
							{oAssociate = GetAssociate(iType, oPartyMember, 1);
						 	 
					         if(GetIsObjectValid(oAssociate))
						 			{AssignCommand(oAssociate, ActionJumpToObject(oReturn));
									 WriteTimestampedLogEntry(GetName(oAssociate) + " is an associate of Type " + IntToString(iType) + " owned by " + GetName(oPartyMember) + " ATing with them.");
						 			}
							 else { WriteTimestampedLogEntry(GetName(oPartyMember)+" Has no associates of type " + IntToString(iType)); }
						 	 iType++;
						 	}
						 if (GetHasFeat(FEAT_BARDSONG_INSPIRE_COURAGE, oPartyMember)) {
		 					// bard found- force-deactivate any inspirations, head off crashes
							SetActionMode(oPartyMember, 15, FALSE);
							SetActionMode(oPartyMember, 16, FALSE);	
							SetActionMode(oPartyMember, 17, FALSE);	
							SetActionMode(oPartyMember, 18, FALSE);	
							SetActionMode(oPartyMember, 19, FALSE);	
							SetActionMode(oPartyMember, 20, FALSE);	
							SetActionMode(oPartyMember, 21, FALSE);	
						 }						
					 oPartyMember = GetNextFactionMember(oTraveller, TRUE);
					}
				JumpPartyToArea(oTraveller, oDestination);		
				return;
				}
		 	
			
			
			//Next look for the location stored on the individual PC
			 lStartFrom = GetLocalLocation(oTraveller, "lStartFrom");
		 	 if(GetIsLocationValid(lStartFrom) == TRUE)
			 	{object oPartyMember = GetFirstFactionMember(oTraveller);
				 while(oPartyMember != OBJECT_INVALID)
						{SetCommandable(TRUE, oPartyMember);
						 //AssignCommand(oPartyMember, ActionJumpToLocation(lStartFrom));
						 WriteTimestampedLogEntry(GetName(oPartyMember) + " ATing through " + GetName(OBJECT_SELF) + " to generic PC-cached destination with " + GetName(oTraveller) + " as party leader.");
						 int iType = 2;
							 object oAssociate = GetAssociate(iType, oPartyMember, 1);
							 while(iType < 4)
								{oAssociate = GetAssociate(iType, oPartyMember, 1);

						         if(GetIsObjectValid(oAssociate))
							 			{AssignCommand(oAssociate, ActionJumpToLocation(lStartFrom));
										 WriteTimestampedLogEntry(GetName(oAssociate) + " is an associate of Type " + IntToString(iType) + " owned by " + GetName(oPartyMember) + " ATing with them.");
							 			}
								 else { WriteTimestampedLogEntry(GetName(oPartyMember)+" Has no associates of type " + IntToString(iType)); }
							 	 iType++;
							 	}
						     if (GetHasFeat(FEAT_BARDSONG_INSPIRE_COURAGE, oPartyMember)) {
		 						// bard found- force-deactivate any inspirations, head off crashes
								SetActionMode(oPartyMember, 15, FALSE);
								SetActionMode(oPartyMember, 16, FALSE);	
								SetActionMode(oPartyMember, 17, FALSE);	
								SetActionMode(oPartyMember, 18, FALSE);	
								SetActionMode(oPartyMember, 19, FALSE);	
								SetActionMode(oPartyMember, 20, FALSE);	
								SetActionMode(oPartyMember, 21, FALSE);	
							 }							
						 oPartyMember = GetNextFactionMember(oTraveller, TRUE);
						}		
				 JumpPartyToArea(oTraveller, oDestination);
				 return;
				}
			
		     else if(GetIsLocationValid(lStartFrom) != TRUE) 
					   {//if that fails, too, define a generic trigger destination after looking for the last trigger the PC was in
					   int iAreaNumber = GetLocalInt(oArea, "AreaNumber");
					   int iAreaSub = GetLocalInt(oArea, "AreaSub");
					   string sTravelArea = GetLocalString(oArea, "sTravelArea");
					   if(iAreaNumber == 0)
							{iAreaNumber = GetLocalInt(oTraveller, "AreaNumber");
							}
						string sGenericExit;
						if((iAreaNumber == 1)&& (iAreaSub == 0))
							{sGenericExit = "Orphanage_TM_WP";
							}
						else if((iAreaNumber == 2)&& (iAreaSub == 0))
							{sGenericExit = "Wendover_TM_WP";
							}
						else if((iAreaNumber == 2)&& (iAreaSub == 3))
							{sGenericExit = "WE_KD_TM_WP";
							}
						else if((iAreaNumber == 3)&& (iAreaSub == 0))
							{sGenericExit = "GreatOak_TM_WP";
							}
						else if((iAreaNumber == 3)&& (iAreaSub == 3))
							{sGenericExit = "MW_WE_TM_WP";
							}
						else if((iAreaNumber == 4)&& (iAreaSub == 0))
							{sGenericExit = "Blasted_TM_WP";
							}
						else if((iAreaNumber == 4)&& (iAreaSub == 1))
							{sGenericExit = "NR1_TM_WP";
							}
						else if((iAreaNumber == 4)&& (iAreaSub == 2))
							{sGenericExit = "6d_Highway_3_TM_WP";
							}
						else if((iAreaNumber == 4)&& (iAreaSub == 3))
							{sGenericExit = "MW_Quaervarr_TM_WP";
							}
						else if((iAreaNumber == 5) && (iAreaSub == 1))
							{sGenericExit = "NR2_TM_WP";
							}
						else if((iAreaNumber == 5)&& (iAreaSub == 2))
							{sGenericExit = "Meteor_TM_WP";
							}
						else if((iAreaNumber == 6)&& (iAreaSub == 0))
							{sGenericExit = "Quaervarr_North_TM_WP";
							}
						else if((iAreaNumber == 8) && (iAreaSub == 1) && (sTravelArea == "003_travel_map_east"))
							{sGenericExit = "SilvyPass_TM_WP8";
							}
						 else if((iAreaNumber == 8) && (iAreaSub == 2)&& (sTravelArea == "003_travel_map_east"))
							{sGenericExit = "SilvyPass_TM_WP9";
							}
						 else if((iAreaNumber == 9)  && (sTravelArea == "003_travel_map_east"))
							{sGenericExit = "Khelb_TM_WP";
							}
						 else if((iAreaNumber == 10)  && (sTravelArea == "003_travel_map_east"))
							{sGenericExit = "SilvyPass_TM_WP6";
							}
						 else if(iAreaNumber == 11)
							{sGenericExit = "HN_TM_WP";
							}
						 else if(iAreaNumber == 12)
							{sGenericExit = "SilvyPass_TM_WP3";
							}
						 else if(iAreaNumber == 13)
							{sGenericExit = "Auril_TM_WP";
							}
						 else if(iAreaNumber == 14)
							{sGenericExit = "SilvyPass_TM_WP";
							}
						 else if(iAreaNumber == 15)
							{sGenericExit = "Auvendell_TM_WP";
							}
						
						object oDestinationGeneric = GetWaypointByTag(sGenericExit);
						if(iAreaNumber != 0)
						 	{if(oDestinationGeneric != OBJECT_INVALID)
								 {oPartyMember = GetFirstFactionMember(oTraveller, TRUE);		
								  while(oPartyMember != OBJECT_INVALID)
										{SetCommandable(TRUE, oPartyMember);
										 //AssignCommand(oPartyMember, ActionJumpToObject(oDestinationGeneric));
										 WriteTimestampedLogEntry(GetName(oPartyMember) + " ATing through " + GetName(OBJECT_SELF) + " to GENERIC PREVIOUS TRIGGER FALLBACK area " + GetName(oDestination) + " with " + GetName(oTraveller) + " as party leader.");
										 int iType = 2;
											 object oAssociate = GetAssociate(iType, oPartyMember, 1);
											 while(iType < 4)
												{oAssociate = GetAssociate(iType, oPartyMember, 1);
											 	 
										         if(GetIsObjectValid(oAssociate))
											 			{AssignCommand(oAssociate, ActionJumpToObject(oDestinationGeneric));
														WriteTimestampedLogEntry(GetName(oAssociate) + " is an associate of Type " + IntToString(iType) + " owned by " + GetName(oPartyMember) + " ATing with them.");
											 			}
												 else { WriteTimestampedLogEntry(GetName(oPartyMember)+" Has no associates of type " + IntToString(iType)); }
											 	 iType++;
											 	}
										 if (GetHasFeat(FEAT_BARDSONG_INSPIRE_COURAGE, oPartyMember)) {
		 									// bard found- force-deactivate any inspirations, head off crashes
											SetActionMode(oPartyMember, 15, FALSE);
											SetActionMode(oPartyMember, 16, FALSE);	
											SetActionMode(oPartyMember, 17, FALSE);	
											SetActionMode(oPartyMember, 18, FALSE);	
											SetActionMode(oPartyMember, 19, FALSE);	
											SetActionMode(oPartyMember, 20, FALSE);	
											SetActionMode(oPartyMember, 21, FALSE);	
		 								 }		
										 oPartyMember = GetNextFactionMember(oTraveller, TRUE);
										}
									JumpPartyToArea(oTraveller, oDestination);	
									return;
								 }
							  }
						
						else if(oDestinationGeneric == OBJECT_INVALID)
						 	 {//If all fail, each generic trigger has a fallback destination stored on itself as a string
							 if(GetLocalObject(OBJECT_SELF, "oDestination") != OBJECT_INVALID)
								{oPartyMember = GetFirstFactionMember(oTraveller, TRUE);		
								  while(oPartyMember != OBJECT_INVALID)
										{SetCommandable(TRUE, oPartyMember);
										 //AssignCommand(oPartyMember, ActionJumpToObject(oDestinationGeneric));
										 WriteTimestampedLogEntry(GetName(oPartyMember) + " ATing through " + GetName(OBJECT_SELF) + " to FINAL FALLBACK TRIGGER CACHE " + GetName(oDestination) + " with " + GetName(oTraveller) + " as party leader.");
										 int iType = 2;
											 object oAssociate = GetAssociate(iType, oPartyMember, 1);
											 while(iType < 4)
												{oAssociate = GetAssociate(iType, oPartyMember, 1);
											 	 
										         if(GetIsObjectValid(oAssociate))
											 			{AssignCommand(oAssociate, ActionJumpToObject(oDestinationGeneric));
														 WriteTimestampedLogEntry(GetName(oAssociate) + " is an associate of Type " + IntToString(iType) + " owned by " + GetName(oPartyMember) + " ATing with them.");
											 			}
												 else { WriteTimestampedLogEntry(GetName(oPartyMember)+" Has no associates of type " + IntToString(iType)); }
											 	 iType++;
											 	}
										 if (GetHasFeat(FEAT_BARDSONG_INSPIRE_COURAGE, oPartyMember)) {
		 									// bard found- force-deactivate any inspirations, head off crashes
											SetActionMode(oPartyMember, 15, FALSE);
											SetActionMode(oPartyMember, 16, FALSE);	
											SetActionMode(oPartyMember, 17, FALSE);	
											SetActionMode(oPartyMember, 18, FALSE);	
											SetActionMode(oPartyMember, 19, FALSE);	
											SetActionMode(oPartyMember, 20, FALSE);	
											SetActionMode(oPartyMember, 21, FALSE);	
		 								 }											
										 oPartyMember = GetNextFactionMember(oTraveller, TRUE);
										}
									JumpPartyToArea(oTraveller, oDestination);		
									}
								 }
							}
						}
				}	
					
			}		
 
	
		