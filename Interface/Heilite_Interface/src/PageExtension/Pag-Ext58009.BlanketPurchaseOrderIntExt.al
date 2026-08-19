pageextension 58009 BlanketPurchaseOrderIntExt extends "Blanket Purchase Order"
{
    //BC Upgrade SHARMP16 
    layout
    {
        addafter(Prepayment)
        {
            group(SRM)
            {
                Caption = 'SRM';
                Editable = BlanketOrderEditable;
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Name"; Rec."SRM Contract Name FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the SRM Contract Name field.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field(Channel; Rec."Channel FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Channel field.';
                }
                field("Target Value Amount"; Rec."Target Value Amount FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Target Value Amount field.';
                }
                field("Blanket Order No."; Rec."Blanket Order No. FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Blanket Order No. field.';
                }
                field(Closed; Rec."Closed FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        BlanketOrderEditable: Boolean;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        //>>HEI.09
        IF NOT GUIALLOWED THEN
            BlanketOrderEditable := InterfaceFrameworkMgt.CheckPermissionSet(USERID, '', TRUE);
        //<<HEI.09
    end;

}