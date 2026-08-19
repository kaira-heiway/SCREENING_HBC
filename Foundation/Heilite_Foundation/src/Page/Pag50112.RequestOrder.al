page 50112 "Request Order"
{
    // version HEI.01

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Page created
    // 
    // HEI.02  CHG2070625 IBM.AK 08.10.20IBM.AK Added fields 8,9 From-Code, From-Name

    Caption = 'Request Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Request Order Header FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit();
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = EnableEdit;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field("From-Code"; Rec."From-Code")
                {
                    Editable = EnableEdit;
                    ToolTip = 'Specifies the value of the From-Code field.';
                }
                field("From-Name"; Rec."From-Name")
                {
                    ToolTip = 'Specifies the value of the From-Name field.';
                }
                field("To-Code"; Rec."To-Code")
                {
                    Editable = EnableEdit;
                    ToolTip = 'Specifies the value of the To-Code field.';
                }
                field("To-Name"; Rec."To-Name")
                {
                    ToolTip = 'Specifies the value of the To-Name field.';
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    Editable = EnableEdit;
                    ToolTip = 'Specifies the value of the In-Transit Code field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = EnableEdit;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            part(Control55009; "Request Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(Control55011; "Item Invoicing FactBox")
            {
                Provider = Control55009;
                SubPageLink = "No." = FIELD("Item No.");
            }
            part(Control55012; "Request Order Details FactBox")
            {
                Provider = Control55009;
                SubPageLink = "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            group("Request O&rder")
            {
                CaptionML = ENU = 'Request O&rder',
                            FRA = 'O&rdre';
                Image = "Order";
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Release action.';

                    trigger OnAction();
                    begin
                        Rec.ReleaseRequestOrder();
                        CurrPage.UPDATE();
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Reopen action.';

                    trigger OnAction();
                    begin
                        Rec.ReopenRequestOrder();
                        CurrPage.UPDATE();
                    end;
                }
            }
            group("Transfer Orders")
            {
                Caption = 'Transfer Orders';
                action("Create Transfer Orders")
                {
                    Caption = 'Create Transfer Orders';
                    Image = TransferOrder;
                    ToolTip = 'Executes the Create Transfer Orders action.';

                    trigger OnAction();
                    begin
                        Rec.CreateTransferOrders();
                        CurrPage.UPDATE();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        EnableEdit := Rec.Status <> Rec.Status::Released;
    end;

    var
        EnableEdit: Boolean;
}

