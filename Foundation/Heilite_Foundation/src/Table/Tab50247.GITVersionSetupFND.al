table 50247 "GIT Version Setup FND"
{
    // version GIT,HEI.02

    // HEI.01 RITM2963894 IBM SAXENA03 23/05/2022
    //   # Added DevOps User ID
    // HEI.02 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    DataPerCompany = false;

    fields
    {
        field(10; ID; Code[10])
        {
        }
        field(20; "NAS Service Name"; Text[100])
        {
        }
        field(30; "NAV Server"; Text[100])
        {
        }
        field(40; "Database Server"; Text[100])
        {
        }
        field(50; "Application Database"; Text[100])
        {
        }
        field(200; "Local Repository Path"; Text[100])
        {
        }
        field(201; "DevOps Repository Url"; Text[100])
        {
        }
        field(202; "DevOps Branch"; Text[100])
        {
        }
        field(203; "DevOps Repository Name"; Text[100])
        {
        }
        field(204; "DevOps Master Branch"; Text[100])
        {
        }
        field(300; "Script Folder"; Text[100])
        {
        }
        field(400; AzureToken; Text[100])
        {
            ExtendedDatatype = None;
        }
        field(401; AzureApiVersion; Text[100])
        {
        }
        field(500; CDate; Date)
        {
        }
        field(501; CTime; Time)
        {
        }
        field(502; "GIT Last Rebase Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(503; "GIT Last Rebase Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(504; "GIT Last Commit Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(505; "GIT Last Commit Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(506; "DevOps User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; ID)
        {
        }
    }

    fieldgroups
    {
    }
}

