codeunit 50070 VATLogicalTests
{
    // version NAVBE9.00

    // HEI.01 V1.05 HT84 IBM POENAB02 28.03.2019
    //   # Object created


    trigger OnRun();
    begin
    end;

    var
        Text11300: TextConst ENU = '1. Row [01] and/or Row [02] and/or Row [03] \', FRB = '1. Ligne [01] et/ou ligne [02] et/ou ligne [03] \', NLB = '1. Vak [01] en/of vak [02] en/of vak [03] \';
        Text11301: TextConst ENU = '    => Row [54]', FRB = '    => Ligne [54]', NLB = '    => vak [54]';
        Text11302: TextConst ENU = '2. Row [54] => Row [01] and/or Row [02] and/or \', FRB = '2. Ligne [54] => ligne [01] et/ou ligne [02] et/ou \', NLB = '2. Vak [54] => vak [01] en/of vak [02] en/of \';
        Text11303: TextConst ENU = '    Row [03]', FRB = '    Ligne [03]', NLB = '    vak [03]';
        Text11304: TextConst ENU = '3. Row [86] and/or Row [88] => Row [55]', FRB = '3. Ligne [86] et/ou ligne [88] => ligne [55]', NLB = '3. Rij [86] en/of rij [88] => Rij [55]';
        Text11305: TextConst ENU = '4. Row [87] => Row [56] and/or Row [57]', FRB = '4. Ligne [87] => ligne [56] et/ou ligne [57]', NLB = '4. Vak [87] => vak [56] en/of vak [57]';
        Text11306: TextConst ENU = '5. There is an amount in Row [65] \', FRB = '5. Il y a un montant dans la ligne [65] \', NLB = '5. Er staat een bedrag in vak [65] \';
        Text11307: TextConst ENU = '    and/or Row [66]', FRB = '    et/ou Ligne [66]', NLB = '    en/of vak [66]';
        Text11308: TextConst ENU = '6. There is a wrong amount in Row [91]', FRB = '6. Il y a un montant incorrect dans la ligne [91]', NLB = '6. Er staat een verkeerd bedrag in vak [91] \';
        Text11309: TextConst ENU = '7. Row [01] x 6% + Row [02] x 12% + \', FRB = '7. Ligne [01] x 6% + ligne [02] x 12% + \', NLB = '7. Vak [01] x 6% + vak [02] x 12% + \';
        Text11310: TextConst ENU = '    Row [03] x 21% = Row [54]', FRB = '    Ligne [03] x 21% = Ligne [54]', NLB = '    vak [03] x 21% = vak [54]';
        Text11311: TextConst ENU = '8. Row [55] =< (Row [84] + Row [86] + Row [88]) * 21%', FRB = '8. Ligne [55] =< (ligne [84] + ligne [86] + ligne [88]) * 21 %', NLB = '8. Rij [55] =< (Rij [84] + Rij [86] + Rij [88]) * 21%';
        Text11312: TextConst ENU = '9. (Row [56] + Row [57]) =< \', FRB = '9. (Ligne [56] + ligne [57]) =< \', NLB = '9. (Vak [56] + vak [57]) =< \';
        Text11313: TextConst ENU = '    (Row [85] + Row [87]) * 21%', FRB = '    (ligne [85] + ligne [87]) * 21%', NLB = '    (vak [85] + vak [87]) * 21%';
        Text11314: TextConst ENU = '10. Row [59] =< (Row [81] + Row [82] + \', FRB = '10. Ligne [59] =< (ligne [81] + ligne [82] + \', NLB = '10. Vak [59] =< (vak [81] + vak [82] + \';
        Text11315: TextConst ENU = '     Row [83] + Row [84] + Row [85]) * 50%', FRB = '     Ligne [83] + ligne [84] + ligne [85]) * 50 %', NLB = '     Rij [83] + Rij [84] + Rij [85]) * 50%';
        Text11316: TextConst ENU = '11. Row [63] =< Row [85] * 21%', FRB = '11. Ligne [63] =< ligne [85] * 21%', NLB = '11. Vak [63] =< vak [85] * 21%';
        Text11317: TextConst ENU = '12. Row [64] =< Row [49] * 21%', FRB = '12. Ligne [64] =< ligne [49] * 21%', NLB = '12. Vak [64] =< vak [49] * 21%';
        Text11318: TextConst ENU = 'Error', FRB = 'Erreur', NLB = 'Fout';
        Text11319: TextConst ENU = 'OK', FRB = 'OK', NLB = 'OK';
        Text11320: TextConst ENU = '13. There is/are row(s) with negative amounts', FRB = '13. Il y a une (ou plusieurs) ligne(s) qui contien(nen)t des montants négatifs', NLB = '13. Er is/zijn vak(ken) met negatieve bedragen';

    procedure CheckNo(No: Text[20]): Boolean;
    var
        Ctrl: Decimal;
        WorkVatNo: Decimal;
        Vatno: Text[20];
    begin
        Vatno := DELCHR(No, '=', DELCHR(No, '=', '0123456789'));
        if STRLEN(Vatno) <> 9 then
            exit(false);
        EVALUATE(WorkVatNo, COPYSTR(Vatno, 1, 7));
        EVALUATE(Ctrl, COPYSTR(Vatno, 8, 2));
        WorkVatNo := 97 - (WorkVatNo mod 97);
        exit(WorkVatNo = Ctrl);
    end;

    procedure CheckForErrors(NoOfPeriods: Integer; Row: array[99, 12] of Decimal; Errormargin: Decimal; December: Integer; var Control: array[14] of Text[250]; var CheckList: array[14, 12] of Text[30]);
    var
        i: Integer;
        j: Integer;
    begin
        for i := 1 to NoOfPeriods do begin
            Control[1] := Text11300 + Text11301; // "Code A"
            Test(1,
              ((Row[1, i] <> 0) or (Row[2, i] <> 0) or (Row[3, i] <> 0)) and
              (Row[54, i] = 0), i, CheckList);

            Control[2] := Text11302 + Text11303; // "Code B"
            Test(2,
              (Row[54, i] <> 0) and
              (Row[1, i] = 0) and (Row[2, i] = 0) and (Row[3, i] = 0), i, CheckList);

            Control[3] := Text11304; // "Code C"
            Test(3, ((Row[86, i] <> 0) or (Row[88, i] <> 0)) and (Row[55, i] = 0), i, CheckList);

            Control[4] := Text11305; // "Code D"
            Test(4, (Row[87, i] <> 0) and (Row[56, i] = 0) and (Row[57, i] = 0), i, CheckList);

            Control[5] := Text11306 + Text11307;
            Test(5, (Row[65, i] <> 0) or (Row[66, i] <> 0), i, CheckList);

            Control[6] := Text11308; // "Code 5"
            Test(6, (Row[91, i] <> 0) and (December <> 12), i, CheckList);

            Control[7] := Text11309 + Text11310; // "Code O"
            Test(7,
              ABS(Row[1, i] * 0.06 + Row[2, i] * 0.12 + Row[3, i] * 0.21 - Row[54, i]) >
              Errormargin, i, CheckList);

            Control[8] := Text11311; // "Code P"
            Test(8, Row[55, i] > ((Row[84, i] + Row[86, i] + Row[88, i]) * 0.21 + Errormargin), i, CheckList);

            Control[9] := Text11312 + Text11313; // "Code Q"
            Test(9, (Row[56, i] + Row[57, i]) > ((Row[85, i] + Row[87, i]) * 0.21 + Errormargin), i, CheckList);

            Control[10] := Text11314 + Text11315; // "Code S"
            Test(10, Row[59, i] > (Row[81, i] + Row[82, i] + Row[83, i] + Row[84, i] + Row[85, i]) * 0.5, i, CheckList);

            Control[11] := Text11316; // "Code T"
            Test(11, Row[63, i] > Row[85, i] * 0.21 + Errormargin, i, CheckList);

            Control[12] := Text11317; // "Code U"
            Test(12, Row[64, i] > Row[49, i] * 0.21 + Errormargin, i, CheckList);

            // check for negative amounts on one of the rows
            Control[13] := Text11320;
            Test(13, false, i, CheckList);  // initial value is OK
            for j := 1 to 99 do
                if Row[j, i] < 0 then
                    Test(13, true, i, CheckList);
        end;
    end;

    procedure Test(TestNo: Integer; LogicalTest: Boolean; Period: Integer; var MyCheckList: array[14, 12] of Text[30]);
    begin
        if LogicalTest then
            MyCheckList[TestNo, Period] := Text11318
        else
            MyCheckList[TestNo, Period] := Text11319;
    end;

    procedure MOD97Check(Number: Text[50]): Boolean;
    var
        Ctrl: Decimal;
        WorkNo: Decimal;
        No: Text[20];
    begin
        No := DELCHR(Number, '=', DELCHR(Number, '=', '0123456789'));
        if STRLEN(No) <> 10 then
            exit(false);
        EVALUATE(WorkNo, COPYSTR(No, 1, 8));
        EVALUATE(Ctrl, COPYSTR(No, 9, 2));
        WorkNo := 97 - (WorkNo mod 97);
        exit(WorkNo = Ctrl);
    end;
}

