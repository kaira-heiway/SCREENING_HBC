table 58066 "HeiFLOW Interface Setup INT"
{
    // Heilite Navision Old Id - 50239
    // version HEI.03

    // HEI.01 CHG2132748 IBM SAXENA03 09.11.2021
    //   # HeiLite Base integration with HeiFlow  Master Data
    //   # Created a new Table as HeiFLOW Interface Setup
    // 
    // HEI.02 CHG2132929 IBM POENAB02 15.04.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Fields added:
    //     # 7 "HeiFlow GL Posting Interface"
    //     # 8 "HeiFlow GL Posting Intf. Resp."
    // 
    // HEI.03 CHG2144425 IBM POENAB02 19.05.2022 HeiLite Vendor Invoice Status| Automation for Caribbean OpCo’s SSC
    //   #Fields added:
    //     # 9 "HeiFlow Vend. Inv. Request"
    //     # 10 "HeiFlow Vend. Inv. Response"


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Interface Enable/Disable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "HeiFLOW Customer"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT".Code;
        }
        field(4; "HeiFLOW Vendor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT".Code;
        }
        field(5; "Last Modified Vendor"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Last Modified Customer"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "HeiFlow GL Posting Interface"; Code[20])
        {
            Caption = 'HeiFlow GL Posting Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT".Code;
        }
        field(8; "HeiFlow GL Posting Intf. Resp."; Code[20])
        {
            Caption = 'HeiFlow GL Posting Interface Response';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT".Code;
        }
        field(9; "HeiFlow Vend. Inv. Request"; Code[20])
        {
            Caption = 'HeiFlow Vend. Inv. Request';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(10; "HeiFlow Vend. Inv. Response"; Code[20])
        {
            Caption = 'HeiFlow Vend. Inv. Response';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
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

