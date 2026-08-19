page 53020 "Sales Forecast"
{
    // version HEI.01
    //BC UPGRADE SIVA Old Page ID 50150
    // HEI.01 FDD-RTRGAP060 IBM HORTOC01 30.08.2017
    //   # New Object created

    //************************************************//
    // BC UPGRADE SIVA 9/01/2026>>
    // SUMMARY OF CHANGES:
    //1.No Drink it code & fields
    //************************************************//

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Forecast FND";
    SourceTableView = SORTING(Year, Month, "Line No.")
                      WHERE("Accounting Notes Generated" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the type of document.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the customer number.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the customer name.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the document date.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the due date.';
                }
                field("Brand Code"; Rec."Brand Code")
                {
                    ToolTip = 'Specifies the brand code.';

                }
                field("Brand Code Name"; Rec."Brand Code Name")
                {
                    ToolTip = 'Specifies the brand code name.';
                }
                field(Volume; Rec.Volume)
                {
                    ToolTip = 'Specifies the volume.';
                }
                field("Sales Price (WithOut VAT)"; Rec."Sales Price (WithOut VAT)")
                {
                    ToolTip = 'Specifies the sales price without VAT.';
                }
                field("Royalty Amount LCY"; Rec."Royalty Amount LCY")
                {
                    ToolTip = 'Specifies the royalty amount in local currency.';
                }
                field("Know-How Amount LCY"; Rec."Know-How Amount LCY")
                {
                    ToolTip = 'Specifies the know-how amount in local currency.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code.';
                }
                field("Royalty Amount EUR"; Rec."Royalty Amount EUR")
                {
                    ToolTip = 'Specifies the royalty amount in EUR.';
                }
                field("Know-How Amount EUR"; Rec."Know-How Amount EUR")
                {
                    ToolTip = 'Specifies the know-how amount in EUR.';
                }
            }
            group(Totals)
            {
                Caption = 'Totals';
                field(Balance; SalesForecast."Royalty Amount EUR")
                {
                    ToolTip = 'Specifies the total royalty amount in EUR.';
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Royalty Amount EUR';
                    Editable = false;
                }
                field("SalesForecast.""Know-How Amount EUR"""; SalesForecast."Know-How Amount EUR")
                {
                    ToolTip = 'Specifies the total ""know-how amount in EUR.""';
                    Caption = 'Know-How Amount EUR';
                    Editable = false;
                }
                field("SalesForecast.""Royalty Amount LCY"""; SalesForecast."Royalty Amount LCY")
                {
                    ToolTip = 'Specifies the total royalty amount in local currency.';
                    Caption = 'Royalty Amount LCY';
                    Editable = false;
                }
                field("SalesForecast.""Know-How Amount LCY"""; SalesForecast."Know-How Amount LCY")
                {
                    ToolTip = 'Specifies the total know-how amount in local currency.';
                    Caption = 'Know-How Amount LCY';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(SuggestSales)
            {
                ToolTip = 'Suggest Sales for Current Month or Current Quarter';
                Caption = 'Suggest Sales';
                Image = SuggestLines;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    /*
                    Selection := STRMENU(Text000);
                    IF Selection = 1 THEN
                      HeinekenGlobal.SuggestSales(DateFilter::CM);
                    
                    IF Selection = 2 THEN
                      HeinekenGlobal.SuggestSales(DateFilter::CQ);
                    */
                    // SuggestSalesForecast.RUN; //BC UPGRADE SIVA
                    SuggestSalesForecast.Run(); //BC Upgrade KAIRAR01 PID-687-RTR098

                    SalesForecast.RESET();
                    SalesForecast.SETRANGE("Accounting Notes Generated", false);
                    SalesForecast.CALCSUMS("Royalty Amount EUR", "Know-How Amount EUR", "Royalty Amount LCY", "Know-How Amount LCY");

                    CurrPage.UPDATE(false);

                end;
            }
            action(SuggestSalesForLastQ)
            {
                ToolTip = 'Suggest Sales for Last Quarter';
                Caption = 'Suggest Sales For Last Quarter';
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction();
                begin
                    HeinekenGlobal.SuggestSalesForLastQuarter();

                    SalesForecast.RESET();
                    SalesForecast.SETRANGE("Accounting Notes Generated", false);
                    SalesForecast.CALCSUMS("Royalty Amount EUR", "Know-How Amount EUR", "Royalty Amount LCY", "Know-How Amount LCY");

                    CurrPage.UPDATE(false);
                end;
            }
            action(GenerateAccountingNotes)
            {
                ToolTip = 'Generate Accounting Notes';
                Caption = 'Generate Accounting Notes';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction();
                var
                    SalesReceivablesSetup: Record "Sales & Receivables Setup";
                begin
                    if CONFIRM(Text002, false) then begin
                        SalesReceivablesSetup.GET();
                        HeinekenGlobal.GenerateAccountingNotes(false);
                        MESSAGE(Text003, SalesReceivablesSetup."Jnl Template Name Forecast FND", SalesReceivablesSetup."Jnl Template Name Forecast FND")
                    end;
                end;
            }
            action("Generate&PostAccountingNotes")
            {
                ToolTip = 'Generate and Post Accounting Notes';
                Caption = 'Generate & Post Accounting Notes';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction();
                begin
                    if CONFIRM(Text001, false) then begin
                        HeinekenGlobal.GenerateAccountingNotes(true);
                        MESSAGE(Text004)
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        SalesForecast.RESET();
        SalesForecast.SETRANGE("Accounting Notes Generated", false);
        SalesForecast.CALCSUMS("Royalty Amount EUR", "Know-How Amount EUR", "Royalty Amount LCY", "Know-How Amount LCY")
    end;

    var
        Text000: Label '&Current Month,&Current Quarter';
        Selection: Integer;
        DateFilter: Option CM,CQ;
        RoyalityAmountEUR: Decimal;
        TotalRoyalityAmountEUR: Decimal;
        Text001: Label 'Do you want to post entries?';
        Text002: Label 'Do you want to generate general journal lines?';
        SalesForecast: Record "Sales Forecast FND";
        Text003: Label 'Transactions generated succesfully!Check journal template %1, batch %2!';
        Text004: Label 'Transactions has been posted succesfully!';
        HeinekenGlobal: Codeunit "Heineken Global";
        SuggestSalesForecast: Report "Suggest Sales Forecast CBN"; //BC UPGRADE SIVA -
}

