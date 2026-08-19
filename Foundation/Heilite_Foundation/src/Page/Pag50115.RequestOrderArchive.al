page 50115 "Request Order Archive"
{
    // version HEI.01

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Page created

    Caption = 'Request Order Archive';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Request Ord Header Archive FND";
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
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.';
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
            part(Control55009; "Request Order Archive Subform")
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
        }
    }
}

