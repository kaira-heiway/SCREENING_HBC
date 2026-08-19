page 51082 "CommonSrcSharingSetupCBN"
{
    // version HEI.01

    // HEI.01 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # Table created, "Enable Common Item Sharing","Global Item No. Series" fields added
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # Table created, "Enable Common Vendor Sharing","Global Vendor No. Series" fields added
    // HEI.03 FDD-HT788 IBM BULIMC01 12.10.2019 #Enable Common Customer Sharing,"Global Customer No. Series" fields added
    // HEI.04 FDD-HT1398 CHG2065738 IBM.GUNERE01 13.07.2020 # new field added "Database Level Sharing"
    // HEI.05 FDD-HT1398 CHG2065738 IBM.GUNERE01 14.07.2020 # new fields added "WS Username","WS Password", "WS Link",
    //                                                        "Source Sharing Setup WS Link","Global No. Series Mgt. WS Link",
    //                                                        "Global No. Series WS Link"

    SourceTable = "Common Src Sharing Setup FND";
    caption = 'Common Source Sharing Setup';
    UsageCategory = Administration; // BC Upgrade SHUKLP03 <<
    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            group(Properties)
            {
                Caption = 'Properties';
                field("Enable Common Item Sharing"; Rec."Enable Common Item Sharing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable Common Item Sharing field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Enable Common Item Sharing field.';

                }
                field("Enable Common Vendor Sharing"; Rec."Enable Common Vendor Sharing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable Common Vendor Sharing field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Enable Common Vendor Sharing field.';

                }
                field("Enable Common Customer Sharing"; Rec."Enable Common Customer Sharing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable Common Customer Sharing field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Enable Common Customer Sharing field.';

                }
                field("Global Item No. Series"; Rec."Global Item No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Item No. Series field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Global Item No. Series field.';

                }
                field("Global Vendor No. Series"; Rec."Global Vendor No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Vendor No. Series field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Global Vendor No. Series field.';

                }
                field("Global Customer No. Series"; Rec."Global Customer No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Customer No. Series field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Global Customer No. Series field.';

                }
                field("Database Level Sharing"; Rec."Database Level Sharing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Database Level Sharing field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Database Level Sharing field.';

                }
                field("WS Username"; Rec."WS Username")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Web Service Username field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Web Service Username field.';

                }
                field("WS Password"; Rec."WS Password")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the Web Service Password field.';
                }
                field("WS Link"; Rec."WS Link")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Web Service Link field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Web Service Link field.';

                }
                field("Source Sharing Setup WS Link"; Rec."Source Sharing Setup WS Link")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Sharing Setup WS Link field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Source Sharing Setup WS Link field.';

                }
                field("Global No. Series Mgt. WS Link"; Rec."Global No. Series Mgt. WS Link")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global No. Series Mgt. WS Link field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Global No. Series Mgt. WS Link field.';

                }
                field("Global No. Series WS Link"; Rec."Global No. Series WS Link")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global No. Series WS Link field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Global No. Series WS Link field.';

                }
            }
        }
    }

    actions
    {
    }
}

