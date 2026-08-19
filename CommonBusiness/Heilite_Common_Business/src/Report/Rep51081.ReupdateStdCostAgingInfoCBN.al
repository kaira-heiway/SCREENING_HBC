report 51081 "Reupdate Std Cost Aging CBN"
{
    // version HEI.01

    // HEI.01 CHG2213838 SAHAL01 01.08.2023 Update of block in standard cost aging table for items blocked
    //   # Created New Report: 50496 - Re-update Std. Cost Aging Info

    // BC Upgrade KUMARS145 Nav ID Report 50496 "Reupdate Std Cost Aging CBN"

    Caption = 'Re-update Std. Cost Aging Info';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Stockkeeping Unit"; "Stockkeeping Unit")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Variant Code") ORDER(Ascending);
            RequestFilterFields = "Item No.", "Location Code";

            trigger OnAfterGetRecord();
            var
                ItemL: Record Item;
                StdCostAgingInfoL: Record "Standard Cost Aging Info FND";
                IsUpdateL: Boolean;
                StdCostAgingInfoL1: Record "Standard Cost Aging Info FND";
            begin
                //HEI.01>>
                if ItemL.GET("Item No.") then
                    if ItemL."Costing Method" = ItemL."Costing Method"::Standard then begin
                        StdCostAgingInfoL.SETCURRENTKEY("Location Code", "Item No.");
                        StdCostAgingInfoL.SETRANGE("Location Code", "Location Code");
                        StdCostAgingInfoL.SETRANGE("Item No.", "Item No.");
                        if StdCostAgingInfoL.FINDSET(false) then begin
                            repeat
                                CLEAR(IsUpdateL);
                                if (ItemL.Blocked and (StdCostAgingInfoL."Block or Unblock Date" <> ItemL."Last Date Modified")) or
                                  (not ItemL.Blocked and StdCostAgingInfoL.Blocked) then begin
                                    StdCostAgingInfoL."Block or Unblock Date" := ItemL."Last Date Modified";
                                    IsUpdateL := true;
                                end;
                                if ItemL.Blocked <> StdCostAgingInfoL.Blocked then begin
                                    StdCostAgingInfoL.Blocked := ItemL.Blocked;
                                    IsUpdateL := true;
                                end;
                                if IsUpdateL then begin
                                    StdCostAgingInfoL.MODIFY(false);
                                    i += 1;
                                end;
                            until StdCostAgingInfoL.NEXT() = 0;
                        end else begin
                            StdCostAgingInfoL1.INIT();
                            StdCostAgingInfoL1."Location Code" := "Location Code";
                            StdCostAgingInfoL1."Item No." := ItemL."No.";
                            StdCostAgingInfoL1."Item Description" := ItemL.Description;
                            StdCostAgingInfoL1."Item Category Code" := ItemL."Item Category Code";
                            StdCostAgingInfoL1.Blocked := ItemL.Blocked;
                            StdCostAgingInfoL1."Block or Unblock Date" := ItemL."Last Date Modified";
                            StdCostAgingInfoL1."Date of Change" := ItemL."Last Date Modified";
                            StdCostAgingInfoL1."Legal Entity" := CompInfo."Legal Entity Code FND";
                            StdCostAgingInfoL1.INSERT(false);
                            j += 1;
                        end;
                    end;
                //HEI.01<<
            end;
        }
    }

    requestpage
    {

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

    trigger OnPostReport();
    begin
        //HEI.01>>
        if GUIALLOWED then
            MESSAGE(Text000, j, i);
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        CompInfo.GET();
        CLEAR(i);
        CLEAR(j);
        //HEI.01<<
    end;

    var
        CompInfo: Record "Company Information";
        i: Integer;
        j: Integer;
        Text000: Label 'Created Lines: %1\Updated Lines: %2';
}

