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
//  and custom code for Silvy Uni creatures.
//
//  Revision History: Wynna, November 2007
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

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
 #include "acr_trigger_i"
 #include "acr_spawn_i"
 #include "acr_tools_i"

void main()

{  ACR_CreatureOnSpawnIn();
	     string sArea;
		 if(FindSubString(GetName(GetArea(OBJECT_SELF)), "Riv") != -1)
		 	{sArea = "rm_";}
		 if(FindSubString(GetName(GetArea(OBJECT_SELF)), "Rauv") != -1)
		 	{sArea = "rv_";}
		 if(FindSubString(GetName(GetArea(OBJECT_SELF)), "Silv") != -1)
		 	{sArea = "sm_";}
		 if(FindSubString(GetName(GetArea(OBJECT_SELF)), "Hold") != -1)
		 	{sArea = "hh_";}
		 string sDirection;
         if(((sArea == "rm_") && (GetLocalInt(OBJECT_SELF, "Rivermoot") != 1)) || ((sArea == "hh_") && (GetLocalInt(OBJECT_SELF, "HighHold") != 1)) ||(sArea == "rv_"))
			 {if(GetLocalInt(OBJECT_SELF, "HighHold") > 1)
			 	{sDirection = "West";
				 if(GetLocalInt(OBJECT_SELF, "HighHold") == 2)
				 	{sDirection = "East";}
				}
			 
			 object oSergeant = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_argent_patrol_sgt", GetLocation(OBJECT_SELF), FALSE, sArea + "argent_patrol" + sDirection);
			 object oScout = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_argent_scout", GetLocation(OBJECT_SELF), FALSE, sArea + "argent_patrol" + sDirection);
			 object oSpearman1 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_argent_spearman", GetLocation(OBJECT_SELF), FALSE, sArea + "argent_patrol" + sDirection);
			 object oSpearman2 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_argent_spearman", GetLocation(OBJECT_SELF), FALSE, sArea + "argent_patrol" + sDirection);
			     
			 SetLocalString(oSergeant, "Direction", sDirection);
			 SetLocalString(oScout, "Direction", sDirection);
			 SetLocalString(oSpearman1, "Direction", sDirection);
			 SetLocalString(oSpearman2, "Direction", sDirection);
				
			 if((sArea == "hh_") && (GetLocalInt(OBJECT_SELF, "HighHold") != 1))
			 	{object oCreateLastEast = GetLocalObject(OBJECT_SELF, "oCreateLastEast");
				 if(oCreateLastEast == OBJECT_INVALID)
				 	{oCreateLastEast = GetWaypointByTag("argentpatrol_AT_E5_WP");
					 SetLocalObject(OBJECT_SELF, "oCreateLastEast", oCreateLastEast);
					 SetLocalObject(oCreateLastEast, GetResRef(oSergeant), oSergeant);
					 SetLocalObject(oCreateLastEast, GetResRef(oScout), oScout);
					 SetLocalObject(oCreateLastEast, GetResRef(oSpearman1), oSpearman1);
					 SetLocalObject(oCreateLastEast, GetResRef(oSpearman2) + "1", oSpearman2);
					 DelayCommand(300.0, SetLocalObject(oCreateLastEast, GetResRef(oSergeant), OBJECT_INVALID));
					 DelayCommand(300.0, SetLocalObject(oCreateLastEast, GetResRef(oScout), OBJECT_INVALID));
					 DelayCommand(300.0, SetLocalObject(oCreateLastEast, GetResRef(oSpearman1), OBJECT_INVALID));
					 DelayCommand(300.0, SetLocalObject(oCreateLastEast, GetResRef(oSpearman2) + "1", OBJECT_INVALID));
					 }
				 object oCreateLastWest = GetLocalObject(OBJECT_SELF, "oCreateLastWest");
				 if(oCreateLastWest == OBJECT_INVALID)
				 	{oCreateLastWest = GetWaypointByTag("argentpatrol_AT_W4_WP");
					 SetLocalObject(OBJECT_SELF, "oCreateLastWest", oCreateLastWest);
					 SetLocalObject(oCreateLastWest, GetResRef(oSergeant), oSergeant);
					 SetLocalObject(oCreateLastWest, GetResRef(oScout), oScout);
					 SetLocalObject(oCreateLastWest, GetResRef(oSpearman1), oSpearman1);
					 SetLocalObject(oCreateLastWest, GetResRef(oSpearman2) + "1", oSpearman2);
					 DelayCommand(300.0, SetLocalObject(oCreateLastWest, GetResRef(oSergeant), OBJECT_INVALID));
					 DelayCommand(300.0, SetLocalObject(oCreateLastWest, GetResRef(oScout), OBJECT_INVALID));
					 DelayCommand(300.0, SetLocalObject(oCreateLastWest, GetResRef(oSpearman1), OBJECT_INVALID));
					 DelayCommand(300.0, SetLocalObject(oCreateLastWest, GetResRef(oSpearman2) + "1", OBJECT_INVALID));
					 }
				 
				}
			 
			 DestroyObject(oSergeant, 900.0);
			 DestroyObject(oScout, 900.0);
			 DestroyObject(oSpearman1, 900.0);
			 DestroyObject(oSpearman2, 900.0);
		 	}
		
		  else if((sArea == "sm_") ||((sArea == "hh_") && (GetLocalInt(OBJECT_SELF, "HighHold") == 1)) || ((sArea == "rm_") && (GetLocalInt(OBJECT_SELF, "Rivermoot") == 1)))
		  	{string sRandom;
			 string sRandom2;
			 string sRandom3;
			 string sRandom4;
			 string sRandom5;
			 string sTraveller = "6d_sm_Traveller";
			 string sTravellerb = "6d_sm_Travellerb";
			 string sTravellerRM = "6b_rm_Traveller";
			 string sTravellerHH = "6c_hh_Traveller";
			 int nRandom = Random(7) + 1;
			 int nRandomSub;
			 string sNumber; 
			 string sNumber2; 
			 string sNumber3; 
			 string sNumber4; 
			 string sNumber5; 
			 int nNumber2; 
			 int nNumber3; 
			 int nNumber4; 
			 int nNumber5; 
			 if(nRandom <= 2)
				 {nRandomSub = Random(42) + 1;
				   nNumber2 = ((nRandomSub) + Random(2) - Random(2)); 
				   nNumber3 = ((nRandomSub) + Random(4) - Random(4)); 
				   nNumber4 = ((nRandomSub) + Random(6) - Random(6)); 
				   nNumber5 = ((nRandomSub) + Random(10) - Random(10)); 
				   sNumber = "s" + IntToString(1) + "_" + IntToString(nRandomSub); 
				   sNumber2 = "s" + IntToString(1) + "_" + IntToString(nNumber2); 
				   sNumber3 = "s" + IntToString(1) + "_" + IntToString(nNumber3); 
				   sNumber4 = "s" + IntToString(1) + "_" + IntToString(nNumber4); 
				   sNumber5 = "s" + IntToString(1) + "_" + IntToString(nNumber5); 
				 }
			  else if(nRandom == 3)
				 {nRandomSub = Random(19) + 1;
				   nNumber2 = ((nRandomSub) + Random(2) - Random(2)); 
				   nNumber3 = ((nRandomSub) + Random(2) - Random(2)); 
				   nNumber4 = ((nRandomSub) + Random(2) - Random(2));
				   nNumber5 = ((nRandomSub) + Random(2) - Random(2));
				   sNumber = "s" + IntToString(2) + "_" + IntToString(nRandomSub); 
				   sNumber2 = "s" + IntToString(2) + "_" + IntToString(nNumber2); 
				   sNumber3 = "s" + IntToString(2) + "_" + IntToString(nNumber3); 
				   sNumber4 = "s" + IntToString(2) + "_" + IntToString(nNumber4); 
				   sNumber5 = "s" + IntToString(2) + "_" + IntToString(nNumber5); 
				 }
			  else if(nRandom == 4)
				 {nRandomSub = Random(4) + 1;
				   nNumber2 = ((nRandomSub) + Random(2) - Random(2)); 
				   nNumber3 = ((nRandomSub) + Random(2) - Random(2)); 
				   nNumber4 = ((nRandomSub) + Random(2) - Random(2));
				   nNumber5 = ((nRandomSub) + Random(2) - Random(2));
				   sNumber = "s" + IntToString(3) + "_" + IntToString(nRandomSub); 
				   sNumber2 = "s" + IntToString(3) + "_" + IntToString(nNumber2); 
				   sNumber3 = "s" + IntToString(3) + "_" + IntToString(nNumber3); 
				   sNumber4 = "s" + IntToString(3) + "_" + IntToString(nNumber4); 
				   sNumber5 = "s" + IntToString(3) + "_" + IntToString(nNumber5); 
				 }
			  else if(nRandom == 5)
				 {nRandomSub = Random(4) + 1;
				   nNumber2 = ((nRandomSub) + Random(2) - Random(2)); 
				   nNumber3 = ((nRandomSub) + Random(2) - Random(2)); 
				   nNumber4 = ((nRandomSub) + Random(2) - Random(2));
				   nNumber5 = ((nRandomSub) + Random(2) - Random(2));
				  if(nNumber2 == nRandomSub)
				   	{nNumber2 = 0;
					}
				  if((nNumber3 == nRandomSub) || (nNumber3 == nNumber2))
				   	{nNumber3 = 0;
					}
				   if((nNumber4 == nRandomSub) || (nNumber4 == nNumber3) || (nNumber4 == nNumber2))
				   	{nNumber4 = 0;
					}
				   if((nNumber5 == nRandomSub)|| (nNumber5 == nNumber3) || (nNumber5 == nNumber4) || (nNumber5 == nNumber2))
				   	{nNumber5 = 0;
					}
				   sNumber = "s" + IntToString(4) + "_" + IntToString(nRandomSub); 
				   sNumber2 = "s" + IntToString(4) + "_" + IntToString(nNumber2); 
				   sNumber3 = "s" + IntToString(4) + "_" + IntToString(nNumber3); 
				   sNumber4 = "s" + IntToString(4) + "_" + IntToString(nNumber4); 
				   sNumber5 = "s" + IntToString(4) + "_" + IntToString(nNumber5); 
				 }
			 
			  else if(nRandom == 6)
				 {nRandomSub = Random(15) + 1;
				   nNumber2 = ((nRandomSub) + Random(2) - Random(2)); 
				   nNumber3 = ((nRandomSub) + Random(2) - Random(2)); 
				   nNumber4 = ((nRandomSub) + Random(2) - Random(2));
				   nNumber5 = ((nRandomSub) + Random(2) - Random(2));
				  if((nNumber2 < 0) || (nNumber2 > nRandomSub))
					  {nNumber2 = Random(nRandomSub);
						} 
				  if((nNumber3 < 0) || (nNumber3 > nRandomSub))
					  	{nNumber3 = Random(nRandomSub);
						} 
				  if((nNumber4 < 0) || (nNumber4 > nRandomSub))
					  	{nNumber4 = Random(nRandomSub);
						} 
				  if((nNumber5 < 0) || (nNumber5 > nRandomSub))
					  	{nNumber5 = Random(nRandomSub);
						}
				  if((nNumber2 == nRandomSub) && (nNumber2 >7))
				   	{nNumber2 = 0;
					}
				  if(((nNumber3 == nRandomSub) || (nNumber3 == nNumber2)) && (nNumber3 >7))
				   	{nNumber3 = 0;
					}
				  if(((nNumber4 == nRandomSub) || (nNumber4 == nNumber3) || (nNumber4 == nNumber2))  && (nNumber4 >7))
				   	{nNumber4 = 0;
					}
				  if(((nNumber5 == nRandomSub) || (nNumber5 == nNumber4) || (nNumber5 == nNumber3) || (nNumber5 == nNumber2))&& (nNumber5 >7))
				   	{nNumber5 = 0;
					}
				  
				   
				  sNumber = "s" + IntToString(5) + "_" + IntToString(nRandomSub); 
				  sNumber2 = "s" + IntToString(5) + "_" + IntToString(nNumber2); 
				  sNumber3 = "s" + IntToString(5) + "_" + IntToString(nNumber3); 
				  sNumber4 = "s" + IntToString(5) + "_" + IntToString(nNumber4); 
				  sNumber5 = "s" + IntToString(5) + "_" + IntToString(nNumber5); 
				}	  
				
			 if(nRandom == 7)
				 {nRandomSub = Random(7) + 1;
				  sNumber = "s" + IntToString(6) + "_" + IntToString(nRandomSub); 
				  int nPriestRandom = Random(4) + 1;
				  if(nPriestRandom == 1)
					  {sNumber2 = "s" + IntToString(1) + "_" + IntToString(Random(42) +1); 
					   sNumber3 = "s" + IntToString(1) + "_" + IntToString(Random(42) +1);
					   sNumber4 = "s" + IntToString(1) + "_" + IntToString(Random(42) +1); 
					   sNumber5 = "s" + IntToString(1) + "_" + IntToString(Random(42) +1);
				      }	
				 else if(nPriestRandom == 2) 
					  {int n20 = Random(19) +1;
					   sNumber2 = "s" + IntToString(nPriestRandom) + "_" + IntToString((n20) + Random(2) - Random(2)); 
					   sNumber3 = "s" + IntToString(nPriestRandom) + "_" + IntToString((n20) + Random(2) - Random(2));  
					   sNumber4 = "s" + IntToString(nPriestRandom) + "_" + IntToString((n20) + Random(2) - Random(2)); 
					   sNumber5 = "s" + IntToString(nPriestRandom) + "_" + IntToString((n20) + Random(2) - Random(2)); 
					  }			  
				 else if(nPriestRandom == 3)
					  {int n5 = Random(4) + 1;
					   sNumber2 = "s" + IntToString(nPriestRandom) + "_" + IntToString((n5) + Random(2) - Random(2)); 
					   sNumber3 = "s" + IntToString(nPriestRandom) + "_" + IntToString((n5) + Random(2) - Random(2));  
					   sNumber4 = "s" + IntToString(nPriestRandom) + "_" + IntToString((n5) + Random(2) - Random(2)); 
					   sNumber5 = "s" + IntToString(nPriestRandom) + "_" + IntToString((n5) + Random(2) - Random(2)); 
					  }			  
				 else if(nPriestRandom == 4)  
					  {sNumber2 = "s" + IntToString(5) + "_" + IntToString(Random(6) +1); 
					   sNumber3 = "s" + IntToString(5) + "_" + IntToString(Random(6) +1);  
					   sNumber4 = "s" + IntToString(5) + "_" + IntToString(Random(7) + 8);  
					   sNumber5 = "s" + IntToString(5) + "_" + IntToString(Random(6)+1); 
					  }			  
			  }

				  
		     if(sNumber == "s1_1")
			 	{sRandom = "03_silvy_commoner_uu";}
			 if(sNumber == "s1_2")
			 	{sRandom = "03_silvy_commoner_vv";}
			 if(sNumber == "s1_3")
			 	{sRandom = "03_silvy_commoner_ii";}
			 if(sNumber == "s1_4")
			 	{sRandom = "03_silvy_commoner_v";}
			 if(sNumber == "s1_5")
			 	{sRandom = "03_silvy_commoner_e";}
			 if(sNumber == "s1_6")
			 	{sRandom = "03_silvy_commoner_dd";}
			 if(sNumber == "s1_7")
			 	{sRandom = "03_silvy_commoner_oo";}
			 if(sNumber == "s1_8")
			 	{sRandom = "03_silvy_commoner_s";}
			 if(sNumber == "s1_9")
			 	{sRandom = "03_silvy_commoner_c";}
			 if(sNumber == "s1_10")
			 	{sRandom = "03_silvy_commoner_bb";}
			 if(sNumber == "s1_11")
			 	{sRandom = "03_silvy_commoner_t";}
			 if(sNumber == "s1_12")
			 	{sRandom = "03_silvy_commoner_j";}
			 if(sNumber == "s1_13")
			 	{sRandom = "03_silvy_commoner_nn";}
			 if(sNumber == "s1_14")
			 	{sRandom = "03_silvy_commoner_cc";}
			 if(sNumber == "s1_15")
			 	{sRandom = "03_silvy_commoner_d";}
			 if(sNumber == "s1_16")
			 	{sRandom = "03_silvy_commoner_k";}
			 if(sNumber == "s1_17")
			 	{sRandom = "03_silvy_commoner_b";}
			 if(sNumber == "s1_18")
			 	{sRandom = "03_silvy_commoner_i";}
			 if(sNumber == "s1_19")
			 	{sRandom = "03_silvy_commoner_h";}
			 if(sNumber == "s1_20")
			 	{sRandom = "03_silvy_commoner_pp";}
			 if(sNumber == "s1_21")
			 	{sRandom = "03_silvy_commoner_ss";}
			 if(sNumber == "s1_22")
			 	{sRandom = "03_silvy_commoner_p";}
			 if(sNumber == "s1_23")
			 	{sRandom = "03_silvy_commoner_mm";}
			 if(sNumber == "s1_24")
			 	{sRandom = "03_silvy_commoner_a";}
			 if(sNumber == "s1_25")
			 	{sRandom = "03_silvy_commoner_f";}
			 if(sNumber == "s1_26")
			 	{sRandom = "03_silvy_commoner_kk";}
			 if(sNumber == "s1_27")
			 	{sRandom = "03_silvy_commoner_u";}
			 if(sNumber == "s1_28")
			 	{sRandom = "03_silvy_commoner_ff";}
			 if(sNumber == "s1_29")
			 	{sRandom = "03_silvy_commoner_jj";}
			 if(sNumber == "s1_30")
			 	{sRandom = "03_silvy_commoner_gg";}
			 if(sNumber == "s1_31")
			 	{sRandom = "03_silvy_commoner_rr";}
			 if(sNumber == "s1_32")
			 	{sRandom = "03_silvy_commoner_ee";}
			 if(sNumber == "s1_33")
			 	{sRandom = "03_silvy_commoner_n";}
			 if(sNumber == "s1_34")
			 	{sRandom = "03_silvy_commoner_g";}
			 if(sNumber == "s1_35")
			 	{sRandom = "03_silvy_commoner_r";}
			 if(sNumber == "s1_36")
			 	{sRandom = "03_silvy_commoner_tt";}
			 if(sNumber == "s1_37")
			 	{sRandom = "03_silvy_commoner_qq";}
			 if(sNumber == "s1_38")
			 	{sRandom = "03_silvy_commoner_hh";}
			 if(sNumber == "s1_39")
			 	{sRandom = "03_silvy_commoner_q";}
			 if(sNumber == "s1_40")
			 	{sRandom = "03_silvy_commoner_ll";}
			 if(sNumber == "s1_41")
			 	{sRandom = "03_silvy_commoner_aa";}
			 if(sNumber == "s1_42")
			 	{sRandom = "03_silvy_commoner_o";}
			 if(sNumber == "s2_1")
			 	{sRandom = "03_quaer_stag_bar";}
			 if(sNumber == "s2_2")
			 	{sRandom = "we_guard_archer";}
			 if(sNumber == "s2_3")
			 	{sRandom = "adbarinfantry";}
			 if(sNumber == "s2_4")
			 	{sRandom = "003_cre_dwarf_felbarr_bow";}
			 if(sNumber == "s2_5")
			 	{sRandom = "003_cre_dwarf_felbarr_hinf_01";}
			 if(sNumber == "s2_6")
			 	{sRandom = "003_cre_dwarf_felbarr_inf";}
			 if(sNumber == "s2_7")
			 	{sRandom = "settle_guard_b";}
			 if(sNumber == "s2_8")
			 	{sRandom = "settle_guard_a";}
			 if(sNumber == "s2_9")
			 	{sRandom = "settle_guard";}
			 if(sNumber == "s2_10")
			 	{sRandom = "fort_guard_archer";}
			 if(sNumber == "s2_11")
			 	{sRandom = "hh_guard_01";}
			 if(sNumber == "s2_12")
			 	{sRandom = "hh_guard_02";}
			 if(sNumber == "s2_13")
			 	{sRandom = "hh_guard_03";}
			 if(sNumber == "s2_14")
			 	{sRandom = "hh_guard_04";}
			 if(sNumber == "s2_15")
			 	{sRandom = "rm_guard_archer";}
			 if(sNumber == "s2_16")
			 	{sRandom = "rm_guard_archer";}
			 if(sNumber == "s2_17")
			 	{sRandom = "rm_guard_pikeman00";}
			 if(sNumber == "s2_18")
			 	{sRandom = "rm_guard_pikeman0";}
			 if(sNumber == "s2_19")
			 	{sRandom = "rm_guard_pikeman";}
			 if(sNumber == "s3_1")
			 	{sRandom = "argentpatroloffduty";}
			 if(sNumber == "s3_2")
			 	{sRandom = "argentpatroloffduty0";}
			 if(sNumber == "s3_3")
			 	{sRandom = "argentpatroloffduty00";}
			 if(sNumber == "s3_4")
			 	{sRandom = "argentpatroloffduty2";}
			 if(sNumber == "s4_1")
			 	{sRandom = "griffoncaravanguardbartrak";}
			 if(sNumber == "s4_2")
			 	{sRandom = "griffoncaravanguardjacobs";}
			 if(sNumber == "s4_3")
			 	{sRandom = "griffoncaravanguardvanth";}
			 if(sNumber == "s4_4")
			 	{sRandom = "griffoncaravanguardorthanus";}
			 if(sNumber == "s5_1")
			 	{sRandom = "silvyhighpalguardin";}
			 if(sNumber == "s5_2")
			 	{sRandom = "silvyhighpalguard";}
			 if(sNumber == "s5_3")
			 	{sRandom = "knightinsilverfullknight";}
			 if(sNumber == "s5_4")
			 	{sRandom = "knightinsilverknightatarmsbow";}
			 if(sNumber == "s5_5")
			 	{sRandom = "knightinsilverknightsgt";}
			 if(sNumber == "s5_6")
			 	{sRandom = "knightinsilverknightatarms";}
			 if(sNumber == "s5_7")
			 	{sRandom = "silvyspellguardadam";}
			 if(sNumber == "s5_8")
			 	{sRandom = "silvyspellguardamanda";}
			 if(sNumber == "s5_9")
			 	{sRandom = "silvyspellguardbelin";}
			 if(sNumber == "s5_10")
			 	{sRandom = "silvyspellguardmarc0";}
			 if(sNumber == "s5_11")
			 	{sRandom = "silvyspellguardmarc";}
			 if(sNumber == "s5_12")
			 	{sRandom = "silvyspellguardmary";}
			 if(sNumber == "s5_13")
			 	{sRandom = "silvyspellguardmyar";}
			 if(sNumber == "s5_14")
			 	{sRandom = "silvyspellguardscott";}
			 if(sNumber == "s5_15")
			 	{sRandom = "silvyspellguardseth";}
			 if(sNumber == "s6_1")
			 	{sRandom = "003_cr_berronar_traveller";}
			 if(sNumber == "s6_2")
			 	{sRandom = "003_cr_helm_traveller";}
			 if(sNumber == "s6_3")
			 	{sRandom = "003_cr_ilmater_traveller";}
			 if(sNumber == "s6_4")
			 	{sRandom = "003_cr_lathander_traveller";}
			 if(sNumber == "s6_5")
			 	{sRandom = "003_cr_mielikki_traveller";}
			 if(sNumber == "s6_6")
			 	{sRandom = "003_cr_redknight_traveller";}
			 if(sNumber == "s6_7")
			 	{sRandom = "003_cr_selune_traveller";}
			 
			 
			 if(sNumber2== "s1_1")
			 	{sRandom2 = "03_silvy_commoner_uu";}
			 if(sNumber2 == "s1_2")
			 	{sRandom2 = "03_silvy_commoner_vv";}
			 if(sNumber2 == "s1_3")
			 	{sRandom2= "03_silvy_commoner_ii";}
			 if(sNumber2 == "s1_4")
			 	{sRandom2 = "03_silvy_commoner_v";}
			 if(sNumber2 == "s1_5")
			 	{sRandom2 = "03_silvy_commoner_e";}
			 if(sNumber2 == "s1_6")
			 	{sRandom2 = "03_silvy_commoner_dd";}
			 if(sNumber2 == "s1_7")
			 	{sRandom2 = "03_silvy_commoner_oo";}
			 if(sNumber2 == "s1_8")
			 	{sRandom2 = "03_silvy_commoner_s";}
			 if(sNumber2 == "s1_9")
			 	{sRandom2 = "03_silvy_commoner_c";}
			 if(sNumber2 == "s1_10")
			 	{sRandom2 = "03_silvy_commoner_bb";}
			 if(sNumber2 == "s1_11")
			 	{sRandom2 = "03_silvy_commoner_t";}
			 if(sNumber2 == "s1_12")
			 	{sRandom2 = "03_silvy_commoner_j";}
			 if(sNumber2 == "s1_13")
			 	{sRandom2 = "03_silvy_commoner_nn";}
			 if(sNumber2 == "s1_14")
			 	{sRandom2 = "03_silvy_commoner_cc";}
			 if(sNumber2 == "s1_15")
			 	{sRandom2 = "03_silvy_commoner_d";}
			 if(sNumber2 == "s1_16")
			 	{sRandom2 = "03_silvy_commoner_k";}
			 if(sNumber2 == "s1_17")
			 	{sRandom2 = "03_silvy_commoner_b";}
			 if(sNumber2 == "s1_18")
			 	{sRandom2 = "03_silvy_commoner_i";}
			 if(sNumber2 == "s1_19")
			 	{sRandom2 = "03_silvy_commoner_h";}
			 if(sNumber2 == "s1_20")
			 	{sRandom2 = "03_silvy_commoner_pp";}
			 if(sNumber2 == "s1_21")
			 	{sRandom2 = "03_silvy_commoner_ss";}
			 if(sNumber2 == "s1_22")
			 	{sRandom2 = "03_silvy_commoner_p";}
			 if(sNumber2 == "s1_23")
			 	{sRandom2 = "03_silvy_commoner_mm";}
			 if(sNumber2 == "s1_24")
			 	{sRandom2 = "03_silvy_commoner_a";}
			 if(sNumber2 == "s1_25")
			 	{sRandom2 = "03_silvy_commoner_f";}
			 if(sNumber2 == "s1_26")
			 	{sRandom2 = "03_silvy_commoner_kk";}
			 if(sNumber2 == "s1_27")
			 	{sRandom2 = "03_silvy_commoner_u";}
			 if(sNumber2 == "s1_28")
			 	{sRandom2 = "03_silvy_commoner_ff";}
			 if(sNumber2 == "s1_29")
			 	{sRandom2 = "03_silvy_commoner_jj";}
			 if(sNumber2 == "s1_30")
			 	{sRandom2 = "03_silvy_commoner_gg";}
			 if(sNumber2 == "s1_31")
			 	{sRandom2 = "03_silvy_commoner_rr";}
			 if(sNumber2 == "s1_32")
			 	{sRandom2 = "03_silvy_commoner_ee";}
			 if(sNumber2 == "s1_33")
			 	{sRandom2 = "03_silvy_commoner_n";}
			 if(sNumber2 == "s1_34")
			 	{sRandom2 = "03_silvy_commoner_g";}
			 if(sNumber2 == "s1_35")
			 	{sRandom2 = "03_silvy_commoner_r";}
			 if(sNumber2 == "s1_36")
			 	{sRandom2 = "03_silvy_commoner_tt";}
			 if(sNumber2 == "s1_37")
			 	{sRandom2 = "03_silvy_commoner_qq";}
			 if(sNumber2 == "s1_38")
			 	{sRandom2 = "03_silvy_commoner_hh";}
			 if(sNumber2 == "s1_39")
			 	{sRandom2 = "03_silvy_commoner_q";}
			 if(sNumber2 == "s1_40")
			 	{sRandom2 = "03_silvy_commoner_ll";}
			 if(sNumber2 == "s1_41")
			 	{sRandom2 = "03_silvy_commoner_aa";}
			 if(sNumber2 == "s1_42")
			 	{sRandom2 = "03_silvy_commoner_o";}
			 if(sNumber2 == "s2_1")
			 	{sRandom2 = "03_quaer_stag_bar";}
			 if(sNumber2 == "s2_2")
			 	{sRandom2 = "we_guard_archer";}
			 if(sNumber2 == "s2_3")
			 	{sRandom2 = "adbarinfantry";}
			 if(sNumber2 == "s2_4")
			 	{sRandom2 = "003_cre_dwarf_felbarr_bow";}
			 if(sNumber2 == "s2_5")
			 	{sRandom2 = "003_cre_dwarf_felbarr_hinf_01";}
			 if(sNumber2 == "s2_6")
			 	{sRandom2 = "003_cre_dwarf_felbarr_inf";}
			 if(sNumber2 == "s2_7")
			 	{sRandom2 = "settle_guard_b";}
			 if(sNumber2 == "s2_8")
			 	{sRandom2 = "settle_guard_a";}
			 if(sNumber2 == "s2_9")
			 	{sRandom2 = "settle_guard";}
			 if(sNumber2 == "s2_10")
			 	{sRandom2 = "fort_guard_archer";}
			 if(sNumber2 == "s2_11")
			 	{sRandom2 = "hh_guard_01";}
			 if(sNumber2 == "s2_12")
			 	{sRandom2 = "hh_guard_02";}
			 if(sNumber2 == "s2_13")
			 	{sRandom2 = "hh_guard_03";}
			 if(sNumber2 == "s2_14")
			 	{sRandom2 = "hh_guard_04";}
			 if(sNumber2 == "s2_15")
			 	{sRandom2 = "rm_guard_archer";}
			 if(sNumber2 == "s2_16")
			 	{sRandom2 = "rm_guard_archer";}
			 if(sNumber2 == "s2_17")
			 	{sRandom2 = "rm_guard_pikeman00";}
			 if(sNumber2 == "s2_18")
			 	{sRandom2 = "rm_guard_pikeman0";}
			 if(sNumber2 == "s2_19")
			 	{sRandom2 = "rm_guard_pikeman";}
			 if(sNumber2 == "s3_1")
			 	{sRandom2 = "argentpatroloffduty";}
			 if(sNumber2 == "s3_2")
			 	{sRandom2 = "argentpatroloffduty0";}
			 if(sNumber2 == "s3_3")
			 	{sRandom2 = "argentpatroloffduty00";}
			 if(sNumber2 == "s3_4")
			 	{sRandom2 = "argentpatroloffduty2";}
			 if(sNumber2 == "s4_1")
			 	{sRandom2 = "griffoncaravanguardbartrak";}
			 if(sNumber2 == "s4_2")
			 	{sRandom2 = "griffoncaravanguardjacobs";}
			 if(sNumber2 == "s4_3")
			 	{sRandom2 = "griffoncaravanguardvanth";}
			 if(sNumber2 == "s4_4")
			 	{sRandom2 = "griffoncaravanguardorthanus";}
			 if(sNumber2 == "s5_1")
			 	{sRandom2 = "silvyhighpalguardin";}
			 if(sNumber2 == "s5_2")
			 	{sRandom2 = "silvyhighpalguard";}
			 if(sNumber2 == "s5_3")
			 	{sRandom2 = "knightinsilverfullknight";}
			 if(sNumber2 == "s5_4")
			 	{sRandom2 = "knightinsilverknightatarmsbow";}
			 if(sNumber2 == "s5_5")
			 	{sRandom2 = "knightinsilverknightsgt";}
			 if(sNumber2 == "s5_6")
			 	{sRandom2 = "knightinsilverknightatarms";}
			 if(sNumber2 == "s5_7")
			 	{sRandom2 = "silvyhighpalguardin";}
			 if(sNumber2 == "s5_8")
			 	{sRandom2 = "silvyhighpalguard";}
			 if(sNumber2 == "s5_9")
			 	{sRandom2 = "knightinsilverfullknight";}
			 if(sNumber2 == "s5_10")
			 	{sRandom2 = "knightinsilverknightatarmsbow";}
			 if(sNumber2 == "s5_11")
			 	{sRandom2 = "knightinsilverknightsgt";}
			 if(sNumber2 == "s5_12")
			 	{sRandom2 = "knightinsilverknightatarms";}
			 if(sNumber2 == "s5_13")
			 	{sRandom2 = "knightinsilverknightatarmsbow";}
			 if(sNumber2 == "s5_14")
			 	{sRandom2 = "knightinsilverknightatarms";}
			 if(sNumber2 == "s5_15")
			 	{sRandom2 = "silvyhighpalguard";}
			 if(sNumber2 == "s6_1")
			 	{sRandom2 = "003_cr_berronar_traveller";}
			 if(sNumber2 == "s6_2")
			 	{sRandom2 = "003_cr_helm_traveller";}
			 if(sNumber2 == "s6_3")
			 	{sRandom2 = "003_cr_ilmater_traveller";}
			 if(sNumber2 == "s6_4")
			 	{sRandom2 = "003_cr_lathander_traveller";}
			 if(sNumber2 == "s6_5")
			 	{sRandom2 = "003_cr_mielikki_traveller";}
			 if(sNumber2 == "s6_6")
			 	{sRandom2 = "003_cr_redknight_traveller";}
			 if(sNumber2 == "s6_7")
			 	{sRandom2 = "003_cr_selune_traveller";}
			 
			 if(sNumber3== "s1_1")
			 	{sRandom3 = "03_silvy_commoner_uu";}
			 if(sNumber3 == "s1_2")
			 	{sRandom3 = "03_silvy_commoner_vv";}
			 if(sNumber3 == "s1_3")
			 	{sRandom3= "03_silvy_commoner_ii";}
			 if(sNumber3 == "s1_4")
			 	{sRandom3 = "03_silvy_commoner_v";}
			 if(sNumber3 == "s1_5")
			 	{sRandom3 = "03_silvy_commoner_e";}
			 if(sNumber3 == "s1_6")
			 	{sRandom3 = "03_silvy_commoner_dd";}
			 if(sNumber3 == "s1_7")
			 	{sRandom3 = "03_silvy_commoner_oo";}
			 if(sNumber3 == "s1_8")
			 	{sRandom3 = "03_silvy_commoner_s";}
			 if(sNumber3 == "s1_9")
			 	{sRandom3 = "03_silvy_commoner_c";}
			 if(sNumber3 == "s1_10")
			 	{sRandom3 = "03_silvy_commoner_bb";}
			 if(sNumber3 == "s1_11")
			 	{sRandom3 = "03_silvy_commoner_t";}
			 if(sNumber3 == "s1_12")
			 	{sRandom3 = "03_silvy_commoner_j";}
			 if(sNumber3 == "s1_13")
			 	{sRandom3 = "03_silvy_commoner_nn";}
			 if(sNumber3 == "s1_14")
			 	{sRandom3 = "03_silvy_commoner_cc";}
			 if(sNumber3 == "s1_15")
			 	{sRandom3 = "03_silvy_commoner_d";}
			 if(sNumber3 == "s1_16")
			 	{sRandom3 = "03_silvy_commoner_k";}
			 if(sNumber3 == "s1_17")
			 	{sRandom3 = "03_silvy_commoner_b";}
			 if(sNumber3 == "s1_18")
			 	{sRandom3 = "03_silvy_commoner_i";}
			 if(sNumber3 == "s1_19")
			 	{sRandom3 = "03_silvy_commoner_h";}
			 if(sNumber3 == "s1_20")
			 	{sRandom3 = "03_silvy_commoner_pp";}
			 if(sNumber3 == "s1_21")
			 	{sRandom3 = "03_silvy_commoner_ss";}
			 if(sNumber3 == "s1_22")
			 	{sRandom3 = "03_silvy_commoner_p";}
			 if(sNumber3 == "s1_23")
			 	{sRandom3 = "03_silvy_commoner_mm";}
			 if(sNumber3 == "s1_24")
			 	{sRandom3 = "03_silvy_commoner_a";}
			 if(sNumber3 == "s1_25")
			 	{sRandom3 = "03_silvy_commoner_f";}
			 if(sNumber3 == "s1_26")
			 	{sRandom3 = "03_silvy_commoner_kk";}
			 if(sNumber3 == "s1_27")
			 	{sRandom3 = "03_silvy_commoner_u";}
			 if(sNumber3 == "s1_28")
			 	{sRandom3 = "03_silvy_commoner_ff";}
			 if(sNumber3 == "s1_29")
			 	{sRandom3 = "03_silvy_commoner_jj";}
			 if(sNumber3 == "s1_30")
			 	{sRandom3 = "03_silvy_commoner_gg";}
			 if(sNumber3 == "s1_31")
			 	{sRandom3 = "03_silvy_commoner_rr";}
			 if(sNumber3 == "s1_32")
			 	{sRandom3 = "03_silvy_commoner_ee";}
			 if(sNumber3 == "s1_33")
			 	{sRandom3 = "03_silvy_commoner_n";}
			 if(sNumber3 == "s1_34")
			 	{sRandom3 = "03_silvy_commoner_g";}
			 if(sNumber3 == "s1_35")
			 	{sRandom3 = "03_silvy_commoner_r";}
			 if(sNumber3 == "s1_36")
			 	{sRandom3 = "03_silvy_commoner_tt";}
			 if(sNumber3 == "s1_37")
			 	{sRandom3 = "03_silvy_commoner_qq";}
			 if(sNumber3 == "s1_38")
			 	{sRandom3 = "03_silvy_commoner_hh";}
			 if(sNumber3 == "s1_39")
			 	{sRandom3 = "03_silvy_commoner_q";}
			 if(sNumber3 == "s1_40")
			 	{sRandom3 = "03_silvy_commoner_ll";}
			 if(sNumber3 == "s1_41")
			 	{sRandom3 = "03_silvy_commoner_aa";}
			 if(sNumber3 == "s1_42")
			 	{sRandom3 = "03_silvy_commoner_o";}
			 if(sNumber3 == "s2_1")
			 	{sRandom3 = "03_quaer_stag_bar";}
			 if(sNumber3 == "s2_2")
			 	{sRandom3 = "we_guard_archer";}
			 if(sNumber3 == "s2_3")
			 	{sRandom3 = "adbarinfantry";}
			 if(sNumber3 == "s2_4")
			 	{sRandom3 = "003_cre_dwarf_felbarr_bow";}
			 if(sNumber3 == "s2_5")
			 	{sRandom3 = "003_cre_dwarf_felbarr_hinf_01";}
			 if(sNumber3 == "s2_6")
			 	{sRandom3 = "003_cre_dwarf_felbarr_inf";}
			 if(sNumber3 == "s2_7")
			 	{sRandom3 = "settle_guard_b";}
			 if(sNumber3 == "s2_8")
			 	{sRandom3 = "settle_guard_a";}
			 if(sNumber3 == "s2_9")
			 	{sRandom3 = "settle_guard";}
			 if(sNumber3 == "s2_10")
			 	{sRandom3 = "fort_guard_archer";}
			 if(sNumber3 == "s2_11")
			 	{sRandom3 = "hh_guard_01";}
			 if(sNumber3 == "s2_12")
			 	{sRandom3 = "hh_guard_02";}
			 if(sNumber3 == "s2_13")
			 	{sRandom3 = "hh_guard_03";}
			 if(sNumber3 == "s2_14")
			 	{sRandom3 = "hh_guard_04";}
			 if(sNumber3 == "s2_15")
			 	{sRandom3 = "rm_guard_archer";}
			 if(sNumber3 == "s2_16")
			 	{sRandom3 = "rm_guard_archer";}
			 if(sNumber3 == "s2_17")
			 	{sRandom3 = "rm_guard_pikeman00";}
			 if(sNumber3 == "s2_18")
			 	{sRandom3 = "rm_guard_pikeman0";}
			 if(sNumber3 == "s2_19")
			 	{sRandom3 = "rm_guard_pikeman";}
			 if(sNumber3 == "s3_1")
			 	{sRandom3 = "argentpatroloffduty";}
			 if(sNumber3 == "s3_2")
			 	{sRandom3 = "argentpatroloffduty0";}
			 if(sNumber3 == "s3_3")
			 	{sRandom3 = "argentpatroloffduty00";}
			 if(sNumber3 == "s3_4")
			 	{sRandom3 = "argentpatroloffduty2";}
			 if(sNumber3 == "s4_1")
			 	{sRandom3 = "griffoncaravanguardbartrak";}
			 if(sNumber3 == "s4_2")
			 	{sRandom3 = "griffoncaravanguardjacobs";}
			 if(sNumber3 == "s4_3")
			 	{sRandom3 = "griffoncaravanguardvanth";}
			 if(sNumber3 == "s4_4")
			 	{sRandom3 = "griffoncaravanguardorthanus";}
			 if(sNumber3 == "s5_1")
			 	{sRandom3 = "silvyhighpalguardin";}
			 if(sNumber3 == "s5_2")
			 	{sRandom3 = "silvyhighpalguard";}
			 if(sNumber3 == "s5_3")
			 	{sRandom3 = "knightinsilverfullknight";}
			 if(sNumber3 == "s5_4")
			 	{sRandom3 = "knightinsilverknightatarmsbow";}
			 if(sNumber3 == "s5_5")
			 	{sRandom3 = "knightinsilverknightsgt";}
			 if(sNumber3 == "s5_6")
			 	{sRandom3 = "knightinsilverknightatarms";}
			 if(sNumber3 == "s5_7")
			 	{sRandom3 = "silvyhighpalguardin";}
			 if(sNumber3 == "s5_8")
			 	{sRandom3 = "silvyhighpalguard";}
			 if(sNumber3 == "s5_9")
			 	{sRandom3 = "knightinsilverfullknight";}
			 if(sNumber3 == "s5_10")
			 	{sRandom3 = "knightinsilverknightatarmsbow";}
			 if(sNumber3 == "s5_11")
			 	{sRandom3 = "knightinsilverknightsgt";}
			 if(sNumber3 == "s5_12")
			 	{sRandom3 = "knightinsilverknightatarms";}
			 if(sNumber3 == "s5_13")
			 	{sRandom3 = "knightinsilverknightatarmsbow";}
			 if(sNumber3 == "s5_14")
			 	{sRandom3 = "knightinsilverknightatarms";}
			 if(sNumber3 == "s5_15")
			 	{sRandom3 = "silvyhighpalguard";}
			 if(sNumber3 == "s6_1")
			 	{sRandom3 = "003_cr_berronar_traveller";}
			 if(sNumber3 == "s6_2")
			 	{sRandom3 = "003_cr_helm_traveller";}
			 if(sNumber3 == "s6_3")
			 	{sRandom3 = "003_cr_ilmater_traveller";}
			 if(sNumber3 == "s6_4")
			 	{sRandom3 = "003_cr_lathander_traveller";}
			 if(sNumber3 == "s6_5")
			 	{sRandom3 = "003_cr_mielikki_traveller";}
			 if(sNumber3 == "s6_6")
			 	{sRandom3 = "003_cr_redknight_traveller";}
			 if(sNumber3 == "s6_7")
			 	{sRandom3 = "003_cr_selune_traveller";}
			 
			 if(sNumber4== "s1_1")
			 	{sRandom4 = "03_silvy_commoner_uu";}
			 if(sNumber4 == "s1_2")
			 	{sRandom4 = "03_silvy_commoner_vv";}
			 if(sNumber4 == "s1_3")
			 	{sRandom4= "03_silvy_commoner_ii";}
			 if(sNumber4 == "s1_4")
			 	{sRandom4 = "03_silvy_commoner_v";}
			 if(sNumber4 == "s1_5")
			 	{sRandom4 = "03_silvy_commoner_e";}
			 if(sNumber4 == "s1_6")
			 	{sRandom4 = "03_silvy_commoner_dd";}
			 if(sNumber4 == "s1_7")
			 	{sRandom4 = "03_silvy_commoner_oo";}
			 if(sNumber4 == "s1_8")
			 	{sRandom4 = "03_silvy_commoner_s";}
			 if(sNumber4 == "s1_9")
			 	{sRandom4 = "03_silvy_commoner_c";}
			 if(sNumber4 == "s1_10")
			 	{sRandom4 = "03_silvy_commoner_bb";}
			 if(sNumber4 == "s1_11")
			 	{sRandom4 = "03_silvy_commoner_t";}
			 if(sNumber4 == "s1_12")
			 	{sRandom4 = "03_silvy_commoner_j";}
			 if(sNumber4 == "s1_13")
			 	{sRandom4 = "03_silvy_commoner_nn";}
			 if(sNumber4 == "s1_14")
			 	{sRandom4 = "03_silvy_commoner_cc";}
			 if(sNumber4 == "s1_15")
			 	{sRandom4 = "03_silvy_commoner_d";}
			 if(sNumber4 == "s1_16")
			 	{sRandom4 = "03_silvy_commoner_k";}
			 if(sNumber4 == "s1_17")
			 	{sRandom4 = "03_silvy_commoner_b";}
			 if(sNumber4 == "s1_18")
			 	{sRandom4 = "03_silvy_commoner_i";}
			 if(sNumber4 == "s1_19")
			 	{sRandom4 = "03_silvy_commoner_h";}
			 if(sNumber4 == "s1_20")
			 	{sRandom4 = "03_silvy_commoner_pp";}
			 if(sNumber4 == "s1_21")
			 	{sRandom4 = "03_silvy_commoner_ss";}
			 if(sNumber4 == "s1_22")
			 	{sRandom4 = "03_silvy_commoner_p";}
			 if(sNumber4 == "s1_23")
			 	{sRandom4 = "03_silvy_commoner_mm";}
			 if(sNumber4 == "s1_24")
			 	{sRandom4 = "03_silvy_commoner_a";}
			 if(sNumber4 == "s1_25")
			 	{sRandom4 = "03_silvy_commoner_f";}
			 if(sNumber4 == "s1_26")
			 	{sRandom4 = "03_silvy_commoner_kk";}
			 if(sNumber4 == "s1_27")
			 	{sRandom4 = "03_silvy_commoner_u";}
			 if(sNumber4 == "s1_28")
			 	{sRandom4 = "03_silvy_commoner_ff";}
			 if(sNumber4 == "s1_29")
			 	{sRandom4 = "03_silvy_commoner_jj";}
			 if(sNumber4 == "s1_30")
			 	{sRandom4 = "03_silvy_commoner_gg";}
			 if(sNumber4 == "s1_31")
			 	{sRandom4 = "03_silvy_commoner_rr";}
			 if(sNumber4 == "s1_32")
			 	{sRandom4 = "03_silvy_commoner_ee";}
			 if(sNumber4 == "s1_33")
			 	{sRandom4 = "03_silvy_commoner_n";}
			 if(sNumber4 == "s1_34")
			 	{sRandom4 = "03_silvy_commoner_g";}
			 if(sNumber4 == "s1_35")
			 	{sRandom4 = "03_silvy_commoner_r";}
			 if(sNumber4 == "s1_36")
			 	{sRandom4 = "03_silvy_commoner_tt";}
			 if(sNumber4 == "s1_37")
			 	{sRandom4 = "03_silvy_commoner_qq";}
			 if(sNumber4 == "s1_38")
			 	{sRandom4 = "03_silvy_commoner_hh";}
			 if(sNumber4 == "s1_39")
			 	{sRandom4 = "03_silvy_commoner_q";}
			 if(sNumber4 == "s1_40")
			 	{sRandom4 = "03_silvy_commoner_ll";}
			 if(sNumber4 == "s1_41")
			 	{sRandom4 = "03_silvy_commoner_aa";}
			 if(sNumber4 == "s1_42")
			 	{sRandom4 = "03_silvy_commoner_o";}
			 if(sNumber4 == "s2_1")
			 	{sRandom4 = "03_quaer_stag_bar";}
			 if(sNumber4 == "s2_2")
			 	{sRandom4 = "we_guard_archer";}
			 if(sNumber4 == "s2_3")
			 	{sRandom4 = "adbarinfantry";}
			 if(sNumber4 == "s2_4")
			 	{sRandom4 = "003_cre_dwarf_felbarr_bow";}
			 if(sNumber4 == "s2_5")
			 	{sRandom4 = "003_cre_dwarf_felbarr_hinf_01";}
			 if(sNumber4 == "s2_6")
			 	{sRandom4 = "003_cre_dwarf_felbarr_inf";}
			 if(sNumber4 == "s2_7")
			 	{sRandom4 = "settle_guard_b";}
			 if(sNumber4 == "s2_8")
			 	{sRandom4 = "settle_guard_a";}
			 if(sNumber4 == "s2_9")
			 	{sRandom4 = "settle_guard";}
			 if(sNumber4 == "s2_10")
			 	{sRandom4 = "fort_guard_archer";}
			 if(sNumber4 == "s2_11")
			 	{sRandom4 = "hh_guard_01";}
			 if(sNumber4 == "s2_12")
			 	{sRandom4 = "hh_guard_02";}
			 if(sNumber4 == "s2_13")
			 	{sRandom4 = "hh_guard_03";}
			 if(sNumber4 == "s2_14")
			 	{sRandom4 = "hh_guard_04";}
			 if(sNumber4 == "s2_15")
			 	{sRandom4 = "rm_guard_archer";}
			 if(sNumber4 == "s2_16")
			 	{sRandom4 = "rm_guard_archer";}
			 if(sNumber4 == "s2_17")
			 	{sRandom4 = "rm_guard_pikeman00";}
			 if(sNumber4 == "s2_18")
			 	{sRandom4 = "rm_guard_pikeman0";}
			 if(sNumber4 == "s2_19")
			 	{sRandom4 = "rm_guard_pikeman";}
			 if(sNumber4 == "s3_1")
			 	{sRandom4 = "argentpatroloffduty";}
			 if(sNumber4 == "s3_2")
			 	{sRandom4 = "argentpatroloffduty0";}
			 if(sNumber4 == "s3_3")
			 	{sRandom4 = "argentpatroloffduty00";}
			 if(sNumber4 == "s3_4")
			 	{sRandom4 = "argentpatroloffduty2";}
			 if(sNumber4 == "s4_1")
			 	{sRandom4 = "griffoncaravanguardbartrak";}
			 if(sNumber4 == "s4_2")
			 	{sRandom4 = "griffoncaravanguardjacobs";}
			 if(sNumber4 == "s4_3")
			 	{sRandom4 = "griffoncaravanguardvanth";}
			 if(sNumber4 == "s4_4")
			 	{sRandom4 = "griffoncaravanguardorthanus";}
			 if(sNumber4 == "s5_1")
			 	{sRandom4 = "silvyhighpalguardin";}
			 if(sNumber4 == "s5_2")
			 	{sRandom4 = "silvyhighpalguard";}
			 if(sNumber4 == "s5_3")
			 	{sRandom4 = "knightinsilverfullknight";}
			 if(sNumber4 == "s5_4")
			 	{sRandom4 = "knightinsilverknightatarmsbow";}
			 if(sNumber4 == "s5_5")
			 	{sRandom4 = "knightinsilverknightsgt";}
			 if(sNumber4 == "s5_6")
			 	{sRandom4 = "knightinsilverknightatarms";}
			 if(sNumber4 == "s5_7")
			 	{sRandom4 = "silvyhighpalguardin";}
			 if(sNumber4 == "s5_8")
			 	{sRandom4 = "silvyhighpalguard";}
			 if(sNumber4 == "s5_9")
			 	{sRandom4 = "knightinsilverfullknight";}
			 if(sNumber4 == "s5_10")
			 	{sRandom4 = "knightinsilverknightatarmsbow";}
			 if(sNumber4 == "s5_11")
			 	{sRandom4 = "knightinsilverknightsgt";}
			 if(sNumber4 == "s5_12")
			 	{sRandom4 = "knightinsilverknightatarms";}
			 if(sNumber4 == "s5_13")
			 	{sRandom4 = "knightinsilverknightatarmsbow";}
			 if(sNumber4 == "s5_14")
			 	{sRandom4 = "knightinsilverknightatarms";}
			 if(sNumber4 == "s5_15")
			 	{sRandom4 = "silvyhighpalguard";}
			 if(sNumber4 == "s6_1")
			 	{sRandom4 = "003_cr_berronar_traveller";}
			 if(sNumber4 == "s6_2")
			 	{sRandom4 = "003_cr_helm_traveller";}
			 if(sNumber4 == "s6_3")
			 	{sRandom4 = "003_cr_ilmater_traveller";}
			 if(sNumber4 == "s6_4")
			 	{sRandom4 = "003_cr_lathander_traveller";}
			 if(sNumber4 == "s6_5")
			 	{sRandom4 = "003_cr_mielikki_traveller";}
			 if(sNumber4 == "s6_6")
			 	{sRandom4 = "003_cr_redknight_traveller";}
			 if(sNumber4 == "s6_7")
			 	{sRandom4 = "003_cr_selune_traveller";}
			 
			 if(sNumber5== "s1_1")
			 	{sRandom5 = "03_silvy_commoner_uu";}
			 if(sNumber5 == "s1_2")
			 	{sRandom5 = "03_silvy_commoner_vv";}
			 if(sNumber5 == "s1_3")
			 	{sRandom5= "03_silvy_commoner_ii";}
			 if(sNumber5 == "s1_4")
			 	{sRandom5 = "03_silvy_commoner_v";}
			 if(sNumber5 == "s1_5")
			 	{sRandom5 = "03_silvy_commoner_e";}
			 if(sNumber5 == "s1_6")
			 	{sRandom5 = "03_silvy_commoner_dd";}
			 if(sNumber5 == "s1_7")
			 	{sRandom5 = "03_silvy_commoner_oo";}
			 if(sNumber5 == "s1_8")
			 	{sRandom5 = "03_silvy_commoner_s";}
			 if(sNumber5 == "s1_9")
			 	{sRandom5 = "03_silvy_commoner_c";}
			 if(sNumber5 == "s1_10")
			 	{sRandom5 = "03_silvy_commoner_bb";}
			 if(sNumber5 == "s1_11")
			 	{sRandom5 = "03_silvy_commoner_t";}
			 if(sNumber5 == "s1_12")
			 	{sRandom5 = "03_silvy_commoner_j";}
			 if(sNumber5 == "s1_13")
			 	{sRandom5 = "03_silvy_commoner_nn";}
			 if(sNumber5 == "s1_14")
			 	{sRandom5 = "03_silvy_commoner_cc";}
			 if(sNumber5 == "s1_15")
			 	{sRandom5 = "03_silvy_commoner_d";}
			 if(sNumber5 == "s1_16")
			 	{sRandom5 = "03_silvy_commoner_k";}
			 if(sNumber5 == "s1_17")
			 	{sRandom5 = "03_silvy_commoner_b";}
			 if(sNumber5 == "s1_18")
			 	{sRandom5 = "03_silvy_commoner_i";}
			 if(sNumber5 == "s1_19")
			 	{sRandom5 = "03_silvy_commoner_h";}
			 if(sNumber5 == "s1_20")
			 	{sRandom5 = "03_silvy_commoner_pp";}
			 if(sNumber5 == "s1_21")
			 	{sRandom5 = "03_silvy_commoner_ss";}
			 if(sNumber5 == "s1_22")
			 	{sRandom5 = "03_silvy_commoner_p";}
			 if(sNumber5 == "s1_23")
			 	{sRandom5 = "03_silvy_commoner_mm";}
			 if(sNumber5 == "s1_24")
			 	{sRandom5 = "03_silvy_commoner_a";}
			 if(sNumber5 == "s1_25")
			 	{sRandom5 = "03_silvy_commoner_f";}
			 if(sNumber5 == "s1_26")
			 	{sRandom5 = "03_silvy_commoner_kk";}
			 if(sNumber5 == "s1_27")
			 	{sRandom5 = "03_silvy_commoner_u";}
			 if(sNumber5 == "s1_28")
			 	{sRandom5 = "03_silvy_commoner_ff";}
			 if(sNumber5 == "s1_29")
			 	{sRandom5 = "03_silvy_commoner_jj";}
			 if(sNumber5 == "s1_30")
			 	{sRandom5 = "03_silvy_commoner_gg";}
			 if(sNumber5 == "s1_31")
			 	{sRandom5 = "03_silvy_commoner_rr";}
			 if(sNumber5 == "s1_32")
			 	{sRandom5 = "03_silvy_commoner_ee";}
			 if(sNumber5 == "s1_33")
			 	{sRandom5 = "03_silvy_commoner_n";}
			 if(sNumber5 == "s1_34")
			 	{sRandom5 = "03_silvy_commoner_g";}
			 if(sNumber5 == "s1_35")
			 	{sRandom5 = "03_silvy_commoner_r";}
			 if(sNumber5 == "s1_36")
			 	{sRandom5 = "03_silvy_commoner_tt";}
			 if(sNumber5 == "s1_37")
			 	{sRandom5 = "03_silvy_commoner_qq";}
			 if(sNumber5 == "s1_38")
			 	{sRandom5 = "03_silvy_commoner_hh";}
			 if(sNumber5 == "s1_39")
			 	{sRandom5 = "03_silvy_commoner_q";}
			 if(sNumber5 == "s1_40")
			 	{sRandom5 = "03_silvy_commoner_ll";}
			 if(sNumber5 == "s1_41")
			 	{sRandom5 = "03_silvy_commoner_aa";}
			 if(sNumber5 == "s1_42")
			 	{sRandom5 = "03_silvy_commoner_o";}
			 if(sNumber5 == "s2_1")
			 	{sRandom5 = "03_quaer_stag_bar";}
			 if(sNumber5 == "s2_2")
			 	{sRandom5 = "we_guard_archer";}
			 if(sNumber5 == "s2_3")
			 	{sRandom5 = "adbarinfantry";}
			 if(sNumber5 == "s2_4")
			 	{sRandom5 = "003_cre_dwarf_felbarr_bow";}
			 if(sNumber5 == "s2_5")
			 	{sRandom5 = "003_cre_dwarf_felbarr_hinf_01";}
			 if(sNumber5 == "s2_6")
			 	{sRandom5 = "003_cre_dwarf_felbarr_inf";}
			 if(sNumber5 == "s2_7")
			 	{sRandom5 = "settle_guard_b";}
			 if(sNumber5 == "s2_8")
			 	{sRandom5 = "settle_guard_a";}
			 if(sNumber5 == "s2_9")
			 	{sRandom5 = "settle_guard";}
			 if(sNumber5 == "s2_10")
			 	{sRandom5 = "fort_guard_archer";}
			 if(sNumber5 == "s2_11")
			 	{sRandom5 = "hh_guard_01";}
			 if(sNumber5 == "s2_12")
			 	{sRandom5 = "hh_guard_02";}
			 if(sNumber5 == "s2_13")
			 	{sRandom5 = "hh_guard_03";}
			 if(sNumber5 == "s2_14")
			 	{sRandom5 = "hh_guard_04";}
			 if(sNumber5 == "s2_15")
			 	{sRandom5 = "rm_guard_archer";}
			 if(sNumber5 == "s2_16")
			 	{sRandom5 = "rm_guard_archer";}
			 if(sNumber5 == "s2_17")
			 	{sRandom5 = "rm_guard_pikeman00";}
			 if(sNumber5 == "s2_18")
			 	{sRandom5 = "rm_guard_pikeman0";}
			 if(sNumber5 == "s2_19")
			 	{sRandom5 = "rm_guard_pikeman";}
			 if(sNumber5 == "s3_1")
			 	{sRandom5 = "argentpatroloffduty";}
			 if(sNumber5 == "s3_2")
			 	{sRandom5 = "argentpatroloffduty0";}
			 if(sNumber5 == "s3_3")
			 	{sRandom5 = "argentpatroloffduty00";}
			 if(sNumber5 == "s3_4")
			 	{sRandom5 = "argentpatroloffduty2";}
			 if(sNumber5 == "s4_1")
			 	{sRandom5 = "griffoncaravanguardbartrak";}
			 if(sNumber5 == "s4_2")
			 	{sRandom5 = "griffoncaravanguardjacobs";}
			 if(sNumber5 == "s4_3")
			 	{sRandom5 = "griffoncaravanguardvanth";}
			 if(sNumber5 == "s4_4")
			 	{sRandom5 = "griffoncaravanguardorthanus";}
			 if(sNumber5 == "s5_1")
			 	{sRandom5 = "silvyhighpalguardin";}
			 if(sNumber5 == "s5_2")
			 	{sRandom5 = "silvyhighpalguard";}
			 if(sNumber5 == "s5_3")
			 	{sRandom5 = "knightinsilverfullknight";}
			 if(sNumber5 == "s5_4")
			 	{sRandom5 = "knightinsilverknightatarmsbow";}
			 if(sNumber5 == "s5_5")
			 	{sRandom5 = "knightinsilverknightsgt";}
			 if(sNumber5 == "s5_6")
			 	{sRandom5 = "knightinsilverknightatarms";}
			 if(sNumber5 == "s5_7")
			 	{sRandom5 = "silvyspellguardadam";}
			 if(sNumber5 == "s5_8")
			 	{sRandom5 = "silvyspellguardamanda";}
			 if(sNumber5 == "s5_9")
			 	{sRandom5 = "silvyspellguardbelin";}
			 if(sNumber5 == "s5_10")
			 	{sRandom5 = "silvyspellguardmarc0";}
			 if(sNumber5 == "s5_11")
			 	{sRandom5 = "silvyspellguardmarc";}
			 if(sNumber5 == "s5_12")
			 	{sRandom5 = "silvyspellguardmary";}
			 if(sNumber5 == "s5_13")
			 	{sRandom5 = "silvyspellguardmyar";}
			 if(sNumber5 == "s5_14")
			 	{sRandom5 = "silvyspellguardscott";}
			 if(sNumber5 == "s5_15")
			 	{sRandom5 = "silvyspellguardseth";}
			 if(sNumber5 == "s6_1")
			 	{sRandom5 = "003_cr_berronar_traveller";}
			 if(sNumber5 == "s6_2")
			 	{sRandom5 = "003_cr_helm_traveller";}
			 if(sNumber5 == "s6_3")
			 	{sRandom5 = "003_cr_ilmater_traveller";}
			 if(sNumber5 == "s6_4")
			 	{sRandom5 = "003_cr_lathander_traveller";}
			 if(sNumber5 == "s6_5")
			 	{sRandom5 = "003_cr_mielikki_traveller";}
			 if(sNumber5 == "s6_6")
			 	{sRandom5 = "003_cr_redknight_traveller";}
			 if(sNumber5 == "s6_7")
			 	{sRandom5 = "003_cr_selune_traveller";}
			 
			 
			 int nQuantity = Random(5) + 1;
			 if(GetLocalInt(OBJECT_SELF, "Silvy") == 1)
			 	{if(nQuantity >= 1)
					 {object oTraveller = CreateObject(OBJECT_TYPE_CREATURE, sRandom, GetLocation(OBJECT_SELF), FALSE, sTraveller);
					  if(nQuantity >= 2)
					 	{object oTraveller2 = CreateObject(OBJECT_TYPE_CREATURE, sRandom2, GetLocation(OBJECT_SELF), FALSE, sTraveller);
					 	 if(nQuantity >= 3)
					 		{object oTraveller3 = CreateObject(OBJECT_TYPE_CREATURE, sRandom3, GetLocation(OBJECT_SELF), FALSE, sTraveller);
					 		 if(nQuantity >= 4)
					 			{object oTraveller4 = CreateObject(OBJECT_TYPE_CREATURE, sRandom4, GetLocation(OBJECT_SELF), FALSE, sTraveller);
					 			 if(nQuantity >= 5)
					 				{object oTraveller5 = CreateObject(OBJECT_TYPE_CREATURE, sRandom5, GetLocation(OBJECT_SELF), FALSE, sTraveller);
					 				}
								}
							}
						}
					}
			   }
			  else if(GetLocalInt(OBJECT_SELF, "Silvy") == 2)
				{if(nQuantity >= 1)
				   {object oTravellerb = CreateObject(OBJECT_TYPE_CREATURE, sRandom, GetLocation(OBJECT_SELF), FALSE, sTravellerb);
					if(nQuantity >= 2)
					 	{object oTravellerb2 = CreateObject(OBJECT_TYPE_CREATURE, sRandom2, GetLocation(OBJECT_SELF), FALSE, sTravellerb);
					 	 if(nQuantity >= 3)
					 		{object oTravellerb3 = CreateObject(OBJECT_TYPE_CREATURE, sRandom3, GetLocation(OBJECT_SELF), FALSE, sTravellerb);
					 		 if(nQuantity >= 4)
					 			{object oTravellerb4 = CreateObject(OBJECT_TYPE_CREATURE, sRandom4, GetLocation(OBJECT_SELF), FALSE, sTravellerb);
					 			 if(nQuantity >= 5)
					 				{object oTravellerb5 = CreateObject(OBJECT_TYPE_CREATURE, sRandom5, GetLocation(OBJECT_SELF), FALSE, sTravellerb);
					 				}
								}
							}
						}
					}
				  }
			else if(GetLocalInt(OBJECT_SELF, "Rivermoot") == 1)
				{if(nQuantity >= 1)
				   {object oTraveller = CreateObject(OBJECT_TYPE_CREATURE, sRandom, GetLocation(OBJECT_SELF), FALSE, sTravellerRM);
					if(nQuantity >= 2)
					 	{object oTraveller2 = CreateObject(OBJECT_TYPE_CREATURE, sRandom2, GetLocation(OBJECT_SELF), FALSE, sTravellerRM);
					 	 if(nQuantity >= 3)
					 		{object oTraveller3 = CreateObject(OBJECT_TYPE_CREATURE, sRandom3, GetLocation(OBJECT_SELF), FALSE, sTravellerRM);
					 		 if(nQuantity >= 4)
					 			{object oTraveller4 = CreateObject(OBJECT_TYPE_CREATURE, sRandom4, GetLocation(OBJECT_SELF), FALSE, sTravellerRM);
					 			 if(nQuantity >= 5)
					 				{object oTraveller5 = CreateObject(OBJECT_TYPE_CREATURE, sRandom5, GetLocation(OBJECT_SELF), FALSE, sTravellerRM);
					 				}
								}
							}
						}
					}
				  }
		    	else if(GetLocalInt(OBJECT_SELF, "HighHold") == 1)
				{if(nQuantity >= 1)
				   {object oTraveller = CreateObject(OBJECT_TYPE_CREATURE, sRandom, GetLocation(OBJECT_SELF), FALSE, sTravellerHH);
					if(nQuantity >= 2)
					 	{object oTraveller2 = CreateObject(OBJECT_TYPE_CREATURE, sRandom2, GetLocation(OBJECT_SELF), FALSE, sTravellerHH);
					 	 if(nQuantity >= 3)
					 		{object oTraveller3 = CreateObject(OBJECT_TYPE_CREATURE, sRandom3, GetLocation(OBJECT_SELF), FALSE, sTravellerHH);
					 		 if(nQuantity >= 4)
					 			{object oTraveller4 = CreateObject(OBJECT_TYPE_CREATURE, sRandom4, GetLocation(OBJECT_SELF), FALSE, sTravellerHH);
					 			 if(nQuantity >= 5)
					 				{object oTraveller5 = CreateObject(OBJECT_TYPE_CREATURE, sRandom5, GetLocation(OBJECT_SELF), FALSE, sTravellerHH);
					 				}
								}
							}
						}
					}
				  }
			
	}
}