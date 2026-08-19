table 50105 "Gate Entry Header FND"
{
    // version HEI.07

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Table Created for Gate Entry
    // HEI:EDD039:1:1 04/06/10 RSM
    //   # New field 50000 Source No. Code 20 created
    // 
    // HEI:EDD151:1:1 13/11/14 TECTURA-HKH
    //   # Gate Control
    //   # Added new field 80001 'Grouped Control' [Boolean]
    //   # Added code for updaing Statistics Buffer on the basis of Location Code
    //   # Added new options in field "Refrence Document" for posted Sale, Purchae and Transfer documents
    // 
    // HEI:CHG0229242:1:1 23/07/2018 IBM.AK
    //   # Added code on Location Code-On Validate
    // 
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Table 80050 - Gate Entry Header from HEI2.0
    //   # Gate Entry No. should not be added to Sales Header, Purchase Header or Transfer Header tables
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"
    // HEI.03 Defect #3271 IBM NASTAA02 17.10.2018 # Error when creating a new Gate entry inbound
    //   # Location Code and Zone Code should be mandatory
    //   # If exist take Default Location and Zone from Warehouse Employee
    // HEI.04 Bugfixing RW IBM NASTAA02 17.10.2018 # Bugfixing Gate Entry RW
    //   # Confirmation message and message added on Registering a Gate Entry
    //   # Validation added on "Date In"/"Date Out"
    //   # "Weight Difference" should not be absolute value
    //   # Added condition on "Zone Code" so that the Zone should be limited at the Location selected
    //   # When validating "Document Type" values of Field "Document No." should be erased
    //   # Created new function "InsertPostedWeight" to insert the Posted Weight when opening the page
    //   # Validation added on "Time In"/"Time Out"
    //   # Changed formula for CheckTolerance
    // HEI.05  FDD_CHG2030239 FA Master Data IBM  SAXENS01 17.09.2019
    //   Added New Field "Automatic Registration"
    // HEI.06 CHG2260099 COSTES04 07.11.2024 Automatic Archiving of Gate Entry Outbound While Undoing Sales Shipment.
    //   # New field added Blocked
    // HEI.07 CHG2284663 COSTES04 05.02.2025 CNET integration with HeiLite BASE for Sales Order Management Status Update APIs
    //   # send cnet status update

    DataCaptionFields = "Gate Entry Document No.";
    DrillDownPageID = "Gate Entry List";
    LookupPageID = "Gate Entry List";

    fields
    {
        field(1; "Gate Entry Document No."; Code[20])
        {
            CaptionML = ENU = 'Gate Entry Document No.',
                        FRA = 'Gate Entry Document No.';

            trigger OnValidate();
            begin
                if "Gate Entry Document No." <> xRec."Gate Entry Document No." then begin
                    WarehouseSetup.GET();
                    //NoSeriesMgt.TestManual(WarehouseSetup."Gate Entry Nos. FND");  // BC Upgrade NANDIS03 - Blocked
                    NoSeries.TestManual(WarehouseSetup."Gate Entry Nos. FND");  //  BC Upgrade NANDIS03 - Added
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            CaptionML = ENU = 'Document Date',
                        FRA = 'Document Date';
        }
        field(3; "Gate Keeper ID"; Code[50])
        {
            CaptionML = ENU = 'Gate Keeper ID',
                        FRA = 'Gate Keeper ID';
            Editable = false;
            TableRelation = User;
        }

        //BC UPGRADE KUMARR78 >> Adding FDD-MTC-007
        field(4; "Vehicle No."; Code[10])
        {
            Caption = 'Vehicle No.';
            TableRelation = Vehicle101FDW;
            trigger OnValidate();
            var
                Truck: Record Vehicle101FDW;
            begin
                if not Truck.GET("Vehicle No.") then
                    ERROR(Err004);

            end;
        }
        field(5; "Driver Code"; Code[10])
        {
            Caption = 'Driver Code';
            TableRelation = Driver107FDW;
            trigger OnValidate()
            var

            begin
                if not Driver.GET("Driver Code") then
                    ERROR(Err005);
            end;
        }
        //BC UPGRADE KUMARR78 << Adding FDD-MTC-007
        field(6; "Gate Entry Type"; Option)
        {
            CaptionML = ENU = 'Gate Entry Type',
                        FRA = 'Gate Entry Type';
            Editable = false;
            OptionCaption = 'Inbound,Outbound,Service,Stay';
            OptionMembers = Inbound,Outbound,Service,Stay;
        }
        field(7; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Document Type';
            OptionCaptionML = ENU = ' ,Purchase Order,Transfer Order,Sales Return Order,Warehouse Receipt,Sales Order,Purchase Return Order,Warehouse Shipment',
                              FRA = ' ,Purchase Order,Transfer Order,Sales Return Order,Warehouse Receipt,Sales Order,Purchase Return Order,Warehouse Shipment';
            OptionMembers = " ","Purchase Order","Transfer Order","Sales Return Order","Warehouse Receipt","Sales Order","Purchase Return Order","Warehouse Shipment";

            trigger OnValidate();
            begin
                if not CheckEntryType() then
                    //ERROR(Err001);
                    ERROR(NotAllowedDocTypeErr, "Document Type", "Gate Entry Type");
                //HEI.04>>
                if "Document Type" <> xRec."Document Type" then
                    CLEAR("Document No.");
                //HEI.04<<
            end;
        }
        field(8; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        FRA = 'Document No.';

            trigger OnLookup();
            begin
                DocNo := GetDocNo();
                if DocNo <> '' then
                    "Document No." := DocNo;
            end;
        }
        field(9; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Location Code';
            NotBlank = true;
            TableRelation = Location;

            trigger OnValidate();
            begin
                //Standard>>
                if not LocationIsAllowed("Location Code") then
                    if "Location Code" <> '' then
                        ERROR(Text80013, "Location Code");

                //HEI:CHG0229242:1:1 23/07/2018 IBM.AK >>
                /*PPsetup.GET;
                IF NOT PPsetup."Enable Physical Loc Group Code" THEN BEGIN
                  IF NOT LocationIsAllowed("Location Code") THEN
                    IF "Location Code" <> '' THEN
                      ERROR(Text80013,"Location Code");
                end;*/

                //HEI:CHG0229242:1:1 23/07/2018 IBM.AK <<

            end;
        }
        field(10; Description; Text[80])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Description';
        }
        field(11; Status; Option)
        {
            CaptionML = ENU = 'Status',
                        FRA = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;

            trigger OnValidate();
            begin
                if Status = Status::Open then
                    OpenGateEntry();
                if Status = Status::Released then
                    ReleaseGateEntry();
            end;
        }
        field(12; "Date In"; Date)
        {
            CaptionML = ENU = 'Date In',
                        FRA = 'Date In';

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                //HEI.04>>
                if "Date In" > "Date Out" then
                    ERROR(DateErr2, "Date In", "Date Out");
                //HEI.04<<
            end;
        }
        field(13; "Time In"; Time)
        {
            CaptionML = ENU = 'Time In',
                        FRA = 'Time In';

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                //HEI.04>>
                if "Date In" = "Date Out" then
                    if "Time In" > "Time Out" then
                        ERROR(TimeErr2, "Time In", "Time Out");
                //HEI.04<<
            end;
        }
        field(14; "Date Out"; Date)
        {
            CaptionML = ENU = 'Date Out',
                        FRA = 'Date Out';

            trigger OnValidate();
            begin
                //HEI.04>>
                if "Date Out" < "Date In" then
                    ERROR(DateErr, "Date Out", "Date In");
                //HEI.04<<
            end;
        }
        field(15; "Time Out"; Time)
        {
            CaptionML = ENU = 'Time Out',
                        FRA = 'Time Out';

            trigger OnValidate();
            begin
                //HEI.04>>
                if "Date In" = "Date Out" then
                    if "Time Out" < "Time In" then
                        ERROR(TimeErr, "Time Out", "Time In");
                //HEI.04<<
            end;
        }
        field(16; "Total Weight on Arrival"; Decimal)
        {
            CaptionML = ENU = 'Total Weight on Arrival',
                        FRA = 'Total Weight on Arrival';
            MinValue = 0;

            trigger OnValidate();
            var
                SalesShipmentHeader: Record "Sales Shipment Header";
            begin
                //HEI.04>>
                SalesShipmentHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
                if not SalesShipmentHeader.FINDFIRST() then
                    //HEI.04<<
                    TESTFIELD(Status, Status::Open);
            end;
        }
        field(17; "Total Weight on Departure"; Decimal)
        {
            CaptionML = ENU = 'Total Weight on Departure',
                        FRA = 'Total Weight on Departure';
            MinValue = 0;

            trigger OnValidate();
            begin
                InsertPostedWeight(); //HEI.04
            end;
        }
        field(18; "Posted Weight Inbound"; Decimal)
        {
            CaptionML = ENU = 'Posted Weight Inbound',
                        FRA = 'Posted Weight Inbound';
            Editable = false;
        }
        field(19; "Posted Weight Outbound"; Decimal)
        {
            CaptionML = ENU = 'Posted Weight Outbound',
                        FRA = 'Posted Weight Outbound';
            Editable = false;
        }
        field(20; "Weight Difference"; Decimal)
        {
            CaptionML = ENU = 'Weight Difference',
                        FRA = 'Weight Difference';
            Editable = false;
        }
        field(21; "Linked Gate Entry No."; Code[20])
        {
            CaptionML = ENU = 'Linked Gate Entry No.',
                        FRA = 'Linked Gate Entry No.';
            TableRelation = "Gate Entry Header FND"."Gate Entry Document No.";
        }
        field(22; Comment; Boolean)
        {
            CalcFormula = Exist("Gate Comment Line FND" where("Document Type" = FIELD("Gate Entry Type"),
                                                           "No." = FIELD("Gate Entry Document No."),
                                                           "Document Line No." = CONST(0)));
            CaptionML = ENU = 'Comment',
                        FRA = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "No. Printed"; Integer)
        {
            CaptionML = ENU = 'No. Printed',
                        FRA = 'No. Printed';
            Editable = false;
        }
        field(24; "No. Series"; Code[20])
        {
            CaptionML = ENU = 'No. Series',
                        FRA = 'No. Series';
            TableRelation = "No. Series";
        }
        field(25; Registered; Boolean)
        {
            CaptionML = ENU = 'Registered',
                        FRA = 'Registered';
        }
        field(26; Assigned; Boolean)
        {
            CaptionML = ENU = 'Assigned',
                        FRA = 'Assigned';
        }
        field(60; "Reference Document"; Option)
        {
            CaptionML = ENU = 'Reference Document',
                        FRA = 'Document référence';
            OptionCaptionML = ENU = ' ,Posted Warehouse Shipment,Posted Warehouse Receipt,Posted Shipment,Posted Receipt,Posted Return Receipt,Posted Return Shipment,Posted Transfer Shipment,Posted Transfer Receipt',
                              FRA = ' ,Posted Warehouse Shipment,Posted Warehouse Receipt,Posted Shipment,Posted Receipt,Posted Return Receipt,Posted Return Shipment,Posted Transfer Shipment,Posted Transfer Receipt';
            OptionMembers = " ","Posted Warehouse Shipment","Posted Warehouse Receipt","Posted Shipment","Posted Receipt","Posted Return Receipt","Posted Return Shipment","Posted Transfer Shipment","Posted Transfer Receipt";
        }
        field(61; "Reference No."; Code[20])
        {
            CaptionML = ENU = 'Reference No.',
                        FRA = 'N° référence';
        }
        field(62; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(50000; "Automatic Registration"; Boolean)
        {
            Description = 'HEI.05';
            Editable = false;
        }
        field(80001; "Grouped Control"; Boolean)
        {
            CaptionML = ENU = 'Grouped control',
                        FRA = 'Contrôle groupé';
        }
        field(80002; "Total Quantity on Arrival"; Decimal)
        {
            CalcFormula = Sum("Gate Entry Line FND"."Quantity on Arrival" where("Gate Entry Document No." = FIELD("Gate Entry Document No.")));
            CaptionML = ENU = 'Total Quantity on Arrival',
                        FRA = 'Total Quantity on Arrival';
            FieldClass = FlowField;
        }
        field(80003; "Total Quantity on Departure"; Decimal)
        {
            CalcFormula = Sum("Gate Entry Line FND"."Quantity on Departure" where("Gate Entry Document No." = FIELD("Gate Entry Document No.")));
            CaptionML = ENU = 'Total Quantity on Departure',
                        FRA = 'Total Quantity on Departure';
            FieldClass = FlowField;
        }
        field(80004; "Total Posted Quantity Inbound"; Decimal)
        {
            CalcFormula = Sum("Gate Entry Line FND"."Posted Quantity Inbound" where("Gate Entry Document No." = FIELD("Gate Entry Document No.")));
            CaptionML = ENU = 'Total Posted Quantity Inbound',
                        FRA = 'Total Posted Quantity Inbound';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80005; "Total Posted Quantity Outbound"; Decimal)
        {
            CalcFormula = Sum("Gate Entry Line FND"."Posted Quantity Outbound" where("Gate Entry Document No." = FIELD("Gate Entry Document No.")));
            CaptionML = ENU = 'Total Posted Quantity Outbound',
                        FRA = 'Total Posted Quantity Outbound';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80006; "Zone Code"; Code[10])
        {
            Description = 'HEI.02';
            NotBlank = true;
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));

            trigger OnValidate();
            begin
                //HEI.03>>
                if not ZoneIsAllowed("Zone Code") then
                    if "Zone Code" <> '' then
                        ERROR(Text80016, "Zone Code");
                //HEI.03<<
            end;
        }
        field(500011; Remarks; Text[100])
        {
            CaptionML = ENU = 'Remarks',
                        FRA = 'Remarks';
        }
    }

    keys
    {
        key(Key1; "Gate Entry Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if Status <> Status::Open then
            ERROR(Err007);

        if Registered then
            ERROR(Err009);
        if "No. Printed" > 0 then
            TESTFIELD("No. Printed");
        GELine.RESET();
        GELine.SETRANGE("Gate Entry Document No.", "Gate Entry Document No.");
        if GELine.findset() then
            GELine.DELETEALL();

        GateCommentLine.SETRANGE("No.", "Document No.");
        if not GateCommentLine.ISEMPTY then
            GateCommentLine.DELETEALL();
    end;

    trigger OnInsert();
    begin
        WarehouseSetup.GET();
        if "Gate Entry Document No." = '' then begin
            WarehouseSetup.TESTFIELD("Gate Entry Nos. FND");
            //NoSeriesMgt.InitSeries(WarehouseSetup."Gate Entry Nos. FND", xRec."No. Series", 0D, "Gate Entry Document No.", "No. Series");  // BC Upgrade NANDIS03 - Blocked
            // NoSeries.AreRelated(WarehouseSetup."Gate Entry Nos. FND", "No. Series");  // BC Upgrade NANDIS03 - Added // BC Upgrade KUMARR78 - Blocked

            // BC Upgrade KUMARR78 - Adding
            "Gate Entry Document No." := NoSeries.GetNextNo(WarehouseSetup."Gate Entry Nos. FND", WorkDate(), true);
            "No. Series" := WarehouseSetup."Gate Entry Nos. FND";
            // BC Upgrade KUMARR78 - Adding
        end;
        // "No. Series" := WarehouseSetup."Gate Entry Nos. FND";// BC Upgrade KUMARR78 - Blocked
        "Gate Keeper ID" := USERID;
        "Document Date" := TODAY;
        SetDefaultLocationZone(); //HEI.03
        VALIDATE("Location Code", DefaultLocation); //HEI.03
        VALIDATE("Zone Code", DefaultZone); //HEI.03
    end;

    var
        GateCommentLine: Record "Gate Comment Line FND";
        GateEntryHeader: Record "Gate Entry Header FND";
        GateEntryHeaderRec: Record "Gate Entry Header FND";
        GateEntryLine: Record "Gate Entry Line FND";
        GELine: Record "Gate Entry Line FND";
        TmpGateEntryBuff: Record "Gate Statistics Buffer FND" temporary;
        Location: Record Location;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PPsetup: Record "Purchases & Payables Setup";
        ReturnRcptHeader: Record "Return Receipt Header";
        ReturnRcptLine: Record "Return Receipt Line";
        ReturnShptHeader: Record "Return Shipment Header";
        ReturnShptLine: Record "Return Shipment Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TransRcptHeader: Record "Transfer Receipt Header";
        TransRcptLine: Record "Transfer Receipt Line";
        TransShptHeader: Record "Transfer Shipment Header";
        TransShptLine: Record "Transfer Shipment Line";
        UserSetup: Record "User Setup";
        // WhseEmployee: Record "Warehouse Employee";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
        WhseEmployee: Record "Warehouse Employee_DTW FND";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table

        WarehouseSetup: Record "Warehouse Setup";
        WhseSetup: Record "Warehouse Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - NoSeriesManagement CU is obsolete
        NoSeries: Codeunit "No. Series";  // BC Upgrade NANDIS03 - "No. Series" CU is added
        PostedEntryExists: Boolean;
        DefaultLocation: Code[10];
        DefaultZone: Code[10];
        DocNo: Code[20];
        ConfirmMsg: Label 'Do you want to register Gate Entry %1?';
        DateErr: Label 'Date Out %1 cannot be before Date In %2.';
        DateErr2: Label 'Date In %1 cannot be after Date Out %2.';
        Err001: Label 'Invalid Selection.';
        // Truck: Record "Whse. Shipping Truck";//BC UpgradeSHARMP16-- Drink-IT table
        Truck: Record Vehicle101FDW;//BC UPGRADE KUMARR78 ++ FDD-MTC-007

        Err002: Label 'Truck Status is not Open.';
        Err004: Label 'Invalid Vehicle No.';
        // Driver: Record "Whse. Shipping Driver";//BC UpgradeSHARMP16-- Drink-IT table
        Driver: Record Driver107FDW; //BC UPGRDAE KUMARR78 FDD-MTC-007
        Err005: Label 'Invalid Driver Code.';
        Err006: Label 'Truck Status is not Gate Entry.';
        Err007: Label 'Gate Entry is Released, and can''t be deleted.';
        Err008: Label 'Gate Entry Must be Released First.';
        Err009: Label 'Gate Entry is Registered, can''t be Deleted.';
        Err010: Label 'Document No. is Required.';
        NotAllowedDocTypeErr: Label 'Not allowed to select Document Type %1 with Gate Entry Type %2';
        RegisteredGateMsg: Label 'Gate Entry %1 has been registered.';
        Text80010: Label 'Destroy previously printed Gate entry document';
        Text80011: Label 'Posted Entry Already Exists.';
        TimeErr: Label 'Time Out %1 cannot be before Time In %2.';
        TimeErr2: Label 'Time In %1 cannot be after Time Out %2.';
        Text80012: TextConst ENU = 'You must set-up a default Location code for User %1.', FRA = 'Vous devez configurer un code magasin par défaut pour l''utilisateur %1.';
        Text80013: TextConst ENU = 'You are not allowed to use Location Code %1.', FRA = 'Vous n''êtes pas autorisé à utiliser le code magasin %1.';
        Text80014: TextConst ENU = 'You are not allowed to register Gate Entry No. %1 & Item %2 with deviation.', FRA = 'You are not allowed to register Gate Entry No. %1 & Item %2 with deviation.';
        Text80015: TextConst ENU = 'Document Type cannot be blank.', FRA = 'Document Type cannot be blank.';
        Text80016: TextConst ENU = 'You are not allowed to use Zone Code %1.', FRA = 'Vous n''êtes pas autorisé à utiliser le code magasin %1.';

    procedure CheckEntryType(): Boolean;
    begin
        if "Gate Entry Type" = "Gate Entry Type"::Inbound then begin
            if ("Document Type" = "Document Type"::"Purchase Order") or
               ("Document Type" = "Document Type"::"Transfer Order") or
               ("Document Type" = "Document Type"::"Sales Return Order") or
               ("Document Type" = "Document Type"::"Warehouse Receipt") then
                exit(true);
        end else if "Gate Entry Type" = "Gate Entry Type"::Outbound then begin
            if ("Document Type" = "Document Type"::"Sales Order") or
               ("Document Type" = "Document Type"::"Transfer Order") or
               ("Document Type" = "Document Type"::"Purchase Return Order") or
               ("Document Type" = "Document Type"::"Warehouse Shipment") then
                exit(true);
        end else if "Gate Entry Type" = "Gate Entry Type"::Service then begin
            if "Document Type" = "Document Type"::"Purchase Order" then
                exit(true);
        end else if "Gate Entry Type" = "Gate Entry Type"::Stay then begin
            if "Document Type" = "Document Type"::" " then
                exit(true);
        end else
            exit(false);
    end;

    procedure GetDocNo(): Code[20];
    var
        PurchHdr: Record "Purchase Header";
        SalesHdr: Record "Sales Header";
        TransferHdr: Record "Transfer Header";
        WhseRecp: Record "Warehouse Receipt Header";
        WhseShip: Record "Warehouse Shipment Header";
    begin
        if "Gate Entry Type" = "Gate Entry Type"::Inbound then begin
            if ("Document Type" = "Document Type"::"Purchase Order") then begin
                PurchHdr.RESET();
                PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::Order);
                // PurchHdr.SETRANGE("Truck Code", "Vehicle No.");//BC upgrade SHARMP16-- Drink_IT field
                // PurchHdr.SETRANGE("Driver Code", "Driver Code");//BC upgrade SHARMP16-- Drink_IT field
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                PurchHdr.SETRANGE("Vehicle Code 101FDW", "Vehicle No.");
                PurchHdr.SETRANGE("Log Driver 107FDW", "Driver Code");
                //BC UPGRADE KUMARR78 << FDD-MTC-007


                if PurchHdr.findset() then begin
                    if PAGE.RUNMODAL(53, PurchHdr) = ACTION::LookupOK then begin
                        VALIDATE("Location Code", PurchHdr."Location Code");
                        exit(PurchHdr."No.");
                    end;
                end;
            end;
            if ("Document Type" = "Document Type"::"Transfer Order") then begin
                TransferHdr.RESET();
                // TransferHdr.SETRANGE("Truck Code", "Vehicle No.");//BC upgrade SHARMP16-- Drink_IT field
                // TransferHdr.SETRANGE("Driver Code", "Driver Code");//BC upgrade SHARMP16-- Drink_IT field
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                TransferHdr.SETRANGE("Vehicle Code 101FDW", "Vehicle No.");
                TransferHdr.SETRANGE("Log Driver 107FDW", "Driver Code");
                //BC UPGRADE KUMARR78 << FDD-MTC-007
                if TransferHdr.findset() then begin
                    if PAGE.RUNMODAL(5742, TransferHdr) = ACTION::LookupOK then begin
                        VALIDATE("Location Code", TransferHdr."Transfer-to Code");
                        exit(TransferHdr."No.");
                    end
                end;
            end;
            if ("Document Type" = "Document Type"::"Sales Return Order") then begin
                SalesHdr.RESET();
                SalesHdr.SETRANGE("Document Type", SalesHdr."Document Type"::"Return Order");
                // SalesHdr.SETRANGE("Truck Code", "Vehicle No.");//BC upgrade SHARMP16-- Drink_IT field
                // SalesHdr.SETRANGE("Driver Code", "Driver Code");//BC upgrade SHARMP16-- Drink_IT field
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                SalesHdr.SETRANGE("Vehicle Code 101FDW", "Vehicle No.");
                SalesHdr.SETRANGE("Log Driver 107FDW", "Driver Code");
                //BC UPGRADE KUMARR78 << FDD-MTC-007
                if SalesHdr.findset() then begin
                    if PAGE.RUNMODAL(45, SalesHdr) = ACTION::LookupOK then begin
                        VALIDATE("Location Code", SalesHdr."Location Code");
                        exit(SalesHdr."No.");
                    end;
                end;
            end;
            if ("Document Type" = "Document Type"::"Warehouse Receipt") then begin
                WhseRecp.RESET();
                // WhseRecp.SETRANGE("Truck Code", "Vehicle No.");//BC upgrade SHARMP16-- Drink_IT field
                // WhseRecp.SETRANGE("Driver Code", "Driver Code");//BC upgrade SHARMP16-- Drink_IT field
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                WhseRecp.SETRANGE("Vehicle Code 101FDW", "Vehicle No.");
                WhseRecp.SETRANGE("Log Driver 107FDW", "Driver Code");
                //BC UPGRADE KUMARR78 << FDD-MTC-007
                if WhseRecp.findset() then begin
                    if PAGE.RUNMODAL(7332, WhseRecp) = ACTION::LookupOK then begin
                        VALIDATE("Location Code", WhseRecp."Location Code");
                        exit(WhseRecp."No.");
                    end;
                end;
            end;
        end;
        if "Gate Entry Type" = "Gate Entry Type"::Outbound then begin
            if ("Document Type" = "Document Type"::"Sales Order") then begin
                SalesHdr.RESET();
                SalesHdr.SETRANGE("Document Type", SalesHdr."Document Type"::Order);
                // SalesHdr.SETRANGE("Truck Code", "Vehicle No.");//BC upgrade SHARMP16-- Drink_IT field
                // SalesHdr.SETRANGE("Driver Code", "Driver Code");//BC upgrade SHARMP16-- Drink_IT field
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                SalesHdr.SETRANGE("Vehicle Code 101FDW", "Vehicle No.");
                SalesHdr.SETRANGE("Log Driver 107FDW", "Driver Code");
                //BC UPGRADE KUMARR78 << FDD-MTC-007
                if SalesHdr.findset() then begin
                    if PAGE.RUNMODAL(45, SalesHdr) = ACTION::LookupOK then begin
                        VALIDATE("Location Code", SalesHdr."Location Code");
                        exit(SalesHdr."No.");
                    end;
                end;
            end;
            if ("Document Type" = "Document Type"::"Transfer Order") then begin
                TransferHdr.RESET();
                // TransferHdr.SETRANGE("Truck Code", "Vehicle No.");//BC upgrade SHARMP16-- Drink_IT field
                // TransferHdr.SETRANGE("Driver Code", "Driver Code");//BC upgrade SHARMP16-- Drink_IT field
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                TransferHdr.SETRANGE("Vehicle Code 101FDW", "Vehicle No.");
                TransferHdr.SETRANGE("Log Driver 107FDW", "Driver Code");
                //BC UPGRADE KUMARR78 << FDD-MTC-007
                if TransferHdr.findset() then begin
                    if PAGE.RUNMODAL(5742, TransferHdr) = ACTION::LookupOK then begin
                        VALIDATE("Location Code", TransferHdr."Transfer-from Code");
                        exit(TransferHdr."No.");
                    end;
                end;
            end;
            if ("Document Type" = "Document Type"::"Purchase Return Order") then begin
                PurchHdr.RESET();
                PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::"Return Order");
                // PurchHdr.SETRANGE("Truck Code", "Vehicle No.");//BC upgrade SHARMP16-- Drink_IT field
                // PurchHdr.SETRANGE("Driver Code", "Driver Code");//BC upgrade SHARMP16-- Drink_IT field
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                PurchHdr.SETRANGE("Vehicle Code 101FDW", "Vehicle No.");
                PurchHdr.SETRANGE("Log Driver 107FDW", "Driver Code");
                //BC UPGRADE KUMARR78 << FDD-MTC-007
                if PurchHdr.findset() then begin
                    if PAGE.RUNMODAL(53, PurchHdr) = ACTION::LookupOK then begin
                        VALIDATE("Location Code", PurchHdr."Location Code");
                        exit(PurchHdr."No.");
                    end;
                end;

            end;
            if ("Document Type" = "Document Type"::"Warehouse Shipment") then begin
                WhseShip.RESET();
                // WhseShip.SETRANGE("Truck Code", "Vehicle No.");//BC upgrade SHARMP16-- Drink_IT field
                // WhseShip.SETRANGE("Driver Code", "Driver Code");//BC upgrade SHARMP16-- Drink_IT field
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                WhseShip.SETRANGE("Vehicle Code 101FDW", "Vehicle No.");
                WhseShip.SETRANGE("Log Driver 107FDW", "Driver Code");
                //BC UPGRADE KUMARR78 << FDD-MTC-007
                if WhseShip.findset() then begin
                    if PAGE.RUNMODAL(7339, WhseShip) = ACTION::LookupOK then begin
                        VALIDATE("Location Code", WhseShip."Location Code");
                        exit(WhseShip."No.");
                    end;
                end;
            end;
        end;
        if "Gate Entry Type" = "Gate Entry Type"::Service then begin
            if "Document Type" = "Document Type"::"Purchase Order" then begin
                PurchHdr.RESET();
                PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::Order);
                // PurchHdr.SETRANGE("Truck Code", "Vehicle No.");//BC upgrade SHARMP16-- Drink_IT field
                // PurchHdr.SETRANGE("Driver Code", "Driver Code");//BC upgrade SHARMP16-- Drink_IT field
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                PurchHdr.SETRANGE("Vehicle Code 101FDW", "Vehicle No.");
                PurchHdr.SETRANGE("Log Driver 107FDW", "Driver Code");
                //BC UPGRADE KUMARR78 << FDD-MTC-007
                if PurchHdr.findset() then begin
                    if PAGE.RUNMODAL(53, PurchHdr) = ACTION::LookupOK then begin
                        VALIDATE("Location Code", PurchHdr."Location Code");
                        exit(PurchHdr."No.");
                    end;
                end;
            end;
        end;
        exit('');
    end;

    procedure ReleaseGateEntry();
    begin
        Status := Status::Released;
        if Status = Status::Released then begin
            TESTFIELD("Vehicle No.");
            TESTFIELD("Driver Code");
            //IF "Document Type" = "Document Type"::" " THEN
            //  ERROR(Text80015);
            //TESTFIELD("Document No.");
            Location.GET("Location Code");
            if Location."Gate Weighing Mandatory FND" then
                TESTFIELD("Total Weight on Arrival");

            if "Gate Entry Type" = "Gate Entry Type"::Outbound then begin
                TESTFIELD("Date In");
                TESTFIELD("Time In");
            end;
            TESTFIELD("Location Code");
            //BC UpgradeSHARMP16 begin>> -- Drink-IT code

            // if Truck.GET("Vehicle No.") then begin
            //     if Truck.Status = Truck.Status::Open then begin
            //         Truck.Status := Truck.Status::"Gate Entry";
            //         Truck.MODIFY;
            //     end else
            //         ERROR(Err002);
            // end;
            //BC UpgradeSHARMP16 end<< -- Drink-IT code
            //BC UPGRADE KUMARR78 >> FDD-MTC-007
            if Truck.GET("Vehicle No.") then begin
                if Truck."Status FND" = Truck."Status FND"::Open then begin
                    Truck."Status FND" := Truck."Status FND"::"Gate Entry";
                    Truck.MODIFY;
                end else
                    ERROR(Err002);
            end;
            //BC UPGRADE KUMARR78 >> FDD-MTC-007

        end;
        MODIFY();
    end;

    procedure OpenGateEntry();
    begin
        //>>HEI:EDD001:1:1
        Status := Status::Open;
        if Status = Status::Open then begin
            //BC UpgradeSHARMP16 begin>> -- Drink-IT code
            //     if Truck.GET("Vehicle No.") then begin
            //         if Truck.Status = Truck.Status::"Gate Entry" then begin
            //             Truck.Status := Truck.Status::Open;
            //             Truck.MODIFY;
            //         end else
            //             ERROR(Err006);
            //     end;
            //BC UpgradeSHARMP16 end<< -- Drink-IT code

            //BC UPGRADE KUMARR78 >> FDD-MTC-007
            if Truck.GET("Vehicle No.") then begin
                if Truck."Status FND" = Truck."Status FND"::"Gate Entry" then begin
                    Truck."Status FND" := Truck."Status FND"::Open;
                    Truck.MODIFY;
                end else
                    ERROR(Err006);
            end;
            //BC UPGRADE KUMARR78 << FDD-MTC-007
        end;
        CheckPostedDoc();
        if PostedEntryExists then
            ERROR(Text80011);
        if "No. Printed" > 0 then
            MESSAGE(Text80010);
        MODIFY();
        //<<HEI:EDD001:1:1
    end;

    procedure Register();
    var
        RecGateEntryLine: Record "Gate Entry Line FND";
        PurchHdr: Record "Purchase Header";
        SalesHdr: Record "Sales Header";
        TransferHdr: Record "Transfer Header";
        WhseRecp: Record "Warehouse Receipt Header";
        WhseShip: Record "Warehouse Shipment Header";
    //   CNETInterfaceMgt: Codeunit "CNET Interface Mgt.";//BC Upgrade SHARMP16-- This no needs to be compiled out of scope.
    begin
        if CONFIRM(ConfirmMsg, true, "Gate Entry Document No.") then begin //HEI.04
            TESTFIELD(Blocked, false);//HEI.06
            RecGateEntryLine.RESET();
            RecGateEntryLine.SETRANGE("Gate Entry Document No.", "Gate Entry Document No.");
            if RecGateEntryLine.findset() then
                repeat
                    RecGateEntryLine.VALIDATE("Quantity on Departure");
                    RecGateEntryLine.MODIFY();
                until RecGateEntryLine.NEXT() = 0;
            //>>HEI:EDD001:1:1
            if Status <> Status::Released then
                ERROR(Err008);
            if "Date Out" = 0D then
                "Date Out" := WORKDATE();
            if "Time Out" = 000000T then
                "Time Out" := TIME;
            TESTFIELD("Date In");
            TESTFIELD("Time In");
            Location.GET("Location Code");
            if Location."Gate Weighing Mandatory FND" then begin
                TESTFIELD("Total Weight on Arrival");
                TESTFIELD("Total Weight on Departure");
            end;
            //CheckProductWiseDeviation;
            if "Gate Entry Type" = "Gate Entry Type"::Inbound then begin
                //HEI.01>>
                //IF ("Document Type" = "Document Type"::"Purchase Order") THEN BEGIN
                //PurchHdr.RESET;
                //PurchHdr.SETRANGE("Document Type",PurchHdr."Document Type"::Order);
                //PurchHdr.SETRANGE("No.","Document No.");
                //IF PurchHdr.FINDFIRST THEN BEGIN
                // PurchHdr."Gate Entry No. FND" := "Gate Entry Document No.";
                //PurchHdr.MODIFY;
                //Assigned := TRUE;
                //end;
                //end;

                //IF ("Document Type" = "Document Type"::"Transfer Order") THEN BEGIN
                //TransferHdr.RESET;
                //TransferHdr.SETRANGE("No.","Document No.");
                //IF TransferHdr.FINDFIRST THEN BEGIN
                //TransferHdr."From Gate Entry No." := "Gate Entry Document No.";
                //TransferHdr.MODIFY;
                //Assigned := TRUE;
                //end;
                //end;

                //IF ("Document Type" = "Document Type"::"Sales Return Order") THEN BEGIN
                //SalesHdr.RESET;
                //SalesHdr.SETRANGE("Document Type",SalesHdr."Document Type"::"Return Order");
                //SalesHdr.SETRANGE("No.","Document No.");
                //IF SalesHdr.FINDFIRST THEN BEGIN
                //SalesHdr."Gate Entry No. FND" := "Gate Entry Document No.";
                //SalesHdr.MODIFY;
                //Assigned := TRUE;
                //end;
                //end;
                //HEI.01<<

                if ("Document Type" = "Document Type"::"Warehouse Receipt") then begin
                    WhseRecp.RESET();
                    WhseRecp.SETRANGE("No.", "Document No.");
                    if WhseRecp.FINDFIRST() then begin
                        WhseRecp."Gate Entry No. FND" := "Gate Entry Document No.";
                        WhseRecp.MODIFY();
                        Assigned := true;
                    end;
                end;
                "Weight Difference" := ABS(("Total Weight on Arrival" - "Posted Weight Inbound") + ("Posted Weight Outbound" - "Total Weight on Departure"));
            end;

            if "Gate Entry Type" = "Gate Entry Type"::Outbound then begin
                //HEI.01>>
                //IF ("Document Type" = "Document Type"::"Sales Order") THEN BEGIN
                //SalesHdr.RESET;
                //SalesHdr.SETRANGE("Document Type",SalesHdr."Document Type"::Order);
                //SalesHdr.SETRANGE("No.","Document No.");
                //IF SalesHdr.FINDFIRST THEN BEGIN
                //SalesHdr."Gate Entry No. FND" := "Gate Entry Document No.";
                //SalesHdr.MODIFY;
                //Assigned := TRUE;
                //end;
                //end;

                //IF ("Document Type" = "Document Type"::"Transfer Order") THEN BEGIN
                //TransferHdr.RESET;
                //TransferHdr.SETRANGE("No.","Document No.");
                //IF TransferHdr.FINDFIRST THEN BEGIN
                //TransferHdr."To Gate Entry No. FND" := "Gate Entry Document No.";
                //TransferHdr.MODIFY;
                //Assigned := TRUE;
                //end;
                //end;

                //IF ("Document Type" = "Document Type"::"Purchase Return Order") THEN BEGIN
                //PurchHdr.RESET;
                //PurchHdr.SETRANGE("Document Type",PurchHdr."Document Type"::"Return Order");
                //PurchHdr.SETRANGE("No.","Document No.");
                //IF PurchHdr.FINDFIRST THEN BEGIN
                //PurchHdr."Gate Entry No. FND" := "Gate Entry Document No.";
                //PurchHdr.MODIFY;
                //Assigned := TRUE;
                //end;
                //end;
                //HEI.01<<

                if ("Document Type" = "Document Type"::"Warehouse Shipment") then begin
                    WhseShip.RESET();
                    WhseShip.SETRANGE("No.", "Document No.");
                    if WhseShip.FINDFIRST() then begin
                        WhseShip."Gate Entry No. FND" := "Gate Entry Document No.";
                        WhseShip.MODIFY();
                        Assigned := true;
                    end;
                end;
                "Weight Difference" := ABS(("Total Weight on Arrival" - "Posted Weight Inbound") +
                                        ("Posted Weight Outbound" - "Total Weight on Departure"));
            end;

            if "Gate Entry Type" = "Gate Entry Type"::Service then begin
                //HEI.01>>
                //IF "Document Type" = "Document Type"::"Purchase Order" THEN BEGIN
                //PurchHdr.RESET;
                //PurchHdr.SETRANGE("Document Type",PurchHdr."Document Type"::Order);
                //PurchHdr.SETRANGE("No.","Document No.");
                //IF PurchHdr.FINDFIRST THEN BEGIN
                //PurchHdr."Gate Entry No. FND" := "Gate Entry Document No.";
                //PurchHdr.MODIFY;
                //Assigned := TRUE;
                //end;
                //end;
                //HEI.01<<
            end;
            //BC UpgradeSHARMP16 begin>>-- Drink-IT code

            // if Truck.GET("Vehicle No.") then begin
            //     if Truck.Status = Truck.Status::"Gate Entry" then begin
            //         Truck.Status := Truck.Status::Open;
            //         Truck.MODIFY;
            //     end else
            //         ERROR(Err006);
            // end;
            //BC UpgradeSHARMP16 end<<-- Drink-IT code
            //BC UPGRADE KUMARR78 << FDD-MTC-007
            if Truck.GET("Vehicle No.") then begin
                if Truck."Status FND" = Truck."Status FND"::"Gate Entry" then begin
                    Truck."Status FND" := Truck."Status FND"::Open;
                    Truck.MODIFY;
                end else
                    ERROR(Err006);
            end;
            //BC UPGRADE KUMARR78 << FDD-MTC-007
            Registered := true;
            if MODIFY() then
                MESSAGE(RegisteredGateMsg, "Gate Entry Document No."); //HEI.04

            // CNETInterfaceMgt.RegisterGateEntry(Rec);//HEI.07//BC Upgrade SHARMP16-- This no needs to be compiled out of scope.
            //<<HEI:EDD001:1:1
        end; //HEI.04
    end;

    procedure Navigate();
    var
        NavigateForm: Page "Navigate Gate Entry";
    begin
        //>>HEI:EDD001:1:1
        if "Gate Entry Type" = "Gate Entry Type"::Inbound then
            NavigateForm.SetDoc("Date In", "Gate Entry Document No.")
        else
            NavigateForm.SetDoc("Date Out", "Gate Entry Document No.");
        NavigateForm.RUN();
        //<<HEI:EDD001:1:1
    end;

    procedure PrintDocument();
    begin
        //>>HEI:EDD001:1:1
        GateEntryHeader.SETRANGE("Gate Entry Document No.", "Gate Entry Document No.");
        // REPORT.RUN(50189, true, false, GateEntryHeader);//BC UPGRADE KUMARR78-- FDD-MTC-007
        REPORT.RUN(53004, true, false, GateEntryHeader);//BC UPGRADE KUMARR78 ++ FDD-MTC-007

        //<<HEI:EDD001:1:1
    end;

    procedure CheckTolerance(): Boolean;
    begin
        //>>HEI:EDD001:1:1
        WhseSetup.GET();
        //IF ABS("Weight Difference") > (("Posted Weight Inbound" + "Posted Weight Outbound") * WhseSetup."Gate Entry Weight Tolerance %" / 100) //HEI.04
        if "Total Weight on Departure" <> 0 then //HEI.04
            if ABS("Weight Difference") / "Total Weight on Departure" * 100 < WhseSetup."Gate Entry Weight Tole % FND" then //HEI.04
                exit(true)
            else
                exit(false)
        //<<HEI:EDD001:1:1
    end;

    procedure FillGateEntryBuffer();
    begin
        //>>HEI:EDD001:1:1
        TmpGateEntryBuff.DELETEALL();
        GateEntryLine.RESET();
        GateEntryLine.SETCURRENTKEY("Gate Entry Document No.", "Unit Of Measure Code");
        GateEntryLine.SETRANGE("Gate Entry Document No.", "Gate Entry Document No.");
        if GateEntryLine.FINDFIRST() then
            repeat
                //>>HEI:EDD151:1:1
                //IF NOT TmpGateEntryBuff.GET(GateEntryLine."Gate Entry Document No.",GateEntryLine."Unit Of Measure Code") THEN BEGIN
                if not TmpGateEntryBuff.GET(GateEntryLine."Gate Entry Document No.", GateEntryLine."Unit Of Measure Code",
                                            GateEntryLine."Location Code") then begin
                    //<<HEI:EDD151:1:1
                    TmpGateEntryBuff.INIT();
                    TmpGateEntryBuff."Gate Entry Document No." := GateEntryLine."Gate Entry Document No.";
                    TmpGateEntryBuff."Unit Of Measure Code" := GateEntryLine."Unit Of Measure Code";
                    //>>HEI:EDD151:1:1
                    TmpGateEntryBuff."Location Code" := GateEntryLine."Location Code";
                    //<<HEI:EDD151:1:1
                    TmpGateEntryBuff.INSERT();
                end;
            until GateEntryLine.NEXT() = 0;
        if TmpGateEntryBuff.FINDFIRST() then
            repeat
                TmpGateEntryBuff.CALCFIELDS("Quantity on Arrival", "Quantity on Departure", "Posted Quantity Inbound", "Posted Quantity Outbound");
                TmpGateEntryBuff."Net Change 1" := TmpGateEntryBuff."Quantity on Arrival" - TmpGateEntryBuff."Quantity on Departure";
                TmpGateEntryBuff."Net Change 2" := TmpGateEntryBuff."Posted Quantity Inbound" - TmpGateEntryBuff."Posted Quantity Outbound";
                TmpGateEntryBuff.Deviation := TmpGateEntryBuff."Net Change 1" - TmpGateEntryBuff."Net Change 2";
                TmpGateEntryBuff.MODIFY();
            until TmpGateEntryBuff.NEXT() = 0;
        PAGE.RUNMODAL(PAGE::"Gate Entry Statistics", TmpGateEntryBuff);
        //<<HEI:EDD001:1:1
    end;

    procedure CheckPostedDoc();
    var
        PurchReceipt: Record "Purch. Rcpt. Header";
        SalesShipment: Record "Sales Shipment Header";
        TransferReceipt: Record "Transfer Receipt Header";
        TransferShipment: Record "Transfer Shipment Header";
    begin
        PostedEntryExists := false;
        TransferShipment.RESET();
        TransferShipment.SETCURRENTKEY("From Gate Entry No. FND");
        TransferShipment.SETRANGE("From Gate Entry No. FND", "Gate Entry Document No.");
        if TransferShipment.FINDFIRST() then
            PostedEntryExists := true;

        if PostedEntryExists = false then begin
            TransferReceipt.RESET();
            TransferReceipt.SETCURRENTKEY("To Gate Entry No. FND");
            TransferReceipt.SETRANGE("To Gate Entry No. FND", "Gate Entry Document No.");
            if TransferReceipt.FINDFIRST() then
                PostedEntryExists := true;
        end;
        if PostedEntryExists = false then begin
            PurchReceipt.RESET();
            PurchReceipt.SETCURRENTKEY("Gate Entry No. FND");
            PurchReceipt.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
            if PurchReceipt.FINDFIRST() then
                PostedEntryExists := true;
        end;

        if PostedEntryExists = false then begin
            SalesShipment.RESET();
            SalesShipment.SETCURRENTKEY("Gate Entry No. FND");
            SalesShipment.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
            if SalesShipment.FINDFIRST() then
                PostedEntryExists := true;
        end;
    end;

    local procedure SetDefaultLocationZone();
    var
        // WhseEmployee: Record "Warehouse Employee";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
        WhseEmployee: Record "Warehouse Employee_DTW FND";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
    begin
        if USERID <> '' then begin
            WhseEmployee.SETCURRENTKEY(Default);
            WhseEmployee.SETRANGE(Default, true);
            WhseEmployee.SETRANGE("User ID", USERID);
            if not WhseEmployee.FIND('-') then
                ERROR(Text80012, USERID);
            DefaultLocation := WhseEmployee."Location Code"; //HEI.03
            DefaultZone := WhseEmployee."Zone Code"; //HEI.03
        end;
    end;

    local procedure LocationIsAllowed(LocationCode: Code[10]): Boolean;
    var
        // WhseEmployee: Record "Warehouse Employee";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
        WhseEmployee: Record "Warehouse Employee_DTW FND";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
    begin
        //HEI.03>>
        WhseEmployee.SETRANGE("User ID", USERID);
        WhseEmployee.SETRANGE("Location Code", LocationCode);
        if WhseEmployee.FINDFIRST() or
        //HEI.03<<
           (USERID = '')
        then
            exit(true)
        else
            exit(false);
    end;

    local procedure ZoneIsAllowed(ZoneCode: Code[10]): Boolean;
    var
        // WhseEmployee: Record "Warehouse Employee";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
        WhseEmployee: Record "Warehouse Employee_DTW FND";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
    begin
        //HEI.03>>
        WhseEmployee.SETRANGE("User ID", USERID);
        WhseEmployee.SETRANGE("Zone Code", ZoneCode);
        if WhseEmployee.FINDFIRST() or
           (USERID = '')
        then
            exit(true)
        else
            exit(false);
        //HEI.03<<
    end;

    procedure CheckProductWiseDeviation();
    begin
        //>>HEI:EDD001:1:1
        UserSetup.GET(USERID);
        if UserSetup."Allow Gate Entry Register FND" = false then begin
            GateEntryLine.RESET();
            GateEntryLine.SETCURRENTKEY("Gate Entry Document No.", "Unit Of Measure Code");
            GateEntryLine.SETRANGE("Gate Entry Document No.", "Gate Entry Document No.");
            if GateEntryLine.FINDFIRST() then
                repeat
                    if (GateEntryLine."Quantity on Arrival" - GateEntryLine."Quantity on Departure") -
                       (GateEntryLine."Posted Quantity Inbound" - GateEntryLine."Posted Quantity Outbound") <> 0 then
                        ERROR(Text80014, GateEntryLine."Gate Entry Document No.", GateEntryLine."No.");
                until GateEntryLine.NEXT() = 0;
        end else
            TESTFIELD(Remarks);
        //<<HEI:EDD001:1:1
    end;

    procedure InsertPostedWeight();
    begin
        //HEI.04>>
        if ("Posted Weight Inbound" = 0) or ("Posted Weight Inbound" <> xRec."Posted Weight Inbound") then begin
            "Posted Weight Inbound" := 0;
            PurchRcptHeader.RESET();
            PurchRcptHeader.SETCURRENTKEY("Gate Entry No. FND");
            PurchRcptHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
            if PurchRcptHeader.FINDFIRST() then
                repeat
                    PurchRcptLine.RESET();
                    PurchRcptLine.SETCURRENTKEY("Document No.", Type);
                    PurchRcptLine.SETRANGE("Document No.", PurchRcptHeader."No.");
                    PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
                    PurchRcptLine.SETFILTER(Quantity, '<>%1', 0);
                    if PurchRcptLine.findset() then
                        repeat
                            //  "Posted Weight Inbound" += PurchRcptLine.Weight;//BC upgrade SHARMP16-- Drink-IT field
                            "Posted Weight Inbound" += PurchRcptLine."Gross Weight 1 101FDW";//BC UPGRADE KUMARR78 ++

                        until PurchRcptLine.NEXT() = 0;
                until PurchRcptHeader.NEXT() = 0;

            ReturnRcptHeader.RESET();
            ReturnRcptHeader.SETCURRENTKEY("Gate Entry No. FND");
            ReturnRcptHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
            if ReturnRcptHeader.FINDFIRST() then
                repeat
                    ReturnRcptLine.RESET();
                    ReturnRcptLine.SETCURRENTKEY("Document No.", Type);
                    ReturnRcptLine.SETRANGE("Document No.", ReturnRcptHeader."No.");
                    ReturnRcptLine.SETRANGE(Type, ReturnRcptLine.Type::Item);
                    ReturnRcptLine.SETFILTER(Quantity, '<>%1', 0);
                    if ReturnRcptLine.findset() then
                        repeat
                            //   "Posted Weight Inbound" += ReturnRcptLine.Weight;//BC upgrade SHARMP16-- Drink-IT field
                            "Posted Weight Inbound" += ReturnRcptLine."Gross Weight 1 101FDW";//BC UPGRADE KUMARR78 ++

                        until ReturnRcptLine.NEXT() = 0;
                until ReturnRcptHeader.NEXT() = 0;

            TransRcptHeader.RESET();
            TransRcptHeader.SETCURRENTKEY("To Gate Entry No. FND");
            TransRcptHeader.SETRANGE("To Gate Entry No. FND", "Gate Entry Document No.");
            if TransRcptHeader.FINDFIRST() then
                repeat
                    TransRcptLine.RESET();
                    TransRcptLine.SETCURRENTKEY("Document No.");
                    TransRcptLine.SETRANGE("Document No.", TransRcptHeader."No.");
                    TransRcptLine.SETFILTER(Quantity, '<>%1', 0);
                    if TransRcptLine.findset() then
                        repeat
                            "Posted Weight Inbound" += TransRcptLine."Gross Weight";
                        until TransRcptLine.NEXT() = 0;
                until TransRcptHeader.NEXT() = 0;
        end;

        if ("Posted Weight Outbound" = 0) or ("Posted Weight Outbound" <> xRec."Posted Weight Outbound") then begin
            "Posted Weight Outbound" := 0;
            SalesShipmentHeader.RESET();
            SalesShipmentHeader.SETCURRENTKEY("Gate Entry No. FND");
            SalesShipmentHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
            if SalesShipmentHeader.FINDFIRST() then
                repeat
                    SalesShipmentLine.RESET();
                    SalesShipmentLine.SETCURRENTKEY("Document No.", Type);
                    SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
                    SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
                    SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);
                    if SalesShipmentLine.findset() then
                        repeat
                            //  "Posted Weight Outbound" += SalesShipmentLine.Weight;//BC upgrade SHARMP16-- Drink-IT field
                            "Posted Weight Outbound" += SalesShipmentLine."Gross Weight 1 101FDW";//BC UPGRADE KUMARR78 ++

                        until SalesShipmentLine.NEXT() = 0;
                until SalesShipmentHeader.NEXT() = 0;

            ReturnShptHeader.RESET();
            ReturnShptHeader.SETCURRENTKEY("Gate Entry No. FND");
            ReturnShptHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
            if ReturnShptHeader.FINDFIRST() then
                repeat
                    ReturnShptLine.RESET();
                    ReturnShptLine.SETCURRENTKEY("Document No.", Type);
                    ReturnShptLine.SETRANGE("Document No.", ReturnShptHeader."No.");
                    ReturnShptLine.SETRANGE(Type, ReturnShptLine.Type::Item);
                    ReturnShptLine.SETFILTER(Quantity, '<>%1', 0);
                    if ReturnShptLine.findset() then
                        repeat
                            // "Posted Weight Outbound" += ReturnShptLine.Weight;//BC upgrade SHARMP16-- Drink-IT field //BC UPGRADE KUMARR78 ++
                            "Posted Weight Outbound" += ReturnShptLine."Gross Weight 1 101FDW";//BC UPGRADE KUMARR78 ++

                        until ReturnShptLine.NEXT() = 0;
                until ReturnShptHeader.NEXT() = 0;

            TransShptHeader.RESET();
            TransShptHeader.SETCURRENTKEY("From Gate Entry No. FND");
            TransShptHeader.SETRANGE("From Gate Entry No. FND", "Gate Entry Document No.");
            if TransShptHeader.FINDFIRST() then
                repeat
                    TransShptLine.RESET();
                    TransShptLine.SETCURRENTKEY("Document No.");
                    TransShptLine.SETRANGE("Document No.", TransShptHeader."No.");
                    TransShptLine.SETFILTER(Quantity, '<>%1', 0);
                    if TransShptLine.findset() then
                        repeat
                            "Posted Weight Outbound" += TransShptLine."Gross Weight";
                        until TransShptLine.NEXT() = 0;
                until TransShptHeader.NEXT() = 0;
        end;

        "Weight Difference" := ("Total Weight on Arrival" - "Posted Weight Inbound") +
                               ("Posted Weight Outbound" - "Total Weight on Departure");

        //HEI.04<<
    end;
}

