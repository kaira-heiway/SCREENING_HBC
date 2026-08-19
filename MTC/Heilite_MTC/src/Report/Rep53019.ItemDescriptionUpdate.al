report 53019 "Item Description-Update"
{
    // version HEI.01

    // HEI.01 #FDD-GAPID013-19/07/2017, PATHAA02
    // Report developed to update Item Description
    // 
    // HEI.02 CHG2134457- 10-11-2021 SURYAS01
    // # TO fix Description 2 issue not updated on item card from Mendix

    // BC Upgrade RAHUL>>
    // 1. Added Business Central report discoverability properties.
    //    Old: ApplicationArea property not defined at report level.
    //    New: ApplicationArea = All added at report level.
    //    Old: UsageCategory property not defined at report level.
    //    New: UsageCategory = ReportsAndAnalysis added at report level.
    //
    // 2. Converted report to ProcessingOnly as report is used only for data update.
    //    Old: DefaultLayout = RDLC with blank/unused RDLC layout.
    //         RDLCLayout = '.\src\ReportsLayout\Item Description-Update.rdl'.
    //    New: ProcessingOnly = true.
    //         RDLCLayout blocked/commented as layout is not required for processing-only execution.
    //
    // 3. No functional changes done in business logic.
    //    - Existing HEI.02 logic retained for updating Item Description and Description 2 using Item Translation.
    //    - CompanyInformation Language Code based processing remains same.
    //    - Message shown after processing remains same.
    // BC Upgrade RAHUL<<

    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory
    ProcessingOnly = true; // BC Upgrade RAHUL Adding As it is for Data Updation and Had Blank Layout.
    // RDLCLayout = '.\src\ReportsLayout\Item Description-Update.rdl'; // BC Upgrade RAHUL Blocking Layout As ProcessingOnly Report.

    dataset
    {
        dataitem(Item1; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                //<<HEI.02 - Commented Exisiting Code
                /*
                CompanyInformation.GET();
                IF (CompanyInformation."Language Code" <> 'ENU') AND (CompanyInformation."Language Code" <> '') THEN BEGIN
                    ItemTranslation.RESET;
                    ItemTranslation.SETRANGE("Item No.","No.");
                    ItemTranslation.SETRANGE("Language Code",CompanyInformation."Language Code");
                    IF ItemTranslation.FINDFIRST THEN BEGIN
                      IF Item1."Description 2" = '' THEN
                        Item1."Description 2" := Item1.Description;
                      Item1.Description := ItemTranslation.Description;
                      Item1.MODIFY;
                    END;
                END ELSE BEGIN
                  ItemTranslation.RESET;
                  ItemTranslation.SETRANGE("Item No.","No.");
                  ItemTranslation.SETRANGE("Language Code",'ENU');
                  IF ItemTranslation.FINDFIRST THEN BEGIN
                    Item1.Description := ItemTranslation.Description;
                    //Item1."Description 2" := '';
                    Item1."Description 2" := Item1.Description;
                    Item1.MODIFY;
                   END ELSE BEGIN
                    Item1.Description := Item1."Description 2";
                   // Item1."Description 2" := '';
                    Item1.MODIFY;
                  END;
                END;
                */
                //>>HEI.02

                //<<HEI.02
                CompanyInformation.GET();
                if (CompanyInformation."Language Code FND" <> 'ENU') and (CompanyInformation."Language Code FND" <> '') then begin
                    ItemTranslation.RESET();
                    ItemTranslation.SETRANGE("Item No.", "No.");
                    // ItemTranslation.SETRANGE("Language Code",CompanyInformation."Language Code");
                    if ItemTranslation.FINDSET() then
                        repeat
                            // IF Item1."Description 2" = '' THEN
                            if ItemTranslation."Language Code" = 'ENG' then
                                Item1."Description 2" := ItemTranslation.Description
                            else
                                Item1.Description := ItemTranslation.Description;
                            Item1.MODIFY();
                        until ItemTranslation.NEXT() = 0;

                end else begin
                    ItemTranslation.RESET();
                    ItemTranslation.SETRANGE("Item No.", "No.");
                    ItemTranslation.SETRANGE("Language Code", 'ENU');
                    if ItemTranslation.FINDFIRST() then begin
                        Item1.Description := ItemTranslation.Description;
                        //Item1."Description 2" := '';
                        Item1."Description 2" := Item1.Description;
                        Item1.MODIFY();
                        // END ELSE BEGIN
                        //Item1.Description := Item1."Description 2";
                        // Item1."Description 2" := '';
                        //Item1.MODIFY;
                    end;
                end;
                //>>HEI.02

            end;

            trigger OnPostDataItem();
            begin
                MESSAGE('%1', 'All items Description have been updated');
            end;
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
        CompanyInformation: Record "Company Information";
        ItemTranslation: Record "Item Translation";
}

