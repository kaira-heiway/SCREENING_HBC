page 51045 "General OpCo Setup CBN"
{
    // version HEI.21

    // HEI.01 FDD-AL-GAPLOG05 IBM NASTAA02 29.09.2017 # Unloading Note template for Algeria
    //   # New field created to store the Report ID which will be used for Unloading Note in Sales Return Order
    // HEI.02 FDD-PTPGAP072 IBM NASTAA02 31.01.2017 # Cashier Order Creation
    //   # New field added "Cashier Order Report ID"
    // HEI.03 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Group added: General
    //   # New Field added: Enable Request Order
    // HEI.04 FDD-BA-PRDGAP01 IBM POSTOI01 12.07.2018
    //   # show new field Spare Part Consumption
    // 
    // HEI.05 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM NAIKH01 11.10.2018
    //   # Added new Field "BRC Location Code" on Page
    // 
    // HEI.06 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM NAIKH01 16.10.2018
    //   # Added new Field "Local Vendor type" and "Item Category"
    // HEI.09 FDD BA-PTPGAP03 IBM NASTAA02 04.02.2019 # Digital Checks Printout
    //   # New Field added: "Enable Digital Check Printout"
    // HEI.10 BRD HT434 IBM GAVANM01 21.06.2019
    //   # New Field added: Deposit% on the net price
    // HEI.11 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field added: "Enable Send to Maraki"
    // HEI.12 FDD-HT915 IBM NASTAA02 27.09.2019 # OtC Billing – Invoice Layout local requirements for Domestic Invoice/Credit Memo/Sundry, and Export Invoice
    //   # New Fields added
    // HEI.14 FDD-HT1139A IBM NASTAA02 12.05.2020 # DRC - BVM Interface
    //   # New Field added: "Enable BVM Integration"
    // HEI.15 CHG2085435 IBM GAVANM01 25.11.2020 - HT1773 Sales documents layout
    //   # new field added: Currency 3
    // HEI.16 CHG2135905 IBM BHATTA09 07.01.2022 # HB2663 Payment remittance advice – French translation
    //   # New field added: French Payment Remittance
    //   # New field added: Payment Remittance Language
    // HEI.17 CHG2171687 IBM SISUM01 15/03/2023 #add new field for filter pattern on EBF Matrix
    //   #display SCOA Financial Dimension from Warehouse Setup table
    // HEI.18 CHG2171687 IBM SISUM01 19/05/2023 HB3907 EBF Matrix
    //   #add new field with Id 128 to Group General
    // HEI.19 IBM YADAVM09 12/10/23 CHG2218600_HB3954 DRC Interredional transfer exclusion from WIS MSV
    // #Added new field Exclude Interreg. WIS and MSV
    // HEI.20 CHG2171687 IBM SISUM01 22/11/2023 HB3907 EBF Matrix
    //   #add new field to skip validation of dimension value when the EBF Matrix Setup is updated/created - Id 130
    // HEI.21 CHG2244079 IBM VERMAA03 13.06.2024 HB3802 Remittance advice – Spanish translation
    //   # New field added: Spanish Payment Remittance
    //   # New field added: Payment Remittance Language Spanish
    //   # Added code on French Payment Remittance - OnValidate()
    //   # Added code on Spanish Payment Remittance - OnValidate()
    //   # Added Text Constants - Text0001
    //   # Added Text Constants - Text0002

    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Page: General OpCo Setup (50158)
    // Changes:
    // 1. Added ApplicationArea = All property to page level 
    // 2. Added UsageCategory = Documents property 
    // 3. Added ApplicationArea = All to ALL fields across all groups
    // 4. Remove Interface related fields and add those fields in New page extenion
    // BC Upgrade BHARDA11 <<

    // BC Upgrade MISHRS14 >>
    // Changed group name RoleCenter because this is area type, this will cause error in Future
    // BC Upgrade MISHRS14 <<

    SourceTable = "General OpCo Setup FND";
    ApplicationArea = All; // BC Upgrade BHARDA11
    UsageCategory = Documents; // BC Upgrade BHARDA11

    layout
    {
        area(content)
        {
            group("<Control55008>")
            {
                CaptionML = ENU = 'General',
                            FRA = 'Général';
                field("Enable Request Order"; Rec."Enable Request Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable Request Order field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Enable Request Order field.';

                }
                field("Spare Part Consumption"; Rec."Spare Part Consumption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Spare Part Consumption field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Spare Part Consumption field.';

                }
                field("Enable Digital Check Printout"; Rec."Enable Digital Check Printout")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable Digital Check Printout field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Enable Digital Check Printout field.';

                }
                field("Deposit% on the net price"; Rec."Deposit% on the net price")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Caption = 'Deposit% on the net price in Sales Invoice';
                    ToolTip = 'Specifies the value of the Deposit% on the net price in Sales Invoice field.';
                }
                field("Enable Send to Maraki"; Rec."Enable Send to Maraki")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable Send to Maraki field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Enable Send to Maraki field.';

                }
                field("Enable BVM Integration"; Rec."Enable BVM Integration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable BVM Integration field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Enable BVM Integration field.';

                }

                field("French Payment Remittance"; Rec."French Payment Remittance")
                {
                    ToolTip = 'Specifies the value of the French Payment Remittance field.';

                    trigger OnValidate();
                    begin
                        //HEI.21>>
                        if Rec."Spanish Payment Remittance" then
                            ERROR(Text0001);
                        //HEI.21<<
                    end;
                }
                field("Payment Remittance Language"; Rec."Payment Remittance Language")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Remittance Language field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Payment Remittance Language field.';

                }
                field("Enable New EBF Matrix Version"; Rec."Enable New EBF Matrix Version")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable New EBF Matrix Version field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Enable New EBF Matrix Version field.';

                }
                field("Validate Dimension Value (EBF)"; Rec."Validate Dimension Value (EBF)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Validate Dimension Value (EBF) field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Validate Dimension Value (EBF) field.';

                }
                field("Exclude Interreg. WIS and MSV"; Rec."Exclude Interreg. WIS and MSV")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Caption = 'Exclude Interreg. WIS and MSV';
                    ToolTip = 'Specifies the value of the Exclude Interreg. WIS and MSV field.';
                }
                field("Spanish Payment Remittance"; Rec."Spanish Payment Remittance")
                {
                    ToolTip = 'Specifies the value of the Spanish Payment Remittance field.';

                    trigger OnValidate();
                    begin
                        //HEI.21>>
                        if Rec."French Payment Remittance" then
                            ERROR(Text0002);
                        //HEI.21<<
                    end;
                }
                field("Payment Remittance Language Sp"; Rec."Payment Remittance Language Sp")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Caption = 'Payment Remittance Language Spanish';
                    ToolTip = 'Specifies the value of the Payment Remittance Language Spanish field.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                field("Payroll Report ID"; Rec."Payroll Report ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Report ID field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Payroll Report ID field.';

                }
                field("Unloading Note Report ID"; Rec."Unloading Note Report ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unloading Note Report ID field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Unloading Note Report ID field.';

                }
                field("Gen. Journal Template"; Rec."Gen. Journal Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Gen. Journal Template field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Payroll Gen. Journal Template field.';

                }
                field("Gen. Journal Batch"; Rec."Gen. Journal Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Gen. Journal Batch field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Payroll Gen. Journal Batch field.';

                }
                field("Export Path"; Rec."Export Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Export Path field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Export Path field.';

                }
            }

            // BC Upgrade MISHRS14 >>
            // Changed group name RoleCenter because this is area type, this will cause error in Future
            //group(RoleCenter)
            group(RoleCenterGroup)
            {
                // Caption = 'RoleCenter';
                Caption = 'RoleCenterGroup';
                // BC Upgrade MISHRS14 <<

                field("RC Location Code"; Rec."RC Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RC Location Code field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the RC Location Code field.';

                }
                field("RC Brewing Zone code"; Rec."RC Brewing Zone code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RC Brewing Zone code field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the RC Brewing Zone code field.';

                }
                field("RC F&Mat Zone Code"; Rec."RC F&Mat Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RC F&Mat Zone Code field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the RC F&Mat Zone Code field.';

                }
                field("RC F&Mix Zone Code"; Rec."RC F&Mix Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RC F&Mix Zone Code field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the RC F&Mix Zone Code field.';

                }
                field("RC Packaging Zone Code"; Rec."RC Packaging Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RC Packaging Zone Code field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the RC Packaging Zone Code field.';

                }
            }
            group(Dimensions)
            {
                Caption = 'Dimensions';
                field("Employee Payroll Dimension"; Rec."Employee Payroll Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Payroll Dimension field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Employee Payroll Dimension field.';

                }
                field("EBF SCOA Range Start Position"; Rec."EBF SCOA Range Start Position")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EBF SCOA Range Start Position field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the EBF SCOA Range Start Position field.';

                }
                field("EBF SCOA Range Digit Nos."; Rec."EBF SCOA Range Digit Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EBF SCOA Range Digit Nos. field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the EBF SCOA Range Digit Nos. field.';

                }
                field("EBF Dim Filter Start Position"; Rec."EBF Dim Filter Start Position")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EBF Dim Filter Start Position field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the EBF Dim Filter Start Position field.';

                }
                field("EBF Dim Filter Digit Nos."; Rec."EBF Dim Filter Digit Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EBF Dim Filter Digit Nos. field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the EBF Dim Filter Digit Nos. field.';

                }
                field("EBF Operator Filter"; Rec."EBF Operator Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EBF Operator Filter field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the EBF Operator Filter field.';

                }
                field(FinancialStatement; FinancialStatement)
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Caption = 'SCOA Financial Statement';
                    Editable = false;
                    ToolTip = 'Specifies the value of the SCOA Financial Statement field.';
                }
            }
            group(BRC)
            {
                Caption = 'BRC';
                field("BRC Location Code"; Rec."BRC Location Code")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Caption = 'Location Code';
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Local Vendor type"; Rec."Local Vendor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Local Vendor type field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Local Vendor type field.';

                }
                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Item Category field.';

                }
            }
            group("Payments 3")
            {
                CaptionML = ENU = 'Payments 3',
                            FRA = 'Paiements 2';
                Description = 'FINXL7.00.001';
                field("Bank Name 3"; Rec."Bank Name 3")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the Bank Name 3 field.';
                }
                field("Bank Account No. 3"; Rec."Bank Account No. 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Account No. 3 field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Bank Account No. 3 field.';

                }
                field("IBAN 3"; Rec."IBAN 3")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the IBAN 3 field.';
                }
                field("SWIFT Code 3"; Rec."SWIFT Code 3")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the SWIFT Code 3 field.';
                }
                field("Report Invoice Type 3"; Rec."Report Invoice Type 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report Invoice Type 3 field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Report Invoice Type 3 field.';

                }
                field("Currency 3"; Rec."Currency 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency 3 field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Currency 3 field.';

                }
            }
            group("Payments 4")
            {
                CaptionML = ENU = 'Payments 4',
                            FRA = 'Paiements 2';
                Description = 'FINXL7.00.001';
                field("Bank Name 4"; Rec."Bank Name 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name 4 field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Bank Name 4 field.';

                }
                field("Bank Account No. 4"; Rec."Bank Account No. 4")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the Bank Account No. 4 field.';
                }
                field("IBAN 4"; Rec."IBAN 4")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the IBAN 4 field.';
                }
                field("SWIFT Code 4"; Rec."SWIFT Code 4")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the SWIFT Code 4 field.';
                }
                field("Report Invoice Type 4"; Rec."Report Invoice Type 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report Invoice Type 4 field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Report Invoice Type 4 field.';

                }
            }
            group("Payments 5")
            {
                CaptionML = ENU = 'Payments 5',
                            FRA = 'Paiements 2';
                Description = 'FINXL7.00.001';
                field("Bank Name 5"; Rec."Bank Name 5")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the Bank Name 5 field.';
                }
                field("Bank Account No. 5"; Rec."Bank Account No. 5")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the Bank Account No. 5 field.';
                }
                field("IBAN 5"; Rec."IBAN 5")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the IBAN 5 field.';
                }
                field("SWIFT Code 5"; Rec."SWIFT Code 5")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the SWIFT Code 5 field.';
                }
                field("Report Invoice Type 5"; Rec."Report Invoice Type 5")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report Invoice Type 5 field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Report Invoice Type 5 field.';

                }
            }
            group("Payments 6")
            {
                CaptionML = ENU = 'Payments 6',
                            FRA = 'Paiements 2';
                Description = 'FINXL7.00.001';
                field("Bank Name 6"; Rec."Bank Name 6")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the Bank Name 6 field.';
                }
                field("Bank Account No. 6"; Rec."Bank Account No. 6")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the Bank Account No. 6 field.';
                }
                field("IBAN 6"; Rec."IBAN 6")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the IBAN 6 field.';
                }
                field("SWIFT Code 6"; Rec."SWIFT Code 6")
                {
                    ApplicationArea = All; // BC Upgrade BHARDA11
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the value of the SWIFT Code 6 field.';
                }
                field("Report Invoice Type 6"; Rec."Report Invoice Type 6")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report Invoice Type 6 field.';
                    // BC Upgrade BHARDA11                    ToolTip = 'Specifies the value of the Report Invoice Type 6 field.';

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        //HEI.07>>
        WhseSetup.GET();
        FinancialStatement := WhseSetup."SCOA Financial Statement FND";
        //HEI.07<<
    end;

    var
        WhseSetup: Record "Warehouse Setup";
        Text0001: Label 'Spanish Payment Remittance must be false.';
        Text0002: Label 'French Payment Remittance must be false.';
        FinancialStatement: Text[100];
}

