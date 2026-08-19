page 58076 "Zycus Interface Setup"
{
    // Heilite Navision Old Id - 50650

    // version HEI.19

    // HEI.01 CHG2210794 SAHAL01 07.12.2023 Zycus - BASE HL Integration Master Dimension
    //   # Created New Page: 50650 - Zycus Interface Setup
    // HEI.02 CHG2210794 SAHAL01 06.02.2024 Zycus - BASE HL Integration Master Dimension
    //   # Added New Fields - Starting Date-Time for CCC
    //                      - Last Zycus CCC Error Date-Time
    //                      - Starting Date-Time for WBN
    //                      - Last Zycus WBN Error Date-Time
    //   # Removed Fixed Assets (CONCAT) Interface functionality due to descope
    // HEI.03 CHG2210794 MAJUMS03 22.01.2024 Zycus - BASE HL Integration Master Vendor and GL Account. (*RLPPD)
    //   # New Groups - Vendor Interface and Account Interface created, Fields added.
    // HEI.04 CHG2210794 SAHAL01 27.02.2024 Zycus - BASE HL Integration Master Dimension
    //   # Added New Fields - Activate PO Interface
    //                      - Zycus PO Creation Interface
    //                      - Zycus PO Confirmatio Interface
    //                      - Zycus Create Action Code
    //                      - Zycus Update Action Code
    //                      - Zycus Cancellation Action Code
    // HEI.05 CHG2210794 MAJUMS03 21.03.2024 Zycus - BASE HL Integration Master Vendor and GL Account.
    //   # Fields added - "Last Interface Run Time Vendor" under Vendor Interface Group and "Last Interface Run Time GL Acc"
    //   under Account Interface Group.
    // HEI.06 CHG2210794 SAHAL01 28.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Action: 55047 - Zycus Dim. Value Mapping
    // HEI.07 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus PO CCC Dimention Code
    //                      - Zycus PO CONCAT Dimention Code
    //                      - Zycus Normal PO Code
    //                      - Zycus Limit PO Code
    //   # Created New Action: 55052 - Zycus PO Line Type Mapping
    // HEI.08 CHG2210794 SAHAL01 22.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Field - Zycus PO CMG Dimention Code
    // HEI.09 CHG2210794 SAHAL01 26.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - HeiLite Business System ID
    //                      - Zycus Business System ID
    // HEI.10 CHG2210794 SAHAL01 30.04.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Activate GR Interface
    //                      - Zycus GR Creation Interface
    //                      - Zycus GR Confirmatio Interface
    //                      - Zycus GR Cancel Interface
    //                      - Zycus GR Cancel Conf Interface
    //                      - Zycus LPO GR CreationInterface
    //                      - Zycus LPO GR Conf Interface
    //                      - Zycus LPO GR Cancel Interface
    //                      - Zycus LPO GR CanlConfInterface
    //                      - Zycus GR CreationMovement Type
    //                      - Zycus GR Cancel Movement Type
    //                      - Zycus RD CreationMovement Type
    //                      - Zycus RD Cancel Movement Type
    // HEI.11 CHG2210794 VERMAA03 14.06.2024 Zycus - BASE Integration with POSM GR
    //   # Added New Fields - Activate POSM GR Interface
    //                      - POSM GR Creation Interface
    //                      - POSM GR Confirmation Interface
    //                      - POSM GR Creation Movement Type
    //                      - POSM GR Cancel Movement Type
    // HEI.12 CHG2210794 MAJUMS03 06.06.2024 Zycus - BASE HL Integration - CMG Rule Map.
    //   # New Groups - GL Rule Map Interface and Fields added.
    // HEI.14 CHG2278614 SHARMP16 06.03.2025 E2E test for Zycus HL integration - G/L Rule map- Development finetuning
    //   # Add new action on Page: Zycus GL Rule Map
    //   # Add new action on Page: Generate Zycus GL Rule Map
    // HEI.15 CHG2278614 SHARMP16 07.03.2025 E2E test for Zycus HL integration - G/L Rule map- Development finetuning
    //   # Add message and error on action : Generate Zycus GL Rule Map
    // HEI.19 CHG2313281 SAHAL01 23.07.2025 Zycus - CMG Dimension Check
    //   # Added New Field - Exclude Dimension Matching
    // BC Upgrade MISHRS14 >> 
    // # "Exclude Dimension Matching" field was blocked --Added that field again as it was updated in Table
    // # Unblocked code in Action - "Generate Zycus GL Rule Map" as the CodeUnit "Zycus Interface Auto Outbound" is compiled
    // # Unblocked Global variable "ZycusInterfaceAutoOutbound" as the CodeUnit "Zycus Interface Auto Outbound" is compiled
    // BC Upgrade MISHRS14 <<

    Caption = 'Zycus Interface Setup';
    PageType = Card;
    SourceTable = "Zycus Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group("Zycus Interface Integration")
            {
                Caption = 'Zycus Interface Integration';
                field("Enabled Zycus Integration"; Rec."Enabled Zycus Integration")
                {
                    ToolTip = 'Specifies the value of the Enabled Zycus Integration field.';
                }
                field("HeiLite Business System ID"; Rec."HeiLite Business System ID")
                {
                    ToolTip = 'Specifies the value of the HeiLite Business System ID field.';
                }
                field("Zycus Business System ID"; Rec."Zycus Business System ID")
                {
                    ToolTip = 'Specifies the value of the Zycus Business System ID field.';
                }
                field("Last Modified By User"; Rec."Last Modified By User")
                {
                    ToolTip = 'Specifies the value of the Last Modified By User field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    ToolTip = 'Specifies the value of the Last Time Modified field.';
                }
            }
            group("Dimension Interface")
            {
                Caption = 'Dimension Interface';
                field("Activate CCC Interface"; Rec."Activate CCC Interface")
                {
                    ToolTip = 'Specifies the value of the Activate CCC Interface field.';
                }
                field("Zycus CCC Object Type"; Rec."Zycus CCC Object Type")
                {
                    ToolTip = 'Specifies the value of the Zycus CCC Object Type field.';
                }
                field("Zycus CCC Interface"; Rec."Zycus CCC Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus CCC Interface field.';
                }
                field("Starting Date-Time for CCC"; Rec."Starting Date-Time for CCC")
                {
                    ToolTip = 'Specifies the value of the Starting Date-Time for CCC field.';
                }
                field("Max No. of Records for CCC"; Rec."Max No. of Records for CCC")
                {
                    ToolTip = 'Specifies the value of the Max No. of Records for CCC field.';
                }
                field("Last Zycus CCC Park Date-Time"; Rec."Last Zycus CCC Park Date-Time")
                {
                    ToolTip = 'Specifies the value of the Last Zycus CCC Park Date-Time field.';
                }
                field("Last Zycus CCC Error Date-Time"; Rec."Last Zycus CCC Error Date-Time")
                {
                    ToolTip = 'Specifies the value of the Last Zycus CCC Error Date-Time field.';
                }
                field("Last Zycus CCC in Error"; Rec."Last Zycus CCC in Error")
                {
                    ToolTip = 'Specifies the value of the Last Zycus CCC in Error field.';
                }
            }
            group("Project Interface")
            {
                Caption = 'Project Interface';
                field("Activate Project Interface"; Rec."Activate Project Interface")
                {
                    ToolTip = 'Specifies the value of the Activate Project Interface field.';
                }
                field("Zycus Project Object Type"; Rec."Zycus Project Object Type")
                {
                    ToolTip = 'Specifies the value of the Zycus Project Object Type field.';
                }
                field("Zycus WBN Interface"; Rec."Zycus WBN Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus WBN Interface field.';
                }
                field("Starting Date-Time for WBN"; Rec."Starting Date-Time for WBN")
                {
                    ToolTip = 'Specifies the value of the Starting Date-Time for WBN field.';
                }
                field("Max No. of Records for WBN"; Rec."Max No. of Records for WBN")
                {
                    ToolTip = 'Specifies the value of the Max No. of Records for WBN field.';
                }
                field("Last Zycus WBN Park Date-Time"; Rec."Last Zycus WBN Park Date-Time")
                {
                    ToolTip = 'Specifies the value of the Last Zycus WBN Park Date-Time field.';
                }
                field("Last Zycus WBN Error Date-Time"; Rec."Last Zycus WBN Error Date-Time")
                {
                    ToolTip = 'Specifies the value of the Last Zycus WBN Error Date-Time field.';
                }
                field("Last Zycus WBN in Error"; Rec."Last Zycus WBN in Error")
                {
                    ToolTip = 'Specifies the value of the Last Zycus WBN in Error field.';
                }
            }
            group("Vendor Interface")
            {
                field("Activate Vendor Interface"; Rec."Activate Vendor Interface")
                {
                    ToolTip = 'Specifies the value of the Activate Vendor Interface field.';
                }
                field("Zycus Vendor Interface Code"; Rec."Zycus Vendor Interface Code")
                {
                    ToolTip = 'Specifies the value of the Zycus Vendor Interface Code field.';
                }
                field("Vendor Account Group Filter"; Rec."Vendor Account Group Filter")
                {
                    ToolTip = 'Specifies the value of the Vendor Account Group Filter field.';
                }
                field("Last Zycus Vendor Sync Time"; Rec."Last Zycus Vendor Sync Time")
                {
                    ToolTip = 'Specifies the value of the Last Zycus Vendor Sync Time field.';
                }
                field("Max. Vendor Per Interface"; Rec."Max. Vendor Per Interface")
                {
                    ToolTip = 'Specifies the value of the Max. Vendor Per Interface field.';
                }
                field("Last Interface Run Time Vendor"; Rec."Last Interface Run Time Vendor")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Last Interface Run Time Vendor field.';
                }
            }
            group("Account Interface")
            {
                field("Activate Account Interface"; Rec."Activate Account Interface")
                {
                    ToolTip = 'Specifies the value of the Activate Account Interface field.';
                }
                field("Zycus Account Interface Code"; Rec."Zycus Account Interface Code")
                {
                    ToolTip = 'Specifies the value of the Zycus Account Interface Code field.';
                }
                field("Last Zycus Account Sync Time"; Rec."Last Zycus Account Sync Time")
                {
                    ToolTip = 'Specifies the value of the Last Zycus Account Sync Time field.';
                }
                field("Max. Account Per Interface"; Rec."Max. Account Per Interface")
                {
                    ToolTip = 'Specifies the value of the Max.Account Per Interface field.';
                }
                field("G/L Account Position"; Rec."G/L Account Position")
                {
                    ToolTip = 'Specifies the value of the G/L Account Position field.';
                }
                field("G/L Account Position Value"; Rec."G/L Account Position Value")
                {
                    ToolTip = 'Specifies the value of the G/L Account Position Value field.';
                }
                field("Last Interface Run Time GL Acc"; Rec."Last Interface Run Time GL Acc")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Last Interface Run Time GL Acc field.';
                }
            }
            group("Purchase Order Interface")
            {
                Caption = 'Purchase Order Interface';
                field("Activate PO Interface"; Rec."Activate PO Interface")
                {
                    ToolTip = 'Specifies the value of the Activate PO Interface field.';
                }
                field("Zycus PO Creation Interface"; Rec."Zycus PO Creation Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus PO Creation Interface field.';
                }
                field("Zycus PO Confirmatio Interface"; Rec."Zycus PO Confirmatio Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus PO Confirmation Interface field.';
                }
                field("Zycus PO CCC Dimention Code"; Rec."Zycus PO CCC Dimention Code")
                {
                    ToolTip = 'Specifies the value of the Zycus PO CCC Dimention Code field.';
                }
                field("Zycus PO CONCAT Dimention Code"; Rec."Zycus PO CONCAT Dimention Code")
                {
                    ToolTip = 'Specifies the value of the Zycus PO CONCAT Dimention Code field.';
                }
                field("Zycus PO CMG Dimention Code"; Rec."Zycus PO CMG Dimention Code")
                {
                    ToolTip = 'Specifies the value of the Zycus PO CMG Dimention Code field.';
                }
                field("Zycus Create Action Code"; Rec."Zycus Create Action Code")
                {
                    ToolTip = 'Specifies the value of the Zycus Create Action Code field.';
                }
                field("Zycus Update Action Code"; Rec."Zycus Update Action Code")
                {
                    ToolTip = 'Specifies the value of the Zycus Update Action Code field.';
                }
                field("Zycus Cancellation Action Code"; Rec."Zycus Cancellation Action Code")
                {
                    ToolTip = 'Specifies the value of the Zycus Cancellation Action Code field.';
                }
                field("Zycus Normal PO Code"; Rec."Zycus Normal PO Code")
                {
                    ToolTip = 'Specifies the value of the Zycus Normal PO Code field.';
                }
                field("Zycus Limit PO Code"; Rec."Zycus Limit PO Code")
                {
                    ToolTip = 'Specifies the value of the Zycus Limit PO Code field.';
                }
                field("Exclude Dimension Matching"; Rec."Exclude Dimension Matching")  // BC Upgrade MISHRS14 - Added this "Exclude Dimension Matching" field which is now available in table
                {
                }
            }
            group("Goods Receipt & Return Interface")
            {
                Caption = 'PO Goods Receipt & Return Interface';
                field("Activate GR Interface"; Rec."Activate GR Interface")
                {
                    ToolTip = 'Specifies the value of the Activate GR Interface field.';
                }
                field("Zycus GR Creation Interface"; Rec."Zycus GR Creation Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus GR Creation Interface field.';
                }
                field("Zycus GR Confirmatio Interface"; Rec."Zycus GR Confirmatio Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus GR Confirmation Interface field.';
                }
                field("Zycus GR Cancel Interface"; Rec."Zycus GR Cancel Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus GR Cancellation Interface field.';
                }
                field("Zycus GR Cancel Conf Interface"; Rec."Zycus GR Cancel Conf Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus GR Cancel Confirmation Interface field.';
                }
                field("Zycus LPO GR CreationInterface"; Rec."Zycus LPO GR CreationInterface")
                {
                    ToolTip = 'Specifies the value of the Zycus Limit PO GR Creation Interface field.';
                }
                field("Zycus LPO GR Conf Interface"; Rec."Zycus LPO GR Conf Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus Limit PO GR Confirmation Interface field.';
                }
                field("Zycus LPO GR Cancel Interface"; Rec."Zycus LPO GR Cancel Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus Limit PO GR Cancellation Interface field.';
                }
                field("Zycus LPO GR CanlConfInterface"; Rec."Zycus LPO GR CanlConfInterface")
                {
                    ToolTip = 'Specifies the value of the Zycus Limit PO GR Cancel Confirmation Interface field.';
                }
                field("Zycus GR CreationMovement Type"; Rec."Zycus GR CreationMovement Type")
                {
                    ToolTip = 'Specifies the value of the Zycus GR Creation Movement Type field.';
                }
                field("Zycus GR Cancel Movement Type"; Rec."Zycus GR Cancel Movement Type")
                {
                    ToolTip = 'Specifies the value of the Zycus GR Cancel Movement Type field.';
                }
                field("Zycus RD CreationMovement Type"; Rec."Zycus RD CreationMovement Type")
                {
                    ToolTip = 'Specifies the value of the Zycus Return Delivery Creation Movement Type field.';
                }
                field("Zycus RD Cancel Movement Type"; Rec."Zycus RD Cancel Movement Type")
                {
                    ToolTip = 'Specifies the value of the Zycus Return Delivery Cancel Movement Type field.';
                }
            }
            group("POSM GR Interface")
            {
                field("Activate POSM GR Interface"; Rec."Activate POSM GR Interface")
                {
                    ToolTip = 'Specifies the value of the Activate POSM GR Interface field.';
                }
                field("POSM GR Creation Interface"; Rec."POSM GR Creation Interface")
                {
                    ToolTip = 'Specifies the value of the POSM GR Creation Interface field.';
                }
                field("POSM GR Confirmation Interface"; Rec."POSM GR Confirmation Interface")
                {
                    ToolTip = 'Specifies the value of the POSM GR Confirmation Interface field.';
                }
                field("POSM GR Creation Movement Type"; Rec."POSM GR Creation Movement Type")
                {
                    ToolTip = 'Specifies the value of the POSM GR Creation Movement Type field.';
                }
                field("POSM GR Cancel Movement Type"; Rec."POSM GR Cancel Movement Type")
                {
                    ToolTip = 'Specifies the value of the POSM GR Cancel Movement Type field.';
                }
            }
            group("GL Rule Map Interface")
            {
                Caption = 'GL Rule Map Interface';
                field("Activate GL Rule Map Interface"; Rec."Activate GL Rule Map Interface")
                {
                    ToolTip = 'Specifies the value of the Activate GL Rule Map Interface field.';
                }
                field("Zycus GL Rule Map Object Type"; Rec."Zycus GL Rule Map Object Type")
                {
                    ToolTip = 'Specifies the value of the Zycus GL Rule Map Object Type field.';
                }
                field("Zycus GL Rule Map Interface"; Rec."Zycus GL Rule Map Interface")
                {
                    ToolTip = 'Specifies the value of the Zycus GL Rule Map Interface field.';
                }
                field("Starting DateTime  GL Rule Map"; Rec."Starting DateTime  GL Rule Map")
                {
                    ToolTip = 'Specifies the value of the Starting DateTime  GL Rule Map field.';
                }
                field("Max. GL Rule Per Interface"; Rec."Max. GL Rule Per Interface")
                {
                    ToolTip = 'Specifies the value of the Max. GL Rule Per Interface field.';
                }
                field("Last Zycus GL Rule Sync Time"; Rec."Last Zycus GL Rule Sync Time")
                {
                    ToolTip = 'Specifies the value of the Last Zycus GL Rule Sync Time field.';
                }
                field("Last Zycus GL Rule Error Time"; Rec."Last Zycus GL Rule Error Time")
                {
                    ToolTip = 'Specifies the value of the Last Zycus GL Rule Error Time field.';
                }
                field("Last Zycus GL Rule in Error"; Rec."Last Zycus GL Rule in Error")
                {
                    ToolTip = 'Specifies the value of the Last Zycus GL Rule in Error field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Zycus Dim. Value Mapping")
            {
                Caption = 'Zycus Dim. Value Mapping';
                Image = MapDimensions;
                RunObject = Page "Zycus Dimension Value Mapping";
                ToolTip = 'Executes the Zycus Dim. Value Mapping action.';
            }
            action("Zycus PO Line Type Mapping")
            {
                Caption = 'Zycus PO Line Type Mapping';
                Image = MapAccounts;
                RunObject = Page "Zycus PO Line Type Mapping";
                ToolTip = 'Executes the Zycus PO Line Type Mapping action.';
            }
            action("Zycus GL Rule Map")
            {
                Caption = 'Zycus GL Rule Map';
                Image = AllLines;
                RunObject = Page "Zycus GL Rule Map";
                ToolTip = 'Executes the Zycus GL Rule Map action.';
            }
            action("Generate Zycus GL Rule Map")
            {
                Caption = 'Generate Zycus GL Rule Map Full Load';
                Image = GetEntries;
                ToolTip = 'Executes the Generate Zycus GL Rule Map Full Load action.';

                trigger OnAction();
                begin
                    //HEI.14>>
                    if Rec."Activate GL Rule Map Interface" then begin

                        // BC Upgrade MISHRS14 >> - CodeUnit "Zycus Interface Auto Outbound" is compiled
                        //HEI.15>>
                        Rec.TESTFIELD("Zycus GL Rule Map Interface");
                        //HEI.15<<
                        ZycusInterfaceAutoOutbound.OnScheduleGLRuleMapCCCCreateOrUpdate_Zycus(false);
                        //HEI.15>>
                        // BC Upgrade MISHRS14 <<

                        MESSAGE(Text001);
                    end else
                        ERROR(Error001);
                    //HEI.15<<
                    //HEI.14<<
                end;
            }
        }
    }
    var
        ZycusInterfaceAutoOutbound: Codeunit "Zycus Interface Auto Outbound";  // BC Upgrade MISHRS14 - Added this Variable because CodeUnit "Zycus Interface Auto Outbound" is compiled 
        Text001: Label 'Zycus GL Rule Map has been generated successfully.';
        Error001: Label 'GL Rule Map setup is not active.';
}





