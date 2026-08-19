page 58113 "Bank Statement Subform"
{
    // version BC

    // HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New page for Bank Connectivity interface

    //Bc Upgrade YADAVM09 Old Id-50351.

    // BC Upgrade MISHRS14 >>
    // Blocked global var - Sales Price Calc. Mgt. because CodeUnit - Sales Price Calc. Mgt. is marked for removal and replaced by the new implementation (V16) of price calculation.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade PATELP08>>
    // Changed name of table from "Imported Bank Statements Line" to "Imported Bank Stmt Line FND"
    // BC Upgrade PATELP08<<

    AutoSplitKey = true;
    CaptionML = ENU = 'Lines',
                FRA = 'Lignes';
    DelayedInsert = true;
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Imported Bank Stmt Line FND";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Value Date"; Rec."Value Date")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                    Visible = false;
                }
                field(Difference; Rec.Difference)
                {
                    Visible = false;
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
            }
        }
    }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("+ Expand")
    //         {
    //             CaptionML = ENU = '+ Expand',
    //                         FRA = '+ Développer';
    //             Enabled = (NOT ExpandLines);
    //             Image = ViewDetails;
    //             //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
    //             //PromotedCategory = Process;
    //             //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
    //             //PromotedIsBig = true;
    //             Visible = (NOT ExpandLines) OR ShowButtonsCE;

    //             trigger OnAction();
    //             begin
    //                 // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //                 ExpandLines := true;
    //                 CurrPage.UPDATE(true);
    //                 // >>DITW17.10.03 DDR DIT-770 #541
    //             end;
    //         }
    //         action("- Collapse")
    //         {
    //             CaptionML = ENU = '- Collapse',
    //                         FRA = '- Réduire';
    //             Enabled = ExpandLines;
    //             Image = ViewDetails;
    //             //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
    //             //PromotedCategory = Process;
    //             //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
    //             //PromotedIsBig = true;
    //             Visible = ExpandLines OR ShowButtonsCE;

    //             trigger OnAction();
    //             begin
    //                 // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //                 ExpandLines := false;
    //                 CurrPage.UPDATE(true);
    //                 // >>DITW17.10.03 DDR DIT-770 #541
    //             end;
    //         }
    //     }
    // }//Bc Upgrade YADAVM09 Drink it Action<<

    trigger OnDeleteRecord(): Boolean;
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        TempRec: Record "Sales Line" temporary;
    begin
    end;

    trigger OnOpenPage();
    var
        Location: Record Location;
    begin
    end;

    var
        TotalSalesHeader: Record "Sales Header";
        TotalSalesLine: Record "Sales Line";
        Currency: Record Currency;
        SalesSetup: Record "Sales & Receivables Setup";
        ApplicationAreaSetup: Record "Application Area Setup";
        TransferExtendedText: Codeunit "Transfer Extended Text";

        // BC Upgrade MISHRS14 >>
        // Blocked var - Sales Price Calc. Mgt. because CodeUnit - Sales Price Calc. Mgt. is marked for removal and replaced by the new implementation (V16) of price calculation.
        //SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        // BC Upgrade MISHRS14 <<

        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        DocumentTotals: Codeunit "Document Totals";
        VATAmount: Decimal;
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: TextConst ENU = 'Unable to run this function while in View mode.', FRA = 'Impossible d''exécuter cette fonction en mode Afficher.';
        LocationCodeVisible: Boolean;
        InvDiscAmountEditable: Boolean;
        RowIsText: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;
        xRecRef: RecordRef;
        //cduAppMgt : Codeunit ApplicationManagement;//Bc Upgrade YADAVM09 codeunit obselete<<
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Unit Price', FRA = 'Total prix unitaire';
        DisabledRefreshLines: Boolean;

        TypeEditable: Boolean;
        "No.Editable": Boolean;
        "Cross-Reference No.Editable": Boolean;
        QuantityEditable: Boolean;
        "Unit PriceEditable": Boolean;
        "Line AmountEditable": Boolean;
        TypeEnable: Boolean;
        "No.Enable": Boolean;
        QuantityEnable: Boolean;
        "Unit PriceEnable": Boolean;
        "Line AmountEnable": Boolean;
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserMgt: Codeunit "User Setup Management";
        txtIntrastatMandStyle: Text;
        EditableDesc: Boolean;
        Error004: Label 'You cannot change the %1 when the value has been filled in.';
}

