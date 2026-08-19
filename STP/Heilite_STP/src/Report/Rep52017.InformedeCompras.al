report 52017 "Informe de Compras"
{
    // version HEI.01

    // HEI.01 IBM MATHEJ01 17.10.19 - #CHG2030082 MONTHLY REPORTS TAX AUTHORITIES
    //   # New report created by importing the existing report DGI Export PAN (59003) from Helitite 2.0
    //   # Modified function: Vendor Ledger Entry - OnPreDataItem(), Vendor Ledger Entry - OnAfterGetRecord(), Vendor Ledger Entry - OnPostDataItem()

    // BC Upgrade SHUKLP03 >>
    // Modified code of trigger OnPostDataItem().
    // Nav old id - 50380.
    // BC Upgrade SHUKLP03 <<

    ProcessingOnly = true;
    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
    UsageCategory = ReportsAndAnalysis;  // BC Upgrade SHUKLP03 <<

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Vendor No.", "Posting Date";

            trigger OnAfterGetRecord();
            var
                VATEntry: Record "VAT Entry";
                TPT: Integer;
                TPTText: Text[1];
            begin
                VendEntryCnt := 0;
                Amt := 0;

                //HEI.01>>
                // IF "Vendor Ledger Entry"."Vendor Posting Group" = 'PROV LOCAL' THEN
                //  LocalPurch := 1
                // ELSE IF "Vendor Ledger Entry"."Vendor Posting Group" = 'PROV EXT' THEN
                //  LocalPurch := 2
                // ELSE
                // LocalPurch := 0;
                LocalPurch := 1;
                //HEI.01<<

                "Vendor Ledger Entry".CALCFIELDS("Vendor Ledger Entry".Amount);
                Amt := "Vendor Ledger Entry".Amount * -1;


                Window.OPEN(
                  Text005 +
                  '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
                Window.UPDATE(1, 0);
                TotalRecNo := "Vendor Ledger Entry".COUNT;
                RecNo := 0;

                RowNo := RowNo + 1;


                Vend.SETRANGE(Vend."No.", "Vendor Ledger Entry"."Vendor No.");
                if Vend.FINDSET then begin
                    //HEI.01>>
                    // PurchaseCode := Vend."Purchase Concept";
                    // //EnterCell(RowNo,1,FORMAT(Vend."Third Party Type"),FALSE,FALSE,'',ExcelBuf."Cell Type"::Text); SOICAD01 delete
                    // TPT := Vend."Third Party Type";
                    // // Export Type Vendor  HNK-FCE 01-
                    // CASE Vend."Third Party Type" OF
                    //  Vend."Third Party Type" :: Natural:
                    //    TPTText:= 'N';
                    //  Vend."Third Party Type" :: Company:
                    //    TPTText:= 'J';
                    //  Vend."Third Party Type" :: Foreign:
                    //    TPTText:= 'E';
                    // END;
                    PurchaseCode := COPYSTR(Vend."Vendor Category FND", 3);
                    case Vend."Partner Type" of
                        Vend."Partner Type"::Company:
                            TPTText := 'J';
                        Vend."Partner Type"::Person:
                            TPTText := 'N';
                    end;
                    if Vend."Vendor Posting Group" = 'FOREIGN' then
                        TPTText := 'P';
                    //HEI.01<<
                    // HNK-FCE01+
                    // HNK_FCE01-+ EnterCell(RowNo,1,FORMAT(TPT),FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);// SOICAD01 single
                    EnterCell(RowNo, 1, TPTText, false, false, '', ExcelBuf."Cell Type"::Text);// SOICAD01 single
                    EnterCell(RowNo, 2, Vend."VAT Registration No.", false, false, '', ExcelBuf."Cell Type"::Text);
                    //HEI.01>>
                    //EnterCell(RowNo,3,Vend."Check Digit",FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                    EnterCell(RowNo, 3, Vend."Tax Number 2 FND", false, false, '', ExcelBuf."Cell Type"::Text);
                    //HEI.01<<
                    EnterCell(RowNo, 4, Vend.Name, false, false, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(RowNo, 5, "Vendor Ledger Entry"."External Document No.", false, false, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(RowNo, 6, FORMAT("Vendor Ledger Entry"."Posting Date", 8, '<Year4><Month,2><Day,2>'), false, false, '', ExcelBuf."Cell Type"::Text);
                    //HEI.01>>
                    //EnterCell(RowNo,7,'0'+FORMAT(PurchaseCode),FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                    EnterCell(RowNo, 7, FORMAT(PurchaseCode), false, false, '', ExcelBuf."Cell Type"::Text);
                    //HEI.01<<
                    EnterCell(RowNo, 8, FORMAT(LocalPurch), false, false, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(RowNo, 9, FORMAT(Amt), false, false, '', ExcelBuf."Cell Type"::Text);
                end;

                //SOICAD01 begin delete
                //VendEntry.SETRANGE(VendEntry."External Document No.","Vendor Ledger Entry"."External Document No.");
                //VendEntry.SETRANGE(VendEntry."Posting Date","Vendor Ledger Entry"."Posting Date");
                //VendEntry.SETRANGE(VendEntry.Type,VendEntry.Type::Purchase);
                //IF VendEntry.FINDSET THEN BEGIN
                //REPEAT
                //  VendEntryCnt := VendEntryCnt +1;
                //UNTIL VendEntry.NEXT =0;
                //END;
                //amount
                //end delete
                //>> SOICAD01+
                VendEntryCnt := 0;
                VATEntry.SETCURRENTKEY("Document No.", "Posting Date");
                VATEntry.SETRANGE("Document No.", "Vendor Ledger Entry"."Document No.");
                VATEntry.SETRANGE("Posting Date", "Vendor Ledger Entry"."Posting Date");
                VATEntry.SETRANGE("Bill-to/Pay-to No.", "Vendor Ledger Entry"."Vendor No.");
                if VATEntry.FINDSET then
                    repeat
                        VendEntryCnt += VATEntry.Amount;
                    until VATEntry.NEXT = 0;
                //>> SOICAD01-
                EnterCell(RowNo, 10, FORMAT(VendEntryCnt), false, false, '', ExcelBuf."Cell Type"::Text);
            end;

            trigger OnPostDataItem();
            begin
                //HEI.01>>
                //ExcelBuf.CreateBookAndOpenExcel('', 'Data', 'Informe de Compras', COMPANYNAME, USERID);// BC Upgrade SHUKLP03 << Blocked code because only for On-prem
                // BC Upgrade SHUKLP03 >> Modified code as per Saas
                ExcelBuf.CreateNewBook('Data');  //(OutStr, 'EBFMatrix');
                ExcelBuf.WriteSheet('Informe de Compras', CompanyName, UserId);
                ExcelBuf.SetFriendlyFilename('Excel Report');
                ExcelBuf.CloseBook();
                ExcelBuf.OpenExcel();
                // BC Upgrade SHUKLP03 << Modified code as per Saas

                // ExcelBuf.CreateBook('Data');

                //ExcelBuf.CreateRangeName(ExcelBuf.GetExcelReference(8),1,HeaderRowNo + 1);

                //ExcelBuf.WriteSheet(
                //  PADSTR(STRSUBSTNO('%1 %2','Test123','Test'),30),
                //  COMPANYNAME,USERID);
                //
                // ExcelBuf.CloseBook;
                // ExcelBuf.OpenExcel;
                // ExcelBuf.GiveUserControl;
                //HEI.01<<
                MESSAGE('Data Exported Succesfully');
            end;

            trigger OnPreDataItem();
            var
                Window: Dialog;
            begin
                ExcelBuf.DELETEALL;

                HeaderRowNo := 1;
                //HEI.01>>
                //RowNo := 2;
                RowNo := 1;
                //HEI.01<<

                EnterCell(HeaderRowNo, 1, Text001, false, true, '', ExcelBuf."Cell Type"::Text);
                EnterCell(HeaderRowNo, 2, Text002, false, true, '', ExcelBuf."Cell Type"::Text);
                EnterCell(HeaderRowNo, 3, Text003, false, true, '', ExcelBuf."Cell Type"::Text);
                EnterCell(HeaderRowNo, 4, Text004, false, true, '', ExcelBuf."Cell Type"::Text);
                EnterCell(HeaderRowNo, 5, Text005, false, true, '', ExcelBuf."Cell Type"::Text);
                EnterCell(HeaderRowNo, 6, Text006, false, true, '', ExcelBuf."Cell Type"::Text);
                EnterCell(HeaderRowNo, 7, Text007, false, true, '', ExcelBuf."Cell Type"::Text);
                EnterCell(HeaderRowNo, 8, Text008, false, true, '', ExcelBuf."Cell Type"::Text);
                EnterCell(HeaderRowNo, 9, Text009, false, true, '', ExcelBuf."Cell Type"::Text);
                EnterCell(HeaderRowNo, 10, Text010, false, true, '', ExcelBuf."Cell Type"::Text);

                "Vendor Ledger Entry".SETFILTER("Vendor Ledger Entry"."Document Type", '%1|%2', "Vendor Ledger Entry"."Document Type"::Invoice, "Vendor Ledger Entry"."Document Type"::"Credit Memo");//Issue54 - Hortoc01
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

    var
        Vend: Record Vendor;
        ExcelBuf: Record "Excel Buffer" temporary;
        Window: Dialog;
        RecNo: Integer;
        RowNo: Integer;
        ColNo: Integer;
        HeaderRowNo: Integer;
        LocalPurch: Integer;
        Amt: Decimal;
        VendEntry: Record "VAT Entry";
        VendEntryCnt: Decimal;
        PurchaseCode: Code[10];
        TotalRecNo: Integer;
        Text001: TextConst ENU = 'Type of Third Party', ESA = 'Tipo de Persona';
        Text002: TextConst ENU = 'VAT Registration Number', ESA = 'Ruc';
        Text003: TextConst ENU = 'Digit Verification', ESA = 'Digito Verificacion';
        Text004: TextConst ENU = 'Name', ESA = 'Nombre';
        Text005: TextConst ENU = 'Invoice Number', ESA = 'No Factura';
        Text006: TextConst ENU = 'Invoice Registration Date', ESA = 'Fecha registro Factura';
        Text007: TextConst ENU = 'Concept', ESA = 'Concepto';
        Text008: TextConst ENU = 'Local Purchase or Import', ESA = 'Compra local o Importación';
        Text009: TextConst ENU = 'Purchase Amount', ESA = 'Monto Compra';
        Text010: TextConst ENU = 'Value ITBM', ESA = 'Valor ITBM';

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option);
    begin
        ExcelBuf.INIT;
        ExcelBuf.VALIDATE("Row No.", RowNo);
        ExcelBuf.VALIDATE("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Formula := '';
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf."Cell Type" := CellType;
        ExcelBuf.INSERT;
    end;
}

