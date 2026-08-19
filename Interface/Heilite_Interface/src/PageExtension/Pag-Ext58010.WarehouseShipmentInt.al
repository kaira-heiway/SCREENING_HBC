pageextension 58010 WarehouseShipmentInt extends "Warehouse Shipment"
{

    //     HEI.14 HB2156CHG2107450 IBM GAVANM01 27.01.2022 # WMS Phase 2 - Transportation cost
    //   # new field added in General tab: WMS Import
    //   # new global var VisibleWMS, WMSInterfaceSetup
    //   # code added in OnInit() and in the actions: Post Shipment, Post and &Print,Post and &Print (Load List)
    //     //BC Upgrade SHARMP16---- Interface related code shifted to main extension.
    //     HEI.02 HORTOC01 15/03.2018
    //   # new temporary action for Algeria
    // HEI.02 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    //   # New Page Action created
    //     HEI.15 HB2156 CHG2107450 IBM GAVANM01 14.03.2022 # WMS Phase 2 Transportation cost
    //   # disable Auto FEFO if WMS Import = TRUE
    //   # new global var EnabledAutoFEFO
    // HEI.12 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Code added on "Get Source Documents" Action
    layout
    {
        // addafter("Sorting Method")
        // {
        //     field("WMS Import"; Rec."WMS Import")
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Visible = VisibleWMS;
        //     }//HEI.14
        // }
    }

    actions
    {
        modify("Get Source Documents")
        {
            trigger OnBeforeAction()
            var
                SalesHeader: Record "Sales Header";
                SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
                CantShipErr: Label 'You can not ship an Order sent by %1.';
            begin
                //HEI.12>>
                IF SalesHeader.GET(SalesHeader."Document Type"::Order, rec."Source No. FND") THEN
                    IF SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") THEN
                        IF SourceSystemIdentifierAPI."Automatic SO Posting" THEN
                            ERROR(CantShipErr, SalesHeader."Source System Identifier FND");
                //HEI.12<<

            end;
        }
        modify("P&ost Shipment")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //HEI.14<<
                IF WMSInterfaceSetup.GET() AND WMSInterfaceSetup."WMS Integration" THEN BEGIN
                    WhseShptLine.RESET();
                    WhseShptLine.SETRANGE("No.", Rec."No.");
                    WhseShptLine.SETFILTER("Item No.", '=%1', '');
                    IF WhseShptLine.FINDFIRST() THEN
                        ERROR(ErrorText001);
                END;
                //HEI.14>>


            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //HEI.14<<
                IF WMSInterfaceSetup.GET() AND WMSInterfaceSetup."WMS Integration" THEN BEGIN
                    WhseShptLine.RESET();
                    WhseShptLine.SETRANGE("No.", Rec."No.");
                    WhseShptLine.SETFILTER("Item No.", '=%1', '');
                    IF WhseShptLine.FINDFIRST() THEN
                        ERROR(ErrorText001);
                END;
                //HEI.14>>

            end;
        }
        addafter("Post and &Print")
        {
            action("Post and &Print (Load List)")
            {
                Caption = 'Post and &Print (Load List)';
                Description = 'HEI.11';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                Visible = PostPrintLoadingNote;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Post and &Print (Load List) action.';
                trigger OnAction();
                var
                    WarehouseShipmentLine: Record "Warehouse Shipment Line";
                begin
                    //HEI.14<<
                    if WMSInterfaceSetup.GET() and WMSInterfaceSetup."WMS Integration" then begin
                        WhseShptLine.RESET();
                        WhseShptLine.SETRANGE("No.", Rec."No.");
                        WhseShptLine.SETFILTER("Item No.", '=%1', '');
                        if WhseShptLine.FINDFIRST() then
                            ERROR(ErrorText001);
                    end;
                    //HEI.14>>

                    // //HEI.16>>
                    // if AstroPostingValidation(Rec) then
                    //     ERROR(Text50000);//BC Upgrade SHARMP16 -- Astro code out of scope
                    //HEI.16<<

                    //HEI.02>>
                    WarehouseShipmentLine.SETRANGE("No.", rec."No.");
                    if WarehouseShipmentLine.findset() then
                        repeat
                            WarehouseShipmentLine."Print Load List Shipment FND" := true;
                            WarehouseShipmentLine.MODIFY();
                        until WarehouseShipmentLine.NEXT() = 0;
                    PostShipmentPrintYesNo();


                    //HEI.02<<
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        VisibleWMS := WMSInterfaceSetup.GET() AND WMSInterfaceSetup."WMS Integration";  //HEI.14

        EnabledAutoFEFO := NOT rec."WMS Import FND";   //HEI.15
    end;

    var
        VisibleWMS: Boolean;
        EnabledAutoFEFO: Boolean;
        PostPrintLoadingNote: Boolean;
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        WhseShptLine: Record "Warehouse Shipment Line";
        ErrorText001: Label 'The warehouse shipment cannot be posted. Please solve the error lines.';

}