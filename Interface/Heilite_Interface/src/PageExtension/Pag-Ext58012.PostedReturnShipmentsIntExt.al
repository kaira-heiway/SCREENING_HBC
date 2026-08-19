pageextension 58012 PostedReturnShipmentsIntExt extends "Posted Return Shipments"
{
    //BC upgrade SHARMP16----- Interface related fields shifted to this table from main extension table

    layout
    {

        addafter("Applies-to Doc. Type")
        {
            field("Zycus Order No. INT"; Rec."Zycus Order No. INT")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus Order No. field.';
            }
            field("PO Transaction Interface Zycus"; Rec."PO Transaction Intf. Zycus INT")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the PO Transaction Interface Zycus field.';
            }
            field("Processed PO Trans. Zycus INT"; Rec."Processed PO Trans. Zycus INT")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the Processed PO Transaction Zycus field.';
            }
            field("Zycus GR UUID INT"; Rec."Zycus GR UUID INT")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus GR UUID field.';
            }
            field("Zycus GR Cancel UUID INT"; Rec."Zycus GR Cancel UUID INT")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus GR Cancel UUID field.';
            }
            field("GR Transaction Interface Zycus"; Rec."GR Trans Interf. Zycus INT")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the GR Transaction Interface Zycus field.';
            }
            field("Processed GR Trans. Zycus INT"; Rec."Processed GR Trans. Zycus INT")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the Processed GR Transaction Zycus field.';
            }
        }
    }
    actions
    {





    }



}

