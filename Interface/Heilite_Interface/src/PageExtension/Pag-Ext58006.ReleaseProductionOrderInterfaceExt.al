pageextension 58006 RelProductionOrderInterfaceExt extends "Released Production Order"
{
    //Bc Upgrade YADAVM09 Page created for interface.
    //Bc Upgrade YADAVM09 function ProdOrderStatusManagement_OnAfterChangeStatusOnProdOrder function changed
    layout
    {
        addafter(Posting)
        {
            group(LogoPak)
            {
                Caption = 'LogoPak';
                Visible = VisibleLogoPak;
                group(Outbound)
                {
                    Caption = 'Outbound';
                    field("Prod. Order Interface"; Rec."Prod. Order Interface INT")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Prod. Order Interface field.';
                    }
                    field("Parked for LogoPak"; Rec."Parked for LogoPak INT")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Parked for LogoPak field.';
                    }
                }
                group(Inbound)
                {
                    Caption = 'Inbound';
                    field("Prod. Order Output Interface"; Rec."Prod. Order Output Interf INT")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Prod. Order Output Interface field.';
                    }
                    field("Parked from LogoPak"; Rec."Parked from LogoPak INT")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Parked from LogoPak field.';
                    }
                    field("Posted from LogoPak"; Rec."Posted from LogoPak INT")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Posted from LogoPak field.';
                    }
                }
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        addafter(RefreshProductionOrder)
        {
            action(SendForLogoPak)
            {
                Caption = 'Send For LogoPak';
                Ellipsis = true;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                Visible = Visiblelogopak;
                ApplicationArea = All;
                ToolTip = 'Executes the Send For LogoPak action.';

                trigger OnAction();
                var
                    ProdOrderStatusMgmtL: Codeunit "Prod. Order Status Management";
                    InterfaceDtWCodeCU: Codeunit InterfaceDtWCode;
                    supress: Boolean;
                    ToProdOrder: Record "Production Order";
                begin
                    //HEI.11>>
                    CurrPage.UPDATE();
                    // ProdOrderStatusMgmtL.OnAfterReleasedProdOrder(Rec, false);//Bc Upgrade YADAVM09
                    InterfaceDtWCodeCU.ProdOrderStatusManagement_OnAfterChangeStatusOnProdOrder(Rec, ToProdOrder, Rec.Status, 0D, false, supress);//Bc Upgrade YADAVM09
                    //HEI.11<<
                end;
            }
        }
        addafter("Re&plan")
        {
            action("&Testscript_Refresh Production Order")
            {
                Caption = '&Testscript_Refresh Production Order';
                Ellipsis = true;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                Visible = Visiblelogopak;
                ApplicationArea = All;
                ToolTip = 'Executes the &Testscript_Refresh Production Order action.';
                trigger OnAction()
                var
                    ProdOrder: Record "Production Order";
                    Item: Record Item;
                    StockKeepingUnit: Record "Stockkeeping Unit";
                    RoutingNo: Code[20];
                    BOM: Code[20];
                    RoutingVersion: Record "Routing Version";
                    ProductionBOMVersion: Record "Production BOM Version";
                    RoutingExist: Boolean;
                    BOMExist: Boolean;
                begin
                    //HEI.10>>
                    ProdOrder.SETRANGE(Status, Rec.Status);
                    ProdOrder.SETRANGE("No.", Rec."No.");
                    IF Item.GET(Rec."Source No.") THEN BEGIN
                        StockKeepingUnit.SETRANGE("Item No.", Item."No.");
                        StockKeepingUnit.SETRANGE("Location Code", Rec."Location Code");
                        IF StockKeepingUnit.FINDFIRST() THEN BEGIN
                            RoutingNo := StockKeepingUnit."Routing No.";
                            BOM := StockKeepingUnit."Production BOM No.";
                        END ELSE
                            ERROR('There is not any Active Routing / BOM version');
                        RoutingVersion.SETRANGE("Routing No.", RoutingNo);
                        RoutingVersion.SETRANGE("Active FND", TRUE);
                        IF RoutingVersion.FINDFIRST() THEN
                            RoutingExist := TRUE
                        ELSE
                            RoutingExist := FALSE;
                        ProductionBOMVersion.SETRANGE("Production BOM No.", BOM);
                        ProductionBOMVersion.SETRANGE("Active FND", TRUE);
                        IF ProductionBOMVersion.FINDFIRST() THEN
                            BOMExist := TRUE
                        ELSE
                            BOMExist := FALSE;
                    END;

                    IF RoutingExist AND BOMExist THEN
                        REPORT.RUNMODAL(REPORT::"Refresh Prod Order DTW CBN", FALSE, FALSE, ProdOrder)
                    ELSE
                        ERROR('There is not any Active Routing / BOM version');
                    //HEI.10<<

                end;
            }
        }
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        WMSInterfaceSetupL: Record "WMS Interface Setup INT";
        InterfaceSetupL: Record "Interface Setup INT";
    begin
        //HEI.11>>
        CLEAR(VisibleLogoPak);
        if WMSInterfaceSetupL.GET() and WMSInterfaceSetupL."WMS Integration" then begin
            if WMSInterfaceSetupL."Activate LogoPak Interface" and (WMSInterfaceSetupL."Prod. Order Interface" <> '') then
                if InterfaceSetupL.GET(WMSInterfaceSetupL."Prod. Order Interface") then
                    VisibleLogoPak := true;
        end;
        //HEI.11<<
    end;

    var
        myInt: Integer;
        VisibleLogoPak: Boolean;
}