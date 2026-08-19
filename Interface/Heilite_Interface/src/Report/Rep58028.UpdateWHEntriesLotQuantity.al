report 58028 "Update WH Entries Lot Quality"
{
    //BC Upgrade GUNREM01 Old ID-50594
    // version HEI.03

    // HEI.01 CHG2174979 IBM GOKULS01 28/09/2022
    //   # Report Created to update unavailable stock (Quality) and Quality status should be same as Lot no. Information card.
    // HEI.02 CHG2178880 IBM PRASAA03 26/10/2022
    //   # Logic Changed to Unavailable Stock (Quality) Field update
    // HEI.03 CHG2184613 IBM PRASAA03 06/12/2022 #Update Warehouse Entries
    //   # Report name changed and code optimized

    Permissions = TableData "Warehouse Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Lot No. Information"; "Lot No. Information")
        {
            DataItemTableView = SORTING("Item No.", "Variant Code", "Lot No.");
            dataitem("Warehouse Entry"; "Warehouse Entry")
            {
                DataItemLink = "Item No." = FIELD("Item No."), "Lot No." = FIELD("Lot No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord();
                var
                    InventorySetup: Record "Inventory Setup";
                begin
                    //HEI.03>>
                    //   "Quality Status" := "Lot No. Information"."Quality Status"; //BC Upgrade GUNREM01 DIT field
                    if "Inspection Status FND" = InventorySetup."Quality Blocked FND" then //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
                        "Unavail. Stock (Quality) FND" := true
                    else
                        "Unavail. Stock (Quality) FND" := false;
                    MODIFY;
                    COMMIT;
                    /*
                    IF "Warehouse Entry"."Quality Status" = "Lot No. Information"."Quality Status" THEN
                      CurrReport.SKIP
                    ELSE
                      BEGIN
                        WHentry.RESET;
                        WHentry.GET("Warehouse Entry"."Entry No.");
                        WHentry."Quality Status" := "Lot No. Information"."Quality Status";
                        //HEI.02>>
                        //WHentry."Unavailable Stock (Quality)" := FALSE;
                        IF WHentry."Quality Status" = WHentry."Quality Status"::Blocked THEN
                          WHentry."Unavailable Stock (Quality)" := TRUE
                        ELSE
                          WHentry."Unavailable Stock (Quality)" := FALSE;
                        //HEI.02<<
                        WHentry.MODIFY;
                        END;
                    *///HEI.03<<

                end;

                trigger OnPreDataItem();
                begin
                    // SETFILTER("Quality Status", '<>%1', "Lot No. Information"."Quality Status");//HEI.03 //BC Upgrade GUNREM01 DIT field
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        WHentry: Record "Warehouse Entry";
}

