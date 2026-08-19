page 58061 "Ibecor Interface Setup"
{
    // Heilite Navision Old Id - 50457

    // version HEI.03

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface
    // HEI.02 CHG2156104 IBM NANDIS01 17.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # New field shown - Ibecor PO channel
    // HEI.03 CHG2255708 SAHAL01 26.08.2024 Ibecor PFI Acknowledgment Interface
    //   # Added New Field - IBECOR PFI Confmtion Interface

    PageType = Card;
    SourceTable = "Ibecor Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Interface Enable/Disable"; Rec."Interface Enable/Disable")
                {
                    ToolTip = 'Specifies the value of the Interface Enable/Disable field.';
                }
                field("IBECOR Vendor"; Rec."IBECOR Vendor")
                {
                    ToolTip = 'Specifies the value of the IBECOR Vendor field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        VendorList: Page "Vendor List";
                        Vendor: Record Vendor;
                    begin
                        //HEI.01>>
                        VendorList.SETTABLEVIEW(Vendor);
                        VendorList.LOOKUPMODE(true);

                        if VendorList.RUNMODAL() = ACTION::LookupOK then begin
                            VendorList.GETRECORD(Vendor);
                            Rec."IBECOR Vendor" := Vendor."Global Vendor Number FND";
                        end;
                        //HEI.01<<
                    end;
                }
                field("IBC Item Category"; Rec."IBC Item Category")
                {
                    Caption = 'IBECOR Item Category';
                    ToolTip = 'Specifies the value of the IBECOR Item Category field.';
                }
                field("Default CMG"; Rec."Default CMG")
                {
                    ToolTip = 'Specifies the value of the Default CMG field.';
                }
                field("IBECOR PFI"; Rec."IBECOR PFI")
                {
                    ToolTip = 'Specifies the value of the IBECOR PFI field.';
                }
                field("IBECOR PFI Rejection"; Rec."IBECOR PFI Rejection")
                {
                    Caption = 'IBECOR PFI Accept/Reject';
                    ToolTip = 'Specifies the value of the IBECOR PFI Accept/Reject field.';
                }
                field("IBECOR API PO Notification"; Rec."IBECOR API PO Notification")
                {
                    ToolTip = 'Specifies the value of the IBECOR API PO Notification field.';
                }
                field("IBECOR PO"; Rec."IBECOR PO")
                {
                    ToolTip = 'Specifies the value of the IBECOR PO field.';
                }
                field("IBECOR Shipping Agent Code"; Rec."IBECOR Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the IBECOR Shipping Agent Code field.';
                }
                field("Ibecor PO Channel"; Rec."Ibecor PO Channel")
                {
                    ToolTip = 'Specifies the value of the Ibecor PO Channel field.';
                }
                field("IBECOR PFI Confmtion Interface"; Rec."IBECOR PFI Confmtion Interface")
                {
                    ToolTip = 'Specifies the value of the IBECOR PFI Confirmation Interface field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Location Matrix")
            {
                Image = Warehouse;
                RunObject = Page "Ibecor Location Matrix";
                ToolTip = 'Executes the Location Matrix action.';
            }
            action("Logistics Officers")
            {
                Image = Employee;
                RunObject = Page "Logistics Officers";
                ToolTip = 'Executes the Logistics Officers action.';
            }
        }
    }
}

