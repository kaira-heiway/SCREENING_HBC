table 50061 "Country Format FND"
{

    fields
    {
        field(1; "Country/Region"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(2; "Row No."; Integer)
        {
            MaxValue = 8;
            MinValue = 1;
        }
        field(18; "Address 1 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(19; "Address 2 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(20; "Address 3 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(21; "Address 4 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(22; "Address 5 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(23; "Address 6 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(24; "Address 7 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(25; "Address 8 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(26; "Address 9 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(27; "Address 10 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(28; "Address 11 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
        field(29; "Address 12 Element"; Option)
        {
            OptionMembers = " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Name5,Street3,Street4,Street5,"House No.","House No. extension";
        }
    }

    keys
    {
        key(Key1; "Country/Region", "Row No.")
        {
        }
    }

    fieldgroups
    {
    }
}

