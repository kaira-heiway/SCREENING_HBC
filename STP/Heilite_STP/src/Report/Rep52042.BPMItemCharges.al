report 52042 "BPM Item Charges"
{
    // HEI.01 CHG2062679 IBM POENAB02 25.05.2020 # La Reunion_BPM  Item charges report (Ficher de Revient)
    //   # Object created
    // HEI.02 CHG2101290 IBM BULIMC01 01/03/2021 #corrections
    // HEI.03 IBM.AK CHG2129304/INC3725201 05.10.21
    //  # increase index dimension values of 2 array variables-ItemChargeNo and ItemChargeValue from 40 to 50

    //BC Upgrade KAPOOV01 >>
    // 1. Add layout path and Change extension RDLC to RDL.
    // 2. Add ApplicationArea and UsageCategory property in Report.
    // 3. Old Report ID- 50383.
    // 4. Commented DRINK-IT Field-"Item Charge Type" from DataItemTableView Property.
    // 5. Commented DRINK-IT Field - "Item Charge Type" in SETCURRENTKEY functions.
    // 6. Commented DRINK-IT Field-"Item Charge Type"  related code.
    //BC Upgrade KAPOOV01  <<

    DefaultLayout = RDLC;
    //RDLCLayout = './BPM Item Charges.rdlc'; //BC Upgrade KAPOOV01 Commented
    RDLCLayout = '.\src\ReportsLayout\BPM Item Charges.rdl'; //BC Upgrade KAPOOV01 Changed  layout path and extension changed from RDLC to RDL.

    CaptionML = ENU = 'BPM Item Charges',
                FRA = 'Fichier de Revient';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Charge"; "Item Charge")
        {
            //BC Upgrade KAPOOV01 Removed DRINK-IT Field -"Item Charge Type" from DataItemTableView Property >>
            //DataItemTableView = SORTING("No.") WHERE("Item Charge Type" = FILTER(ShippingCost)); 
            DataItemTableView = SORTING("No.") where("Shipping Cost BPM FND" = filter(true)); //#BCUP0-RTR-BPM Item Charges BC Upgrade KAIRAR01 
            //BC Upgrade KAPOOV01 Removed DRINK-IT Field -"Item Charge Type" Field from DataItemTableView Property <<
            RequestFilterFields = "No.";
            RequestFilterHeadingML = ENU = 'Item Charge Exclusion',
                                     FRA = 'Exclus Frais annexes';

            trigger OnPreDataItem();
            begin
                CurrReport.BREAK;
            end;
        }
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = WHERE("Document Type" = FILTER("Purchase Receipt" | "Purchase Return Shipment"), "Source Type" = FILTER(Vendor), "Item Ledger Entry Type" = FILTER(Purchase));
            RequestFilterFields = "Posting Date", "Inventory Posting Group";
            column(TitleCaption; TitleCaption)
            {
            }
            column(ValueEntryFilters; ValueEntryFilters)
            {
            }
            column(ItemChargeExcl; ItemChargeExcl)
            {
            }
            column(ItemChargeExclusion; ItemChargeExclusion)
            {
            }
            column(STRSUBSTNO___1___2__ValueEntry_TABLECAPTION_Filter_; STRSUBSTNO('%1: %2', TABLECAPTION, ValueEntryFilters))
            {
            }
            column(STRSUBSTNO_ItemChargeExcl; STRSUBSTNO('%1: %2', ItemChargeExcl, ItemChargeExclusion))
            {
            }
            column(DocumentDateLbl; ColAText)
            {
            }
            column(LocationLbl; ColBText)
            {
            }
            column(DocumentNoLbl; ColCText)
            {
            }
            column(VendorNoLbl; ColDText)
            {
            }
            column(ItemNoLbl; ColEText)
            {
            }
            column(DescriptionLbl; ColFText)
            {
            }
            column(InvPostGrLbl; ColGText)
            {
            }
            column(GenProdPostGrLbl; ColHText)
            {
            }
            column(QuantityLbl; ColIText)
            {
            }
            column(VendAmtLbl; ColJText)
            {
            }
            column(VendReceptionLbl; ColKText)
            {
            }
            column(TotalReceptionLbl; ColYText)
            {
            }
            column(AverageCostLbl; ColZText)
            {
            }
            column(GRIRLbl; ColAAText)
            {
            }
            column(LandedCostLbl; ColABText)
            {
            }
            column(ExpectedCostLbl; ColACText)
            {
            }
            column(VEDocumentDate; "Posting Date")
            {
            }
            column(VELocation; "Location Code")
            {
            }
            column(VEDocumentNo; "Document No.")
            {
            }
            column(VEVEndorNo; "Source No.")
            {
            }
            column(VEItemNo; "Item No.")
            {
            }
            column(VEDescription; Description)
            {
            }
            column(VEInventoryPostingGroup; "Inventory Posting Group")
            {
            }
            column(VEGenProdPostingGroup; "Gen. Prod. Posting Group")
            {
            }
            column(VEQuantity; "Item Ledger Entry Quantity")
            {
            }
            column(VEVendorAmount; VendorAmount)
            {
            }
            column(VEVendorReception; VendorReception)
            {
            }
            column(ItemChargeNo1; ItemChargeNo[1])
            {
            }
            column(ItemChargeNo2; ItemChargeNo[2])
            {
            }
            column(ItemChargeNo3; ItemChargeNo[3])
            {
            }
            column(ItemChargeNo4; ItemChargeNo[4])
            {
            }
            column(ItemChargeNo5; ItemChargeNo[5])
            {
            }
            column(ItemChargeNo6; ItemChargeNo[6])
            {
            }
            column(ItemChargeNo7; ItemChargeNo[7])
            {
            }
            column(ItemChargeNo8; ItemChargeNo[8])
            {
            }
            column(ItemChargeNo9; ItemChargeNo[9])
            {
            }
            column(ItemChargeNo10; ItemChargeNo[10])
            {
            }
            column(ItemChargeNo11; ItemChargeNo[11])
            {
            }
            column(ItemChargeNo12; ItemChargeNo[12])
            {
            }
            column(ItemChargeNo13; ItemChargeNo[13])
            {
            }
            column(ItemChargeNo14; ItemChargeNo[14])
            {
            }
            column(ItemChargeNo15; ItemChargeNo[15])
            {
            }
            column(ItemChargeNo16; ItemChargeNo[16])
            {
            }
            column(ItemChargeNo17; ItemChargeNo[17])
            {
            }
            column(ItemChargeNo18; ItemChargeNo[18])
            {
            }
            column(ItemChargeNo19; ItemChargeNo[19])
            {
            }
            column(ItemChargeNo20; ItemChargeNo[20])
            {
            }
            column(ItemChargeNoValue1; ItemChargeNoValue[1])
            {
            }
            column(ItemChargeNoValue2; ItemChargeNoValue[2])
            {
            }
            column(ItemChargeNoValue3; ItemChargeNoValue[3])
            {
            }
            column(ItemChargeNoValue4; ItemChargeNoValue[4])
            {
            }
            column(ItemChargeNoValue5; ItemChargeNoValue[5])
            {
            }
            column(ItemChargeNoValue6; ItemChargeNoValue[6])
            {
            }
            column(ItemChargeNoValue7; ItemChargeNoValue[7])
            {
            }
            column(ItemChargeNoValue8; ItemChargeNoValue[8])
            {
            }
            column(ItemChargeNoValue9; ItemChargeNoValue[9])
            {
            }
            column(ItemChargeNoValue10; ItemChargeNoValue[10])
            {
            }
            column(ItemChargeNoValue11; ItemChargeNoValue[11])
            {
            }
            column(ItemChargeNoValue12; ItemChargeNoValue[12])
            {
            }
            column(ItemChargeNoValue13; ItemChargeNoValue[13])
            {
            }
            column(ItemChargeNoValue14; ItemChargeNoValue[14])
            {
            }
            column(ItemChargeNoValue15; ItemChargeNoValue[15])
            {
            }
            column(ItemChargeNoValue16; ItemChargeNoValue[16])
            {
            }
            column(ItemChargeNoValue17; ItemChargeNoValue[17])
            {
            }
            column(ItemChargeNoValue18; ItemChargeNoValue[18])
            {
            }
            column(ItemChargeNoValue19; ItemChargeNoValue[19])
            {
            }
            column(ItemChargeNoValue20; ItemChargeNoValue[20])
            {
            }
            column(VETotalReception; TotalReception)
            {
            }
            column(VEAverageCost; AverageCost)
            {
            }
            column(GR_IR; GR_IR)
            {
            }
            column(VELandedCosts; LandedCosts)
            {
            }
            column(VEExpectedCosts; ExpectedCosts)
            {
            }

            trigger OnAfterGetRecord();
            var
                lILE: Record "Item Ledger Entry";
                lValueEntry: Record "Value Entry";
            begin
                TotalReception := 0;
                TotalItemCharge := 0;
                VendorAmount := 0;

                lILE.RESET;
                lValueEntry.RESET;
                //HEI.02<< commented
                /*lILE.SETCURRENTKEY("Document No.","Document Type","Document Line No.");
                lILE.SETRANGE("Document No.","Document No.");
                lILE.SETRANGE("Document Line No.","Document Line No.");*/
                //HEI.02?? commented
                if lILE.GET("Item Ledger Entry No.") then begin //HEI.02
                                                                //IF lILE.FINDFIRST THEN
                                                                //REPEAT  HEI.02 commented
                    lValueEntry.RESET;
                    //BC Upgrade KAPOOV01 Removed DRINK-IT Field-"Item Charge Type" in SETCURRENTKEY function >>
                    //lValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Item Charge Type", "Item Charge No.");
                    lValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Item Charge No.");
                    //BC Upgrade KAPOOV01 Removed DRINK-IT Field-"Item Charge Type" in SETCURRENTKEY function <<
                    lValueEntry.SETRANGE("Item Ledger Entry No.", lILE."Entry No.");
                    lValueEntry.SETRANGE("Entry Type", lValueEntry."Entry Type"::"Direct Cost");
                    //lValueEntry.SETRANGE("Item Charge Type", lValueEntry."Item Charge Type"::" "); //BC Upgrade KAPOOV01 Commented DRINK-IT Field-"Item Charge Type" related code 

                    if lValueEntry.FINDFIRST then
                        repeat
                            VendorAmount += lValueEntry."Cost Amount (Actual)";
                        until lValueEntry.NEXT = 0;
                end; //HEI.02
                     // UNTIL lILE.NEXT = 0;  HEI.02 commented

                /*
                IF "Valued Quantity" <> 0 THEN
                  VendorReception := VendorAmount/"Valued Quantity"
                  ELSE
                    VendorReception := 0;
                */
                if "Item Ledger Entry Quantity" <> 0 then
                    VendorReception := VendorAmount / "Item Ledger Entry Quantity"
                else
                    VendorReception := 0;

                for i := 1 to NoOfItemCharges do begin
                    ItemChargeNoValue[i] := 0;
                    lILE.RESET;
                    lValueEntry.RESET;
                    /* lILE.SETCURRENTKEY("Document No.","Document Type","Document Line No.");
                     lILE.SETRANGE("Document No.","Document No.");
                     lILE.SETRANGE("Document Line No.","Document Line No.");
                     IF lILE.FINDFIRST THEN */
                    if lILE.GET("Item Ledger Entry No.") then begin //HEI.02
                                                                    //  REPEAT HEI.02 commented
                        lValueEntry.RESET;
                        //BC Upgrade KAPOOV01 Removed DRINK-IT- Field "Item Charge Type" in SETCURRENTKEY function >> 
                        //lValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Item Charge Type", "Item Charge No.");
                        lValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Item Charge No.");
                        //BC Upgrade KAPOOV01 Removed DRINK-IT- Field "Item Charge Type" in SETCURRENTKEY function <<
                        lValueEntry.SETRANGE("Item Ledger Entry No.", lILE."Entry No.");
                        lValueEntry.SETRANGE("Item Charge No.", ItemChargeNo[i]);
                        if lValueEntry.FINDFIRST then
                            repeat
                                ItemChargeNoValue[i] += lValueEntry."Cost Amount (Actual)";
                                TotalReception += lValueEntry."Cost Amount (Actual)";
                                TotalItemCharge += lValueEntry."Cost Amount (Actual)";
                            until lValueEntry.NEXT = 0;
                        //  UNTIL lILE.NEXT = 0; HEI.02 commented
                    end; //HEI.02
                end;


                /*
                IF "Valued Quantity" <> 0 THEN
                  AverageCost := TotalReception / "Valued Quantity"
                  ELSE
                    AverageCost := 0;
                */

                TotalReception += VendorAmount;

                if "Item Ledger Entry Quantity" <> 0 then
                    AverageCost := TotalReception / "Item Ledger Entry Quantity"
                else
                    AverageCost := 0;

                GR_IR := 0;
                lILE.RESET;
                if lILE.GET("Item Ledger Entry No.") then begin
                    lILE.CALCFIELDS("Cost Amount (Expected)");
                    GR_IR := lILE."Cost Amount (Expected)";
                end;


                if VendorAmount <> 0 then
                    LandedCosts := (TotalItemCharge / VendorAmount) * 100
                else
                    LandedCosts := 0;

                /*
                IF VendorAmount <> 0 THEN
                  LandedCosts := (TotalItemCharge / TotalReception) * 100
                  ELSE
                    LandedCosts := 0;
                */

                ExpectedCosts := 0;
                lILE.RESET;
                lValueEntry.RESET;
                /*lILE.SETCURRENTKEY("Document No.","Document Type","Document Line No.");
                lILE.SETRANGE("Document No.","Document No.");
                lILE.SETRANGE("Document Line No.","Document Line No.");
                IF lILE.FINDFIRST THEN*/
                if lILE.GET("Item Ledger Entry No.") then begin //HEI.02
                                                                // REPEAT HEI.02 commented
                    lValueEntry.RESET;
                    //BC Upgrade KAPOOV01 Removed DRINK-IT Field-"Item Charge Type" in SETCURRENTKEY function >>
                    //lValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Item Charge Type", "Item Charge No.");
                    lValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Item Charge No.");
                    //BC Upgrade KAPOOV01 Removed DRINK-IT Field-"Item Charge Type" in SETCURRENTKEY function <<
                    lValueEntry.SETRANGE("Item Ledger Entry No.", lILE."Entry No.");
                    lValueEntry.SETFILTER("Document Type", '%1|%2', lValueEntry."Document Type"::"Purchase Receipt", lValueEntry."Document Type"::"Purchase Return Shipment");
                    if lValueEntry.FINDFIRST then
                        repeat
                            ExpectedCosts += lValueEntry."Cost Amount (Expected)";
                        until lValueEntry.NEXT = 0;
                    // UNTIL lILE.NEXT = 0; HEI.02 commented
                end; //HEI.02

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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

    trigger OnPreReport();
    begin
        ValueEntryFilters := "Value Entry".GETFILTERS;
        ItemChargeExclusion := "Item Charge".GETFILTER("No.");

        ItemCharge.RESET;
        //ItemCharge.SETRANGE("Item Charge Type", ItemCharge."Item Charge Type"::ShippingCost); //BC Upgrade KAPOOV01 Commented DRINK-IT Field-"Item Charge Type"  related code 
        ItemCharge.SetRange("Shipping Cost BPM FND", true); //#BCUP0-RTR-BPM Item Charges BC Upgrade KAIRAR01
        if ItemChargeExclusion <> '' then
            ItemCharge.SETFILTER("No.", '<>%1', '*' + ItemChargeExclusion + '*');
        NoOfItemCharges := ItemCharge.COUNT;
        i := 1;
        if ItemCharge.FINDFIRST then
            repeat
                ItemChargeNo[i] := ItemCharge."No.";
                i += 1;
            until ItemCharge.NEXT = 0;
    end;

    var
        FileMgt: Codeunit "File Management";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Text000: TextConst ENU = 'Analyzing Data...\\', FRA = 'Analyse des données...\\';
        Text001: TextConst ENU = 'Filters', FRA = 'Filtres';
        Text002: TextConst ENU = 'Update Workbook', FRA = 'Mise à jour du classeur';
        ExcelFileExtensionTok: TextConst Comment = '{Locked}', ENU = '.xlsx', FRA = '.xlsx';
        OverwriteFileQst: TextConst ENU = 'Do you want to overwrite the existing file?', FRA = 'Souhaitez-vous remplacer le fichier existant ?';
        ServerFileName: Text;
        SheetName: Text[250];
        TestMode: Boolean;
        DoUpdateExistingWorksheet: Boolean;
        ClientFileName: Text;
        ColAText: TextConst ENU = 'Posting Date', FRA = 'Date Document';
        ColBText: TextConst ENU = 'Location', FRA = 'Magasin';
        ColCText: TextConst ENU = 'Document No.', FRA = 'No. Document';
        ColDText: TextConst ENU = 'Vendor No.', FRA = 'Code FRN';
        ColEText: TextConst ENU = 'Item No.', FRA = 'No. Article';
        ColFText: TextConst ENU = 'Description', FRA = 'Description';
        ColGText: TextConst ENU = 'Inv. Posting Group', FRA = 'Groupe compta. stock';
        ColHText: TextConst ENU = 'Gen. Prod Posting Group', FRA = 'Groupe compta. produit';
        ColIText: TextConst ENU = 'Quantity', FRA = 'Quantité';
        ColJText: TextConst ENU = 'Vendor Amount', FRA = 'Montant FRN';
        ColKText: TextConst ENU = 'Vendor Reception - unit cost', FRA = 'Revient FRN - coût unitaire';
        ItemChargeNo: array[50] of Code[20];
        ValueEntryFilters: Text;
        ColYText: TextConst ENU = 'Total Reception', FRA = 'Total Revient';
        ColZText: TextConst ENU = 'Average Cost', FRA = 'Pump';
        ColAAText: TextConst ENU = 'GR/IR', FRA = 'FNP';
        ColABText: TextConst ENU = 'Landed Costs', FRA = 'Frais d''approche';
        ColACText: TextConst ENU = 'Expected Costs (Goods receipt)', FRA = 'Coût total (prévu)';
        ItemChargeExclusion: Text;
        ItemChargeExclusionNew: Text;
        ItemCharge: Record "Item Charge";
        NoOfItemCharges: Integer;
        i: Integer;
        VendorAmount: Decimal;
        VendorReception: Decimal;
        ItemChargeNoValue: array[50] of Decimal;
        TotalReception: Decimal;
        AverageCost: Decimal;
        GR_IR: Decimal;
        LandedCosts: Decimal;
        ExpectedCosts: Decimal;
        TitleCaption: TextConst ENU = 'BPM Item Charges', FRA = 'Fichier de Revient';
        VEFilters: TextConst ENU = 'Value Entry filters', FRA = 'Ecritures valeur filtre';
        ItemChargeExcl: TextConst ENU = 'Item Charge Exclusion', FRA = 'Exclusion de frais annexes';
        TotalItemCharge: Decimal;
}

