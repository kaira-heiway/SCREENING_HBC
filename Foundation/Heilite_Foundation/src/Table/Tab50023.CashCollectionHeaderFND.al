table 50023 "Cash Collection Header FND"
{
    // version HEI.02

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order
    // HEI.02 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Address" and "Address 2" fields length from 50 to 60 characters
    //   # Increased "City" field length from 30 to 35 characters

    //BC UPGRADE KUMARR78 >>
    // Changing for (FDD OTC 091)
    //Adding Table Relation for Vehical and Driver Code. 
    //Changing OptionMembers and Correcting Name.
    //BC UPGARDE KUMARR78 <<
    Caption = 'Cash Collection Header';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Cash Collections List";
    LookupPageID = "Cash Collections List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                if "No." <> xRec."No." then begin
                    SalesSetup.GET();
                    NoSeriesMgt.TestManual(SalesSetup."Reminder Nos.");
                    "No. Series" := '';
                end;
                "Posting Description" := STRSUBSTNO(Text000, "No.");
                //HEI.01<<
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Description = 'HEI.01';
            TableRelation = Customer;

            trigger OnValidate();
            begin
                //HEI.01>>
                if CurrFieldNo = FIELDNO("Customer No.") then
                    if Undo() then begin
                        "Customer No." := xRec."Customer No.";
                        CreateDim(DATABASE::Customer, "Customer No.");
                        exit;
                    end;
                if "Customer No." = '' then begin
                    CreateDim(DATABASE::Customer, "Customer No.");
                    exit;
                end;
                Cust.GET("Customer No.");
                if Cust.Blocked = Cust.Blocked::All then
                    Cust.CustBlockedErrorMessage(Cust, false);
                Name := Cust.Name;
                "Name 2" := Cust."Name 2";
                Address := Cust.Address;
                "Address 2" := Cust."Address 2";
                "Post Code" := Cust."Post Code";
                City := Cust.City;
                County := Cust.County;
                Contact := Cust.Contact;
                "Country/Region Code" := Cust."Country/Region Code";
                "Language Code" := Cust."Language Code";
                "Currency Code" := Cust."Currency Code";
                "Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                "Shortcut Dimension 2 Code" := Cust."Global Dimension 2 Code";
                "VAT Registration No." := Cust."VAT Registration No.";
                Cust.TESTFIELD("Customer Posting Group");
                "Customer Posting Group" := Cust."Customer Posting Group";
                "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                "Tax Area Code" := Cust."Tax Area Code";
                "Tax Liable" := Cust."Tax Liable";
                "Cash Collection Terms Code" := Cust."Reminder Terms Code";
                "Fin. Charge Terms Code" := Cust."Fin. Charge Terms Code";
                VALIDATE("Cash Collection Terms Code");

                CreateDim(DATABASE::Customer, "Customer No.");
                //HEI.01<<
            end;
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
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            else IF ("Country/Region Code" = FILTER(<> '')) "Post Code" where("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                //HEI.01>>
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED);
                //HEI.01<<
            end;
        }
        field(8; City; Text[35])
        {
            Caption = 'City';
            Description = 'HEI.02';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            else IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City where("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                //HEI.01>>
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED);
                //HEI.01<<
            end;
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

            trigger OnValidate();
            begin
                //HEI.01>>
                if CurrFieldNo = FIELDNO("Currency Code") then
                    if Undo() then begin
                        "Currency Code" := xRec."Currency Code";
                        exit;
                    end;
                //HEI.01<<
            end;
        }
        field(13; Contact; Text[50])
        {
            Caption = 'Contact';
            Description = 'HEI.01';
        }
        field(14; "Your Reference"; Text[30])
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

            trigger OnValidate();
            begin
                //HEI.01>>
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                //HEI.01<<
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'HEI.01';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                //HEI.01>>
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                //HEI.01<<
            end;
        }
        field(17; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Customer Posting Group";
        }
        field(18; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate();
            begin
                //HEI.01>>
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        VALIDATE("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
                //HEI.01<<
            end;
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

            trigger OnValidate();
            begin
                //HEI.01>>
                if CurrFieldNo = FIELDNO("Document Date") then
                    if Undo() then begin
                        "Document Date" := xRec."Document Date";
                        exit;
                    end;
                VALIDATE("Cash Collection Level");
                //HEI.01<<
            end;
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

            trigger OnValidate();
            begin
                //HEI.01>>
                /*IF CurrFieldNo = FIELDNO("Cash Collection Terms Code") THEN
                  IF Undo THEN BEGIN
                    "Cash Collection Terms Code" := xRec."Cash Collection Terms Code";
                    EXIT;
                  end;
                IF "Cash Collection Terms Code" <> '' THEN BEGIN
                  CashCollectionTerms.GET("Cash Collection Terms Code");
                  "Post Interest" := CashCollectionTerms."Post Interest";
                  "Post Additional Fee" := CashCollectionTerms."Post Additional Fee";
                  "Post Add. Fee per Line" := CashCollectionTerms."Post Add. Fee per Line";
                  VALIDATE("Cash Collection Level");
                  VALIDATE("Post Interest");
                end;*/
                //HEI.01<<

            end;
        }
        field(25; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            Description = 'HEI.01';
            TableRelation = "Finance Charge Terms";

            trigger OnValidate();
            begin
                //HEI.01>>
                if CurrFieldNo = FIELDNO("Fin. Charge Terms Code") then
                    if Undo() then begin
                        "Fin. Charge Terms Code" := xRec."Fin. Charge Terms Code";
                        exit;
                    end;
                //HEI.01<<
            end;
        }
        field(26; "Post Interest"; Boolean)
        {
            Caption = 'Post Interest';
            Description = 'HEI.01';
        }
        field(27; "Post Additional Fee"; Boolean)
        {
            Caption = 'Post Additional Fee';
            Description = 'HEI.01';
        }
        field(28; "Cash Collection Level"; Integer)
        {
            Caption = 'Cash Collection Level';
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                /*IF ("Cash Collection Level" <> 0) AND ("Cash Collection Terms Code" <> '') THEN BEGIN
                  CashCollectionTerms.GET("Cash Collection Terms Code");
                  CashCollectionLevel.SETRANGE("Cash Collection Terms Code","Cash Collection Terms Code");
                  CashCollectionLevel.SETRANGE("No.",1,"Cash Collection Level");
                  IF CashCollectionLevel.FINDLAST AND ("Document Date" <> 0D) THEN
                    "Due Date" := CALCDATE(CashCollectionLevel."Due Date Calculation","Document Date");
                end;*/
                //HEI.01<<

            end;
        }
        field(29; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
            Description = 'HEI.01';
        }
        field(30; Comment; Boolean)
        {
            CalcFormula = Exist("Cash Collection Cmt Line FND" where(Type = CONST("Cash Collection"),
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
            CalcFormula = Sum("Cash Collection Line FND"."Remaining Amount" where("Cash Collection No." = FIELD("No."),
                                                                               "Line Type" = FILTER(<> "Not Due")));
            Caption = 'Remaining Amount';
            DecimalPlaces = 2 : 2;
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Interest Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Cash Collection Line FND".Amount where("Cash Collection No." = FIELD("No."),
                                                                   Type = CONST("Customer Ledger Entry"),
                                                                   "Line Type" = FILTER(<> "Not Due")));
            Caption = 'Interest Amount';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Additional Fee"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Cash Collection Line FND".Amount where("Cash Collection No." = FIELD("No."),
                                                                   Type = CONST("Customer Ledger Entry"),
                                                                   "Line Type" = FILTER(<> "Not Due")));
            Caption = 'Additional Fee';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Cash Collection Line FND"."VAT Amount" where("Cash Collection No." = FIELD("No."),
                                                                         "Line Type" = FILTER(<> "Not Due")));
            Caption = 'VAT Amount';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(38; "Issuing No. Series"; Code[10])
        {
            Caption = 'Issuing No. Series';
            Description = 'HEI.01';
            TableRelation = "No. Series";

            trigger OnLookup();
            begin
                //HEI.01>>
                //with CashCollectionHeader do begin  //Commented KUMBHS03_26022026
                CashCollectionHeader := Rec;
                SalesSetup.GET();
                SalesSetup.TESTFIELD("Reminder Nos.");
                SalesSetup.TESTFIELD("Issued Reminder Nos.");
                //if NoSeriesMgt.LookupSeries(SalesSetup."Issued Reminder Nos.", "Issuing No. Series") then  // BC Upgrade NANDIS03 - Blocked
                if NoSeriesMgt.LookupRelatedNoSeries(SalesSetup."Issued Reminder Nos.", CashCollectionHeader."Issuing No. Series") then  // BC Upgrade NANDIS03 - Added  //Added CashCollectionHeader var KUMBHS03_26022026
                    CashCollectionHeader.VALIDATE("Issuing No. Series");   //Added CashCollectionHeader var KUMBHS03_26022026
                Rec := CashCollectionHeader;
            end;
            //HEI.01<<
            //end;  //Commented KUMBHS03_26022026

            trigger OnValidate();
            begin
                //HEI.01>>
                if "Issuing No. Series" <> '' then begin
                    SalesSetup.GET();
                    SalesSetup.TESTFIELD("Reminder Nos.");
                    SalesSetup.TESTFIELD("Issued Reminder Nos.");
                    //NoSeriesMgt.TestSeries(SalesSetup."Issued Reminder Nos.", "Issuing No. Series");  // BC Upgrade NANDIS03 - Blocked
                    NoSeriesMgt.TestAreRelated(SalesSetup."Issued Reminder Nos.", "Issuing No. Series");  // BC Upgrade NANDIS03 - Added
                end;
                TESTFIELD("Issuing No.", '');
                //HEI.01<<
            end;
        }
        field(39; "Issuing No."; Code[20])
        {
            Caption = 'Issuing No.';
            Description = 'HEI.01';
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
        field(44; "Use Header Level"; Boolean)
        {
            Caption = 'Use Header Level';
            Description = 'HEI.01';
        }
        field(45; "Add. Fee per Line"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            CalcFormula = Sum("Cash Collection Line FND".Amount where("Cash Collection No." = FIELD("No."),
                                                                   Type = CONST("Customer Ledger Entry"),
                                                                   "Line Type" = FILTER(<> "Not Due")));
            Caption = 'Add. Fee per Line';
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(46; "Post Add. Fee per Line"; Boolean)
        {
            Caption = 'Post Add. Fee per Line';
            Description = 'HEI.01';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup();
            begin
                ShowDocDim();
            end;
        }
        field(9000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            Description = 'HEI.01';
            TableRelation = "User Setup";
        }
        field(50000; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            Description = 'HEI.01';
            /* //BC Upgrade  Manisha Drink it code comment
            TableRelation = IF ("Responsibility Center" = CONST('')) "Shipping Agent" where("Responsibility Center" = FIELD("Resp. Center Table Filter"))
            else IF ("Responsibility Center" = FILTER(<> '')) "Shipping Agent" where("Responsibility Center" = FIELD("Resp. Center Table Filter 2"));

            trigger OnValidate();
            begin
                //HEI.01>>
                TestRouteTypeVariable(FIELDNO("Shipping Agent Code"));
                if (xRec."Shipping Agent Code" <> Rec."Shipping Agent Code") and ("Shipping Agent Code" <> '') and
                  ("Responsibility Center" <> '') then
                    UserSetupMgt.CheckShipmentAgent("Responsibility Center", "Shipping Agent Code");

                if xRec."Shipping Agent Code" = "Shipping Agent Code" then
                    exit;
                GetShippingTime(FIELDNO("Shipping Agent Code"));
                //HEI.01<<
            end;
            */
            //BC Upgrade  Manisha Drink it code comment
            //BC UPGRADE KUMARR78 >> Rwriting Blocked Condition Alternative
            TableRelation = "Shipping Agent";
            trigger OnValidate()
            begin
                TestRouteTypeVariable(FIELDNO("Shipping Agent Code"));
                //BC UPGRADE KUMARR78 >> Blocking as No Responsibility field is in New Driver Table
                // iif (xRec."Shipping Agent Code" <> Rec."Shipping Agent Code") and ("Shipping Agent Code" <> '') and
                // ("Responsibility Center" <> '') then
                //     UserSetupMgt.CheckShipmentAgent("Responsibility Center", "Shipping Agent Code");
                //BC UPGRADE KUMARR78 << Blocking as No Responsibility field is in New Driver Table
                if xRec."Shipping Agent Code" = "Shipping Agent Code" then
                    exit;
                GetShippingTime(FIELDNO("Shipping Agent Code"));
            end;
            //BC UPGRADE KUMARR78 << Rwriting Blocked Condition Alternative

        }
        field(50001; "Truck Code"; Code[10])
        {
            Caption = 'Truck Code';
            Description = 'HEI.01';
            //BC Upgrade Manisha code block for table'Whse. Shipping Truck' drink it table code blocked
            /*
            TableRelation = IF ("Responsibility Center" = CONST('')) "Whse. Shipping Truck".Code where("Responsibility Center" = FIELD("Resp. Center Table Filter"),
            "Transport Unit Type" = FILTER(<> Trailer))
            else IF ("Responsibility Center" = FILTER(<> '')) "Whse. Shipping Truck".Code where("Responsibility Center" = FIELD("Resp. Center Table Filter 2"),
            "Transport Unit Type" = FILTER(<> Trailer));

            trigger OnValidate();
            begin
                //HEI.01>>
                TESTFIELD("Truck Code");
                TestRouteTypeVariable(FIELDNO("Truck Code"));
                if (xRec."Truck Code" <> Rec."Truck Code") and ("Truck Code" <> '') and
                  ("Responsibility Center" <> '') then
                    UserSetupMgt.CheckTruck("Responsibility Center", "Truck Code");
                //HEI.01<<
            end;
            */
            //BC Upgrade Manisha code block for table'Whse. Shipping Truck' drink it table code blocked
            //BC UPGRADE KUMARR78 >> Rewriting Blocked Condition
            TableRelation = IF ("Responsibility Center" = CONST('')) Vehicle101FDW.Code where(Type = FILTER(<> Trailer))
            else IF ("Responsibility Center" = FILTER(<> '')) Vehicle101FDW.Code where(Type = FILTER(<> Trailer));
            trigger OnValidate();
            begin
                TESTFIELD("Truck Code");
                TestRouteTypeVariable(FIELDNO("Truck Code"));
                //BC UPGRADE KUMARR78 >> Blocking as No Responsibility field is in New Driver Table
                // if (xRec."Truck Code" <> Rec."Truck Code") and ("Truck Code" <> '') and
                //  ("Responsibility Center" <> '') then
                //     UserSetupMgt.CheckTruck("Responsibility Center", "Truck Code");
                //BC UPGRADE KUMARR78 << Blocking as No Responsibility field is in New Truck Table
            end;
            //BC UPGRADE KUMARR78 << Rewriting Blocked Condition


        }
        field(50002; "Driver Code"; Code[10])
        {
            Caption = 'Driver Code';
            Description = 'HEI.01';
            // BCUPGRADE Manisha 'Whse. Shipping Driver' Drink it table 'whse Shipping drive'r code commented
            /*
            TableRelation = IF ("Responsibility Center" = CONST('')) "Whse. Shipping Driver".Code where("Responsibility Center" = FIELD("Resp. Center Table Filter"))
             else IF ("Responsibility Center" = FILTER(<> '')) "Whse. Shipping Driver".Code where("Responsibility Center" = FIELD("Resp. Center Table Filter 2"));
                       trigger OnValidate();
            begin
                //HEI.01>>
                TestRouteTypeVariable(FIELDNO("Driver Code"));
                //HEI.01>>
                if (xRec."Driver Code" <> Rec."Driver Code") and ("Driver Code" <> '') and
                  ("Responsibility Center" <> '') then
                    UserSetupMgt.CheckDriver("Responsibility Center", "Driver Code");
                //HEI.01<<
            end;
            */
            // BCUPGRADE Manisha 'Whse. Shipping Driver' Drink it table 'whse Shipping drive'r code commented
            //BC UPGRADE KUMARR78 >> Rewriting Blocked Condition
            TableRelation = Driver107FDW;
            trigger OnValidate()
            begin
                TestRouteTypeVariable(FIELDNO("Driver Code"));
                //BC UPGRADE KUMARR78 >> Blocking as No Responsibility field is in New Driver Table
                // if (xRec."Driver Code" <> Rec."Driver Code") and ("Driver Code" <> '') and
                //  ("Responsibility Center" <> '') then
                //     UserSetupMgt.CheckDriver("Responsibility Center", "Driver Code");
                //BC UPGRADE KUMARR78 << Blocking as No Responsibility field is in New Driver Table
            end;
            //BC UPGRADE KUMARR78 << Rewriting Blocked Condition
        }
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
                //HEI.01>>
                if not UserSetupMgt.CheckRespCenter(0, "Responsibility Center") then
                    ERROR(
                      Text027,
                      RespCenter.TABLECAPTION, UserSetupMgt.GetSalesFilter());
                //HEI.01<<
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
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Customer No.", "Currency Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Customer No.", Name, "Due Date")
        {
        }
    }

    trigger OnDelete();
    begin
        //HEI.01>>
        CashCollectionIssue.DeleteHeader(Rec, IssuedCashCollectionHeader);
        CashCollectionLine.SETRANGE("Cash Collection No.", "No.");
        CashCollectionLine.DELETEALL();

        CashCollectionCommentLine.SETRANGE(Type, CashCollectionCommentLine.Type::"Cash Collection");
        CashCollectionCommentLine.SETRANGE("No.", "No.");
        CashCollectionCommentLine.DELETEALL();

        if IssuedCashCollectionHeader."No." <> '' then begin
            COMMIT();
            if CONFIRM(
                 Text001, true,
                 IssuedCashCollectionHeader."No.")
            then begin
                IssuedCashCollectionHeader.SETRECFILTER();
                // IssuedCashCollectionHeader.PrintRecords(true, false, false)//BC UPGRADE KUMARR78 --01-07-2026
                IssuedCashCollectionHeader.NewPrintRecords(true, false, false);//BC UPGRADE KUMARR78 ++01-07-2026

            end;
        end;
        //HEI.01<<
    end;

    trigger OnInsert();
    begin
        //HEI.01>>
        SalesSetup.GET();
        if "No." = '' then begin
            SalesSetup.TESTFIELD("Reminder Nos.");
            SalesSetup.TESTFIELD("Issued Reminder Nos.");
            // NoSeriesMgt.InitSeries(SalesSetup."Reminder Nos.", xRec."No. Series", "Posting Date","No.", "No. Series");  // BC Upgrade NANDIS03 - Blocked
            // if NoSeriesMgt.AreRelated(SalesSetup."Reminder Nos.", xRec."No. Series") then   // BC Upgrade NANDIS03 - Added // BC UPGRADE KUMARR78 - Blocking

            // BC UPGRADE KUMARR78 >> Adding
            "No." := NoSeriesMgt.GetNextNo(SalesSetup."Reminder Nos.");
            "Issuing No. Series" := SalesSetup."Issued Reminder Nos.";
            "No. Series" := SalesSetup."Reminder Nos.";
            // BC UPGRADE KUMARR78 << Adding

            // "No. Series" := xRec."No. Series";  // BC Upgrade NANDIS03 - Added // BC UPGRADE KUMARR78 - Blocking
        end;
        "Posting Description" := STRSUBSTNO(Text000, "No.");
        if ("No. Series" <> '') and (SalesSetup."Reminder Nos." = SalesSetup."Issued Reminder Nos.") then
            "Issuing No. Series" := "No. Series"
        else begin  //// BC Upgrade NANDIS03 - Added begin end
            //NoSeriesMgt.SetDefaultSeries("Issuing No. Series", SalesSetup."Issued Reminder Nos.");  // BC Upgrade NANDIS03 - Blocked
            if "Issuing No. Series" = '' then  // BC Upgrade NANDIS03 - Added
                "Issuing No. Series" := SalesSetup."Issued Reminder Nos.";  // BC Upgrade NANDIS03 - Added
        end;
        if "Posting Date" = 0D then
            "Posting Date" := WORKDATE();
        "Document Date" := WORKDATE();
        "Due Date" := WORKDATE();
        if GETFILTER("Customer No.") <> '' then
            if GETRANGEMIN("Customer No.") = GETRANGEMAX("Customer No.") then
                VALIDATE("Customer No.", GETRANGEMIN("Customer No."));
        //HEI.01<<
    end;

    var
        CashCollectionCommentLine: Record "Cash Collection Cmt Line FND";
        CashCollectionHeader: Record "Cash Collection Header FND";
        CashCollectionLine: Record "Cash Collection Line FND";
        Currency: Record Currency;
        Cust: Record Customer;
        CustPostingGr: Record "Customer Posting Group";
        FinChrgTerms: Record "Finance Charge Terms";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND";
        PostCode: Record "Post Code";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        CashCollectionIssue: Codeunit "Cash Collection-Issue";
        DimMgt: Codeunit DimensionManagement;
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDISS03 - Blocked as this CU is obsolete
        NoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDISS03 - new CU used 
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ApplicationManagement: Codeunit "UI Helper Triggers";
        UserSetupMgt: Codeunit "User Setup Management";
        StatusCheckSuspended: Boolean;
        TestOpenStatus: Boolean;
        ReminderTotal: Decimal;
        LineSpacing: Integer;
        NextLineNo: Integer;
        Text000: Label 'Reminder %1';
        Text001: Label 'Do you want to print reminder %1?';
        Text002: Label 'This change will cause the existing lines to be deleted for this reminder.\\';
        Text003: Label 'Do you want to continue?';
        Text004: Label 'There is not enough space to insert the text.';
        Text005: Label '"Deleting this document will cause a gap in the number series for reminders. "';
        Text006: Label 'An empty reminder %1 will be created to fill this gap in the number series.\\';
        Text027: Label 'Your identification is set up to process from %1 %2 only.';

    procedure AssistEdit(OldCashCollectionHeader: Record "Cash Collection Header FND"): Boolean;
    begin
        //HEI.01>>
        //with CashCollectionHeader do begin  //Commented KUMBHS03_26022026
        CashCollectionHeader := Rec;
        SalesSetup.GET();
        SalesSetup.TESTFIELD("Reminder Nos.");
        SalesSetup.TESTFIELD("Issued Reminder Nos.");
        //if NoSeriesMgt.SelectSeries(SalesSetup."Reminder Nos.", OldCashCollectionHeader."No. Series", "No. Series") then begin  // BC Upgrade NANDIS03 - Blocked
        if NoSeriesMgt.LookupRelatedNoSeries(SalesSetup."Reminder Nos.", OldCashCollectionHeader."No. Series", CashCollectionHeader."No. Series") then begin  // BC Upgrade NANDIS03 - Added //Added CashCollectionHeader var KUMBHS03_26022026
            SalesSetup.GET();
            SalesSetup.TESTFIELD("Reminder Nos.");
            SalesSetup.TESTFIELD("Issued Reminder Nos.");
            //NoSeriesMgt.SetSeries("No.");  // BC Upgrade NANDIS03 - Blocked
            NoSeriesMgt.GetNextNo(CashCollectionHeader."No.");  // BC Upgrade NANDIS03 - Added //Added CashCollectionHeader var KUMBHS03_26022026
            Rec := CashCollectionHeader;
            exit(true);
        end;
    end;
    //HEI.01<<
    //end;  //Commented KUMBHS03_26022026

    local procedure Undo(): Boolean;
    begin
        //HEI.01>>
        CashCollectionLine.SETRANGE("Cash Collection No.", "No.");
        if CashCollectionLine.FIND('-') then begin
            COMMIT();
            if not
               CONFIRM(
                 Text002 +
                 Text003,
                 false)
            then
                exit(true);
            CashCollectionLine.DELETEALL();
            MODIFY()
        end;
        //HEI.01<<
    end;

    procedure InsertLines();
    var
        CashCollectionLine2: Record "Cash Collection Line FND";
        CurrencyForReminderLevel: Record "Currency for Reminder Level";
        //CaptionManagement: Codeunit "Caption Management"; //BC Upgrade Manisha
        CaptionManagement: Codeunit "Translation Helper";//BC Upgrade Manisha
        AdditionalFee: Decimal;
    begin
        //HEI.01>>
        CurrencyForReminderLevel.INIT();
        CALCFIELDS("Remaining Amount");
        CashCollectionLine.RESET();
        CashCollectionLine.SETRANGE("Cash Collection No.", "No.");
        CashCollectionLine.SETRANGE("Line Type", CashCollectionLine."Line Type"::"Cash Collection Line");
        CashCollectionLine."Cash Collection No." := "No.";
        if CashCollectionLine.FIND('+') then
            NextLineNo := CashCollectionLine."Line No."
        else
            NextLineNo := 0;
        CashCollectionLine.SETRANGE("Line Type");
        CashCollectionLine2 := CashCollectionLine;
        CashCollectionLine2.COPYFILTERS(CashCollectionLine);
        CashCollectionLine2.SETFILTER("Line Type", '<>%1', CashCollectionLine2."Line Type"::"Line Fee");
        if CashCollectionLine2.NEXT() <> 0 then begin
            LineSpacing := (CashCollectionLine2."Line No." - CashCollectionLine."Line No.") div 3;
        end else
            LineSpacing := 10000;
        InsertBlankLine(CashCollectionLine."Line Type"::"Additional Fee");

        NextLineNo := NextLineNo + LineSpacing;
        CashCollectionLine.INIT();
        CashCollectionLine."Line No." := NextLineNo;
        CashCollectionLine.Type := CashCollectionLine.Type::"Customer Ledger Entry";
        TESTFIELD("Customer Posting Group");
        CustPostingGr.GET("Customer Posting Group");
        CustPostingGr.TESTFIELD("Additional Fee Account");
        CashCollectionLine.VALIDATE("No.", CustPostingGr."Additional Fee Account");
        CashCollectionLine.Description :=
          COPYSTR(
            CaptionManagement.GetTranslatedFieldCaption(
              "Language Code", DATABASE::"Currency for Reminder Level",
              CurrencyForReminderLevel.FIELDNO("Additional Fee")), 1, 100);
        CashCollectionLine.VALIDATE(Amount, AdditionalFee);
        CashCollectionLine."Line Type" := CashCollectionLine."Line Type"::"Additional Fee";
        CashCollectionLine.INSERT();

        CashCollectionLine."Line No." := CashCollectionLine."Line No." + 10000;
        ReminderRounding(Rec);
        InsertBeginTexts(Rec);
        InsertEndTexts(Rec);
        MODIFY();
        //HEI.01<<
    end;

    procedure UpdateLines(ReminderHeader: Record "Reminder Header"; UpdateAdditionalFee: Boolean);
    begin
        //HEI.01>>
        CashCollectionLine.RESET();
        CashCollectionLine.SETRANGE("Cash Collection No.", CashCollectionHeader."No.");
        CashCollectionLine.SETRANGE(
          "Line Type",
          CashCollectionLine."Line Type"::"Beginning Text",
          CashCollectionLine."Line Type"::"Ending Text");
        CashCollectionLine.SETRANGE(Type, CashCollectionLine.Type::" ");
        CashCollectionLine.SETRANGE("Attached to Line No.", 0);
        CashCollectionLine.DELETEALL(true);

        if UpdateAdditionalFee then begin
            CashCollectionLine.RESET();
            CashCollectionLine.SETRANGE("Cash Collection No.", CashCollectionHeader."No.");
            CashCollectionLine.SETRANGE("Line Type", CashCollectionLine."Line Type"::"Additional Fee");
            CashCollectionLine.DELETEALL();
            InsertLines();
        end else begin
            InsertBeginTexts(CashCollectionHeader);
            InsertEndTexts(CashCollectionHeader);
        end;
        //HEI.01<<
    end;

    local procedure InsertBeginTexts(CashCollectionHeader: Record "Cash Collection Header FND");
    begin
        //HEI.01>>
        CashCollectionLine.RESET();
        CashCollectionLine.SETRANGE("Cash Collection No.", CashCollectionHeader."No.");
        CashCollectionLine."Cash Collection No." := CashCollectionHeader."No.";
        if CashCollectionLine.FIND('-') then begin
            LineSpacing := CashCollectionLine."Line No." div (0 + 2);
            if LineSpacing = 0 then
                ERROR(Text004);
        end else
            LineSpacing := 10000;
        NextLineNo := 0;
        InsertTextLines(CashCollectionHeader);
        //HEI.01<<
    end;

    local procedure InsertEndTexts(CashCollectionHeader: Record "Cash Collection Header FND");
    var
        CashCollectionLine2: Record "Cash Collection Line FND";
    begin
        //HEI.01>>
        CashCollectionLine.RESET();
        CashCollectionLine.SETRANGE("Cash Collection No.", CashCollectionHeader."No.");
        CashCollectionLine.SETFILTER(
          "Line Type", '%1|%2|%3',
          CashCollectionLine."Line Type"::"Cash Collection Line",
          CashCollectionLine."Line Type"::"Additional Fee",
          CashCollectionLine."Line Type"::Rounding);
        if CashCollectionLine.FINDLAST() then
            NextLineNo := CashCollectionLine."Line No."
        else
            NextLineNo := 0;
        CashCollectionLine.SETRANGE("Line Type");
        CashCollectionLine2 := CashCollectionLine;
        CashCollectionLine2.COPYFILTERS(CashCollectionLine);
        CashCollectionLine2.SETFILTER("Line Type", '<>%1', CashCollectionLine2."Line Type"::"Line Fee");
        if CashCollectionLine2.NEXT() <> 0 then begin
            LineSpacing :=
              (CashCollectionLine2."Line No." - CashCollectionLine."Line No.") div
              (0 + 2);
            if LineSpacing = 0 then
                ERROR(Text004);
        end else
            LineSpacing := 10000;
        InsertTextLines(CashCollectionHeader);
        //HEI.01<<
    end;

    local procedure InsertTextLines(CashCollectionHeader: Record "Cash Collection Header FND");
    var
        CompanyInfo: Record "Company Information";
        Translation: Text[80];// BC Upgrade Manisha 
    begin
        //HEI.01>>
        if CashCollectionHeader."Fin. Charge Terms Code" <> '' then
            FinChrgTerms.GET(CashCollectionHeader."Fin. Charge Terms Code");

        CashCollectionHeader.CALCFIELDS(
          "Remaining Amount", "Interest Amount", "Additional Fee", "VAT Amount", "Add. Fee per Line");
        ReminderTotal :=
          CashCollectionHeader."Remaining Amount" + CashCollectionHeader."Interest Amount" +
          CashCollectionHeader."Additional Fee" + CashCollectionHeader."VAT Amount" +
          CashCollectionHeader."Add. Fee per Line";
        CompanyInfo.GET();
        ApplicationManagement.AutoFormatTranslate(1, CashCollectionHeader."Currency Code", Translation);
        //BC Upgrade Manisha for CU Application Mangement. This function is now moved in CU UI help Triggers and also this functions returned Text value but now a parameter is increased in the same function.
        //REPEAT
        NextLineNo := NextLineNo + LineSpacing;
        CashCollectionLine.INIT();
        CashCollectionLine."Line No." := NextLineNo;
        CashCollectionLine.Type := CashCollectionLine.Type::" ";
        CashCollectionLine.Description :=
          COPYSTR(
            STRSUBSTNO(
              '',
              CashCollectionHeader."Document Date",
              CashCollectionHeader."Due Date",
              FinChrgTerms."Interest Rate",
              FORMAT(CashCollectionHeader."Remaining Amount", 0,
                Translation),//BC Upgrade Manisha

        CashCollectionHeader."Interest Amount",
              CashCollectionHeader."Additional Fee",
              FORMAT(ReminderTotal, 0, Translation),//BC Uprgade Manisha
              CashCollectionHeader."Cash Collection Level",
              CashCollectionHeader."Currency Code",
              CashCollectionHeader."Posting Date",
              CompanyInfo.Name,
              CashCollectionHeader."Add. Fee per Line"),
            1,
            MAXSTRLEN(CashCollectionLine.Description));
        //HEI.01<<
    end;

    local procedure InsertBlankLine(LineType: Integer);
    begin
        //HEI.01>>
        NextLineNo := NextLineNo + LineSpacing;
        CashCollectionLine.INIT();
        CashCollectionLine."Line No." := NextLineNo;
        CashCollectionLine."Line Type" := LineType;
        CashCollectionLine.INSERT();
        //HEI.01<<
    end;

    procedure PrintRecords();
    var
        ReminderHeader: Record "Reminder Header";
        ReportSelection: Record "Report Selections";
    begin
        //HEI.01>>
        //Commented KUMBHS03_26022026 >>
        //with CashCollectionHeader do begin
        //COPY(Rec);
        //FINDFIRST();
        //SETRECFILTER();
        //ReportSelection.PrintReport(ReportSelection.Usage::"Rem.Test", CashCollectionHeader);
        //end;
        //Commented KUMBHS03_26022026 <<

        //Added KUMBHS03_26022026 >>
        CashCollectionHeader.COPY(Rec);
        CashCollectionHeader.FINDFIRST();
        CashCollectionHeader.SETRECFILTER();
        ReportSelection.PrintReport(ReportSelection.Usage::"Rem.Test", CashCollectionHeader);
        //Added KUMBHS03_26022026 <<
        //HEI.01<<
    end;

    procedure ConfirmDeletion(): Boolean;
    begin
        //HEI.01>>
        CashCollectionIssue.TestDeleteHeader(Rec, IssuedCashCollectionHeader);
        if IssuedCashCollectionHeader."No." <> '' then
            if not CONFIRM(
                 Text005 +
                 Text006 +
                 Text003, true,
                 IssuedCashCollectionHeader."No.")
            then
                exit;
        exit(true);
        //HEI.01<<
    end;

    local procedure CreateDim(Type1: Integer; No1: Code[20]);
    var
        SourceCodeSetup: Record "Source Code Setup";
        DimManagement: Codeunit DimensionManagement;
        No: array[10] of Code[20];
        TableID: array[10] of Integer;
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; //BC Upgrade Manisha

    begin
        //HEI.01>>
        SourceCodeSetup.GET();
        TableID[1] := Type1;
        No[1] := No1;
        //BC upgrade Manisha
        DimManagement.AddDimSource(DefaultDimSource, Type1, No1);

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        /* //BC Upgrade Manisha
              DimMgt.GetDefaultDimID(
             TableID, No, SourceCodeSetup.Reminder,
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
       */ //BC Upgrade Manisha Previously TableID,No is used Now instead of 2 only one parameter is used DefaultDimSource
        "Dimension Set ID" :=
   DimMgt.GetDefaultDimID(
     DefaultDimSource, SourceCodeSetup.Reminder,
     "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
        //HEI.01<<
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    local procedure ReminderRounding(CashCollectionHeader: Record "Cash Collection Header FND");
    var
        ReminderRoundingAmount: Decimal;
        TotalAmountInclVAT: Decimal;
    begin
        //HEI.01>>
        GetCurrency(CashCollectionHeader);
        if Currency."Invoice Rounding Precision" = 0 then
            exit;

        CashCollectionHeader.CALCFIELDS(
          "Remaining Amount", "Interest Amount", "Additional Fee", "VAT Amount", "Add. Fee per Line");

        TotalAmountInclVAT := CashCollectionHeader."Remaining Amount" +
          CashCollectionHeader."Interest Amount" +
          CashCollectionHeader."Additional Fee" +
          CashCollectionHeader."Add. Fee per Line" +
          CashCollectionHeader."VAT Amount";
        ReminderRoundingAmount :=
          -ROUND(
            TotalAmountInclVAT -
            ROUND(
              TotalAmountInclVAT,
              Currency."Invoice Rounding Precision",
              Currency.InvoiceRoundingDirection()),
            Currency."Amount Rounding Precision");
        if ReminderRoundingAmount <> 0 then begin
            CustPostingGr.GET(CashCollectionHeader."Customer Posting Group");
            CustPostingGr.TESTFIELD("Invoice Rounding Account");
            //Commented KUMBHS03_26022026 >>
            //with CashCollectionLine do begin
            //  INIT();
            // VALIDATE("Line No.", GetNextLineNo(CashCollectionHeader."No."));
            // VALIDATE("Cash Collection No.", CashCollectionHeader."No.");
            // VALIDATE(Type, Type::"Customer Ledger Entry");
            // "System-Created Entry" := true;
            // VALIDATE("No.", CustPostingGr."Invoice Rounding Account");
            // VALIDATE(
            // Amount,
            // ROUND(
            //  ReminderRoundingAmount / (1 + ("VAT %" / 100)),
            // Currency."Amount Rounding Precision"));
            //"VAT Amount" := ReminderRoundingAmount - Amount;
            //"Line Type" := "Line Type"::Rounding;
            //INSERT();
            // end;
            //Commented KUMBHS03_26022026 <<

            //Added KUMBHS03_26022026 >>
            CashCollectionLine.INIT();
            CashCollectionLine.VALIDATE("Line No.", GetNextLineNo(CashCollectionHeader."No."));
            CashCollectionLine.VALIDATE("Cash Collection No.", CashCollectionHeader."No.");
            CashCollectionLine.VALIDATE(Type, CashCollectionLine.Type::"Customer Ledger Entry");
            CashCollectionLine."System-Created Entry" := true;
            CashCollectionLine.VALIDATE("No.", CustPostingGr."Invoice Rounding Account");
            CashCollectionLine.VALIDATE(
              Amount,
              ROUND(
                ReminderRoundingAmount / (1 + (CashCollectionLine."VAT %" / 100)),
                Currency."Amount Rounding Precision"));
            CashCollectionLine."VAT Amount" := ReminderRoundingAmount - CashCollectionLine.Amount;
            CashCollectionLine."Line Type" := CashCollectionLine."Line Type"::Rounding;
            CashCollectionLine.INSERT();
            //Added KUMBHS03_26022026 <<
        end;
        //HEI.01<<
    end;

    local procedure GetCurrency(CashCollectionHeader: Record "Cash Collection Header FND");
    begin
        //Commented KUMBHS03_26022026 >>
        //HEI.01>>
        //with CashCollectionHeader do
        //  if "Currency Code" = '' then
        //    Currency.InitRoundingPrecision()
        //else begin
        //    Currency.GET("Currency Code");
        //    Currency.TESTFIELD("Amount Rounding Precision");
        //end;
        //HEI.01<<
        //Commented KUMBHS03_26022026 >>

        //HEI.01>>
        //Added KUMBHS03_26022026 >>
        if CashCollectionHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.GET(CashCollectionHeader."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        end;
        //Added KUMBHS03_26022026 <<
        //HEI.01<<
    end;

    procedure UpdateReminderRounding(CashCollectionHeader: Record "Cash Collection Header FND");
    var
        OldLineNo: Integer;
    begin
        //HEI.01>>
        CashCollectionLine.RESET();
        CashCollectionLine.SETRANGE("Cash Collection No.", CashCollectionHeader."No.");
        CashCollectionLine.SETRANGE("Line Type", CashCollectionLine."Line Type"::Rounding);
        if CashCollectionLine.FINDFIRST() then
            CashCollectionLine.DELETE(true);

        CashCollectionLine.SETRANGE("Line Type");
        CashCollectionLine.SETFILTER(Type, '<>%1', CashCollectionLine.Type::" ");
        if CashCollectionLine.FINDLAST() then begin
            OldLineNo := CashCollectionLine."Line No.";
            CashCollectionLine.SETRANGE(Type);
            if CashCollectionLine.NEXT() <> 0 then
                CashCollectionLine."Line No." := OldLineNo + ((CashCollectionLine."Line No." - OldLineNo) div 2)
            else
                CashCollectionLine."Line No." := OldLineNo + 10000;
        end else
            CashCollectionLine."Line No." := 10000;

        ReminderRounding(CashCollectionHeader);
        //HEI.01<<
    end;

    procedure ShowDocDim();
    begin
        //HEI.01>>
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //HEI.01<<
    end;

    procedure CalculateLineFeeVATAmount(): Decimal;
    var
        ReminderLine: Record "Reminder Line";
    begin
        //HEI.01>>
        CashCollectionLine.SETCURRENTKEY("Cash Collection No.", Type, "Line Type");
        CashCollectionLine.SETRANGE("Cash Collection No.", "No.");
        CashCollectionLine.SETRANGE(Type, CashCollectionLine.Type::"Customer Ledger Entry");
        CashCollectionLine.CALCSUMS("VAT Amount");
        exit(CashCollectionLine."VAT Amount");
        //HEI.01<<
    end;

    local procedure GetNextLineNo(ReminderNo: Code[20]): Integer;
    var
        ReminderLine: Record "Reminder Line";
    begin
        //HEI.01>>
        CashCollectionLine.SETRANGE("Cash Collection No.", ReminderNo);
        if CashCollectionLine.FINDLAST() then
            exit(CashCollectionLine."Line No." + 10000);
        exit(10000);
        //HEI.01<<
    end;

    local procedure GetFilterCustNo(): Code[20];
    begin
        if GETFILTER("Customer No.") <> '' then
            if GETRANGEMIN("Customer No.") = GETRANGEMAX("Customer No.") then
                exit(GETRANGEMAX("Customer No."));
    end;

    procedure SetCustomerFromFilter();
    begin
        if GetFilterCustNo() <> '' then
            VALIDATE("Customer No.", GetFilterCustNo());
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100];
    var
        "Field": Record "Field";
    begin
        //HEI.01>>
        if FieldNumber = 0 then
            exit;
        Field.GET(DATABASE::"Sales Header", FieldNumber);
        exit(Field."Field Caption");
        //HEI.01<<
    end;
    /* BCUPGRADE Manisha Drink it table 'Route' used code commented>>
    local procedure TestRouteTypeVariable(CalledbyFieldNo: Integer);
    var
        LRoute: Record Route;
    begin
        //HEI.01>>
        if (CalledbyFieldNo <> CurrFieldNo) and (CurrFieldNo <> 0) then
            exit;
        //HEI.01<<
    end;
  */ //BCUPGRADE Manisha Drink it table 'Route' used code commented>>
    local procedure GetShippingTime(CalledByFieldNo: Integer);
    var
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
        //HEI.01>>
        if (CalledByFieldNo <> CurrFieldNo) and (CurrFieldNo <> 0) then
            exit;
        //HEI.01<<
    end;
    //BC UPGRADE KUMARR78 >> Rewriting Blocked Condition.
    local procedure TestRouteTypeVariable(CalledbyFieldNo: Integer);
    var
        LRoute: Record Route107FDW;
    begin
        //HEI.01>>
        if (CalledbyFieldNo <> CurrFieldNo) and (CurrFieldNo <> 0) then
            exit;
        //HEI.01<<
    end;
    //BC UPGRADE KUMARR78 << Rewriting Blocked Condition.

}

