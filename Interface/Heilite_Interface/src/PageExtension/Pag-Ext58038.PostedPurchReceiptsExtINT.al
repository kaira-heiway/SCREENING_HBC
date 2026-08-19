pageextension 58038 PostedPurchReceiptsExtINT extends "Posted Purchase Receipts"
{
    //  DITW15.00.00.38 DDR 17/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added columns
    //                                      "Vendor Tax Registration No.","Fiscal Representative No.",
    //                                      "Vendor Tax Warehouse Ref."
    //   DITW18.00.07 VSC 15/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    //   DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-PTPGAP062 IBM.HORTOC01 11.07.2017
    //     # Display field UserID
    //   HEI.02 Defect #807 IBM NASTAA02 02.11.2017 # Confirmation field to be added in HeiLite
    //     # New field "SRM Contract No." added
    //   HEI.03 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //     # New Field added "Gate Entry No."
    //   HEI.04 FDD-HT650 BULIMC01 IBM 02.07.2019 #New field displayed "Order No." and "Posting Description"

    //   HEI.05 CHG2058828 IBM NANDIS01 20.05.2020 GR IR Writeoff
    //     # New button created "GR/IR WriteOff Invoicing" for the funtionality
    //   HEI.06 CHG2091605 IBM NANDIS01 18.12.2020 invoice reference issue
    //     # Add No Series to be populated at time of creation of PO
    //   HEI.07 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //     # New field added: LSR Order No
    //   HEI.08 CHG2200434 FDD-HB3431 IBM MAJUMS03 01.06.2023 # Column Data Availability of WH Shipment & WH Receipt No. stated in all Posted Documents for all Customer
    //   Distribution, Inter-Brewery Transfers & Purchased Mater
    //     # New field "Posted Warehouse Receipt No." is added.
    //   HEI.09 CHG2229933 HB3689 IBM SRIVAS07 25.04.2024 # SRM Reference Document Mapping - Development
    //     # Added field - "Vendor Shipment No."
    //   HEI.10 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - PO Transaction Interface Zycus
    //                        - Processed PO Transaction Zycus
    //   HEI.11 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Fields - Zycus GR UUID
    //                        - Zycus GR Cancel UUID
    //                        - GR Transaction Interface Zycus
    //                        - Processed GR Transaction Zycus
    //BC Upgrade GUNREM01 Added
    layout
    {

        // Add changes to page layout here
        addafter("Shipment Method Code")
        {
            field("SRM Contract No."; Rec."SRM Contract No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the SRM Contract No. field.';
            }
            field("SRM Order No."; Rec."SRM Order No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the SRM Order No. field.';
            }
            // BC Upgrade MISHRS14 >>
            // Added FND In field Rec.
            field("Zycus Order No."; PostedPurchReceiptAdditional."Zycus Order No. FND")
            {
                Caption = 'Zycus Order No.';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus Order No. field.';
            }

            field("PO Transaction Interface Zycus"; PostedPurchReceiptAdditional."PO Trans. Interf. Zycus FND")
            {
                Caption = 'PO Transaction Interface Zycus';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Transaction Interface Zycus field.';
            }

            field("Processed PO Transaction Zycus"; PostedPurchReceiptAdditional."Procsd. PO Trans. Zycus FND")
            {
                Caption = 'Processed PO Transaction Zycus';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Processed PO Transaction Zycus field.';
                
            }
            field("Zycus GR UUID"; PostedPurchReceiptAdditional."Zycus GR UUID FND")
            {
                Caption = 'Zycus GR UUID';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus GR UUID field.';
            }
            field("Zycus GR Cancel UUID"; PostedPurchReceiptAdditional."Zycus GR Cancel UUID FND")
            {
                Caption = 'Zycus GR Cancel UUID';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus GR Cancel UUID field.';
            }
            field("GR Transaction Interface Zycus"; PostedPurchReceiptAdditional."GR Trans. Interf. Zycus FND")
            {
                Caption = 'GR Transaction Interface Zycus';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GR Transaction Interface Zycus field.';
            }

            field("Processed GR Transaction Zycus"; PostedPurchReceiptAdditional."Procsd. GR Trans. Zycus FND")
            {
                Caption = 'Processed GR Transaction Zycus';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Processed GR Transaction Zycus field.';
            }
            // BC upgrade MISHRS14 <<
        }
    }
    trigger OnAfterGetRecord();
    begin

        if PostedPurchReceiptAdditional.GET(Rec."No.") then;  //HEI.07

    end;


    var
        PostedPurchReceiptAdditional: Record "Purch. Rcpt. Header Add FND";
}