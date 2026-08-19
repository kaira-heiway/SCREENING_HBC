page 50117 "Request Order List"
{
    // version HEI.01

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Page created
    // HEI.02 CHG2070625 IBM.AK 07.10.20
    //   # "From-Code" & "FromName" Field added

    Caption = 'Request Order List';
    CardPageID = "Request Order";
    PageType = List;
    SourceTable = "Request Order Header FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field("From-Code"; Rec."From-Code")
                {
                    ToolTip = 'Specifies the value of the From-Code field.';
                }
                field("From-Name"; Rec."From-Name")
                {
                    ToolTip = 'Specifies the value of the From-Name field.';
                }
                field("To-Code"; Rec."To-Code")
                {
                    ToolTip = 'Specifies the value of the To-Code field.';
                }
                field("To-Name"; Rec."To-Name")
                {
                    ToolTip = 'Specifies the value of the To-Name field.';
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    ToolTip = 'Specifies the value of the In-Transit Code field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable Request Order" then
            ERROR(Text001);
    end;

    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        Text001: Label 'You are not allowed to use Request Orders.';
}

