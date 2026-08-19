page 50027 "Dispute Cases"
{
    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP029 IBM ISYED01 28/06/2017
    //   #Created new page for Dispute Cases
    // HEI.02 FDD-HB2071 - CHG2099230 IBM NASTAA02 04.05.2021 # Update Dispute Module in HL
    //   # New Fields added: "Dispute Category Code", "Customer No.", "Document No.",
    //   # Re-arranged the fields on the Page
    //   # Code added on "OnModifyRecord" trigger

    AutoSplitKey = true;
    CardPageID = "Dispute Card Cases";
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Dispute Case FND";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cust. Ledger Entry No."; Rec."Cust. Ledger Entry No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field(CustomerName; CustomerName)
                {
                    Caption = 'Customer Name';
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Dispute Category Code"; Rec."Dispute Category Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Dispute Category Code field.';

                    trigger OnValidate();
                    begin
                        ReasonCodeEditable := Rec."Dispute Category Code" <> ''; //HEI.02
                    end;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = ALL;
                    Editable = ReasonCodeEditable;
                    Enabled = ReasonCodeEditable;
                    LookupPageID = "Dispute Reasons";
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Resolution Code"; Rec."Resolution Code")
                {
                    DrillDown = true;
                    LookupPageID = "Dispute Resolutions";
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Resolution Code field.';
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Closing Date field.';
                }
                field("Duration of Ticket"; Rec."Duration of Ticket")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Duration of Ticket field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        Customer: Record Customer;
    begin
        //HEI.02>>
        Rec.SETAUTOCALCFIELDS("Customer No.");
        if Customer.GET(Rec."Customer No.") then
            CustomerName := Customer.Name;

        ReasonCodeEditable := Rec."Dispute Category Code" <> '';
        //HEI.02<<
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    var
        DisputeCase: Record "Dispute Case FND";
        xDisputeCase: Record "Dispute Case FND";
        SplitResult: Integer;
    begin
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Rec.TESTFIELD("Reason Code"); //HEI.02
    end;

    trigger OnOpenPage();
    begin
        ReasonCodeEditable := Rec."Dispute Category Code" <> ''; //HEI.02
    end;

    var
        ReasonCodeEditable: Boolean;
        Error001: Label 'You cannot create more than one open dispute case for a customer ledger entry %1';
        CustomerName: Text[50];
}

