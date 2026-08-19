
pageextension 55003 SalesAnalysisbyDimMatrixExt extends "Sales Analysis by Dim Matrix"
{

    // version NAVW110.0.00.16177,DITW110.00.08,HEI.01
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-It Item Charges functionnalities
    //                                  added "Quantity in HL" into ValueType variable
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.24 DDR 14/08/2008 Added DrillDown for column "TotalQuantityHL"
    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //********************************//
    //BC UPGRADE SIVA  22/01/2026.
    //1.HEI.01 Version not exist in current page.
    //2.Commented drink it code.
    //Bc Upgrade YADAVM09,28.04.26 PID-475, PID-503, PID-504, PID-505, PID-535, PID-536, PID-537, PID-758GAP ID: IBM GAP RTR 09.
    //Bc Upgrade YADAVM09 Fields added Volume1 and Volume2.
    layout
    {

        addafter(TotalInvtValue)
        {
            field(TotalVolume1; Rec."Volume 1 FND")
            {
                ApplicationArea = All;
                AutoFormatExpression = FormatStr();
                AutoFormatType = 11;
                BlankZero = true;
                Caption = 'Total Volume 1';
                StyleExpr = 'Strong';
                ToolTip = 'Specifies the total value for the Volume 1 type that you select in the Show field.';
                Visible = TotalVolume1Visible;
                CaptionClass = '3,' + TotalVolumeCaption + FoundationSetup101FDW."Add. Rep. Unit Volume UOM"; // POENAB02, 08.04.2026

                trigger OnDrillDown()
                begin
                    ItemAnalysisMgt.DrillDownAmount(
                      CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                      ItemFilter, LocationFilter, DateFilter,
                      Dim1Filter, Dim2Filter, Dim3Filter, BudgetFilter,
                      LineDimType, Rec,
                      ColumnDimType, DimCodeBufferColumn,
                      false, ItemAnalysisValueTypeHNK::"Volume 1", ShowActualBudget);
                end;
            }
            field(TotalVolume2; Rec."Volume 2 FND")
            {
                ApplicationArea = All;
                AutoFormatExpression = FormatStr();
                AutoFormatType = 11;
                BlankZero = true;
                Caption = 'Total Volume 2';
                StyleExpr = 'Strong';
                ToolTip = 'Specifies the total value for the Volume 2 type that you select in the Show field.';
                Visible = TotalVolume2Visible;
                CaptionClass = '3,' + TotalVolumeCaption + FoundationSetup101FDW."Unit Volume UOM"; // POENAB02, 08.04.2026

                trigger OnDrillDown()
                begin
                    ItemAnalysisMgt.DrillDownAmount(
                      CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                      ItemFilter, LocationFilter, DateFilter,
                      Dim1Filter, Dim2Filter, Dim3Filter, BudgetFilter,
                      LineDimType, Rec,
                      ColumnDimType, DimCodeBufferColumn,
                      false, ItemAnalysisValueTypeHNK::"Volume 2", ShowActualBudget);
                end;
            }
        }


    }
    actions
    {
        addbefore("Export to Excel")
        {
            action("Export to CIL1")
            {
                ApplicationArea = all;
                ToolTip = 'Export to CIL1';
                Caption = 'Export to CIL1';
                Image = ExportFile;

                trigger OnAction();
                var
                    Lrep_CIL1Export: Report "Export CIL1 RTR";//Bc Upgrade YADAVM09,28.04.26<<
                begin
                    //>>HEI1.0:1:1 EDD072 WSA
                    CLEAR(Lrep_CIL1Export);
                    //Bc Upgrade YADAVM09 BCUP0-140>>
                    clear(CurrentItemAnalysisViewCode);
                    CurrentItemAnalysisViewCode := GSingleInstance.getAnalysisViewCode();
                    //Bc Upgrade YADAVM09 BCUP0-140<<
                    Lrep_CIL1Export.Setdefaults(CurrentAnalysisArea,
                                                CurrentItemAnalysisViewCode,
                                                ShowActualBudget,
                                                BudgetFilter,
                                                ItemFilter);
                    Lrep_CIL1Export.RUNMODAL();
                    //<<HEI 1.0:1:1 EDD072 WSA
                end;
            }
            action("Export to CIL2")
            {
                ApplicationArea = all;
                Caption = 'Export to CIL2';
                ToolTip = 'Export to CIL2';
                Image = ExportFile;
                trigger OnAction();
                var
                    Lrep_CIL2Export: Report "Export CIL2";
                begin
                    // >>HEI1.0:1:1 EDD072 WSA
                    CLEAR(Lrep_CIL2Export);
                    //Bc Upgrade YADAVM09 BCUP0-140>>
                    clear(CurrentItemAnalysisViewCode);
                    CurrentItemAnalysisViewCode := GSingleInstance.getAnalysisViewCode();
                    //Bc Upgrade YADAVM09 BCUP0-140<<

                    Lrep_CIL2Export.Setdefaults(CurrentAnalysisArea,
                                                CurrentItemAnalysisViewCode,
                                                ShowActualBudget,
                                                BudgetFilter,
                                                ItemFilter);
                    Lrep_CIL2Export.RUNMODAL();
                    // <<HEI1.0:1:1 EDD072 WSA
                end;
            }
        }
    }


    //Unsupported feature: PropertyModification on "ValueType(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ValueType : 1003;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ValueType : 19070499;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ValueType(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ValueType : "Sales Amount","COGS Amount","Sales Quantity";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ValueType : "Sales Amount","COGS Amount","Sales Quantity",,,,,QuantityHL,SalesTaxAmount,SalesDepositAmount,DiscountAmount,PurchaseTaxAmount,PurchaseDepositAmount;
    //Variable type has not been exported.




    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CalcAmounts;

    FormatLine;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.01 DDR 14/03/2008
    QuantityHLHideValue := false;
    // >>DITW15.00.00.01 DDR 14/03/2008
    #1..3
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Field32Visible := true;
    Field31Visible := true;
    Field30Visible := true;
    #4..29
    Field3Visible := true;
    Field2Visible := true;
    Field1Visible := true;
    TotalInvtValueVisible := true;
    TotalQuantityVisible := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..32
    // <<DITW15.00.00.01 DDR 14/03/2008
    TotalQuantityHLVisible := true;
    // >>DITW15.00.00.01 DDR 14/03/2008
    TotalInvtValueVisible := true;
    TotalQuantityVisible := true;
    */
    //end;


    //Unsupported feature: CodeModification on "CalcAmounts(PROCEDURE 10)". Please convert manually.

    //procedure CalcAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if TotalQuantityVisible then
      Quantity := CalcAmt(DimCodeBufferColumn,2,false);
    if TotalInvtValueVisible then
      Amount := CalcAmt(DimCodeBufferColumn,0,false);
    Steps := 1;
    Which := '-';

    #8..18
        GetFieldDim1Filter,GetFieldDim2Filter,GetFieldDim3Filter);
      i := i + 1;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    // <<DITW15.00.00.01 DDR 14/03/2008
    if TotalQuantityHLVisible then
      "Quantity in HL" := CalcAmt(DimCodeBufferColumn,7,false);
    // >>DITW15.00.00.01 DDR
    #5..21
    */
    //end;

    //BC UPGRADE SIVA >> Drink IT Code
    // local procedure QuantityinHLOnFormat(Text: Text[1024]);
    // begin  
    // if REC."Quantity in HL" = 0 then
    //     QuantityHLHideValue := true;
    // ItemAnalysisMgt.FormatAmount(Text, RoundingFactor);
    // end;
    //BC UPGRADE SIVA << Drink IT Code

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    //Bc Upgrade YADAVM09>>
    local procedure FormatStr(): Text
    var
        RoundingFactorFormatString: Text;
    begin
        exit(RoundingFactorFormatString);
    end;

    //BC Upgrade YADAVM09<<
    var
        ItemAnalysisView: Record "Item Analysis View";//Bc upgrade YADAVM09<<
        GSingleInstance: Codeunit "Levy Preview Custom RTR";//Bc Upgrade YADAVM09 BCUP0-140<<
        CurrentAnalysisArea: Option "Analysis Area Type";
        CurrentItemAnalysisViewCode: Code[10];
        ShowActualBudget: Option "Item Analysis Show Type";

        BudgetFilter: Code[250];
        ItemFilter: Code[250];
        TotalVolume1Visible: Boolean;
        ItemAnalysisMgt: Codeunit ItemAnalysisMgtRtR;
        FoundationSetup101FDW: Record "FoundationSetup101FDW";//Bc Upgrade YADAVM09<<
        TotalVolumeCaption: Label 'Total Volume '; //Bc Upgrade YADAVM09<< 
        ItemStatisticsBuffer: Record "Item Statistics Buffer"; //Bc Upgrade YADAVM09<< 
        LocationFilter: Code[250];
        Dim1Filter: Code[250];
        Dim2Filter: Code[250];
        Dim3Filter: Code[250];
        CodeRange: Code[250];
        DateFilter: Text[30];
        LineDimType: Enum "Item Analysis Dimension Type";
        ColumnDimType: Enum "Item Analysis Dimension Type";
        DimCodeBufferColumn: Record "Dimension Code Buffer";
        DimCodeBufferColumn3: Record "Dimension Code Buffer";
        TotalVolume2Visible: Boolean;


}

