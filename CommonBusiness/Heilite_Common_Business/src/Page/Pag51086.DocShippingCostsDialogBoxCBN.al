page 51086 "Doc.ShipCostDialogBox CBN"
{
    // version HEI.01

    // HEI.01 FDD-HT658 IBM.GUNERE01 19.09.2019 # Page created
    //************************************************************************
    //BC UPGRADE PATHAA02-21.11.25

    PageType = ConfirmationDialog;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(PostingDate; PostingDate)
            {
                Caption = 'Posting Date';
                ToolTip = 'Specifies the value of the Posting Date field.';
            }
            field(DocumentDate; DocumentDate)
            {
                Caption = 'Document Date';
                ToolTip = 'Specifies the value of the Document Date field.';
            }
            field(VendorShipmentNo; VendorShipmentNo)
            {
                Caption = 'Vendor Shipment No.';
                ToolTip = 'Specifies the value of the Vendor Shipment No. field.';
            }
            field(VendorOrderNo; VendorOrderNo)
            {
                Caption = 'Vendor Order No.';
                ToolTip = 'Specifies the value of the Vendor Order No. field.';
            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        PostingDate := WORKDATE();
        DocumentDate := WORKDATE();
    end;

    var
        VendorOrderNo: Code[20];
        VendorShipmentNo: Code[35];
        DocumentDate: Date;
        PostingDate: Date;

    procedure ReturnPostingDate(): Date;
    begin
        exit(PostingDate);
    end;

    procedure ReturnDocumentDate(): Date;
    begin
        exit(DocumentDate);
    end;

    procedure ReturnOrderNo(): Code[20];
    begin
        exit(VendorOrderNo);
    end;

    procedure ReturnShipmentNo(): Code[35];
    begin
        exit(VendorShipmentNo);
    end;
}

