page 50072 "Dispute Card Cases"
{
    // version HEI.02

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP029 IBM ISYED01 28/06/2017
    //   #Created new page for Dispute Card Cases
    // HEI.02 FDD-HB2071 - CHG2099230 IBM NASTAA02 04.05.2021 # Update Dispute Module in HL
    //   # New Fields added: "Dispute Category Code", "Customer No.", "Document No.",
    //   # Re-arranged the fields on the Page
    //   # Code added on "OnQueryClosePage" trigger

    DelayedInsert = true;
    SourceTable = "Dispute Case FND";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<


    layout
    {
        area(content)
        {
            field("Cust. Ledger Entry No."; Rec."Cust. Ledger Entry No.")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Entry No. field.';

                trigger OnValidate();
                begin
                    CurrPage.UPDATE();
                end;
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
                Editable = false;
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
            }
            field("Reason Code"; Rec."Reason Code")
            {
                Editable = Rec."Dispute Category Code" <> '';
                LookupPageID = "Dispute Reasons";
                ApplicationArea = ALL;
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
        //HEI.02<<
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        //HEI.02>>
        if Rec."Cust. Ledger Entry No." <> 0 then
            Rec.TESTFIELD("Reason Code");
        //HEI.02<<
    end;

    var
        HeinekenGlobal: Codeunit "Heineken Global";
        CustomerName: Text[50];
}

