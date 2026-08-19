tableextension 50139 ContactExtFND extends Contact
{
    //     DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added all new fields while creating customer/vendor card based on cust/vend template
    // DITW15.00.00.39 DDR 04/07/2011 issue 951 Added fields
    //                                  2034849 Serv. Contract Acc. Gr. Code
    // DITW16.00.00.41 AHU 13/08/2012 DIT-715 #327 Added to transfer all Contract Posting Group fields while creating new customer
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields added
    //     # 10801Trade Register
    //     # 10802APE Code
    //     # 10803Legal Form
    //     # 10804Stock Capital
    fields
    {
        // BC Upgrade NANDIS03 >>
        // field(10801; "Trade Register"; Text[30])
        // {
        //     Description = 'HEI.01';
        //     Caption = 'Trade Register';
        //     DataClassification = CustomerContent;
        // }
        // field(10802; "APE Code"; Code[10])
        // {
        //     Description = 'HEI.01';
        //     Caption = 'APE Code';
        //     DataClassification = CustomerContent;
        // }
        // field(10803; "Legal Form"; Text[30])
        // {
        //     Description = 'HEI.01';
        //     Caption = 'Legal Form';
        //     DataClassification = CustomerContent;
        // }
        // field(10804; "Stock Capital"; Text[30])
        // {
        //     Description = 'HEI.01';
        //     Caption = 'Stock Capital';
        //     DataClassification = CustomerContent;
        // }
        // BC Upgrade NANDIS03 <<
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