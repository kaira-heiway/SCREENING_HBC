page 58011 "Cash Van Sales Interface Setup"
{
    // Heilite Navision Old Id - 50186
    SourceTable = "Cash Van Sales Interf. Stp INT";
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    ApplicationArea = All;  // BC Upgrade NANDIS03
    layout
    {
        area(content)
        {
            group("Cash Van Sales Interfaces")
            {
                Caption = 'Cash Van Sales Interfaces';
                field("CVS Currency Request Interface"; Rec."CVS Currency Request Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Currency Request Interface field.';
                }
                field("CVS Currency Response Interf."; Rec."CVS Currency Response Interf.")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Currency Response Interface field.';
                }
                field("CVS Curr Exch. Rate Req Interf"; Rec."CVS Curr Exch. Rate Req Interf")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Currency Exch. Rate Request Interface field.';
                }
                field("CVS Curr Exch. Rate Res Interf"; Rec."CVS Curr Exch. Rate Res Interf")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Currency Exch. Rate Response Interface field.';
                }
                field("CVS SalesP/Purch. Req. Interf"; Rec."CVS SalesP/Purch. Req. Interf")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales SalesP/Purchaser Request Interface field.';
                }
                field("CVS SalesP/Purch. Resp. Interf"; Rec."CVS SalesP/Purch. Resp. Interf")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales SalesP/Purchaser Response Interface field.';
                }
                field("CVS Customer Request Interface"; Rec."CVS Customer Request Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Customer Request Interface field.';
                }
                field("CVS Customer Respons Interface"; Rec."CVS Customer Respons Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Customer Response Interface field.';
                }
                field("CVS Cust Price List Req Interf"; Rec."CVS Cust Price List Req Interf")
                {
                    ToolTip = 'Specifies the value of the CVS Customer Price List Request Interface field.';
                }
                field("CVS Cust Price List Res Interf"; Rec."CVS Cust Price List Res Interf")
                {
                    ToolTip = 'Specifies the value of the CVS Customer Price List Response Interface field.';
                }
                field("CVS Salesman Cust Req Interf"; Rec."CVS Salesman Cust Req Interf")
                {
                    ToolTip = 'Specifies the value of the CVS Salesman Customer Request Interface field.';
                }
                field("CVS Salesman Cust Resp Interf"; Rec."CVS Salesman Cust Resp Interf")
                {
                    ToolTip = 'Specifies the value of the CVS Salesman Customer Response Interface field.';
                }
                field("CVS Item Request Interface"; Rec."CVS Item Request Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Item Request Interface field.';
                }
                field("CVS Item Response Interface"; Rec."CVS Item Response Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Item Request Interface field.';
                }
                field("CVS Sales Price Request Interf"; Rec."CVS Sales Price Request Interf")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Sales Price Request Interface field.';
                }
                field("CVS Sales Price Resp Interf"; Rec."CVS Sales Price Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Sales Price Response Interface field.';
                }
                field("CVS Brand Request Interface"; Rec."CVS Brand Request Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Brand Request Interface field.';
                }
                field("CVS Brand Response Interface"; Rec."CVS Brand Response Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Brand Response Interface field.';
                }
                field("CVS Route Request Interface"; Rec."CVS Route Request Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Route Request Interface field.';
                }
                field("CVS Route Response Interface"; Rec."CVS Route Response Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Route Response Interface field.';
                }
                field("CVS WarehouseProduct Req Inter"; Rec."CVS WarehouseProduct Req Inter")
                {
                    ToolTip = 'Specifies the value of the CVS WarehouseProduct Request Interface field.';
                }
                field("CVS WarehouseProduct Res Inter"; Rec."CVS WarehouseProduct Res Inter")
                {
                    ToolTip = 'Specifies the value of the CVS WarehouseProduct Response Interface field.';
                }
                field("CVS Transfer Order Interf"; Rec."CVS Transfer Order Interf")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Transfer Order Interface field.';
                }
                field("CVS Sales Orders Interface"; Rec."CVS Sales Orders Interface")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Sales Orders Interface field.';
                }
                field("CVS Cash Receipt Interf"; Rec."CVS Cash Receipt Interf")
                {
                    ToolTip = 'Specifies the value of the Cash Van Sales Cash Receipt Interface field.';
                }
            }
            group("Cash Van Sales Interface Setups")
            {
                Caption = 'Cash Van Sales Interface Setups';
                field("Item Category Filter"; Rec."Item Category Filter")
                {
                    ToolTip = 'Specifies the value of the Item Category Filter field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    begin
                        //HEI.01>>
                        CLEAR(ItemCategories);
                        ItemCategories.LOOKUPMODE(true);
                        if not (ItemCategories.RUNMODAL() = ACTION::LookupOK) then
                            exit(false);

                        Text := ItemCategories.GetSelectionFilter();
                        exit(true);
                        //HEI.01<<
                    end;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ToolTip = 'Specifies the value of the Transfer-from Code field.';
                }
                field("CVS Cash Receipt Jnl. Template"; Rec."CVS Cash Receipt Jnl. Template")
                {
                    Caption = 'Cash Receipt Jnl. Template';
                    ToolTip = 'Specifies the value of the Cash Receipt Jnl. Template field.';
                }
                field("CVS Cash Receipt Jnl. Batch"; Rec."CVS Cash Receipt Jnl. Batch")
                {
                    Caption = 'Cash Receipt Jnl. Batch';
                    ToolTip = 'Specifies the value of the Cash Receipt Jnl. Batch field.';
                }
                field("Customer Price Group Code"; Rec."Customer Price Group Code")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group Code field.';
                }
                field("Movement Type Dimension Code"; Rec."Movement Type Dimension Code")
                {
                    ToolTip = 'Specifies the value of the Movement Type Dimension Code field.';
                }
                field("Movement Type Dimension Value"; Rec."Movement Type Dimension Value")
                {
                    ToolTip = 'Specifies the value of the Movement Type Dimension Value field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the value of the Bal. Account Type field.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ToolTip = 'Specifies the value of the Bal. Account No. field.';
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    ToolTip = 'Specifies the value of the In-Transit Code field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("SO G/L Account Difference"; Rec."SO G/L Account Difference")
                {
                    ToolTip = 'Specifies the value of the Sales Order g/l account difference field.';
                }
                field("Max Order Difference Amt."; Rec."Max Order Difference Amt.")
                {
                    ToolTip = 'Specifies the value of the Max. Order Difference Amount (LCY) field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.GET() then begin
            Rec.INIT();
            Rec.INSERT();   // BC Upgrade NANDIS03 - Added Rec
        end;
    end;

    var
        ItemCategories: Page "Item Categories";
}

