report 58003 "Send Master Data to Maximo"
{
    // Heilite Navision Old Id - 58003

    // version HEI.02

    // HEI.02 FDD-PURGAP026 IBM NASTAA02 27.07.2018 # Item Selection Heilite-Maximo Interface
    //   # Used Table 50094 - Maximo Item Category Filter for filtering instead of deleted Field "Maximo Item Category Filter"
    // HEI.03 CHG2077676 IBM POENAB02 10.03.2021 HB1174 Include locations in ItemMD HeiLite->Maximo interface
    //   # Modified trigger Item - OnAfterGetRecord
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in Report and Request page fields.
    // BC Upgrade BHARDA11 <<
    Caption = 'Send Master Data to Maximo';
    ProcessingOnly = true;
    ApplicationArea = ALl;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "No. 2";

            trigger OnAfterGetRecord();
            begin
                //HEI.03>>
                //IF MaximoInterfaceManagement.FindItemFilters(Item) THEN //HEI.02
                //  MaximoInterfaceManagement.CreateItemRequest(Item,FALSE);
                //HEI.03<<

                //HEI.03>>
                if MaximoInterfaceManagement.FindItemFilters(Item) then begin
                    ItemTMP.TRANSFERFIELDS(Item);
                    if ItemTMP.INSERT() then;
                end;
                //HEI.03<<
            end;

            trigger OnPostDataItem();
            var
                lHeaderID: Integer;
                lItem: Record Item;
                lEntryNo: Integer;
                lEntryNoNew: Integer;
            begin
                //HEI.03>>
                ItemTMP.RESET();
                if ItemTMP.FINDFIRST() then begin
                    lHeaderID := MaximoInterfaceManagement.CreateItemRequestGroupHeader();
                    lEntryNo := 0;
                    lEntryNoNew := 0;

                    if lHeaderID <> 0 then
                        repeat
                            lItem.GET(ItemTMP."No.");
                            lEntryNo := MaximoInterfaceManagement.CreateItemRequestGrouped(lHeaderID, lItem, false, lEntryNoNew);
                            lEntryNoNew := lEntryNo;
                        until ItemTMP.NEXT() = 0;
                end;
                //HEI.03<<
            end;

            trigger OnPreDataItem();
            begin
                if not SendItems then
                    CurrReport.BREAK();

                //Item.SETFILTER("Item Category Code",GeneralInterfaceSetup."Maximo Item Category Filter"); HEI.02
            end;
        }
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", "Global Vendor Number FND";

            trigger OnAfterGetRecord();
            begin
                MaximoInterfaceManagement.CreateVendorRequest(Vendor, false);
            end;

            trigger OnPreDataItem();
            begin
                if not SendVendors then
                    CurrReport.BREAK();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(SendItems; SendItems)
                    {
                        ApplicationArea = All;
                        Caption = 'Send Items';
                        ToolTip = 'Specifies the value of the Send Items field.';
                    }
                    field(SendVendors; SendVendors)
                    {
                        ApplicationArea = All;
                        Caption = 'Send Vendors';
                        ToolTip = 'Specifies the value of the Send Vendors field.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        GeneralInterfaceSetup.GET();
    end;

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        MaximoInterfaceManagement: Codeunit "Maximo Interface Management";
        SendItems: Boolean;
        SendVendors: Boolean;
        ItemTMP: Record Item temporary;
}

