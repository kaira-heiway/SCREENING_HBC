table 58015 "Esker Interface Setup INT"
{
    // Heilite Navision Old Id - 50066
    // version ESKER

    // HEI.01 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01, 22.10.2018
    //   # object created
    // HEI.02 FDD_Ethiopia_Esker_ Interface_V0.3_HT75 IBM POSTOI01, 09.07.2019
    //   # 4 new fields ID's: 28, 29, 30, 31
    // HEI.03 FDD_Ethiopia_Esker_ Interface_V0.3_HT75 IBM POSTOI01, 27.08.2019
    //   # new field 32 Esker POLines Interf
    // HEI.04 FDD HB1348 CHG2061857 IBM SHANKJ03 25.06.2020
    //   # New Field Added


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Esker Vendor Req Interf"; Code[20])
        {
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(3; "Esker Vendor Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(4; "Esker Company Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(5; "Esker Company Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(6; "Esker CostCenters Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(7; "Esker CostCenters Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(8; "Esker GLAccount Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(9; "Esker GLAccount Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(10; "Esker Brand Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(11; "Esker Brand Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(12; "Esker Currency Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(13; "Esker Currency Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(14; "Esker TaxCode Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(15; "Esker TaxCode Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(16; "Esker PaymTerm Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(17; "Esker PaymTerm Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(18; "Esker BankDetail Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(19; "Esker BankDetail Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(20; "Esker POHeader Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(21; "Esker POHeader Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(22; "Esker POLine Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(23; "Esker POLine Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(24; "Esker PaymStatus Req Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(25; "Esker PaymStatus Resp Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(26; "Esker InvPosting Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(27; "Esker InvConfirm Interf"; Code[20])
        {
            Description = 'HEi.01';
            TableRelation = "Interface Setup INT";
        }
        field(28; "Esker WHT Req Interf"; Code[20])
        {
            Description = 'HEi.02';
            TableRelation = "Interface Setup INT";
        }
        field(29; "Esker WHT  Resp Interf"; Code[20])
        {
            Description = 'HEi.02';
            TableRelation = "Interface Setup INT";
        }
        field(30; "Esker LC Req Interf"; Code[20])
        {
            Description = 'HEi.02';
            TableRelation = "Interface Setup INT";
        }
        field(31; "Esker LC  Resp Interf"; Code[20])
        {
            Description = 'HEi.02';
            TableRelation = "Interface Setup INT";
        }
        field(32; "Esker POLines Interf"; Code[20])
        {
            Description = 'HEi.03';
            TableRelation = "Interface Setup INT";
        }
        field(33; "Esker VendorPostGrp Req Interf"; Code[20])
        {
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(34; "Esker VendorPostGr Resp Interf"; Code[20])
        {
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

