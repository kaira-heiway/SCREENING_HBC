table 50026 "Issue Cash Collection Head FND"
{
    // version NAVW110.0,DITW110.00.08,HEI.02

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order
    // HEI.02 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Address" and "Address 2" fields length from 50 to 60 characters
    //   # Increased "City" field length from 30 to 35 characters

    // BC Upgrade MISHRS14 >>
    // Added type conversion-AsInteger in procedure PrintRecords for Reminder and Cash Collection.
    // BC Upgrade MISHRS14 <<

    Caption = 'Issued Cash Collection Header';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Issued Cash Collections List";
    LookupPageID = "Issued Cash Collections List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'HEI.01';
            NotBlank = true;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Description = 'HEI.01';
            TableRelation = Customer;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
            Description = 'HEI.01';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            Description = 'HEI.01';
        }
        field(5; Address; Text[60])
        {
            Caption = 'Address';
            Description = 'HEI.02';
        }
        field(6; "Address 2"; Text[60])
        {
            Caption = 'Address 2';
            Description = 'HEI.02';
        }
        field(7; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            Description = 'HEI.01';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8; City; Text[35])
        {
            Caption = 'City';
            Description = 'HEI.02';
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(9; County; Text[30])
        {
            Caption = 'County';
            Description = 'HEI.01';
        }
        field(10; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Description = 'HEI.01';
            TableRelation = "Country/Region";
        }
        field(11; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            Description = 'HEI.01';
            TableRelation = Language;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Description = 'HEI.01';
            TableRelation = Currency;
        }
        field(13; Contact; Text[50])
        {
            Caption = 'Contact';
            Description = 'HEI.01';
        }
        field(14; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
            Description = 'HEI.01';
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'HEI.01';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(1));
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'HEI.01';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(2));
        }
        field(17; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Description = 'HEI.01';
            TableRelation = "Customer Posting Group";
        }
        field(18; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Description = 'HEI.01';
            TableRelation = "Gen. Business Posting Group";
        }
        field(19; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            Description = 'HEI.01';
        }
        field(20; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            Description = 'HEI.01';
            TableRelation = "Reason Code";
        }
        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Description = 'HEI.01';
        }
        field(22; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Description = 'HEI.01';
        }
        field(23; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Description = 'HEI.01';
        }
        field(24; "Cash Collection Terms Code"; Code[10])
        {
            Caption = 'Cash Collection Terms Code';
            Description = 'HEI.01';
        }
        field(25; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            Description = 'HEI.01';
            TableRelation = "Finance Charge Terms";
        }
        field(26; "Interest Posted"; Boolean)
        {
            Caption = 'Interest Posted';
            Description = 'HEI.01';
        }
        field(27; "Additional Fee Posted"; Boolean)
        {
            Caption = 'Additional Fee Posted';
            Description = 'HEI.01';
        }
        field(28; "Cash Collection Level"; Integer)
        {
            Caption = 'Cash Collection Level';
            Description = 'HEI.01';
        }
        field(29; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
            Description = 'HEI.01';
        }
        field(30; Comment; Boolean)
        {
            CalcFormula = Exist("Reminder Comment Line" where(Type = CONST("Issued Reminder"),
                                                               "No." = FIELD("No.")));
            Caption = 'Comment';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Remaining Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Issue Cash Collection Line FND"."Remaining Amount" where("Cash Collection No." = FIELD("No."),
                                                                                      "Line Type" = CONST("Cash Collection Line")));
            Caption = 'Remaining Amount';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Interest Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Issued Reminder Line".Amount where("Reminder No." = FIELD("No."),
                                                                   Type = CONST("Customer Ledger Entry"),
                                                                   "Line Type" = CONST("Reminder Line")));
            Caption = 'Interest Amount';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Additional Fee"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Issued Reminder Line".Amount where("Reminder No." = FIELD("No."),
                                                                   Type = CONST("G/L Account")));
            Caption = 'Additional Fee';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Issued Reminder Line"."VAT Amount" where("Reminder No." = FIELD("No.")));
            Caption = 'VAT Amount';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Description = 'HEI.01';
        }
        field(36; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'HEI.01';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup();
            var
                //UserMgt: Codeunit "User Management"; //BC Upgrade Manisha
                UserSelection: Codeunit "User Selection"; //BC Upgrade Manisha
            begin
                //HEI.01>>
                // UserMgt.LookupUserID("User ID"); //BC Upgrade Manisha
                UserSelection.ValidateUserName("User ID"); //BC Upgrade Manisha
                //HEI.01<<
            end;
        }
        field(37; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(38; "Pre-Assigned No. Series"; Code[10])
        {
            Caption = 'Pre-Assigned No. Series';
            Description = 'HEI.01';
            TableRelation = "No. Series";
        }
        field(39; "Pre-Assigned No."; Code[20])
        {
            Caption = 'Pre-Assigned No.';
            Description = 'HEI.01';
        }
        field(40; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Description = 'HEI.01';
            TableRelation = "Source Code";
        }
        field(41; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            Description = 'HEI.01';
            TableRelation = "Tax Area";
        }
        field(42; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            Description = 'HEI.01';
        }
        field(43; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            Description = 'HEI.01';
            TableRelation = "VAT Business Posting Group";
        }
        field(44; "Add. Fee per Line"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            CalcFormula = Sum("Issued Reminder Line".Amount where("Reminder No." = FIELD("No."),
                                                                   Type = CONST("Line Fee")));
            Caption = 'Add. Fee per Line';
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup();
            begin
                ShowDimensions();
            end;
        }
        field(50000; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            Description = 'HEI.01';
            /* //BC UPGRADE Manisha Code commented due to table relation with drink it table
            TableRelation = IF ("Responsibility Center" = CONST('')) "Shipping Agent" where("Responsibility Center" = FIELD("Resp. Center Table Filter"))
            else IF ("Responsibility Center" = FILTER(<> '')) "Shipping Agent" where("Responsibility Center" = FIELD("Resp. Center Table Filter 2"));

            trigger OnValidate();
            begin
                //HEI.01>>
                //TestRouteTypeVariable(FIELDNO("Shipping Agent Code"));
                //BC Upgrade Manisha comment due to drink it function.

                if (xRec."Shipping Agent Code" <> Rec."Shipping Agent Code") and ("Shipping Agent Code" <> '') and
                  ("Responsibility Center" <> '') then
                    UserSetupMgt.CheckShipmentAgent("Responsibility Center", "Shipping Agent Code");

                if xRec."Shipping Agent Code" = "Shipping Agent Code" then
                    exit;
                //HEI.01<<
            end;
            */
            //BC UPGRADE Manisha Code commented due to table relation with drink it table
        }
        //BC UPGRADE KUMARR78 >>
        field(50001; "Truck Code"; Code[10])
        {
            Caption = 'Truck Code';
            Description = 'HEI.01';
            TableRelation = IF ("Responsibility Center" = CONST('')) Vehicle101FDW.Code where(Type = FILTER(<> Trailer))
            else IF ("Responsibility Center" = FILTER(<> '')) Vehicle101FDW.Code where(Type = FILTER(<> Trailer));
        }
        field(50002; "Driver Code"; Code[10])
        {
            Caption = 'Driver Code';
            Description = 'HEI.01';
            TableRelation = Driver107FDW;
        }
        //BC UPGRADE KUMARR78 <<
        /* //BCUPGRADE Manisha Code commented due to table relation with drink it table
        field(50001; "Truck Code"; Code[10])
        {
            Caption = 'Truck Code';
            Description = 'HEI.01';
            TableRelation = IF ("Responsibility Center" = CONST('')) "Whse. Shipping Truck".Code where("Responsibility Center" = FIELD("Resp. Center Table Filter"),
                                                                                                      "Transport Unit Type" = FILTER(<> Trailer))
            else IF ("Responsibility Center" = FILTER(<> '')) "Whse. Shipping Truck".Code where("Responsibility Center" = FIELD("Resp. Center Table Filter 2"),
                                                                                                                                                                                        "Transport Unit Type" = FILTER(<> Trailer));
        }
        
        field(50002; "Driver Code"; Code[10])
        {
            Caption = 'Driver Code';
            Description = 'HEI.01';
            TableRelation = IF ("Responsibility Center" = CONST('')) "Whse. Shipping Driver".Code where("Responsibility Center" = FIELD("Resp. Center Table Filter"))
            else IF ("Responsibility Center" = FILTER(<> '')) "Whse. Shipping Driver".Code where("Responsibility Center" = FIELD("Resp. Center Table Filter 2"));
        }
        */ //BCUPGRADE Manisha COde commented due to table relation with drink it table
        field(50003; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'HEI.01';
            TableRelation = "Responsibility Center" where(Code = FIELD("Resp. Center Table Filter"));

            trigger OnValidate();
            var
                LocationCode: Code[10];
                PhysicalLocationCode: Code[10];
            begin
            end;
        }
        field(50004; "Resp. Center Table Filter"; Code[10])
        {
            Caption = 'Resp. Center Table Filter';
            Description = 'HEI.01';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
        }
        field(50005; "Resp. Center Table Filter 2"; Code[10])
        {
            Caption = 'Resp. Center Table Filter';
            Description = 'HEI.01';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
        }
        /*  //BCUPGRADE Manisha COde commented due to table relation with drink it table
        field(50006; Route; Code[20])
        {
            Caption = 'Route';
            Description = 'HEI.01';
            TableRelation = Route where("Responsibility Center" = FIELD("Resp. Center Table Filter"));

            trigger OnValidate();
            var
                lrRoute: Record Route;
                lrxRoute: Record Route;
            begin
            end;
        }*/ //BCUPGRADE Manisha COde commented due to table relation with drink it table
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Customer No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Customer No.", Name, "Posting Date")
        {
        }
    }

    trigger OnDelete();
    begin
        //HEI.01>>
        LOCKTABLE();
        CashCollectionIssue.DeleteIssuedReminderLines(Rec);

        CashCollectionCommentLine.SETRANGE(Type, CashCollectionCommentLine.Type::"Issued Cash Collection");
        CashCollectionCommentLine.SETRANGE("No.", "No.");
        CashCollectionCommentLine.DELETEALL();
        //HEI.01<<
    end;

    var
        CashCollectionCommentLine: Record "Cash Collection Cmt Line FND";
        RespCenter: Record "Responsibility Center";
        CashCollectionIssue: Codeunit "Cash Collection-Issue";
        DimMgt: Codeunit DimensionManagement;
        UserSetupMgt: Codeunit "User Setup Management";
        ReminderTxt: Label 'Issued Reminder';
        SuppresSendDialogQst: Label 'Do you want to suppress send dialog?';

    procedure PrintRecords(ShowRequestForm: Boolean; SendAsEmail: Boolean; HideDialog: Boolean);
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND";
        IssuedCashCollectionHeaderToSend: Record "Issue Cash Collection Head FND";
        DummyReportSelections: Record "Report Selections";
    begin
        //HEI.01>>
        IssuedCashCollectionHeader.COPY(Rec);
        if (not HideDialog) and (IssuedCashCollectionHeader.COUNT > 1) then
            if CONFIRM(SuppresSendDialogQst) then
                HideDialog := true;
        if IssuedCashCollectionHeader.findset() then
            repeat
                IssuedCashCollectionHeaderToSend.COPY(IssuedCashCollectionHeader);
                IssuedCashCollectionHeaderToSend.SETRECFILTER();
                if SendAsEmail then
                    DocumentSendingProfile.TrySendToEMail(
                      DummyReportSelections.Usage::Reminder.AsInteger(), IssuedCashCollectionHeaderToSend, // BC Upgrade MISHRS14 >> - added type conversion - AsInteger in Reminder.
                      IssuedCashCollectionHeaderToSend.FIELDNO("No."), ReminderTxt, IssuedCashCollectionHeaderToSend.FIELDNO("Customer No."), not HideDialog)
                else
                    DocumentSendingProfile.TrySendToPrinter(
                      DummyReportSelections.Usage::"Cash.Collection".AsInteger(), IssuedCashCollectionHeaderToSend, // BC Upgrade MISHRS14 >> - added type conversion - AsInteger in Cash Collection.
                      IssuedCashCollectionHeaderToSend.FieldNo("Customer No."), ShowRequestForm);
            until IssuedCashCollectionHeader.NEXT() = 0;
        //HEI.01<<
    end;
    //BC UPGRADE KUMARR78 ++01-07-2026
    procedure NewPrintRecords(ShowRequestForm: Boolean; SendAsEmail: Boolean; HideDialog: Boolean)
    var
        IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND";
    begin
        IssuedCashCollectionHeader.Copy(Rec);

        if (not HideDialog) and (IssuedCashCollectionHeader.Count > 1) then
            if Confirm(SuppresSendDialogQst) then
                HideDialog := true;

        if IssuedCashCollectionHeader.FindSet() then
            repeat
                if SendAsEmail then
                    SendIssuedCashCollectionByEmail(IssuedCashCollectionHeader)
                else
                    PrintIssuedCashCollection(IssuedCashCollectionHeader, ShowRequestForm);
            until IssuedCashCollectionHeader.Next() = 0;
    end;

    local procedure SendIssuedCashCollectionByEmail(var IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND")
    var
        ReportSelections: Record "Report Selections";
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        OutStr: OutStream;
        InStr: InStream;
        Customer: Record Customer;
    begin
        ReportSelections.SetRange(Usage, ReportSelections.Usage::"WHT Certificate");

        if not ReportSelections.FindFirst() then
            Error('No report is configured for Cash Collection.');

        if not Customer.Get(IssuedCashCollectionHeader."Customer No.") then
            Error('Customer not found.');

        if Customer."E-Mail" = '' then
            Error('Customer email is blank.');

        TempBlob.CreateOutStream(OutStr);

        Report.SaveAs(
            ReportSelections."Report ID",
            '',
            ReportFormat::Pdf,
            OutStr,
            IssuedCashCollectionHeader);

        TempBlob.CreateInStream(InStr);

        EmailMessage.Create(
            Customer."E-Mail",
            'Issued Cash Collection',
            'Please find the attached Issued Cash Collection.',
            true);

        EmailMessage.AddAttachment(
            'IssuedCashCollection.pdf',
            'application/pdf',
            InStr);

        Email.Send(EmailMessage);
    end;

    local procedure PrintIssuedCashCollection(var IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND"; ShowRequestForm: Boolean)
    var
        ReportSelections: Record "Report Selections";
    begin
        ReportSelections.SetRange(Usage, ReportSelections.Usage::"WHT Certificate");

        if not ReportSelections.FindFirst() then
            Error('No report is configured for Cash Collection in Report Selections.');

        Report.Run(
            ReportSelections."Report ID",
            ShowRequestForm,
            false,
            IssuedCashCollectionHeader);
    end;
    //BC UPGRADE KUMARR78 ++01-07-2026

    procedure Navigate();
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "No.");
        NavigateForm.RUN();
    end;

    procedure IncrNoPrinted();
    begin
        //HEI.01>>
        CashCollectionIssue.IncrNoPrinted(Rec);
        //HEI.01<<
    end;

    procedure ShowDimensions();
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "No."));
    end;

    procedure CalculateLineFeeVATAmount(): Decimal;
    var
        IssuedCashCollectionLine: Record "Issue Cash Collection Line FND";
    begin
        //HEI.01>>
        IssuedCashCollectionLine.SETCURRENTKEY("Cash Collection No.", Type, "Line Type");
        IssuedCashCollectionLine.SETRANGE("Cash Collection No.", "No.");
        IssuedCashCollectionLine.SETRANGE(Type, IssuedCashCollectionLine.Type::" ");
        IssuedCashCollectionLine.CALCSUMS("VAT Amount");
        exit(IssuedCashCollectionLine."VAT Amount");
        //HEI.01<<
    end;
    /* //BCUPGRADE Manisha COde commented due to table relation with drink it table
    local procedure TestRouteTypeVariable(CalledbyFieldNo: Integer);
    var
        LRoute: Record Route;
    begin
        //HEI.01>>
        if (CalledbyFieldNo <> CurrFieldNo) and (CurrFieldNo <> 0) then
            exit;
        if (Route = '') then
            exit;

        LRoute.GET(Route);
        LRoute.TESTFIELD("Route Type", LRoute."Route Type"::Variable);
        //HEI.01<<
    end;
*/ //BCUPGRADE Manisha COde commented due to table relation with drink it table
    local procedure GetShippingTime(CalledByFieldNo: Integer);
    var
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
        if (CalledByFieldNo <> CurrFieldNo) and (CurrFieldNo <> 0) then
            exit;
    end;
}

