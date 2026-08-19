page 58062 "Ibecor Location Matrix"
{
    // Heilite Navision Old Id - 50458

    // version HEI.02

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface
    // HEI.02 CHG2195261 IBM NANDIS01 16.03.2023 # Ibecor Retrofit DCR
    //   # Compiled the page after changing the PK in base table

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Interface Location Matrix" to "Interface Location Matrix FND".
    // BC UPGRADE PATELS08 <<

    PageType = List;
    SourceTable = "Interface Location Matrix FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Global Vendor ID"; Rec."Global Vendor ID")
                {
                    ToolTip = 'Specifies the value of the Global Vendor ID field.';

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
                            Rec."Global Vendor ID" := Vendor."Global Vendor Number FND";
                        end;
                        //HEI.01<<
                    end;
                }
                field("Heilite Location Code"; Rec."Heilite Location Code")
                {
                    ToolTip = 'Specifies the value of the Heilite Location Code field.';
                }
                field("IBC Location Code"; Rec."IBC Location Code")
                {
                    ToolTip = 'Specifies the value of the IBC Location Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

