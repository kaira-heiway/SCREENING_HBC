codeunit 51016 "Levenshtein Compare CBN"
{

    trigger OnRun();
    var
        Vendor: Record Vendor;
        CustDesc: Text;
    begin
        //Sample Code to use Levisthine Check Similarities Code
        /*
        Vendor.RESET;
        IF Vendor.findset THEN
        REPEAT
          IF CheckSimilarities('My New Vendor Name',Vendor.Name) > 50 THEN
            Vendor.MARK(TRUE);
        UNTIL Vendor.NEXT = 0;
        Vendor.MARKEDONLY(TRUE);
        PAGE.RUNMODAL(0,Vendor);
        */

        CustDesc := '0AlcaldeDiazAlcaldeDiazMiniSuperChungRRPCallePrincipalMADUNGANDI';
        Customer.RESET();
        Customer.SETRANGE("No.", '0010000353');
        if Customer.findset() then
            repeat
                //IF CheckSimilarities('0AlcaldeDiazAlcaldeDiazMiniSuperChungRRPCallePrincipalMADUNGANDI',Customer."Customer Description") > 50 THEN
                CustDuplicateDistance := HeinekenGlobal.DamerauLevenshtein(CustDesc, Customer."Customer Description FND");
            //CustDuplicateDistance := CheckSimilarities(CustDesc,Customer."Customer Description");
            //IF CustDuplicateDistance > 50 THEN
            //Customer.MARK(TRUE);
            until Customer.NEXT() = 0;
        //Customer.MARKEDONLY(TRUE);
        //PAGE.RUNMODAL(0,Customer);
        MESSAGE('done')

    end;

    var
        Customer: Record Customer;
        HeinekenGlobal: Codeunit "Heineken Global";
        CustDuplicateDistance: Decimal;

    procedure CheckSimilarities(Source: Text; Target: Text): Decimal;
    var
        done: Boolean;
        last: Boolean;
        singleWordWeighting: Decimal;
        weighting: Decimal;
        compareWord: Text;
        String1: Text;
        String2: Text;
        wordString: Text;
    begin
        String1 := LOWERCASE(Target);
        String2 := LOWERCASE(Source);
        wordString := String1;
        weighting := CalcSimilarities(String1, String2) * 100;
        done := false;
        last := false;
        if (weighting > 50) then begin
            exit(weighting);
        end else
            repeat
                if STRPOS(wordString, ' ') > 0 then begin
                    compareWord := COPYSTR(wordString, 1, STRPOS(wordString, ' ') - 1);
                    wordString := DELSTR(wordString, 1, STRPOS(wordString, ' '));
                end else begin
                    compareWord := wordString;
                    wordString := '';
                end;
                singleWordWeighting := CalcSimilarities(wordString, String2) * 100;
                if singleWordWeighting > 90 then
                    exit(singleWordWeighting);
            until (wordString = '');
        exit(0);
    end;

    local procedure CalcSimilarities(var Source: Text; var Target: Text): Decimal;
    var
        MaxVal: Integer;
        sourceWordCount: Integer;
        stepsToSame: Integer;
        targetWordCount: Integer;
    begin
        if (Source = '') or (Target = '') then
            exit(0.0);

        if (Source = Target) then
            exit(1.0);


        sourceWordCount := STRLEN(Source);
        targetWordCount := STRLEN(Target);
        if sourceWordCount > targetWordCount then
            MaxVal := sourceWordCount
        else
            MaxVal := targetWordCount;

        stepsToSame := ComputeLevDistance(Source, Target);
        exit(1.0 - (stepsToSame / MaxVal));
    end;

    local procedure ComputeLevDistance(var Source: Text; var Target: Text): Integer;
    var
        cost: Integer;
        distance: array[100, 100] of Integer;
        i: Integer;
        j: Integer;
        minVal: Integer;
        sourceWordCount: Integer;
        targetWordCount: Integer;
    begin
        // Compute Levenshtein Distance
        if (Source = '') or (Target = '') then
            exit(0);

        sourceWordCount := STRLEN(Source);
        targetWordCount := STRLEN(Target);

        if Source = Target then
            exit(sourceWordCount);


        // Step 1
        if (sourceWordCount = 0) then
            exit(targetWordCount);

        if (targetWordCount = 0) then
            exit(sourceWordCount);

        for i := 1 to 51 do
            for j := 1 to 51 do
                distance[i, j] := 0;

        // Step 2
        for i := 1 to sourceWordCount do
            distance[i, 1] := i;


        for j := 1 to targetWordCount do
            distance[1, j] := j;

        for i := 2 to sourceWordCount do
            for j := 2 to targetWordCount do begin
                // Step 3
                if (Target[j - 1] = Source[i - 1]) then
                    cost := 0
                else
                    cost := 1;
                // Step 4
                if distance[i - 1, j] + 1 > distance[i, j - 1] + 1 then
                    minVal := distance[i, j - 1] + 1
                else
                    minVal := distance[i - 1, j] + 1;

                if distance[i - 1, j - 1] + cost > minVal then
                    distance[i, j] := minVal
                else
                    distance[i, j] := distance[i - 1, j - 1] + cost;
            end;

        exit(distance[sourceWordCount, targetWordCount]);
    end;
}

