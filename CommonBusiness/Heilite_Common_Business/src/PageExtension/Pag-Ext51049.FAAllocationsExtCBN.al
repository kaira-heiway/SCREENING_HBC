pageextension 51049 FAAllocationsExtCBN extends "FA Allocations"
{
    // version NAVW110.0

    layout
    {
        modify("Account No.")
        {
            ToolTipML = ENU = 'Specifies the account number to allocate to for the fixed asset allocation type on this line.', FRA = 'Spécifie le numéro de compte à allouer pour le type ventilation immobilisation de cette ligne.';
        }
        modify("Account Name")
        {
            ToolTipML = ENU = 'Specifies the name of the account on this allocation line.', FRA = 'Spécifie le nom du compte de cette ligne ventilation.';
        }
        modify("Allocation %")
        {
            ToolTipML = ENU = 'Specifies the percentage to use when allocating the amount for the allocation type.', FRA = 'Spécifie le pourcentage à utiliser lors de la ventilation du montant du type ventilation.';
        }
        modify(AllocationPct)
        {
            CaptionML = ENU = 'Allocation %', FRA = '% ventilation';
            ToolTipML = ENU = 'Specifies the allocation percentage that has accumulated on the line.', FRA = 'Spécifie le pourcentage ventilation totalisé sur la ligne.';
        }
        modify(TotalAllocationPct)
        {
            CaptionML = ENU = 'Total Alloc. %', FRA = '% total ventilation';
            ToolTipML = ENU = 'Specifies the total allocation percentage for the accounts in the FA Allocations window.', FRA = 'Spécifie le pourcentage total ventilation des comptes de la fenêtre Ventilations immobilisation.';
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
    }

    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalAllocationPctVisible := TRUE;
    AllocationPctVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TotalAllocationPctVisible := true;
    AllocationPctVisible := true;
    */
    //end;


    //Unsupported feature: CodeModification on "UpdateAllocationPct(PROCEDURE 3)". Please convert manually.

    //procedure UpdateAllocationPct();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TempFAAlloc.COPYFILTERS(Rec);
    ShowTotalAllocationPct := TempFAAlloc.CALCSUMS("Allocation %");
    IF ShowTotalAllocationPct THEN BEGIN
      TotalAllocationPct := TempFAAlloc."Allocation %";
      IF "Line No." = 0 THEN
        TotalAllocationPct := TotalAllocationPct + xRec."Allocation %";
    end;

    IF "Line No." <> 0 THEN BEGIN
      TempFAAlloc.SETRANGE("Line No.",0,"Line No.");
      ShowAllocationPct := TempFAAlloc.CALCSUMS("Allocation %");
      IF ShowAllocationPct THEN
        AllocationPct := TempFAAlloc."Allocation %";
    end else BEGIN
      TempFAAlloc.SETRANGE("Line No.",0,xRec."Line No.");
      ShowAllocationPct := TempFAAlloc.CALCSUMS("Allocation %");
      IF ShowAllocationPct THEN BEGIN
        AllocationPct := TempFAAlloc."Allocation %";
        TempFAAlloc.COPYFILTERS(Rec);
        TempFAAlloc := xRec;
        IF TempFAAlloc.NEXT = 0 THEN
          AllocationPct := AllocationPct + xRec."Allocation %";
      end;
    end;

    AllocationPctVisible := ShowAllocationPct;
    TotalAllocationPctVisible := ShowTotalAllocationPct;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TempFAAlloc.COPYFILTERS(Rec);
    ShowTotalAllocationPct := TempFAAlloc.CALCSUMS("Allocation %");
    if ShowTotalAllocationPct then begin
      TotalAllocationPct := TempFAAlloc."Allocation %";
      if "Line No." = 0 then
        TotalAllocationPct := TotalAllocationPct + xRec."Allocation %";
    end;

    if "Line No." <> 0 then begin
      TempFAAlloc.SETRANGE("Line No.",0,"Line No.");
      ShowAllocationPct := TempFAAlloc.CALCSUMS("Allocation %");
      if ShowAllocationPct then
        AllocationPct := TempFAAlloc."Allocation %";
    end else begin
      TempFAAlloc.SETRANGE("Line No.",0,xRec."Line No.");
      ShowAllocationPct := TempFAAlloc.CALCSUMS("Allocation %");
      if ShowAllocationPct then begin
    #18..20
        if TempFAAlloc.NEXT = 0 then
          AllocationPct := AllocationPct + xRec."Allocation %";
      end;
    end;
    #25..27
    */
    //end;

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

