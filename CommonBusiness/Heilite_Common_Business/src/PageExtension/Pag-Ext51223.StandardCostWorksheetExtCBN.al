pageextension 51223 StandardCostWorksheetExtCBN extends "Standard Cost Worksheet"
{
    // version NAVW110.0.00.16996,DITW110.00.08,HEI.04
    // DITW18.00.06 MSF 16/02/2015 DIT-770 #1185  Added Fields "Location code" "Variant code"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7

    //   HEI.01 CHG2157335 HB2876 NORRIQ KOROLA04 04.08.2022
    //     #New fields added - Production BOM No., Routing No., WCCode, WCCost, BatchSize, SetupTime, Run Time, LotSize
    //     #New action added - CurrWkshNameOnAfterValidate
    //   HEI.02 CHG2214181 PRASAA03 05.12.2023 STD COST WORKSHEET/ AUTOMATIC UPDATE FOR ITEM CARD/ALL LOCATIONS
    //     #New action added - UpdateNewStdCost
    //     #New Function added - UpdateStdCost
    //   HEI.03 CHG2214181 PRASAA03 18.12.2023 STD COST WORKSHEET/ AUTOMATIC UPDATE FOR ITEM CARD/ALL LOCATIONS
    //     #Condition Added to include all Replinishment lines.
    //   HEI.04 CHG2234778 PRASAA03 20.02.2024 Standard cost update/ all locations for purchased items
    //     #functiona and action added to update direct unit cost for only purchase item.
    //     #Name and caption changed for update UpdateNewStdCost action.
    //************************************************************//
    //1.HEI.01 Fields added & CurrWkshNameOnAfterValidate Action is not found in NAV Object only can see Base procedure   
    //2.HEI.02 Added Action & function.
    //3.HEI.03 No changes
    //4.HEI.04 No changes.
    //5.Commented Action NewStdCostDetails is navigate to Page Std. Cost Details and page source table is "COGS Alloc STD Price Line FND"
    //as online excel mention that dependncy on aptean.
    //6. Commented action ImpementStandardCostBasedOnComp is navigate Report "Implement Standard Cost" & report is depency
    //on Abhay work Items.    

    layout
    {
        modify(CurrWkshName)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the Standard Cost Worksheet.', FRA = 'Spécifie le nom de la feuille coût standard.';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            ToolTipML = ENU = 'Specifies the type of worksheet line.', FRA = 'Spécifie le type de ligne feuille.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the item number, work center number or machine center number, depending on the Type of the worksheet line.', FRA = 'Spécifie le numéro d''article, le numéro du centre de charge ou le numéro du poste de charge, selon le type de la ligne feuille.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the worksheet line.', FRA = 'Spécifie la description de la ligne feuille.';
        }
        modify("Standard Cost")
        {
            ToolTipML = ENU = 'Specifies the standard cost.', FRA = 'Spécifie le coût standard.';
        }
        modify("New Standard Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the indirect cost percentage.', FRA = 'Spécifie le pourcentage de coût indirect.';
        }
        modify("New Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Overhead Rate")
        {
            ToolTipML = ENU = 'Specifies the overhead rate.', FRA = 'Spécifie les frais généraux.';
        }
        modify("New Overhead Rate")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify(Implemented)
        {
            ToolTipML = ENU = 'Specifies that you have run the Implement Standard Cost Changes batch job.', FRA = 'Indique que vous avez exécuté le traitement par lots Appliquer nouv. coût standard.';
        }
        modify("Replenishment System")
        {
            ToolTipML = ENU = 'Specifies the replenishment method for the items, for example, purchase or prod. order.', FRA = 'Spécifie la méthode de réapprovisionnement des articles, par exemple, commande achat ou ordre de fabrication.';
        }
        modify("Single-Lvl Material Cost")
        {
            ToolTipML = ENU = 'Specifies the single-level material cost of the item.', FRA = 'Spécifie le coût matière mono-niveau de l''article.';
        }
        modify("New Single-Lvl Material Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Single-Lvl Cap. Cost")
        {
            ToolTipML = ENU = 'Specifies the single-level capacity cost of the item.', FRA = 'Spécifie le coût capacité mono-niveau de l''article.';
        }
        modify("New Single-Lvl Cap. Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Single-Lvl Subcontrd Cost")
        {
            ToolTipML = ENU = 'Specifies the single-level subcontracted cost of the item.', FRA = 'Spécifie le coût sous-traité mono-niveau de l''article.';
        }
        modify("New Single-Lvl Subcontrd Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Single-Lvl Cap. Ovhd Cost")
        {
            ToolTipML = ENU = 'Specifies the single-level capacity overhead cost of the item.', FRA = 'Spécifie les frais généraux capacité mono-niveau de l''article.';
        }
        modify("New Single-Lvl Cap. Ovhd Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Single-Lvl Mfg. Ovhd Cost")
        {
            ToolTipML = ENU = 'Specifies the single-level manufacturing overhead cost of the item.', FRA = 'Spécifie les frais généraux production mono-niveau de l''article.';
        }
        modify("New Single-Lvl Mfg. Ovhd Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Rolled-up Material Cost")
        {
            ToolTipML = ENU = 'Specifies the rolled-up material cost of the item.', FRA = 'Spécifie le coût matière multi-niveau de l''article.';
        }
        modify("New Rolled-up Material Cost")
        {
            ToolTipML = ENU = 'Specifies the updated rolled-up material cost based on either the batch job or what you have entered manually.', FRA = 'Spécifie le coût matériel multi-niveau mis à jour selon le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Rolled-up Cap. Cost")
        {
            ToolTipML = ENU = 'Specifies the rolled-up capacity cost of the item.', FRA = 'Spécifie le coût capacité multi-niveau de l''article.';
        }
        modify("New Rolled-up Cap. Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Rolled-up Subcontrd Cost")
        {
            ToolTipML = ENU = 'Specifies the rolled-up subcontracted cost of the item.', FRA = 'Spécifie le coût sous-traité multi-niveau de l''article.';
        }
        modify("New Rolled-up Subcontrd Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Rolled-up Cap. Ovhd Cost")
        {
            ToolTipML = ENU = 'Specifies the rolled-up capacity overhead cost of the item.', FRA = 'Spécifie les frais généraux capacité multi-niveau de l''article.';
        }
        modify("New Rolled-up Cap. Ovhd Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }
        modify("Rolled-up Mfg. Ovhd Cost")
        {
            ToolTipML = ENU = 'Specifies the rolled-up manufacturing overhead cost of the item.', FRA = 'Spécifie les frais généraux production multi-niveau de l''article.';
        }
        modify("New Rolled-up Mfg. Ovhd Cost")
        {
            ToolTipML = ENU = 'Specifies the updated value based on either the batch job or what you have entered manually.', FRA = 'Spécifie la valeur mise à jour basée sur le traitement par lots ou les informations que vous avez saisies manuellement.';
        }

        //Unsupported feature: CodeInsertion on "Type(Control 61)". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //var
        //  CalculateFields: Integer;
        //begin
        /*
        */
        //end;
        //BC UPGRADE SIVA >> Drink IT fields
        // addafter(Description)
        // {
        //     field("Location Code"; Rec."Location Code")
        //     {
        //         ApplicationArea = all;

        //     }


        //     field("Variant Code"; Rec."Variant Code")
        //     {
        //         ApplicationArea = all;

        //     }
        // }
        //BC UPGRADE SIVA << Drink IT fields
        addafter("New Rolled-up Mfg. Ovhd Cost")
        {
            field("Production BOM No."; Rec."Production BOM No. FND")
            {
                Description = 'HEI.01';
                Editable = false;
                LookupPageID = "Production BOM";
                TableRelation = "Production BOM Header";
                ApplicationArea = all;
            }
            field("Routing No."; Rec."Routing No. FND")
            {
                ApplicationArea = ALL;
                Description = 'HEI.01';
                Editable = false;
                LookupPageID = Routing;
                TableRelation = "Routing Header";
            }
            field(WCCode; RoutingLine."No.")
            {
                ApplicationArea = all;
                Caption = 'Work Center Code';
                Description = 'HEI.01';
                Editable = false;
                LookupPageID = "Work Center Card";
                TableRelation = "Work Center";
                ToolTip = 'Work Center Code';
            }
            field(WCCost; WorkCenter."Direct Unit Cost")
            {
                ApplicationArea = all;
                Caption = 'Work Center Cost';
                Description = 'HEI.01';
                Editable = false;
                ToolTip = 'Work Center Code';

            }
            field(BatchSize; RoutingLine."Batch Size FND")
            {
                ApplicationArea = all;
                Caption = 'Batch Size';
                Description = 'HEI.01';
                Editable = false;
                ToolTip = 'Batch Size';
            }
            field(SetupTime; RoutingLine."Setup Time")
            {
                ApplicationArea = all;
                Caption = 'Setup Time';
                Description = 'HEI.01';
                Editable = false;
                ToolTip = 'Setup Time';

            }
            field(RunTime; RoutingLine."Run Time")
            {
                ApplicationArea = all;
                Caption = 'Run Time';
                Description = 'HEI.01';
                Editable = false;
                ToolTip = 'Run Time';
            }
            field(LotSize; RoutingLine."Lot Size")
            {
                ApplicationArea = all;
                Caption = 'Lot Size';
                Description = 'HEI.01';
                Editable = false;
                ToolTip = 'Lot Size';
            }
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Suggest I&tem Standard Cost")
        {
            CaptionML = ENU = 'Suggest I&tem Standard Cost', FRA = 'S&uggérer coût std article';
        }
        modify("Suggest &Capacity Standard Cost")
        {
            CaptionML = ENU = 'Suggest &Capacity Standard Cost', FRA = 'S&uggérer le coût standard de la capacité';
        }
        modify("Copy Standard Cost Worksheet")
        {
            CaptionML = ENU = 'Copy Standard Cost Worksheet', FRA = 'Copier feuille coût standard';
        }
        modify("Roll Up Standard Cost")
        {
            CaptionML = ENU = 'Roll Up Standard Cost', FRA = 'Calculer coût std multi-niv.';
        }
        modify("&Implement Standard Cost Changes")
        {
            CaptionML = ENU = '&Implement Standard Cost Changes', FRA = '&Appliquer nouv. coût standard';
        }
        addafter("&Implement Standard Cost Changes")
        {
            //BC UPGRADE SIVA >>dependencies  Abhay Report
            action(ImpementStandardCostBasedOnComp)  //BC Upgrade KAIRAR01 PID-521 BPM001 
            {
                ApplicationArea = all;
                Caption = 'Implement Standard Cost Based On Components';
                Image = ImplementCostChanges;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Implement Standard Cost CBN";
                ToolTip = 'Implement Standard Cost Based On Components';
            }
            //BC UPGRADE SIVA << dependencies  Abhay Report


            //BC UPGRADE SIVA >> Drink IT Table
            action(NewStdCostDetails)  //BC Upgrade KAIRAR01 PID-521 BPM001 
            {
                ApplicationArea = all;
                Caption = 'New Std. Cost Details';
                Image = ImplementPriceChange;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'New Std. Cost Details';

                trigger OnAction();
                var
                    StdCostDetailsNewPage: Page "Std. Cost Details CBN";
                begin
                    //HEI.01 >>
                    StdCostDetailsNewPage.SetContextRecord(Rec);
                    StdCostDetailsNewPage.RUN;
                    // HEI.01 <<
                end;
            }
            //BC UPGRADE SIVA << Drink IT Table
            action("UpdateNewStdCost-Production")
            {
                ApplicationArea = all;
                Caption = 'UpdateNewStdCost-Production';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'UpdateNewStdCost-Production';

                trigger OnAction();
                begin
                    UpdateStdCost();//HEI.02
                    //HEI.04-Action name changed.
                end;
            }
            action("UpdateNewStdCost-Purchase")
            {
                ApplicationArea = all;
                Caption = 'UpdateNewStdCost-Purchase';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'UpdateNewStdCost-Purchase';

                trigger OnAction();
                begin
                    UpdateStdCost2();//HEI.04
                end;
            }
        }
    }


    //Unsupported feature: PropertyModification on "DefaultNameTxt(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DefaultNameTxt : ENU=Default;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DefaultNameTxt : ENU=Default;FRA=Par défaut;
    //Variable type has not been exported.

    var
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
        Text50000: Label 'Do you want to update the Lines ?';
        Text50001: Label 'Lines updated successfully.';


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    //HEI.01 >>
    RefreshValues();
    //HEI.01 <<
    */
    //end;

    local procedure RefreshValues();
    begin
        //HEI.01 >>
        Rec.CALCFIELDS(Rec."Production BOM No. FND", Rec."Routing No. FND");

        CLEAR(RoutingLine);
        CLEAR(WorkCenter);

        if Rec."Routing No. FND" <> '' then begin
            RoutingLine.SETRANGE("Routing No.", Rec."Routing No. FND");
            if RoutingLine.FINDFIRST() then
                if WorkCenter.GET(RoutingLine."No.") then;
        end;
        //HEI.01 <<
    end;

    local procedure UpdateStdCost();
    var
        StandardCostWorksheet: Record "Standard Cost Worksheet";
        StandardCostWorksheet2: Record "Standard Cost Worksheet";
        PrevItem: Text;
        WindowsUpd: Dialog;
    begin
        //HEI.02>>
        if not CONFIRM(Text50000, true, false) then
            exit;
        WindowsUpd.OPEN('Item No.#1#########');
        StandardCostWorksheet.RESET();
        StandardCostWorksheet.SETCURRENTKEY("Standard Cost Worksheet Name", "Replenishment System", "No.");
        StandardCostWorksheet.SETRANGE("Standard Cost Worksheet Name", CurrWkshName);
        StandardCostWorksheet.SETRANGE("Replenishment System", StandardCostWorksheet."Replenishment System"::"Prod. Order");
        if StandardCostWorksheet.FINDSET() then begin
            repeat
                if PrevItem <> StandardCostWorksheet."No." then begin
                    WindowsUpd.UPDATE(1, StandardCostWorksheet."No.");
                    PrevItem := StandardCostWorksheet."No.";
                    StandardCostWorksheet2.RESET();
                    StandardCostWorksheet2.SETCURRENTKEY("Standard Cost Worksheet Name", "Replenishment System", "No.");
                    StandardCostWorksheet2.SETRANGE("Standard Cost Worksheet Name", CurrWkshName);
                    //StandardCostWorksheet2.SETFILTER("Replenishment System",'<>%1',StandardCostWorksheet2."Replenishment System"::Purchase);//HEI.03
                    StandardCostWorksheet2.SETRANGE("No.", StandardCostWorksheet."No.");
                    if StandardCostWorksheet2.FINDSET(true) then
                        StandardCostWorksheet2.MODIFYALL("New Standard Cost", StandardCostWorksheet."New Standard Cost");
                end;
            until StandardCostWorksheet.NEXT() = 0;
            MESSAGE(Text50001);
        end;
        WindowsUpd.CLOSE();
        //HEI.02<<
    end;

    local procedure UpdateStdCost2();
    var
        StandardCostWorksheet: Record "Standard Cost Worksheet";
        StandardCostWorksheet2: Record "Standard Cost Worksheet";
        PrevItem: Text;
        WindowsUpd: Dialog;
        StockkeepingUnit: Record "Stockkeeping Unit";
        BasePriceSTDCostCalc: Record "Base Price STD Cost Calc. FND";
    begin
        //HEI.04>>
        if not CONFIRM(Text50000, true, false) then
            exit;
        WindowsUpd.OPEN('Item No.#1#########');
        StandardCostWorksheet.RESET();
        StandardCostWorksheet.SETCURRENTKEY("Standard Cost Worksheet Name", "Replenishment System", "No.");
        StandardCostWorksheet.SETRANGE("Standard Cost Worksheet Name", CurrWkshName);
        StandardCostWorksheet.SETRANGE("Replenishment System", StandardCostWorksheet."Replenishment System"::Purchase);
        if StandardCostWorksheet.FINDSET(false) then begin
            repeat
                if PrevItem <> StandardCostWorksheet."No." then begin
                    PrevItem := StandardCostWorksheet."No.";
                    StockkeepingUnit.RESET();
                    StockkeepingUnit.SETRANGE("Item No.", StandardCostWorksheet."No.");
                    StockkeepingUnit.SETRANGE("Replenishment System", StockkeepingUnit."Replenishment System"::"Prod. Order");
                    if not StockkeepingUnit.FINDFIRST() then begin
                        WindowsUpd.UPDATE(1, StandardCostWorksheet."No.");
                        BasePriceSTDCostCalc.RESET();
                        BasePriceSTDCostCalc.SETCURRENTKEY("Item No.", "Starting Date", "Ending Date");
                        BasePriceSTDCostCalc.SETRANGE("Item No.", StandardCostWorksheet."No.");
                        BasePriceSTDCostCalc.SETFILTER("Starting Date", '<=%1', WORKDATE);
                        //BasePriceSTDCostCalc.SETFILTER("Ending Date",'>=%1',WORKDATE);
                        if BasePriceSTDCostCalc.FINDLAST() then begin
                            StandardCostWorksheet2.RESET();
                            StandardCostWorksheet2.SETCURRENTKEY("Standard Cost Worksheet Name", "Replenishment System", "No.");
                            StandardCostWorksheet2.SETRANGE("Standard Cost Worksheet Name", CurrWkshName);
                            StandardCostWorksheet2.SETRANGE("No.", StandardCostWorksheet."No.");
                            if StandardCostWorksheet2.FINDSET(true) then
                                StandardCostWorksheet2.MODIFYALL("New Standard Cost", BasePriceSTDCostCalc."Direct Unit Cost");
                        end;
                    end;
                end;
            until StandardCostWorksheet.NEXT() = 0;
            MESSAGE(Text50001);
        end;
        WindowsUpd.CLOSE();
        //HEI.04<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

