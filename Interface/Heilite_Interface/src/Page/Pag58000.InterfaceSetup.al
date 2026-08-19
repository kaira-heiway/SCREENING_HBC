page 58000 "Interface Setup"
{
    // Heilite Navision Old Id - 50005
    // version HEI.04,FM

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework
    // HEI.02 FDD-HNK LOGGAP001 03/12/2017 IBM.CHAUHB01. Following fields displayed.
    //   Object Type
    //   Object ID
    //   Object Name
    //   File Name
    //   Tranasaction Type
    //   File Header
    // HEI.04 S&OP IBM POSTOI01 21.10.2018 # new page action Page Interface Setup Card , Caption= Edit Details
    // HEI.05 FDD-PA-SLSGAP023 IBM BULIMC01 21.02.2019 # Show new field Pepperi Interface.
    // HEI.06 CHG2021537 IBM HORTOC01 17.09.2019 # rename caption for "peperi interface" field
    // HEI.07 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Field added: "VIP Interface"
    // HEI.08 FDD-HT626 IBM SURYAS01 16-12-2019 Bank Connection Setup_La Réunion
    //   # Added below New Field's
    //   Interface Code
    //   Interface Type
    //   Last Seq. No.
    //   Interface Dim 1 Filter
    //   Interface Dim 2 Filter
    // HEI.09 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # New Field added: "Enable Processing Flag"
    // HEI.10 CHG2335817 IBM SAHAL01 29.01.2026 To restrict users not to process Zycus errors in HeiLite
    //   # Added New Field - Block to Reprocess VIP Error

    // BC Upgrade PATELS08 >>
    // # Tag HEI.10 added and the related code.
    // BC Upgrade PATELS08 <<

    Caption = 'Interface Setup';
    PageType = List;
    SourceTable = "Interface Setup Int";
    ApplicationArea = All;  // BC Upgrade SHARMP16
    UsageCategory = Lists;  // BC Upgrade SHARMP16

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Enabled; Rec.Enabled)
                {
                    ToolTip = 'Specifies the value of the Enabled field.';
                }
                field("Pepperi Interface"; Rec."Pepperi Interface")
                {
                    Caption = 'Opco Interface';
                    ToolTip = 'Specifies the value of the Opco Interface field.';
                }
                field(Direction; Rec.Direction)
                {
                    ToolTip = 'Specifies the value of the Direction field.';
                }
                field("Call Type"; Rec."Call Type")
                {
                    ToolTip = 'Specifies the value of the Call Type field.';
                }
                field("VIP Interface"; Rec."VIP Interface")
                {
                    ToolTip = 'Specifies the value of the VIP Interface field.';
                }
                field("Enable Processing Flag"; Rec."Enable Processing Flag")
                {
                    ToolTip = 'Specifies the value of the Enable Processing Flag field.';
                }
                field("Data Exch. Def Code"; Rec."Data Exch. Def Code")
                {
                    ToolTip = 'Specifies the value of the Data Exch. Def Code field.';
                }
                field("Data Exch. Line Def Code"; Rec."Data Exch. Line Def Code")
                {
                    ToolTip = 'Specifies the value of the Data Exch. Line Def Code field.';
                }
                field("Use Component Detail"; Rec."Use Component Detail")
                {
                    ToolTip = 'Specifies the value of the Use Component Detail field.';
                }
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the value of the Object ID field.';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the value of the Object Name field.';
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("File Header"; Rec."File Header")
                {
                    ToolTip = 'Specifies the value of the File Header field.';
                }
                field("Interface Code"; Rec."Interface Code")
                {
                    ToolTip = 'Specifies the value of the Interface Code field.';
                }
                field("Interface Type"; Rec."Interface Type")
                {
                    ToolTip = 'Specifies the value of the Interface Type field.';
                }
                field("Last Seq. No."; Rec."Last Seq. No.")
                {
                    ToolTip = 'Specifies the value of the Last Seq. No. field.';
                }
                field("Interface Dim 1 Filter"; Rec."Interface Dim 1 Filter")
                {
                    ToolTip = 'Specifies the value of the Interface Dim 1 Filter field.';
                }
                field("Interface Dim 2 Filter"; Rec."Interface Dim 2 Filter")
                {
                    ToolTip = 'Specifies the value of the Interface Dim 2 Filter field.';
                }

                // BC Upgrade PATELS08 >>
                field("Block to ReProcess VIP Error"; Rec."Block to ReProcess VIP Error")
                {
                    ToolTip = 'Specifies the value of the Block to ReProcess VIP Error field.';
                }
                // BC Upgrade PATELS08 <<
            }
        }
        area(factboxes)
        {
            systempart(Control50008; Links)
            {
            }
            systempart(Control50009; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Data Exchange Definition")
            {
                Caption = 'Data Exchange Definition';
                Image = ReferenceData;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Inter Data Exch Def Card CBN";
                RunPageLink = Code = FIELD("Data Exch. Def Code");
                ToolTip = 'Open the data exchange definition for the current interface';
            }
            action("Outbound Details")
            {
                Caption = 'Outbound Details';
                Image = StepOut;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Outbound Interfaces";
                RunPageLink = "Interface Code" = FIELD(Code);
                ToolTip = 'Open the outbound details for the current interface';
            }
            action("Page Interface Setup Card")
            {
                Caption = 'Edit Details';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Interface Setup Details";
                RunPageLink = Code = FIELD(Code);
                RunPageMode = Edit;
                RunPageView = SORTING(Code);
                ToolTip = 'Executes the Edit Details action.';
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        ShowRunTypeFields(Rec."Run Type");
    end;

    var
        Password: Text;
        EditRunTypeFields: Boolean;

    local procedure ShowRunTypeFields(RunType: Option Automatic,Manual);
    begin
        if RunType = RunType::Automatic then
            EditRunTypeFields := false
        else
            EditRunTypeFields := true;
    end;
}

