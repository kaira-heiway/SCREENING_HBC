page 58028 "Ortec & KStore Interface Setup"
{
    // Heilite Navision Old Id - 50324

    // version HEI.06

    // HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new page
    // HEI.02 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new field "Exclude Doc. Subtype Code"
    // HEI.03 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Route Administrator group created,
    //                                               Fields added to group,
    //                                               Code added to Customer Account Group - OnLookup func.
    // HEI.04 FDD-LC-HT736 IBM.GUNERE01 21.11.2019 # code added to "Inventory Location Code" - OnLookup func.
    // HEI.05 CHG2182881 IBM SOICAD02 22.11.2022 Fix for wrong VAT calculation
    //   # Added fields
    //     Def. VAT Bus Pst Group (Dom)
    //     Def. VAT Bus Pst Group (For)
    //     Def. VAT Prod Pst Group
    //   # Fix for init of the page
    // HEI.06 CHG2211138 IBM.COSTES04 27.09.2023 # Modification to St Lucia HL to RA Discounts
    //   # Add field RA Previous Days to Export, "RA Ending Date Previous Days"

    Caption = 'Ortec & KStore & RA Interface Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Ortec & KStore Interf. Stp INT";
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    ApplicationArea = All;  // BC Upgrade NANDIS03
    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Ortec Interface';
                field("SO Update Interface"; Rec."SO Update Interface")
                {
                    ToolTip = 'Specifies the value of the SO Update Interface field.';
                }
                field("Default Route"; Rec."Default Route")
                {
                    ToolTip = 'Specifies the value of the Default Route field.';
                }
                field("Exclude Doc. Subtype Code"; Rec."Exclude Doc. Subtype Code")
                {
                    ToolTip = 'Specifies the value of the Exclude Doc. Subtype Code field.';
                }
            }
            group("KStore Interface")
            {
                Caption = 'KStore Interface';
                group(Import)
                {
                    Caption = 'Import';
                    field("SO/SRO Interface Request"; Rec."SO/SRO Interface Request")
                    {
                        ToolTip = 'Specifies the value of the SO/SRO Interface Request field.';
                    }
                    field("SO/SRO Interface Response"; Rec."SO/SRO Interface Response")
                    {
                        ToolTip = 'Specifies the value of the SO/SRO Interface Response field.';
                    }
                    field("Sales Order Prefix"; Rec."Sales Order Prefix")
                    {
                        ToolTip = 'Specifies the value of the Sales Order Prefix field.';
                    }
                    field("Sales Return Order Prefix"; Rec."Sales Return Order Prefix")
                    {
                        ToolTip = 'Specifies the value of the Sales Return Order Prefix field.';
                    }
                    field("Payment Prefix"; Rec."Payment Prefix")
                    {
                        ToolTip = 'Specifies the value of the Payment Prefix field.';
                    }
                }
            }
            group("Route Administrator")
            {
                Caption = 'Route Administrator';
                field("RA SO/SRO Interface Request"; Rec."RA SO/SRO Interface Request")
                {
                    ToolTip = 'Specifies the value of the Route Adm. SO/SRO Interface Request field.';
                }
                field("RA SO/SRO Interface Response"; Rec."RA SO/SRO Interface Response")
                {
                    ToolTip = 'Specifies the value of the Route Adm. SO/SRO Interface Response field.';
                }
                field("RA Payment/Refund Request"; Rec."RA Payment/Refund Request")
                {
                    Caption = 'Route Adm. Payment/Refund Request';
                    ToolTip = 'Specifies the value of the Route Adm. Payment/Refund Request field.';
                }
                field("RA Payment/Refund Response"; Rec."RA Payment/Refund Response")
                {
                    Caption = 'Route Adm. Payment/Refund Response';
                    ToolTip = 'Specifies the value of the Route Adm. Payment/Refund Response field.';
                }
                field("<RA Sales Order Prefix>"; Rec."Sales Order Prefix")
                {
                    Caption = 'Route Adm. Sales Order Prefix';
                    ToolTip = 'Specifies the value of the Route Adm. Sales Order Prefix field.';
                }
                field("<RA Sales Return Order Prefix>"; Rec."Sales Return Order Prefix")
                {
                    Caption = 'Route Adm. Sales Return Order Prefix';
                    ToolTip = 'Specifies the value of the Route Adm. Sales Return Order Prefix field.';
                }
                field("<RA Payment Prefix>"; Rec."Payment Prefix")
                {
                    Caption = 'Route Adm. Payment Prefix';
                    ToolTip = 'Specifies the value of the Route Adm. Payment Prefix field.';
                }
                field("Refund Prefix"; Rec."Refund Prefix")
                {
                    Caption = 'Route Adm. Refund Prefix';
                    ToolTip = 'Specifies the value of the Route Adm. Refund Prefix field.';
                }
                field("RA Previous Days to Export"; Rec."RA Previous Days to Export")
                {
                    ToolTip = 'Previous no. of days to export data in route administrator discount interface.';
                }
                field("RA Ending Date Previous Days"; Rec."RA Ending Date Previous Days")
                {
                    ToolTip = 'Specifies the value of the Route Adm. Ending Date Previous Days field.';
                }
                // BC Upgrade SHUKLP03 >> Added field for RA Payment Refund Request

                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ToolTip = 'Specifies the value of the Route Adm. Payment Bal. Account No. field.';
                }
                // BC Upgrade SHUKLP03 << Added field for RA Payment Refund Request

            }
            group("General Export")
            {
                Caption = 'General Export';
                field("Customer Account Group"; Rec."Customer Account Group")
                {
                    ToolTip = 'Specifies the value of the Customer Account Group field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    begin
                        //>> HEI.03
                        CLEAR(AccountGroups);
                        AccountGroups.LOOKUPMODE(true);
                        if not (AccountGroups.RUNMODAL() = ACTION::LookupOK) then
                            exit(false);

                        Text := AccountGroups.GetSelectionFilter();
                        exit(true);
                        //<< HEI.03
                    end;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    begin
                        CLEAR(ItemCategories);
                        ItemCategories.LOOKUPMODE(true);
                        if not (ItemCategories.RUNMODAL() = ACTION::LookupOK) then
                            exit(false);

                        Text := ItemCategories.GetSelectionFilter();
                        exit(true);
                    end;
                }
                field("Item Charge Type"; Rec."Item Charge Type")
                {
                    ToolTip = 'Specifies the value of the Item Charge Type field.';
                }
                field("Primary Pack Type Attribute ID"; Rec."Primary Pack Type Attribute ID")
                {
                    ToolTip = 'Specifies the value of the Primary Pack Type Attribute ID field.';
                }
                field("Inventory Location Code"; Rec."Inventory Location Code")
                {
                    ToolTip = 'Specifies the value of the Inventory Location Code field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    begin
                        //>> HEI.04
                        CLEAR(LocationList);
                        LocationList.LOOKUPMODE(true);
                        if not (LocationList.RUNMODAL() = ACTION::LookupOK) then
                            exit(false);

                        Text := LocationList.GetSelectionFilter();
                        exit(true);
                        //<< HEI.04
                    end;
                }
                field("Customer Price Group Code"; Rec."Customer Price Group Code")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group Code field.';
                }
                field("RA SO G/L Account Difference"; Rec."RA SO G/L Account Difference")
                {
                    ToolTip = 'Specifies the value of the Sales Order g/l account difference field.';
                }
                field("Max Order Difference Amt."; Rec."Max Order Difference Amt.")
                {
                    ToolTip = 'Specifies the value of the Max. Order Difference Amount (LCY) field.';
                }
            }
            group("VAT Calculation")
            {
                Caption = 'VAT Calculation';
                field("Def. VAT Bus Pst Group (Dom)"; Rec."Def. VAT Bus Pst Group (Dom)")
                {
                    ToolTip = 'Specifies the value of the Default VAT Bus Posting Group - Domestic field.';
                }
                field("Def. VAT Bus Pst Group (For)"; Rec."Def. VAT Bus Pst Group (For)")
                {
                    ToolTip = 'Specifies the value of the Default VAT Bus Posting Group - Foreign field.';
                }
                field("Def. VAT Prod Pst Group"; Rec."Def. VAT Prod Pst Group")
                {
                    ToolTip = 'Specifies the value of the Default VAT Prod Posting Group field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        //HEI.05>>
        Rec.RESET();
        if not Rec.GET() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
        //HEI.05<<
    end;

    var
        ItemCategories: Page "Item Categories";
        //DocumentSubtypeCodes: Page "Document Subtype Codes";  // BC Upgrade NANDIS03 - Dependency on APtean
        AccountGroups: Page "Account Group List";
        LocationList: Page "Location List";
}

