report 58002 "Send Maximo Unit Cost"
{
    // Heilite Navision Old Id - 50089

    // version HEI.03

    // HEI.01 FDD-PURGAPINT002 IBM LAZARE02 22.12.2017 # New report used to manually send units costs to Maximo
    // HEI.02 HB1986 - CHG2095257 IBM NANDIS01 16.03.2021 - Maximo Unit Cost interface Redesign
    //   # Complete logic change in tis report from the existing one
    // HEI.03 HB3985-CHG2257892 IBM PATHAA02 25.07.2024 Send Unit Cost To Maximo | Sending More Than One Technical Zone to Maximo
    //   # Code Changes to Include all Technical Zones
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in report and requestpage fields.
    // BC Upgrade BHARDA11 <<

    // BC Upgrade PATELP08>>
    // Changed name of table from "Last Send Interface Values" to "Last Send Interface Values FND"
    // BC Upgrade PATELP08<<

    Caption = 'Send Maximo Unit Cost';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);
            MaxIteration = 1;

            trigger OnAfterGetRecord();
            begin
                grec_MaximoUnitCostInterface.RESET();
                if (itemcategory <> '') then
                    grec_MaximoUnitCostInterface.SETRANGE("Item Category Code", itemcategory);
                if (GenProdPostGrp <> '') then
                    grec_MaximoUnitCostInterface.SETRANGE("Gen Prod Posting Group", GenProdPostGrp);
                if (ItemNo <> '') then
                    grec_MaximoUnitCostInterface.SETFILTER(grec_MaximoUnitCostInterface."Item No", ItemNo);
                if grec_MaximoUnitCostInterface.findset() then
                    repeat
                        grec_MaximoUnitCostInterface.DELETEALL();
                    until grec_MaximoUnitCostInterface.NEXT() = 0;

                CLEAR(InterfaceEntryHeaderOut);
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo Unit Cost Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
                InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryHeaderOut.INSERT(true);

                grec_Item.RESET();
                if (itemcategory <> '') then
                    grec_Item.SETRANGE("Item Category Code", itemcategory);
                if (GenProdPostGrp <> '') then
                    grec_Item.SETRANGE("Gen. Prod. Posting Group", GenProdPostGrp);
                if (ItemNo <> '') then
                    grec_Item.SETFILTER("No.", ItemNo);
                if grec_Item.findset() then
                    repeat
                        if FindItemFilters(grec_Item) then begin
                            SKU.RESET();
                            SKU.SETRANGE("Item No.", grec_Item."No.");
                            SKU.SETFILTER("Location Code", GeneralInterfaceSetup."Maximo Location Filter");
                            if SKU.findset() then
                                repeat
                                    SKU.CALCFIELDS(Description);
                                    grec_MaximoUnitCostInterface.RESET();
                                    grec_MaximoUnitCostInterface.SETRANGE(grec_MaximoUnitCostInterface."Item No", SKU."Item No.");
                                    grec_MaximoUnitCostInterface.SETRANGE(grec_MaximoUnitCostInterface."Location Code", SKU."Location Code");
                                    if not grec_MaximoUnitCostInterface.FINDFIRST() then begin
                                        //insert outb intr Line
                                        Zone.RESET();
                                        Zone.SETRANGE(Zone."Location Code", SKU."Location Code");
                                        Zone.SETRANGE(Zone."Use As Technical Zone FND", true);
                                        //IF Zone.FINDFIRST THEN BEGIN//HEI.03
                                        if Zone.findset(false) then
                                            repeat //HEI.03
                                                CLEAR(InterfaceEntryLineOut);
                                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                                EntryNo := EntryNo + 1;
                                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                                InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
                                                InterfaceEntryLineOut."No." := SKU."Item No." + '-' + CompanyInformation."Legal Entity Code FND";
                                                InterfaceEntryLineOut."Location Code" := SKU."Location Code";
                                                InterfaceEntryLineOut."Zone Code" := Zone.Code;
                                                InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                                                InterfaceEntryLineOut."Unit Amount" := SKU."Unit Cost";
                                                InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(grec_Item."Base Unit of Measure");
                                                InterfaceEntryLineOut.INSERT(true);
                                                //Insert Maximo Unit Cost Table
                                                CLEAR(grec_MaximoUnitCostInterfaceInsert);

                                                grec_MaximoUnitCostInterfaceInsert."Item No" := SKU."Item No.";
                                                grec_MaximoUnitCostInterfaceInsert."Item Description" := SKU.Description;
                                                grec_MaximoUnitCostInterfaceInsert."Unit Of Measure" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(grec_Item."Base Unit of Measure");
                                                grec_MaximoUnitCostInterfaceInsert."Interface Code" := GeneralInterfaceSetup."Maximo Unit Cost Interface";
                                                grec_MaximoUnitCostInterfaceInsert."Direct Unit Cost" := SKU."Unit Cost";
                                                grec_MaximoUnitCostInterfaceInsert."Location Code" := SKU."Location Code";
                                                grec_MaximoUnitCostInterfaceInsert."Zone Code" := Zone.Code;
                                                grec_MaximoUnitCostInterfaceInsert."Gen Prod Posting Group" := grec_Item."Gen. Prod. Posting Group";
                                                grec_MaximoUnitCostInterfaceInsert."Item Category Code" := grec_Item."Item Category Code";
                                                grec_MaximoUnitCostInterfaceInsert."Send Date" := TODAY;
                                                grec_MaximoUnitCostInterfaceInsert.INSERT(true);
                                            //END; //HEI.03
                                            until Zone.NEXT() = 0; //HEI.03
                                    end;
                                until SKU.NEXT() = 0;
                        end;
                    until grec_Item.NEXT() = 0;

                Window.CLOSE();
            end;

            trigger OnPostDataItem();
            begin
                MESSAGE(OutboundInterfaceEntryCreatedMsg);
            end;

            trigger OnPreDataItem();
            begin
                GetGeneralInterfaceSetup();
                GetCompanyInformation();

                InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Unit Cost Interface");
                if not InterfaceSetup.Enabled then
                    exit;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control55001)
                {
                    ShowCaption = false; //BC UPGRADE ATHUKS01
                    field("Item Category Code"; itemcategory)
                    {
                        ApplicationArea = All;
                        TableRelation = "Item Category";
                        ToolTip = 'Specifies the value of the itemcategory field.';
                    }
                    field("Gen Prod Posting Group"; GenProdPostGrp)
                    {
                        ApplicationArea = All;
                        TableRelation = "Gen. Product Posting Group";
                        ToolTip = 'Specifies the value of the GenProdPostGrp field.';
                    }
                    field("Item No"; ItemNo)
                    {
                        ApplicationArea = All;
                        TableRelation = Item;
                        ToolTip = 'Specifies the value of the ItemNo field.';
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
        if not CONFIRM(SendUnitCostsQst) then
            exit;

        Window.OPEN(WindowTxt);
        //MaximoInterfaceManagement.CreateUnitCost;
    end;

    var
        // MaximoInterfaceManagement: Codeunit "Maximo Interface Management";
        SendUnitCostsQst: Label 'Do you want to send unit costs to Maximo?';
        WindowTxt: Label 'Generating outbound interface entries...';
        OutboundInterfaceEntryCreatedMsg: Label 'The outbound interface entry has been created.';
        Window: Dialog;
        itemcategory: Code[20];
        GenProdPostGrp: Code[10];
        CompanyInformationRead: Boolean;
        CompanyInformation: Record "Company Information";
        GeneralInterfaceSetupRead: Boolean;
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        SKU: Record "Stockkeeping Unit";
        grec_Item: Record Item;
        MaximoItemCategoryFilter: Record "Maximo Item Category Flter INT";
        grec_MaximoUnitCostInterface: Record "Last Send Interface Values FND";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        Zone: Record Zone;
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        EntryNo: Integer;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        grec_MaximoUnitCostInterfaceInsert: Record "Last Send Interface Values FND";
        ItemNo: Text;

    local procedure GetCompanyInformation();
    begin
        if not CompanyInformationRead then
            CompanyInformation.GET();
        CompanyInformationRead := true;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET();
        GeneralInterfaceSetupRead := true;
    end;

    procedure FindItemFilters(Item: Record Item): Boolean;
    var
        DefaultDimensions: Record "Default Dimension";
    begin
        //HEI.05>>
        if DefaultDimensions.GET(DATABASE::Item, Item."No.", 'CMG') then; //HEI.06

        MaximoItemCategoryFilter.SETRANGE("Item Category", Item."Item Category Code");
        MaximoItemCategoryFilter.SETRANGE("Gen. Prod. Posting Group", Item."Gen. Prod. Posting Group");
        MaximoItemCategoryFilter.SETRANGE("CMG Code", DefaultDimensions."Dimension Value Code"); //HEI.06
        if MaximoItemCategoryFilter.FINDFIRST() then
            exit(true);
        MaximoItemCategoryFilter.RESET();
        MaximoItemCategoryFilter.SETRANGE("Item Category", Item."Item Category Code");
        MaximoItemCategoryFilter.SETRANGE("Gen. Prod. Posting Group", Item."Gen. Prod. Posting Group");
        MaximoItemCategoryFilter.SETRANGE("CMG Code", ''); //HEI.06
        if MaximoItemCategoryFilter.FINDFIRST() then
            exit(true);
        MaximoItemCategoryFilter.RESET();
        MaximoItemCategoryFilter.SETRANGE("Item Category", Item."Item Category Code");
        MaximoItemCategoryFilter.SETRANGE("Gen. Prod. Posting Group", '');
        MaximoItemCategoryFilter.SETRANGE("CMG Code", ''); //HEI.06
        if MaximoItemCategoryFilter.FINDFIRST() then
            exit(true);
        //HEI.05<<
    end;
}

