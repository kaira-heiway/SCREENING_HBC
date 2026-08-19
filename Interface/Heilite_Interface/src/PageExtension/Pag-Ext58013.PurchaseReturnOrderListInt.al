pageextension 58013 PurchaseReturnOrderListIntExt extends "Purchase Return Order List"
{
    //BC upgrade SHARMP16----- Interface related fields shifted to this table from main extension table
    layout
    {
        addafter("Job Queue Status")

        {
            field("SRM Order No."; Rec."SRM Order No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Order No. field.';
            }
            field("Zycus Order No."; PurchaseHeaderAdditional."Zycus Order No. INT")
            {
                ApplicationArea = All;
                Caption = 'Zycus Order No.';
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus Order No. field.';
            }
            field("PO Transaction Interface Zycus"; PurchaseHeaderAdditional."PO Transaction Intf. Zycus INT")
            {
                ApplicationArea = All;
                Caption = 'PO Transaction Interface Zycus';
                Visible = false;
                ToolTip = 'Specifies the value of the PO Transaction Interface Zycus field.';
            }
            field("Processed PO Transaction Zycus"; PurchaseHeaderAdditional."Processed PO Trans. Zycus INT")
            {
                ApplicationArea = All;
                Caption = 'Processed PO Transaction Zycus';
                Visible = false;
                ToolTip = 'Specifies the value of the Processed PO Transaction Zycus field.';
            }
            field("Zycus GR UUID"; PurchaseHeaderAdditional."Zycus GR UUID INT")
            {
                ApplicationArea = All;
                Caption = 'Zycus GR UUID';
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus GR UUID field.';
            }
            field("Zycus GR Cancel UUID"; PurchaseHeaderAdditional."Zycus GR Cancel UUID INT")
            {
                ApplicationArea = All;
                Caption = 'Zycus GR Cancel UUID';
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus GR Cancel UUID field.';
            }
            field("GR Transaction Interface Zycus"; PurchaseHeaderAdditional."GR Transaction Intf Zycus INT")
            {
                ApplicationArea = All;
                Caption = 'GR Transaction Interface Zycus';
                Visible = false;
                ToolTip = 'Specifies the value of the GR Transaction Interface Zycus field.';
            }
            field("Processed GR Transaction Zycus"; PurchaseHeaderAdditional."Processed GR Trans. Zycus INT")
            {
                ApplicationArea = All;
                Caption = 'Processed GR Transaction Zycus';
                Visible = false;
                ToolTip = 'Specifies the value of the Processed GR Transaction Zycus field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
}