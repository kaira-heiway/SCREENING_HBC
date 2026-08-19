page 51001 "Zone List WH CBN"
{
    // version HEI.01

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #zone transfers

    Caption = 'Zone List';
    DataCaptionFields = "Location Code", "Code";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Zone;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the code of the zone.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code of the zone.';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        //
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the zone.';
                }
                field("Use As In-Transit"; Rec."Use As In-Transit FND")
                {
                    ToolTip = 'Specifies the value of the Use As In-Transit field.';
                }
            }
        }
    }

    actions
    {
    }

    //BC Upgrade Priya >> DrinkIT Function(LocationPhysIsAllowed) is used.
    // trigger OnFindRecord(Which: Text): Boolean;
    // var
    //     Zones: Record Zone;
    //     WMSMgt: Codeunit "WMS Management";
    // begin
    //     if Rec.FIND(Which) then begin
    //         Zones := Rec;
    //         while true do begin
    //             if WMSMgt.LocationPhysIsAllowed("Location Code", '', Rec.Code) then
    //                 exit(true);
    //             if Rec.NEXT(1) = 0 then begin
    //                 Rec := Zones;
    //                 if Rec.FIND(Which) then
    //                     while true do begin
    //                         if WMSMgt.LocationPhysIsAllowed("Location Code", '', Rec.Code) then
    //                             exit(true);
    //                         if Rec.NEXT(-1) = 0 then
    //                             exit(false);
    //                     end;
    //             end;
    //         end;
    //     end;
    //     exit(false);
    // end;

    // trigger OnNextRecord(Steps: Integer): Integer;
    // var
    //     Zones: Record Zone;
    //     WMSMgt: Codeunit "WMS Management";
    //     NextSteps: Integer;
    //     RealSteps: Integer;
    // begin
    //     if Steps = 0 then
    //         exit;

    //     Zones := Rec;
    //     repeat
    //         NextSteps := Rec.NEXT(Steps / ABS(Steps));
    //         if WMSMgt.LocationPhysIsAllowed("Location Code", '', Rec.Code) then begin
    //             RealSteps := RealSteps + NextSteps;
    //             Zones := Rec;
    //         end;
    //     until (NextSteps = 0) or (RealSteps = Steps);
    //     Rec := Zones;
    //     Rec.FIND;
    //     exit(RealSteps);
    // end; //BC Upgrade Priya>> DrinkIT Function(LocationPhysIsAllowed) is used.
}

