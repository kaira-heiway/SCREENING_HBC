page 58060 "Proforma Invoice Lines"
{
    // Heilite Navision Old Id - 50456

    // version HEI.02

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface
    // HEI.02 CHG2156104 IBM NANDIS01 26.10.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Visible property of "Price from Blanket Order" made false

    // BC Upgrade PATELP08>>
    // Changed name of table from "PFI Lines" to "PFI Lines FND"
    // BC Upgrade PATELP08<<
    
    PageType = ListPart;
    SourceTable = "PFI Lines FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PFI Document No."; Rec."PFI Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the PFI Document No. field.';
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("CMG Code"; Rec."CMG Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the CMG Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Price from Blanket Order"; Rec."Price from Blanket Order")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Price from Blanket Order field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Blanket Order No"; Rec."Blanket Order No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Blanket Order No field.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                }
                field("PO Number"; Rec."PO Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the PO Number field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        //HEI.01>>
        StyleTxt := StyleTxt;
        //HEI.01<<
    end;

    var
        StyleTxt: Text;
}

