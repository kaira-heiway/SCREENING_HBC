report 53034 "Spare Parts ConsumedBAH"
{
    // version HEI.01

    // BC Upgrade KUMARR78 >>
    // Report Name  : Spare Parts ConsumedBAH
    // Old Report ID: 50202 (NAV)
    // 1. Added Business Central report visibility properties.
    //    Old: ApplicationArea and UsageCategory were not defined at report level.
    //    New: 
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //    Reason: Required for report discoverability and role-based visibility in BC.
    // 2. Added ApplicationArea property to Request Page fields.
    //    Old: ApplicationArea not defined on request page fields.
    //    New: ApplicationArea = All added to:
    //         - Project Code field
    //         - Item Description field
    //    Reason: Mandatory property requirement in Business Central.
    // 3. Updated OnLookup trigger signature to meet BC method definition.
    //    Old: trigger OnLookup(Text: Text): Boolean;
    //    New: trigger OnLookup(var Text: Text): Boolean;
    //    Reason: BC requires VAR parameter in OnLookup trigger signature.
    // 4. Replaced deprecated GetSelectionFilter function (removed in BC).
    //    Old: ItemLedgerEntries.GetSelectionFilter();
    //    New: CU_HenikenBCUpgrade.GetSelectionFilterForILE(ItemLedgerEntries1);
    //    Reason: Standard function removed in BC; replaced with custom Codeunit logic.
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding UsageCategory
    RDLCLayout = '.\src\ReportsLayout\Spare Parts ConsumedBAH.rdl';


    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Entry Type" = const(Consumption));
            RequestFilterFields = "Posting Date", "Item No.";
            column(CompanyName; CompanyName)
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(PostingDate; "Item Ledger Entry"."Posting Date")
            {
            }
            column(Item; "Item Ledger Entry"."Item No.")
            {
            }
            column(ItemDescription; "Item Ledger Entry".Description)
            {
            }
            column(ProjectCode; "Item Ledger Entry"."Project Code FND")
            {
            }
            column(LocationCode; "Item Ledger Entry"."Location Code")
            {
            }
            column(Quantity; "Item Ledger Entry".Quantity)
            {
            }
            column(UOM; "Item Ledger Entry"."Unit of Measure Code")
            {
            }
            column(ProjectDesc; ProjectDesc)
            {
            }
            column(ReportHeader; ReportLable)
            {
            }
            column(ConsumedValue; ConsumedValue)
            {
            }

            trigger OnAfterGetRecord();
            var
                Item: Record Item;
            begin
                Clear(ProjectDesc);
                Clear(ConsumedValue);

                Project.Reset;
                if Project.Get("Item Ledger Entry"."Project Code FND") then
                    ProjectDesc := Project.Description;

                if Item.Get("Item Ledger Entry"."Item No.") then
                    ConsumedValue := "Item Ledger Entry".Quantity * Item."Unit Cost";
            end;

            trigger OnPreDataItem();
            var
                postingdateCon: Date;
                day: Integer;
                month: Integer;
                year: Integer;
            begin

                ManufacturingSetup.Get;
                ManufacturingSetup.TestField("SP Item Category Filter FND");
                SetFilter("Item Category Code", ManufacturingSetup."SP Item Category Filter FND");

                ItemFilter := "Item Ledger Entry".GetFilter("Item Ledger Entry"."Item No.");
                //PostingDateFilter := "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Posting Date");

                /*  EVALUATE(year, COPYSTR(PostingDateFilter,7,4));
                  EVALUATE(day, COPYSTR(PostingDateFilter,4,2));
                  EVALUATE(month, COPYSTR(PostingDateFilter,1,2));

              //PostingDateFilter := FORMAT(PostingDateFilter,0,'<Day,2>,<Month,2>,<Year4>');

              MESSAGE(PostingDateFilter);*/

                //postingdateCon := DMY2DATE(day,month,year);
                //postingdateCon := FORMAT(postingdateCon,10,'<Day,2>/<Month,2>,<Year4>');

                //IF PostingDateFilter <> '' THEN
                //  "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Posting Date",postingdateCon);

                //IF ItemFilter <> '' THEN
                //"Item Ledger Entry".SETFILTER("Item Ledger Entry"."Item No.",ItemFilter);

                if ProjectCodeFilter <> '' then
                    "Item Ledger Entry".SetFilter("Item Ledger Entry"."Project Code FND", ProjectCodeFilter);

                if ItemDescFilter <> '' then
                    "Item Ledger Entry".SetFilter("Item Ledger Entry".Description, ItemDescFilter);

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(GENERAL)
                {
                    field("Project Code"; ProjectCodeFilter)
                    {
                        Lookup = true;
                        ApplicationArea = All;//BC Upgrade KUMARR78

                        // trigger OnLookup(Text: Text): Boolean; //BC Upgrade KUMARR78 Blocking due to VAR missing from Paratmeters
                        trigger OnLookup(var Text: Text): Boolean;  //BC Upgrade KUMARR78 Adding VAR was missing from Paratmeters
                        var
                            Project1: Record "Project FND";
                            strlnlength: Integer;
                            String1: Text[50];
                            String2: Text[50];
                            ProjFilterText: Text[1024];
                        begin
                            Clear(ProjectList);
                            ProjectList.LookupMode := true;
                            /*
                            Project1.RESET;
                            Project1.SETCURRENTKEY(Description);
                            
                            IF Text <>'' THEN BEGIN
                              String1 := COPYSTR(Text,1,1);
                              String2 := COPYSTR(Text,STRLEN(Text),(STRLEN(Text)-1));
                            END;
                            
                            IF (String1 = '*') AND (String2 <> '*') THEN
                              Project1.SETFILTER(Description,'*'+Text)
                            ELSE IF (String1 <> '*') AND (String2 = '*') THEN
                              Project1.SETFILTER(Description,Text +'*')
                            ELSE IF (String1 = '*') AND (String2 = '*') THEN
                              Project1.SETFILTER(Description,'*'+ Text +'*');
                            
                            ProjectList.SETTABLEVIEW(Project1);
                            */
                            if ProjectList.RunModal = Action::LookupOK then begin
                                if Text <> '' then
                                    Text := Text + '|';
                                Text := Text + ProjectList.GetSelectionFilter;
                                //Text :=ProjectList.GetSelectionFilter;
                                ProjectCodeFilter := Text;
                            end;
                            Clear(ProjectList);

                        end;
                    }
                    field("Item Description"; ItemDescFilter)
                    {
                        ApplicationArea = All;//BC Upgrade KUMARR78
                        trigger OnLookup(var Text: Text): Boolean;
                        var
                            ItemLedgerEntries1: Record "Item Ledger Entry";
                            String1: Text[50];
                            String2: Text[50];
                        begin

                            Clear(ItemLedgerEntries);
                            ItemLedgerEntries.LookupMode := true;

                            ItemLedgerEntries1.Reset;
                            ItemLedgerEntries1.SetCurrentKey(Description);

                            if Text <> '' then begin
                                String1 := CopyStr(Text, 1, 1);
                                String2 := CopyStr(Text, StrLen(Text), (StrLen(Text) - 1));
                            end;

                            if (String1 = '*') and (String2 <> '*') then
                                ItemLedgerEntries1.SetFilter(Description, '*' + Text)
                            else if (String1 <> '*') and (String2 = '*') then
                                ItemLedgerEntries1.SetFilter(Description, Text + '*')
                            else if (String1 = '*') and (String2 = '*') then
                                ItemLedgerEntries1.SetFilter(Description, '*' + Text + '*');

                            ItemLedgerEntries.SetTableView(ItemLedgerEntries1);
                            if ItemLedgerEntries.RunModal = Action::LookupOK then begin
                                if Text <> '' then
                                    // Text := ItemLedgerEntries.GetSelectionFilter; //BC Upgrade KUMARR78 Blocking As Function was Removed in BC.
                                    Text := CU_HenikenBCUpgrade.GetSelectionFilterForILE(ItemLedgerEntries1); //BC Upgrade KUMARR78 Adding As Used Function was Removed in BC.
                                ItemDescFilter := Text;
                            end;
                            Clear(ItemLedgerEntries);
                        end;
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
        PostingDatelbl = 'Posting Date'; Itemlbl = 'Item'; ItemDesclbl = 'Item Description'; ProjectCodelbl = '"Project FND" Code'; ProjectDesclbl = 'Porject Description'; Locationlbl = 'Location'; Qtylbl = 'Quantity'; Consumedvaluelbl = 'Consumed Value'; BUMlbl = 'Base Unit Of Measure';
    }

    var
        ManufacturingSetup: Record "Manufacturing Setup";
        Project: Record "Project FND";
        ItemLedgerEntries: Page "Item Ledger Entries";
        ProjectList: Page "Project List";
        ConsumedValue: Decimal;
        ReportLable: Label 'Spares Parts Consumptions.';
        ProjectDesc: Text[250];
        ItemDescFilter: Text[1024];
        ItemFilter: Text[1024];
        PostingDateFilter: Text[1024];
        ProjectCodeFilter: Text[1024];
        Text: Text[1024];
        CU_HenikenBCUpgrade: Codeunit "Heineken BC Upgrade";
}

