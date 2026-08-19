tableextension 58023 "ReturnShipmentHeaderIntExt_INT" extends "Return Shipment Header"
{
    // DITW15.00.00.01 DDR 27/12/2007 Added fields
    //                                  2034647 Drink Tax Group Code
    // DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                  2034647 Vendor DTax Group Code + Filter to the source table
    // DITW15.00.00.01 DDR 04/01/2008 added field
    //                                  2013610 Customer DDeposit Group Code
    // DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                Added fields
    //                                  2034690 Price Incl. Reversing Calc.
    // DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
    //                                  2034690 Price Incl. Reversing Calc.
    //                                Drink-it Return Deposit functionnalities
    //                                  added key "Applies-to Doc. Type,Applies-to Doc. No."
    //                                Added fields
    //                                  2013613 Link Purch. Document No.
    //                                Added key
    //                                  "Link Purch. Document No."
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.21 DDR 13/06/2008 Added flowfields
    //                                  2014430 Amount
    //                                  2014431 Amount Including VAT
    //                                  2014438 Prices Including VAT
    //                                  2013695 Item Charge Type Filter
    // DITW15.00.00.24 DDR 07/10/2008 Added fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 10/10/2008 Added optionstring 'ShippingCost' for field "Item Charge Type"
    //                                Added fields
    //                                  2014075 Shipping Agent Code
    //                                  2014076 Shipping Agent Service Code
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    //                     21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013726 Tax Registration No.
    //                                  2013730 Fiscal Representative No.
    // DITW15.00.00.35 DDR 22/06/2009 Added functions
    //                                  GetReturnShptLines(),SumReturnShptLinesTemp(),
    //                                  SumReturnShptLines2(),IncrAmount(),Increment()
    //                     25/06/2009 Added fields
    //                                  2013824 Gen. Bus. Posting Free Group
    // DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014271 Tax Warehouse Reference
    //                     27/01/2011 issue 1217 (DIT711 137)
    //                                  Modified Caption field2013730 "Fiscal Representative No."
    //                                  Added fields
    //                                    2014460 Tax Office Code
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                     19/08/2011 issue 1363
    //                                  Added fields
    //                                    2013733 Tax Date
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                    2014087 Distance
    //                                    2014495 Delivery Sequence
    //                     22/12/2011 DIT-715 issue 187
    //                                  Added fields
    //                                    2014277 Transport Mode (flowfield)
    //                                    2014291 Transport Mode Comment (flowfield)
    //                     05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" to calculate VAT on free items
    //                     20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
    //                                Added fields
    //                                  2034850 DIT Sub-Contract Type
    //                                  2034872 Contract Group Code
    //                                  2034915 Service Contract No.
    //                                  2014311 Service Contract Type
    //                 AHU 31/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                               2013630 Deposit Vendor Posting Group
    //                                               2013631 Deposit Payment Terms Code
    //                                               2013632 Deposit Payment Method Code
    //                                               2013633 Deposit Bal. Account Type
    //                                               2013634 Deposit Bal. Account No.
    //                 AHU 30/01/2013 DIT-715 #395 Added 'DrillDownFormID' property table
    // DITW16.00.00.44 DDR 19/03/2014 DIT-715 #910 Added DIT fields
    //                                               2014060 Maximum Weight
    //                                               2014061 Maximum Cubage
    //                                               2014064 Shipping Charge Per
    //                                               2014067 Total Weight
    //                                               2014068 Total Cubage
    //                                               2014426 Service Order No.
    //                                               2013825 Free Item Posting Type
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
    // DITW17.00.03 DDR 20/03/2014 DIT-715 #910 merge
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields
    //                                                          2014410 Physical Location Group Code
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified function SetSecurityFilterOnRespCenter()
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field 2014420 "Sundry Vendor"
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added Field 2014300 "Submission Type (EMCS)"
    // DITW18.00.07 MVN 17/03/2016 DIT-770 #1253 Check Permissions on Loyalty with License
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Field Flowfield "Document Shipping Costs"
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added new field 2014421 "Document Subtype Code"
    // DITW18.00.07 MVN 07/04/2016 DIT-770 #1397 Check Permissions on EMCS
    // DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    // DITW18.00.07 AKH 20/04/2016 DIT-770 #1508 Adjusted filtering code
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field 2014080 "Vendor Delivery Type"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"
    // DITW19.00.08 MSF 05/09/2016 BL#9640 (DIT-770#1819) Added field "Trailer Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                "Route Planning No."
    //                                 Route

    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account

    // HEI.02 HLSRM02 IBM LAZARE02 27.07.2017
    //   #New fields for SRM integration

    // HEI.03 PURGAP05 IBM LAZARE02 31.07.2017
    //   #Extend City fields to 35; Extend Address and Address 2 fields to 60

    // HEI.04 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration

    // HEI.05 FDD-PURGAPINT002 IBM LAZARE02 25.09.2017
    //   # New field "Maximo Requisition No."
    // HEI.06 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50031 - "Gate Entry No."
    // HEI.07 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //   # New Field added "Maximo Status"
    // HEI.08 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50078 - Zycus GR UUID
    //                         50079 - Zycus GR Cancel UUID
    //                         50081 - PO Transaction Interface Zycus
    //                         50082 - GR Transaction Interface Zycus
    //                         50085 - Processed PO Transaction Zycus
    //                         50086 - Processed GR Transaction Zycus
    //BC Upgrade SHARMP16--- Interface Ext fields - shifed from main Ext table
    fields
    {
        field(50005; "SRM Contract No. INT"; Code[10])
        {
            Caption = 'SRM Contract No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50006; "SRM Contract Name INT"; Text[50])
        {
            Caption = 'SRM Contract Name';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50007; "SRM Contract Type INT"; Code[10])
        {
            Caption = 'Contract Type';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "SRM Contract Type FND";
        }
        field(50013; "SRM Order No. INT"; Code[10])
        {
            Caption = 'SRM Order No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50014; "SRM Version No. INT"; Code[10])
        {
            Caption = 'SRM Version No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50030; "Maximo Requisition No. INT"; Code[20])
        {
            Caption = 'Maximo Requisition No.';
            Description = 'HEI.05';
            Editable = false;
        }
        field(50043; "Maximo Status INT"; Option)
        {
            Caption = 'Maximo Status';
            Description = 'HEI.07';
            Editable = false;
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        }
        field(50075; "Zycus Order No. INT"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.08';
            Editable = false;
        }
        field(50078; "Zycus GR UUID INT"; Text[50])
        {
            Caption = 'Zycus GR UUID';
            Description = 'HEI.08';
            Editable = false;
        }
        field(50079; "Zycus GR Cancel UUID INT"; Text[50])
        {
            Caption = 'Zycus GR Cancel UUID';
            Description = 'HEI.08';
            Editable = false;
        }
        field(50081; "PO Transaction Intf. Zycus INT"; Code[20])
        {
            Caption = 'PO Transaction Interface Zycus';
            Description = 'HEI.08';
            Editable = false;
            TableRelation = "Interface Setup INT";
        }
        field(50082; "GR Trans Interf. Zycus INT"; Code[20])
        {
            Caption = 'GR Transaction Interface Zycus';
            Description = 'HEI.08';
            Editable = false;
            TableRelation = "Interface Setup INT";
        }
        field(50085; "Processed PO Trans. Zycus INT"; Boolean)
        {
            Caption = 'Processed PO Transaction Zycus';
            Description = 'HEI.08';
            Editable = false;
        }
        field(50086; "Processed GR Trans. Zycus INT"; Boolean)
        {
            Caption = 'Processed GR Transaction Zycus';
            Description = 'HEI.08';
            Editable = false;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}