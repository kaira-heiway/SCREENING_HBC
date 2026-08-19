page 58039 "Legacy Futur Master Int Setup"
{
    // Heilite Navision Old Id - 50374

    // version HEI.04

    // HEI.01 FDD-HT610 IBM NASTAA02 11.12.2019 # La Reunion Futur Master
    //   # New Page created to store Legacy Futur Master Interface Setup
    // HEI.02 CHG2093033 IBM.LS      20.04.2021
    //   # Added New Fields - ELP Unit of Measure
    //                      - ELP Primary Pack Type
    // HEI.03 CHG2113047 HB2232 IBM GAVANM01 20.07.2021 # FM interfaces files
    //   # New field added: Cust. Subtype Tr/Kiosk
    // 
    // HEI.04 IBM SAMANR01 12.05.2023 CHG2204329 Email Validation on JOB Q & Interfaces
    //   # Add code for email validation

    Caption = 'Legacy Futur Master Interface Setup';
    PageType = Card;
    SourceTable = "Legacy Futur Mster Int Stp INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("PUM Unit of Measure"; Rec."PUM Unit of Measure")
                {
                    Caption = 'FuturMaster Unit of Measure';
                    ToolTip = 'Specifies the value of the FuturMaster Unit of Measure field.';
                }
                field("HL Unit of Measure"; Rec."HL Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the HL Unit of Measure field.';
                }
                field("Pallet Unit of Measure"; Rec."Pallet Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Pallet Unit of Measure field.';
                }
                field("Content UoM"; Rec."Content UoM")
                {
                    ToolTip = 'Specifies the value of the Content Unit of Measure field.';
                }
                field("Error E-mail Address"; Rec."Error E-mail Address")
                {
                    ToolTip = 'Specifies the value of the Error E-mail Address field.';

                    trigger OnValidate();
                    var
                        SendEmailConfirmation: Codeunit "Send Email Confirmation CBN";
                    begin
                        //HEI.04>>
                        SendEmailConfirmation.ValidateEmailAddresses(Rec."Error E-mail Address", true);
                    end;
                }
                field("ELP Unit of Measure"; Rec."ELP Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the ELP Unit of Measure field.';
                }
                field("ELP Primary Pack Type"; Rec."ELP Primary Pack Type")
                {
                    ToolTip = 'Specifies the value of the ELP Primary Pack Type field.';
                }
            }
            group("Legacy FM Request Interfaces")
            {
                Caption = 'Legacy FM Request Interfaces';
                field("Client Master Interface Req"; Rec."Client Master Interface Req")
                {
                    ToolTip = 'Specifies the value of the Client Master Interface Request field.';
                }
                field("Actual Sales Daily Exp BB Req"; Rec."Actual Sales Daily Exp BB Req")
                {
                    ToolTip = 'Specifies the value of the Actual Sales Daily Exp BB Request field.';
                }
                field("DRP Stock Export Req"; Rec."DRP Stock Export Req")
                {
                    ToolTip = 'Specifies the value of the DRP Stock Export Request field.';
                }
                field("MPS Stock Export Req"; Rec."MPS Stock Export Req")
                {
                    ToolTip = 'Specifies the value of the MPS Stock Export Request field.';
                }
                field("Actual Sales Weekly Exp BB Req"; Rec."Actual Sales Weekly Exp BB Req")
                {
                    ToolTip = 'Specifies the value of the Actual Sales Weekly Exp BB Request field.';
                }
                field("Actual Sales Monthly Exp BB R"; Rec."Actual Sales Monthly Exp BB R")
                {
                    ToolTip = 'Specifies the value of the Actual Sales Monthly Export BB Request field.';
                }
                field("MRP Stock Export BB Request"; Rec."MRP Stock Export BB Request")
                {
                    ToolTip = 'Specifies the value of the MRP Stock Export BB Request field.';
                }
                field("Purchase Order Export Req"; Rec."Purchase Order Export Req")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Export Request field.';
                }
                field("Product FM Global Req"; Rec."Product FM Global Req")
                {
                    ToolTip = 'Specifies the value of the Product FM Global Request field.';
                }
                field("Customer Discount Req"; Rec."Customer Discount Req")
                {
                    ToolTip = 'Specifies the value of the Customer Discount Request field.';
                }
            }
            group("Legacy FM Export Interfaces")
            {
                Caption = 'Legacy FM Export Interfaces';
                field("Client Master Interface"; Rec."Client Master Interface")
                {
                    ToolTip = 'Specifies the value of the Client Master Interface Export field.';
                }
                field("Actual Sales Daily Exp BB"; Rec."Actual Sales Daily Exp BB")
                {
                    ToolTip = 'Specifies the value of the Actual Sales Daily Export BB field.';
                }
                field("DRP Stock Export"; Rec."DRP Stock Export")
                {
                    ToolTip = 'Specifies the value of the DRP Stock Export field.';
                }
                field("MPS Stock Export"; Rec."MPS Stock Export")
                {
                    ToolTip = 'Specifies the value of the MPS Stock Export field.';
                }
                field("Actual Sales Weekly Exp BB"; Rec."Actual Sales Weekly Exp BB")
                {
                    ToolTip = 'Specifies the value of the Actual Sales Weekly Export BB field.';
                }
                field("Actual Sales Monthly Exp BB"; Rec."Actual Sales Monthly Exp BB")
                {
                    ToolTip = 'Specifies the value of the Actual Sales Monthly Export BB field.';
                }
                field("MRP Stock Export BB Exp"; Rec."MRP Stock Export BB Exp")
                {
                    ToolTip = 'Specifies the value of the MRP Stock Export BB field.';
                }
                field("Purchase Order Export Exp"; Rec."Purchase Order Export Exp")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Export field.';
                }
                field("Product FM Global Exp"; Rec."Product FM Global Exp")
                {
                    ToolTip = 'Specifies the value of the Product FM Global Export field.';
                }
            }
            group("Client Master Setup")
            {
                Caption = 'Client Master Setup';
                field("Filter Dimension 1 Code"; Rec."Filter Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Filter Dimension 1 Code field.';
                }
                field("Filter Dimension 1 Value Code"; Rec."Filter Dimension 1 Value Code")
                {
                    ToolTip = 'Specifies the value of the Filter Dimension 1 Value Code field.';
                }
                field("Filter Dimension 2 Code"; Rec."Filter Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Filter Dimension 2 Code field.';
                }
                field("Filter Dimension 2 Value Code"; Rec."Filter Dimension 2 Value Code")
                {
                    ToolTip = 'Specifies the value of the Filter Dimension 2 Value Code field.';
                }
                field("Account Group Filter"; Rec."Account Group Filter")
                {
                    ToolTip = 'Specifies the value of the Account Group Filter field.';
                }
                field("Customer Subtype Exporter"; Rec."Customer Subtype Exporter")
                {
                    ToolTip = 'Specifies the value of the Customer Subtype Exporter field.';
                }
                field("Cust. Subtype Tr/Kiosk"; Rec."Cust. Subtype Tr/Kiosk")
                {
                    ToolTip = 'Specifies the value of the Customer Subtype Transportation/Kiosk field.';
                }
            }
            group("Actual Sales Daily Export BB")
            {
                Caption = 'Actual Sales Daily Export BB';
                field("Item Category Code Filter"; Rec."Item Category Code Filter")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Location Code Filter"; Rec."Location Code Filter")
                {
                    ToolTip = 'Specifies the value of the Location Code Filter field.';
                }
                field("Bin Filter"; Rec."Bin Filter")
                {
                    ToolTip = 'Specifies the value of the Bin Filter field.';
                }
            }
            group("DRP Stock Export BB")
            {
                Caption = 'DRP Stock Export BB';
                field("Item Category Code Filter2"; Rec."Item Category Code Filter2")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Location Code Filter2"; Rec."Location Code Filter2")
                {
                    ToolTip = 'Specifies the value of the Location Code Filter field.';
                }
                field("Bin Filter2"; Rec."Bin Filter2")
                {
                    ToolTip = 'Specifies the value of the Bin Filter field.';
                }
            }
            group("MPS Stock Export BB")
            {
                Caption = 'MPS Stock Export BB';
                field("Item Category Code Filter3"; Rec."Item Category Code Filter3")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Location Code Filter3"; Rec."Location Code Filter3")
                {
                    ToolTip = 'Specifies the value of the Location Code Filter field.';
                }
                field("Bin Filter3"; Rec."Bin Filter3")
                {
                    ToolTip = 'Specifies the value of the Bin Filter field.';
                }
            }
            group("Actual Sales Weekly Export BB")
            {
                Caption = 'Actual Sales Weekly Export BB';
                field("Item Category Code Filter4"; Rec."Item Category Code Filter4")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Location Code Filter4"; Rec."Location Code Filter4")
                {
                    ToolTip = 'Specifies the value of the Location Code Filter field.';
                }
                field("Bin Filter4"; Rec."Bin Filter4")
                {
                    ToolTip = 'Specifies the value of the Bin Filter field.';
                }
            }
            group("Actual Sales Monthly Export BB")
            {
                Caption = 'Actual Sales Monthly Export BB';
                field("Item Category Code Filter5"; Rec."Item Category Code Filter5")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Location Code Filter5"; Rec."Location Code Filter5")
                {
                    ToolTip = 'Specifies the value of the Location Code Filter field.';
                }
                field("Bin Filter5"; Rec."Bin Filter5")
                {
                    ToolTip = 'Specifies the value of the Bin Filter field.';
                }
            }
            group("MRP Stock Export BB")
            {
                Caption = 'MRP Stock Export BB';
                field("Item Category Code Filter6"; Rec."Item Category Code Filter6")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Location Code Filter6"; Rec."Location Code Filter6")
                {
                    ToolTip = 'Specifies the value of the Location Code Filter field.';
                }
                field("Bin Filter6"; Rec."Bin Filter6")
                {
                    ToolTip = 'Specifies the value of the Bin Filter field.';
                }
            }
            group("Purchase Order Export")
            {
                Caption = 'Purchase Order Export';
                field("Item Category Code Filter7"; Rec."Item Category Code Filter7")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Location Code Filter7"; Rec."Location Code Filter7")
                {
                    ToolTip = 'Specifies the value of the Location Code Filter field.';
                }
                field("Age of Plan Rcpt Days"; Rec."Age of Plan Rcpt Days")
                {
                    ToolTip = 'Specifies the value of the Age of Planned Receipt in Days field.';
                }
            }
            group("Product FM Global")
            {
                Caption = 'Product FM Global';
                field("Item Category Code Filter8"; Rec."Item Category Code Filter8")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Location Code Filter8"; Rec."Location Code Filter8")
                {
                    ToolTip = 'Specifies the value of the Location Code Filter field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Legacy Futur Master Discount Charges")
            {
                Caption = 'Legacy Futur Master Discount Charges';
                Image = Discount;
                RunObject = Page "FM Discount Charges";
                ToolTip = 'Executes the Legacy Futur Master Discount Charges action.';
            }
        }
    }
}

