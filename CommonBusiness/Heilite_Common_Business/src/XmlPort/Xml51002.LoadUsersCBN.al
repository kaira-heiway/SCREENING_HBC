xmlport 51002 "Load Users CBN"
{
    // version HEIL3.0.FCE

    // 09.06.2020 FCE XML Load quickly Warehouse related values for testing
    // BC Upgrade BHARAD11 >>
    // 1. Remove Drink-IT Field ("Gyle No.","Bin Code")
    // BC Upgrade BHARDA11 <<
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF16;

    schema
    {
        textelement(PackImport)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'UserDetails';
                textelement(UsersId)
                {
                }

                trigger OnAfterInsertRecord()
                var
                    IntValue: Integer;
                    lCodeBOMVersion: Code[20];
                    LocationCodig: Code[20];
                    ZoneCoding: Code[20];
                    BinCoding: Code[20];
                begin
                    gRecUsers.SETFILTER(gRecUsers."User Name", '*' + UPPERCASE(UsersId));
                    IF gRecUsers.FINDSET() THEN BEGIN
                        IF CreateLocationZones THEN BEGIN
                            IF gRecZones.FINDSET() THEN
                                REPEAT
                                    gRecWarehouseEmployees.VALIDATE("User ID", gRecUsers."User Name");
                                    gRecWarehouseEmployees.VALIDATE("Location Code", gRecZones."Location Code");
                                    gRecWarehouseEmployees.VALIDATE("Zone Code FND", gRecZones.Code);
                                    IF gRecWarehouseEmployees.INSERT() THEN;
                                UNTIL gRecZones.NEXT() = 0
                        END;

                        IF CreateUserItemJournalRights THEN BEGIN
                            gRecItemJournalTemplates.SETFILTER(gRecItemJournalTemplates.Type, '%1|%2|%3|%4', gRecItemJournalTemplates.Type::Item, gRecItemJournalTemplates.Type::"Phys. Inventory",
                                                            gRecItemJournalTemplates.Type::Transfer, gRecItemJournalTemplates.Type::Revaluation);
                            IF gRecItemJournalTemplates.FINDSET() THEN
                                REPEAT
                                    gRecUserGenSetup."Journal Type" := gRecUserGenSetup."Journal Type"::Item;
                                    gRecUserGenSetup.VALIDATE("User ID", gRecUsers."User Name");
                                    gRecUserGenSetup."Gen. Journal Template Name" := gRecItemJournalTemplates.Name;
                                    IF gRecUserGenSetup.INSERT() THEN;
                                UNTIL gRecItemJournalTemplates.NEXT() = 0
                        END;
                    END;



                end;

                trigger OnBeforeInsertRecord()
                var
                    IntValue: Integer;
                    // ObjectRec: Record "2000000071";
                    Int_AttributeID: Integer;
                begin
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(CreateLocationZones; CreateLocationZones)
                {
                    ApplicationArea = All;
                    Caption = 'Create Location Zones per User ';
                }
                field(CreateUserItemJournalRights; CreateUserItemJournalRights)
                {
                    ApplicationArea = All;
                    Caption = 'Create User General Iteml Journals';
                }
            }
        }

        actions
        {
        }
    }

    var
        gTxt01: Label 'Continue with the load';
        ItemJournalCode: Code[10];
        ItemJournalBatch: Code[10];
        "LineNo.": Integer;
        ProductionBomHeader: Record "Production BOM Header";
        ProductionBOmLine: Record "Production BOM Line";
        ProductionVersion: Record "Production BOM Version";
        Itemjournal: Record "Item Journal Line";
        gFCE01: Label 'Item %1 for production BOM %2';
        Productionquantity: Decimal;
        DocNo: Code[20];
        LotCode: Code[20];
        // ----: Integer;
        gRecUsers: Record User;
        gRecWarehouseEmployees: Record "Warehouse Employee";
        gRecUserGenSetup: Record "User Gen. Journal Setup FND";
        gRecLocations: Record Location;
        gRecZones: Record Zone;
        gRecItemJournalTemplates: Record "Item Journal Template";
        CreateLocationZones: Boolean;
        CreateUserItemJournalRights: Boolean;

    local procedure BOMVersion(pProductionORder: Code[10]): Code[20]
    var
        ProductionVersion2: Record "Production BOM Version";
    begin
        ProductionVersion2.SETRANGE(ProductionVersion2."Production BOM No.", pProductionORder);
        ProductionVersion2.SETRANGE(ProductionVersion2.Status, ProductionVersion2.Status::Certified);
        ProductionVersion2.SETRANGE(ProductionVersion2."Active FND", TRUE);
        IF ProductionVersion2.FINDLAST() THEN
            EXIT(ProductionVersion2."Version Code")
        ELSE
            EXIT('');
    end;

    local procedure GetZoneCode(LocationCode: Code[20]; BinCode: Code[20]): Code[20]
    var
        RoutingHEader: Record "Routing Header";
        RoitingLines: Record "Routing Line";
        RoutingVersion: Record "Routing Version";
        Bin: Record Bin;
    begin
        IF Bin.GET(LocationCode, BinCode) THEN
            EXIT(Bin."Zone Code")
        ELSE
            EXIT('');
    end;

    local procedure GetLocation(RoutingLink: Code[20]; var LocationCode: Code[20]; var ZoneCode: Code[20]; var BinCode: Code[20])
    var
        RoutingVersion: Record "Routing Version";
        RoutingLines: Record "Routing Line";
        WorkCenters: Record "Work Center";
    begin
        RoutingVersion.SETRANGE(RoutingVersion."Routing No.", RoutingLink);
        RoutingVersion.SETRANGE(RoutingVersion."Active FND", TRUE);
        IF RoutingVersion.FINDLAST() THEN BEGIN
            RoutingLines.SETRANGE(RoutingLines."Routing No.", RoutingLink);
            RoutingLines.SETRANGE(RoutingLines.Type, RoutingLines.Type::"Work Center");
            RoutingLines.SETRANGE(RoutingLines."Version Code", RoutingVersion."Version Code");
            IF RoutingLines.FINDSET() THEN BEGIN
                IF WorkCenters.GET(RoutingLines."No.") THEN BEGIN
                    LocationCode := WorkCenters."Location Code";
                    BinCode := WorkCenters."To-Production Bin Code";
                    ZoneCode := GetZoneCode(LocationCode, BinCode);
                END;

            END;
        END;
    end;

    procedure InsertItemTracking(ItemJnlLine: Record "Item Journal Line"; LotNo: Code[20])
    var
        ReserveEntry: Record "Reservation Entry";
        EntryNo: Integer;
        LotNoInformation: Record "Lot No. Information";
    begin
        IF ReserveEntry.FINDLAST() THEN
            EntryNo := ReserveEntry."Entry No." + 1
        ELSE
            EntryNo := 1;
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with ReserveEntry.
        //WITH ReserveEntry DO BEGIN
        ReserveEntry.INIT();
        ReserveEntry."Entry No." := EntryNo;
        ReserveEntry.Positive := TRUE;
        ReserveEntry.VALIDATE("Item No.", ItemJnlLine."Item No.");
        ReserveEntry.VALIDATE("Location Code", ItemJnlLine."Location Code");
        ReserveEntry.VALIDATE("Quantity (Base)", ItemJnlLine."Quantity (Base)");
        ReserveEntry."Reservation Status" := "Reservation Status"::Prospect;
        ReserveEntry.VALIDATE("Creation Date", ItemJnlLine."Posting Date");
        ReserveEntry."Source Type" := 83;
        ReserveEntry."Source Subtype" := 2;
        ReserveEntry."Source ID" := ItemJnlLine."Journal Template Name";
        ReserveEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
        ReserveEntry."Source Ref. No." := ItemJnlLine."Line No.";
        ReserveEntry."Expected Receipt Date" := ItemJnlLine."Posting Date";
        ReserveEntry."Expiration Date" := ItemJnlLine."Expiration Date";
        // "Bin Code" := ItemJnlLine."Bin Code"; // BC Upgrade BHARDA11 -- Drink-IT Field("Bin Code")
        ReserveEntry.VALIDATE("Lot No.", LotNo);
        ReserveEntry."Item Tracking" := ReserveEntry."Item Tracking"::"Lot No.";
        ReserveEntry.INSERT();

        IF NOT LotNoInformation.GET(ReserveEntry."Item No.", ReserveEntry."Variant Code", ReserveEntry."Lot No.") THEN BEGIN
            LotNoInformation.INIT();
            LotNoInformation.VALIDATE("Item No.", ReserveEntry."Item No.");
            LotNoInformation.VALIDATE("Variant Code", ReserveEntry."Variant Code");
            LotNoInformation.VALIDATE("Lot No.", LotNo);
            LotNoInformation.Description := ReserveEntry.Description;


            // LotNoInformation."Gyle No." := "Gyle No."; // BC Upgrade BHARDA11 --Drink-IT Field("Gyle No.")
            LotNoInformation.INSERT(TRUE);
        END;
        //END;
        // BC Upgrade MISHRS14 <<
    end;

    local procedure LotRequired(ItemCode: Code[20]): Boolean
    var
        lRecItems: Record Item;
    begin
        lRecItems.GET(ItemCode);
        EXIT(lRecItems."Item Tracking Code" <> '');
    end;
}

