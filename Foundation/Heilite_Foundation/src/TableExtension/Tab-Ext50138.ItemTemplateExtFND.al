tableextension 50138 ItemTemplateExtFND extends "Item Templ."
{
    //     DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013727 AAD Nos.
    //                                  2013747 Default Tax Spec. HL
    //                                  2013748 Default Tax Spec. Degree Plato
    //                                Added function GetUomCaptionClass()
    // DITW15.00.00.37 DDR 16/02/2010 Issue 960 Added fields
    //                                  2014456 Inventory Value Zero
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2013610 DDeposit Group Code
    //                                    2013667 DTax Group Code
    //                                    2014474 Location Code
    //                                    2014493 Tariff No.
    //                                    2014495 Country/Region Purchased Code
    //                                    2014497 Country/Region of Origin Code
    //                                  Removed fields "Tax Spec. HL","Tax Spec. Degrees Plato"
    // DITW15.00.00.38 DDR 05/01/2011 issue 822
    //                                  Added fields
    //                                    2034927 Service Item Group
    //                     01/02/2011 issue 941
    //                                  Added fields
    //                                    2013824 Def. Prod. Posting Free Group
    //                                    2013825 Free Item Posting Type
    //                                    2013826 Free Item
    //                     03/02/2011 issue 941 Renamed Caption field 2013824 Def. Prod. Posting Free Group
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
    //                                  Added fields
    //                                    2013803 Allow VAT Calculation (Free)
    //                     25/01/2012 DIT-715 #172 Removed test while selecting "Allowed VAT Calculation (Free)"
    // DITW16.00.00.43 AHU 28/05/2013 DIT-715 #497 Added fields
    //                                               2014440 Exclusivity

    // DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added fields
    //                                               2014560 C945 Category Type
    //                                               2014561 C945 Category Unit of Measure
    //              DDR 28/05/2013 DIT-715 #497 merge
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95
    // DITW17.00.02 SR 20/09/2013 DIT-770 #187 : New Field "2034640,2034641,2034642" Added
    //                                         : New Function "CheckDimPostingRules" Added
    // DITW17.00.02 AT  25/09/2013 DIT-770 #145 Added New Field 2014060 St. Return Reason Code
    // DITW17.10.05 DDR 12/02/2015 DIT-770 #1118 Added field 2013827 Free Reason Code
    // DITW18.00.07 VSC 22/01/2016 DIT-770 #1702 Assign "Manco/Surplus Tolerance %" from ItemCat.
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 09/02/2017 NRQ#20699 Add all DIT from table5722 Item Category
    //                                        Renamed field names 2013610,2013667,2013824,2014060
    //                                        Removed fields (doesn't meet new NAV Template, redundant-double, ???also used on item/cust table "blocked" field)
    //                                          2034640 Autocreate dimension Code = functional? is to create default "Cost Object2 Dimension" of Cost Accounting with bad fieldname!
    //                                          2034641 Autocreate form dimension = functional? pre-default dimensions to add into DIT item category default dimension?
    //                                          2034642 Dimension Seperator       = never used, already managed by the NAV Dim selection function
    //                                        Remapping DIT vs NAV fields
    //                                          Service Item Group              2034927 -> 5900
    //                                          Tariff No.                      2014457 -> 47
    //                                          Inventory Value Zero            2014456 -> 5409
    //                                          Country/Region of Origin Code   2014474 -> 95
    //                                          Country/Region Purchased Code   2014475 -> 96
    //                                          Location Code                   2014457 -> 2014441
    //                                     !! Merge NAV CU3.15052 + FieldRefArray variables to array100 (see codeunit 8612)
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

    // QXL10.0 DDR 09/02/2017 NRQ#20699 added field2035091
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields

    fields
    {
        field(50016; "RPM Solution FND"; Enum "RPM Solution")
        {
            Caption = 'RPM Solution';
            Description = 'HEI.01';
            DataClassification = CustomerContent;
        }
        field(50017; "RPM Type FND"; Code[20])
        {
            Caption = 'RPM Type';
            TableRelation = "Return Pack Material Type FND".Code;
            Description = 'HEI.01';
            DataClassification = CustomerContent;

        }
        field(50018; "Item Type FND"; Enum "Item Type RPM")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
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