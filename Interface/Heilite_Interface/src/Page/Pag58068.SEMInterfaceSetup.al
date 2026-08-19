page 58068 "SEM Interface Setup"
{
    // Heilite Navision Old Id - 50467

    // version HEI.03

    // HEI.01 CHG2115040 HB2342 IBM GAVANM01 16.08.2021 #SEM Customer Integration
    //   # New Page created for LSR Interfaces
    // HEI.02 CHG2178366-HB3189 IBM COSTES04 15.02.2023 Customer Masterdata interface to DOT change
    //   # New field Enable Promotion Interface
    // HEI.03 CHG2187475 IBM COSTES04 09.05.2023  SEM Sales Information
    //   # New group Send Sem Sales Information

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Manage,Process,Filters';
    SourceTable = "SEM Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group("SEM Master data")
            {
                field("Enable SEM Interface"; Rec."Enable SEM Interface")
                {
                    ToolTip = 'Specifies the value of the Enable SEM Interface field.';
                }
                field("SEM Customer Interface"; Rec."SEM Customer Interface")
                {
                    ToolTip = 'Specifies the value of the SEM Customer Interface field.';
                }
                field("Customer Acc Group Filter"; Rec."Customer Acc Group Filter")
                {
                    ToolTip = 'Specifies the value of the Customer Account groups to be Included field.';
                }
                field("Enable Promotion Interface"; Rec."Enable Promotion Interface")
                {
                    ToolTip = 'Specifies the value of the Enable Promotion Interface field.';
                }
            }
            group("SEM Sales Information")
            {
                field("Send Sales Information"; Rec."Send Sales Information")
                {
                    ToolTip = 'Specifies the value of the Send Sales Information field.';
                }
                field("Sales Information Interface"; Rec."Sales Information Interface")
                {
                    ToolTip = 'Specifies the value of the Sales Information Interface field.';
                }
                field("Sales Info. Cust. Acc Group"; Rec."Sales Info. Cust. Acc Group")
                {
                    ToolTip = 'Specifies the value of the Sales Info. Customer Account Group Filter field.';
                }
                field("Send Multiple Doc. per File"; Rec."Send Multiple Doc. per File")
                {
                    ToolTip = 'Specifies the value of the Send Multiple Doc. per File field.';
                }
                field("No. of Documents per File"; Rec."No. of Documents per File")
                {
                    ToolTip = 'Specifies the value of the No. of Documents per File field.';
                }
                field("Mapping Item Code"; Rec."Mapping Item Code")
                {
                    ToolTip = 'Specifies the value of the Mapping Item Code field.';
                }
                field("Sales Information Distributor"; Rec."Sales Information Distributor")
                {
                    ToolTip = 'Specifies the value of the Sales Information Distributor field.';
                }
                field("Sales Person Mapping Code"; Rec."Sales Person Mapping Code")
                {
                    ToolTip = 'Specifies the value of the Sales Person Mapping Code field.';
                }
                field("Sales Info. Currency Code"; Rec."Sales Info. Currency Code")
                {
                    ToolTip = 'Specifies the value of the Sales Info. Currency Code field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            //Caption = 'Options';  // BC Upgrade NANDIS03
            action("Customers Included/Excluded")
            {
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "SEM Customer Included/Excluded";
                ToolTip = 'Executes the Customers Included/Excluded action.';
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.GET() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
    end;

    var
        LSRMasterIncl_ExclPage: Page "LSR Master Included/Excluded";
}

