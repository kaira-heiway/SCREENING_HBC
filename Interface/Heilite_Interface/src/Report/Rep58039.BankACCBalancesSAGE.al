report 58039 "Bank Acc Balances SAGE"
{
    //BC Upgrade GUNREM01 Old ID-50403
    // version HEI 0.1

    // //HEI.01 IBM SURYAS01 FDD-HT626 10-jan-2020
    //   #Created New Report

    //BC Upgrade GUNREM01 
    // # Replaced Tempblob record to code unit. 
    // # Replaced Dotnet variables with xml variables
    // # Code modified using XML variables and tempblob

    Permissions = TableData "Bank Account Ledger Entry" = rimd;
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord();
            var
                BankAccPostGroups: Record "Bank Account Posting Group";
            begin
                if not BankAccledEntry.FINDSET then begin
                    MESSAGE(Text010);
                    CurrReport.QUIT;
                end;
                //Exported := FALSE;
                Filename := FilePath + '.txt';
                //BC Upgrade GUNREM01 >>
                // FleCIL1.CREATE(Filename);
                // FleCIL1.TEXTMODE := true;
                TempBlob.CreateOutStream(OutStr);
                //BC Upgrade GUNREM01 <<
                if BankAccledEntry.FINDSET then
                    repeat

                        if BankAccledEntry."Amount (LCY)" < 0 then
                            "Debit-Credit" := 'C'
                        else
                            "Debit-Credit" := 'D';

                        BankAccPostGroups.GET(BankAccledEntry."Bank Account No.");

                        FleRecord := FORMAT(BlankChar);
                        PrintBlankSpace(13);
                        FleRecord += "Debit-Credit" + Text004;
                        PrintBlankSpace(8);
                        FleRecord += FORMAT((100 * ABS(BankAccledEntry."Amount (LCY)")), 14, '<Integer>') + Text004;
                        FleRecord += FORMAT(BankAccledEntry.Description, 20) + Text004;
                        FleRecord += FORMAT(BankAccledEntry."External Document No.", 8) + Text004;
                        PrintBlankSpace(33);
                        FleRecord += FORMAT(BankAccledEntry."Transaction Code FND", 2) + Text004;
                        PrintBlankSpace(8);
                        //  FleRecord += FORMAT(BankAccPostGroups."G/L Bank Account No.", 8) + Text004;
                        FleRecord += FORMAT(BankAccPostGroups."G/L Account No.", 8) + Text004; //BC Upgrade GUNREM01 -In BC G/L Bank Account No. replaced with G/L Account No.

                        PrintBlankSpace(14);
                        FleRecord += Company + Text004;
                        PrintBlankSpace(39);
                        FleRecord += FORMAT(BankAccledEntry."Posting Date", 0, '<Year4><Month,2><Day,2>') + Text004;
                        FleRecord += FORMAT(BankAccledEntry."Document Date", 0, '<Year4><Month,2><Day,2>');
                        FleRecord += FORMAT(BankAccledEntry."Entry No.");
                        //BC Upgrade GUNREM01 >>
                        //  FleCIL1.WRITE(FleRecord);
                        OutStr.WriteText(FleRecord);
                        //BC Upgrade GUNREM01 >>
                        LastEntryNO := BankAccledEntry."Entry No.";

                        BankAccledEntry."Exported FND" := true;
                        BankAccledEntry.MODIFY;
                    //Exported := TRUE;
                    until BankAccledEntry.NEXT = 0;
            end;

            trigger OnPostDataItem();
            var
                Base64String: Text;
                IStream: InStream;
                //BC Upgrade GUNREM01 >>
                // XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
                // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
                // Convert: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Convert";
                // MemoryStream: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.MemoryStream";
                XMLRootElement: XmlElement;
                XMLNodeCurr: XmlNode;
                XMLText: Text;
                Tempblob: Codeunit "Temp Blob";
                Base64Convert: Codeunit "Base64 Convert";
                XMLTextNode: Text;
            //BC Upgrade GUNREM01 <<
            begin
                //BC Upgrade GUNREM01 >>
                // XMLDomDoc := XMLDomDoc.XmlDocument;
                // XMLDomDoc.LoadXml('<?xml version="1.0" encoding="UTF-8"?><Document><bankaccountbalances><Payload></Payload></bankaccountbalances></Document>');
                // XMLRootElement := XMLDomDoc.DocumentElement;
                // XMLNodeCurr := XMLDomDoc.SelectSingleNode('/Document/bankaccountbalances/Payload');
                // FleCIL1.CREATEINSTREAM(FileInstream);
                // FileTempBlob.Blob.CREATEOUTSTREAM(FileOutstream);
                // COPYSTREAM(FileOutstream, FileInstream);
                // XMLNodeCurr.InnerText := FileTempBlob.ToBase64String();

                // TempBlob.INIT;
                // TempBlob.Blob.CREATEOUTSTREAM(OutStr);
                // XMLDomDoc.Save(OutStr);
                // //IF Exported = FALSE THEN
                // SageInterfaceMgmt.CreateBankAccountDetails(BankAccledEntry, TempBlob);
                // CLEAR(XMLDomDoc);
                XMLText :=
                    '<?xml version="1.0" encoding="UTF-8"?>' +
                    '<Document>' +
                    '<bankaccountbalances>' +
                    '<Payload></Payload>' +
                    '</bankaccountbalances>' +
                    '</Document>';

                XmlDocument.ReadFrom(XMLText, XMLDomDoc);
                XMLDomDoc.SelectSingleNode('/Document/bankaccountbalances/Payload', XMLNodeCurr);

                TempBlob.CreateInStream(FileInStream);
                TempBlob.CreateOutStream(FileOutStream);
                CopyStream(FileOutStream, FileInStream);

                TempBlob.CreateInStream(FileInStream);
                Base64String := Base64Convert.ToBase64(FileInStream);

                XMLRootElement := XMLNodeCurr.AsXmlElement();
                XMLRootElement.RemoveNodes();
                XMLRootElement.Add(Base64String);

                TempBlob.CreateOutStream(OutStr);
                XMLDomDoc.WriteTo(OutStr);

                SageInterfaceMgmt.CreateBankAccountDetails(BankAccLedEntry, TempBlob);

                Clear(XMLDomDoc);
            end;
            //BC Upgrade GUNREM01 <<

            trigger OnPreDataItem();
            begin

                BankAccledEntry.SETFILTER(BankAccledEntry."Posting Date", DateFilter);     //NAIKH01
                BankAccledEntry.SETFILTER(BankAccledEntry."Entry No.", '>%1', LastSeqNo);
                BankAccledEntry.SETFILTER(BankAccledEntry."Exported FND", FORMAT(false));
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

    trigger OnInitReport();
    begin

        GenLegSetup.GET();
        //GenLegSetup.TESTFIELD("File path");
    end;

    trigger OnPostReport();
    begin
        /*
        FleCIL1.CLOSE;
        InterfaceSetup.RESET;
        InterfaceSetup.SETRANGE("Interface Type",InterfaceSetup."Interface Type"::"SAGE-Treasory");
        InterfaceSetup.SETRANGE("Interface Code",'STR');
        InterfaceSetup.SETRANGE("Object Type",InterfaceSetup."Object Type"::Report);
        InterfaceSetup.SETRANGE("Object ID",55022);
        IF InterfaceSetup.FINDFIRST THEN BEGIN
          InterfaceSetup."Last Seq. No." := LastEntryNO;
          InterfaceSetup.MODIFY();
        END;
        */

        MESSAGE(Text009);

    end;

    trigger OnPreReport();
    var
        FileMgmt: Codeunit "File Management";
    begin
        /*
        IF DateFilter = ''  THEN
          ERROR(Text007);
        //NAIKH01
         */
        //BC Upgrade GUNREM01 >>
        // if EXISTS(Filename) then
        // Initialize TempBlob and OutStream instead of File object
        TempBlob.CreateOutStream(OutStr);
        //BC Upgrade GUNREM01 <<
        //IF CONFIRM(Text003,FALSE,Filename) THEN
        // ERASE(Filename);
        //ELSE
        // CurrReport.QUIT;

        Blank := 32;
        BlankChar := Blank;

    end;

    var
        Interface: Record "Interface table INT";
        InterfaceSetup: Record "Interface Setup INT";
        BankAccledEntry: Record "Bank Account Ledger Entry";
        DateFilter: Text[100];
        LastSeqNo: Integer;
        FleCIL1: File;
        Filename: Text[150];
        "Debit-Credit": Text[1];
        FleRecord: Text[1024];
        BlankChar: Char;
        Text004: Label ':';
        Company: Label 'R1';
        LastEntryNO: Integer;
        Text007: Label 'Please specify Valid Date Filter.';
        Blank: Integer;
        FilePath: Label 'RAPPRO_NAV';
        Text009: TextConst ENU = 'File Exported Succesfully', FRA = 'Fichier créé avec succès';
        GenLegSetup: Record "General Ledger Setup";
        SageInterfaceMgmt: Codeunit "Sage Interface Mgmt.";

        FileInstream: InStream;
        FileOutstream: OutStream;
        // TempBlob: Record TempBlob temporary;
        // FileTempBlob: Record TempBlob temporary;
        // XMLDomDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        TempBlob: Codeunit "Temp Blob";
        FileTempBlob: Codeunit "Temp Blob";
        XMLDomDoc: XmlDocument;
        OutStr: OutStream;
        XMLPortID: Integer;
        Text010: TextConst ENU = 'Nothing to Export', FRA = 'Rien à Exporter';
        Exported: Boolean;

    procedure SetFileName(p_FileName: Text[150]);
    begin
        Filename := p_FileName;
    end;

    procedure PrintBlankSpace(Counter: Integer);
    var
        i: Integer;
    begin
        for i := 1 to Counter do
            FleRecord += FORMAT(BlankChar);
        FleRecord += Text004;
    end;

    procedure SetDateFilter(p_DateFilter: Text[100]);
    begin
        DateFilter := p_DateFilter;
    end;

    procedure SetLastSeqNo(_LastSeqNo: Integer);
    begin
        LastSeqNo := _LastSeqNo;
    end;

    procedure ToBase64String(): Text;
    var
        IStream: InStream;
        // Convert: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Convert";
        // MemoryStream: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.MemoryStream";
        Base64String: Text;

        Base64Convert: Codeunit "Base64 Convert"; //BC Upgrade GUNREM01
    begin
        //BC Upgrade GUNREM01 >>
        // TempBlob.INIT;
        // if not TempBlob.Blob.HASVALUE then
        //     exit('');
        // TempBlob.Blob.CREATEINSTREAM(IStream);
        // MemoryStream := MemoryStream.MemoryStream;
        // COPYSTREAM(MemoryStream, IStream);
        // Base64String := Convert.ToBase64String(MemoryStream.ToArray);
        // MemoryStream.Close;
        // exit(Base64String);

        if not TempBlob.HasValue() then
            exit('');
        TempBlob.CreateInStream(IStream);
        Base64String := Base64Convert.ToBase64(IStream);
        exit(Base64String);
        //BC Upgrade GUNREM01 <<
    end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;
}

