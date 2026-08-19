pageextension 58049 PostedPurchasereceiptINT extends "Posted Purchase Receipt"
{

    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 18/06/2008 added new tab "Shipping Agent"
    //                                  added form property CalcFields("Total Weight","Total Cubage")
    //                                  added fields (not editable)
    //                                    "Maximum Weight","Maximum Cubage",
    //                                    "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per",
    //                                    "Total Weight","Total Cubage","Shipping Agent Code","Shipping Agent Service Code"
    //                                    "Shipping Charge Per"
    //   DITW15.00.00.23.04 DDR 16/09/2008 Added fields (not editable)
    //                                      "Shipping Quantity Invoiced","Shipping Qty. Not Invd."
    //                                      "Shipping Unit Cost","Shipping Cost Amount"
    //   DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    //   DITW15.00.00.25 DDR 10/10/2008 Added field "Truck Code","Driver Code" into "Shipping Agent" tab
    //                                  Remove fields "Shipping Charge Type","Shipping Charge No.",
    //                                    "Shipping Unit Cost","Shipping Cost Amount"
    //                                    "Shipping Quantity Invoiced","Shipping Qty. Not Invd."
    //                       21/10/2008 Deleted field2013722 Duty Tax Type
    //                                  Added fields "Vendor DTax Group Code" into Invoicing tab
    //   DITW15.00.00.28 DDR 24/11/2008 Added fields "Fiscal Representative No."
    //   DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
    //   DITW15.00.00.36 DDR 18/12/2009 issue 949 Added "Entry Point" into 'Shipping Agent' tab
    //   DITW15.00.00.38 DDR 05/10/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                             Added 'Unsatisfactory Comment' menu button in 'Line' button
    //                                             Added functions ShowLineUnstatisfactoryCmts()
    //                                             Added 'Send Report Receipt Request' menus in 'Functions' buttons
    //                   DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    //   DITW15.00.00.39 DDR 19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    //   DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Delivery Sequence","Distance" (Shipping Agent tab)
    //                       11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    call function SetDisableRefreshLines() before each report
    //                                                    (don't use the <RunObject> property)

    //   FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference" on page
    //                                  PDF Functionality
    //   DITW17.00.01 VVE 22/03/2013 Check which codeunit to use from setup
    //   DITW17.00.02 DDR 06/06/2013 DIT-770 #99 Added fields "Ship-to Country/Region Code" into 'Shipping' tab
    //                    04/07/2013 DIT-770 #99 Added fields "GWC Country/Region Code" into 'Foreign Trade' tab
    //                    28/08/2013 DIT-770 #178 Remove DIT-770 #99
    //   DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    //   DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB
    //   DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    //   DITW18.00.07 AKH 21/04/2016 DIT-770 #1508 Removed filter
    //   DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added fields "Vendor Delivery Type" & "Delivery Time (sec.)" under Shipping tab

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    //   DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields

    //   HEI.01 FDD-PTPGAP062 IBM.HORTOC01 11.07.2017
    //     # Display field UserID
    //   HEI.02 HLSRM02-05 IBM LAZARE02 31.07.2017
    //     #New fields for SRM integration added to SRM tab
    //   HEI.03 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //     # New Field added "Gate Entry No."
    //   HEI.04 FDD-PURGAP027 IBM NASTAA02 14.06.2019 # Maximo POs Approval Flow
    //     # Created new Page Action "Purchase Receipt Additional"
    //   HEI.05 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //     # New field added Maximo status

    //   HEI.06 CHG2058828 IBM NANDIS01 20.05.2020 GR IR Writeoff
    //     # New button created "GR/IR WriteOff Invoicing" for the funtionality

    //   HEI.07 CHG2091605 IBM NANDIS01 18.12.2020 invoice reference issue
    //     # Add No Series to be populated at time of creation of PO
    //   HEI.08 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //     # New field added in General tab: LSR Order No
    //     # New global var:PostedPurchReceiptAdditional,  code added
    //   HEI.09 CHG2190299 FDD-HB3316 IBM NANDIS01 24.05.2023 # POSM eshop SRM- HL interface
    //     # New field shown in page - "POSM GR Confirmed" in SRM tab
    //   HEI.10 CHG2201773 HB3442 SRIVAS07 IBM 27/11/23 - Development - Undoing a Goods Receipt for Fixed Asset
    //     # Added new action - GRIR Reversal
    //   HEI.11 CHG2201773 HB3442 SRIVAS07 IBM 06/12/23 - Development - Undoing a Goods Receipt for Fixed Asset
    //     # Change the Caption of Action - GRIR Reversal

    //BC Upgrade GUNREM01 - HEI.02 added SRM related fields

    layout
    {
        addafter("Responsibility Center")
        {
            field("Maximo Status"; Rec."Maximo Status FND")
            {
                ApplicationArea = all;
            }
            field("PostedPurchReceiptAdditional.""LSR Order No FND"; PostedPurchReceiptAdditional."LSR Order No FND")
            {
                ApplicationArea = all;
            }
        }//BC Upgrade SHARMP16--Zycus
         //  BC Upgrade GUNREM01 >> added SRM related fields
        addafter(Shipping)//BC Upgrade SHARMP16--SRM
        {
            group(SRM)
            {
                Caption = 'SRM';
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ApplicationArea = all;
                }
                field("SRM Contract Name"; Rec."SRM Contract Name FND")
                {
                    ApplicationArea = all;
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ApplicationArea = all;
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ApplicationArea = all;
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ApplicationArea = all;
                }
                field(Channel; Rec."Channel FND")
                {
                    ApplicationArea = all;
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ApplicationArea = all;
                }
                field(Closed; Rec."Closed FND")
                {
                    ApplicationArea = all;
                }

                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ApplicationArea = all;
                }

                field("Target Value Currency"; Rec."Target Value Currency FND")
                {
                    ApplicationArea = all;
                }
                field("Target Value Amount"; Rec."Target Value Amount FND")
                {
                    ApplicationArea = all;
                }
                field("POSM GR Confirmed"; Rec."POSM GR Confirmed FND")
                {
                    ApplicationArea = all;
                }
            }
            //  BC Upgrade GUNREM01 >> added SRM related fields
        }
    }
    actions
    {
        addafter(approvals)
        {
            action("Purchase Receipt Additional")
            {
                ApplicationArea = all;
                Caption = 'Purchase Receipt Additional';
                Image = Purchase;
                RunObject = Page "Purch. Rcpt. Additional";
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }
    var
        PostedPurchReceiptAdditional: Record "Purch. Rcpt. Header Add FND";
}


