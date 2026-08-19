page 50483 "RPM - SKU Relationship Archive"
{
    // version HEI.04

    // HEI.01 CHG2141694 IBM BULIMC01 13/04/2022#new page created
    // HEI.02 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //   #sync with original page P50451
    // HEI.03 CHG2169207 IBM SISUM01 15/08/2022#new fields added (the fields from T 50234 marked with HEI.05)
    // HEI.04 CHG2167931 IBM SISUM01 19/11/2022 #add new fields (the fields from T 50234 marked with HEI.06)

    Caption = 'RPM - SKU Relationships Archive';
    Editable = false;
    PageType = List;
    SourceTable = "RPM-SKU Relationship Arch FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Start Date"; rec."Period Start Date")
                {
                    ToolTip = 'Specifies the value of the Period Start Date field.';
                }
                field("Period End Date"; rec."Period End Date")
                {
                    ToolTip = 'Specifies the value of the Period End Date field.';
                }
                field("RPM Item No."; rec."RPM Item No.")
                {
                    ToolTip = 'Specifies the value of the RPM Item No. field.';
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Customer No."; rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Linked Item No."; rec."Linked Item No.")
                {
                    ToolTip = 'Specifies the value of the Linked Item No. field.';
                }
                field("Own Fleet"; rec."Own Fleet")
                {
                    ToolTip = 'Specifies the value of the Own Fleet field.';
                }
                field("Period Alloc. Amount Customer"; rec."Period Alloc. Amount Customer")
                {
                    ToolTip = 'Specifies the value of the Period Primary Allocated Amount Customer field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(RPMTransportsPage);

                        ShipCostAllocation.RESET();
                        //ShipCostAllocation.SETCURRENTKEY("Posting Date","Source Document","Only RPM Transportation","Item No.","Destination No."); //HEI.03 commented
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Destination No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Destination No.", rec."Customer No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total); //HEI.02

                        RPMTransportsPage.SETTABLEVIEW(ShipCostAllocation);
                        RPMTransportsPage.LOOKUPMODE(true);
                        if RPMTransportsPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Primary Alloc. Amount Customer"; rec."Primary Alloc. Amount Customer")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Primary Period Primary Allocated Amount Customer field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(RPMTransportsPage);

                        ShipCostAllocation.RESET();
                        //ShipCostAllocation.SETCURRENTKEY("Posting Date","Source Document","Only RPM Transportation","Item No.","Destination No.");//HEI.03 commented
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Destination No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Destination No.", rec."Customer No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Primary); //HEI.02

                        RPMTransportsPage.SETTABLEVIEW(ShipCostAllocation);
                        RPMTransportsPage.LOOKUPMODE(true);
                        if RPMTransportsPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Second. Alloc. Amount Customer"; rec."Second. Alloc. Amount Customer")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Secondary Period Primary Allocated Amount Customer field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(RPMTransportsPage);

                        ShipCostAllocation.RESET();
                        //ShipCostAllocation.SETCURRENTKEY("Posting Date","Source Document","Only RPM Transportation","Item No.","Destination No."); //HEI.03 commented
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Destination No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Destination No.", rec."Customer No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Secondary); //HEI.02

                        RPMTransportsPage.SETTABLEVIEW(ShipCostAllocation);
                        RPMTransportsPage.LOOKUPMODE(true);
                        if RPMTransportsPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Period Net Weight Customer"; rec."Period Net Weight Customer")
                {
                    ToolTip = 'Specifies the value of the Period Net Weight (Kg)-Linked Item No. & Customer No. field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(DeliverytoCustPage);

                        ShipCostAllocation.RESET();
                        //ShipCostAllocation.SETCURRENTKEY("Posting Date","Source Document","Only RPM Transportation","Item No.","Destination No."); //HEI.03 commented
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Destination No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."Linked Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Destination No.", rec."Customer No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total); //HEI.02

                        DeliverytoCustPage.SETTABLEVIEW(ShipCostAllocation);
                        DeliverytoCustPage.LOOKUPMODE(true);
                        if DeliverytoCustPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Period Picking Factor Cust."; rec."Period Picking Factor Cust.")
                {
                    ToolTip = 'Specifies the value of the Period Picking Factor Linked Item No. & Customer No. field.';

                    trigger OnDrillDown();
                    begin
                        //HEI.03
                        CLEAR(DeliverytoCustPage);

                        ShipCostAllocation.RESET();
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Destination No.", ShipCostAllocation."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Destination No.", rec."Customer No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."Linked Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total);

                        DeliverytoCustPage.SETTABLEVIEW(ShipCostAllocation);
                        DeliverytoCustPage.LOOKUPMODE(true);
                        if DeliverytoCustPage.RUNMODAL() = ACTION::LookupOK then;
                        //HEI.03
                    end;
                }
                field("Period RPM Unit Cost Customer"; rec."Period RPM Unit Cost Customer")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Formula: Period Primary Allocated Amount Customer / Period Net Weight (Kg)-Linked Item No. & Customer No.';
                }
                field("Primary RPM Unit Cost Customer"; rec."Primary RPM Unit Cost Customer")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Formula: Period Primary Allocated Amount Customer / Period Net Weight (Kg)-Linked Item No. & Customer No.';
                    Visible = false;
                }
                field("Second. RPM Unit Cost Customer"; rec."Second. RPM Unit Cost Customer")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"Formula: Period Secondary Allocated Amount Customer / Period Net Weight (Kg)-Linked Item No. & Customer No. "';
                    Visible = false;
                }
                field("Period Alloc. Amount Transfer"; rec."Period Alloc. Amount Transfer")
                {
                    ToolTip = 'Specifies the value of the Period Primary Allocated Amount Internal Transfers field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(InternalTransferAllocPage);

                        ShipCostAllocation.RESET();
                        //ShipCostAllocation.SETCURRENTKEY("Posting Date","Source Document","Only RPM Transportation","Item No.","Destination No."); //HEI.03 commented
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Only RPM Transportation", true);
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total); //HEI.02

                        InternalTransferAllocPage.SETTABLEVIEW(ShipCostAllocation);
                        InternalTransferAllocPage.LOOKUPMODE(true);
                        if InternalTransferAllocPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Primary Alloc. Amount Transfer"; rec."Primary Alloc. Amount Transfer")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Primary Period Primary Allocated Amount Internal Transfers field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(InternalTransferAllocPage);

                        ShipCostAllocation.RESET();
                        //ShipCostAllocation.SETCURRENTKEY("Posting Date","Source Document","Only RPM Transportation","Item No.","Destination No."); //HEI.03 commented
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Only RPM Transportation", true);
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Primary); //HEI.02

                        InternalTransferAllocPage.SETTABLEVIEW(ShipCostAllocation);
                        InternalTransferAllocPage.LOOKUPMODE(true);
                        if InternalTransferAllocPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Second. Alloc. Amount Transfer"; rec."Second. Alloc. Amount Transfer")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Secondary Period Primary Allocated Amount Internal Transfers field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(InternalTransferAllocPage);

                        ShipCostAllocation.RESET();
                        //ShipCostAllocation.SETCURRENTKEY("Posting Date","Source Document","Only RPM Transportation","Item No.","Destination No."); //HEI.03 commented
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Only RPM Transportation", true);
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Secondary); //HEI.02

                        InternalTransferAllocPage.SETTABLEVIEW(ShipCostAllocation);
                        InternalTransferAllocPage.LOOKUPMODE(true);
                        if InternalTransferAllocPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Period Net Weight Linked Item"; rec."Period Net Weight Linked Item")
                {
                    ToolTip = 'Specifies the value of the Period Net Weight (Kg)-Linked Item No. field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(DeliverytoCustPage);

                        ShipCostAllocation.RESET();
                        //ShipCostAllocation.SETCURRENTKEY("Posting Date","Source Document","Only RPM Transportation","Item No.","Destination No."); //HEI.03 commented
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."Linked Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total); //HEI.02

                        DeliverytoCustPage.SETTABLEVIEW(ShipCostAllocation);
                        DeliverytoCustPage.LOOKUPMODE(true);
                        if DeliverytoCustPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Period Pick. Fact. Linked Item"; rec."Period Pick. Fact. Linked Item")
                {
                    ToolTip = 'Specifies the value of the Period Picking Factor Linked Item No. field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(DeliverytoCustPage);

                        ShipCostAllocation.RESET();
                        //ShipCostAllocation.SETCURRENTKEY("Posting Date","Source Document","Only RPM Transportation","Item No.","Destination No."); //HEI.03 commented
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."Linked Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total); //HEI.02

                        DeliverytoCustPage.SETTABLEVIEW(ShipCostAllocation);
                        DeliverytoCustPage.LOOKUPMODE(true);
                        if DeliverytoCustPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Period RPM Unit Cost Transfer"; rec."Period RPM Unit Cost Transfer")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"Formula: Period Primary Allocated Amount Internal Transfer / Period Net Weight (Kg)-Linked Item No. "';
                }
                field("Primary RPM Unit Cost Transfer"; rec."Primary RPM Unit Cost Transfer")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"Formula: Period Primary Allocated Amount Internal Transfer / Period Net Weight (Kg)-Linked Item No. "';
                    Visible = false;
                }
                field("Second. RPM Unit Cost Transfer"; rec."Second. RPM Unit Cost Transfer")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Formula: Period Secondary Allocated Amount Internal Transfer / Period Net Weight (Kg)-Linked Item No.';
                    Visible = false;
                }
                field("Period Gen. Overheads Cust."; rec."Period Gen. Overheads Cust.")
                {
                    ToolTip = 'Specifies the value of the Period General Overheads RPM & Customer field.';

                    trigger OnDrillDown();
                    begin
                        //HEI.03<<
                        CLEAR(RPMTransportsPage);

                        ShipCostAllocation.RESET();
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Destination No.", ShipCostAllocation."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Destination No.", rec."Customer No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total);

                        RPMTransportsPage.SETTABLEVIEW(ShipCostAllocation);
                        RPMTransportsPage.LOOKUPMODE(true);
                        if RPMTransportsPage.RUNMODAL() = ACTION::LookupOK then;
                        //HEI.03>>
                    end;
                }
                field("Period Whse. Overheads Cust."; rec."Period Whse. Overheads Cust.")
                {
                    ToolTip = 'Specifies the value of the Period Warehouse Overheads RPM & Customer field.';

                    trigger OnDrillDown();
                    begin
                        //HEI.03<<
                        CLEAR(RPMTransportsPage);

                        ShipCostAllocation.RESET();
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Destination No.", ShipCostAllocation."Own Fleet"); //HEI.03
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Destination No.", rec."Customer No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total);

                        RPMTransportsPage.SETTABLEVIEW(ShipCostAllocation);
                        RPMTransportsPage.LOOKUPMODE(true);
                        if RPMTransportsPage.RUNMODAL() = ACTION::LookupOK then;
                        //HEI.03<<
                    end;
                }
                field("Period Whse. Handling Cust."; rec."Period Whse. Handling Cust.")
                {
                    ToolTip = 'Specifies the value of the Period Warehouse Handling RPM & Customer field.';

                    trigger OnDrillDown();
                    begin
                        //HEI.03<<
                        CLEAR(RPMTransportsPage);

                        ShipCostAllocation.RESET();
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Destination No.", ShipCostAllocation."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Destination No.", rec."Customer No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total);

                        RPMTransportsPage.SETTABLEVIEW(ShipCostAllocation);
                        RPMTransportsPage.LOOKUPMODE(true);
                        if RPMTransportsPage.RUNMODAL() = ACTION::LookupOK then;
                        //HEI.03<<
                    end;
                }
                field("Period RPM Gen. Overh. Cust."; rec."Period RPM Gen. Overh. Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Period General Overheads RPM & Customer"" / ""Period Net Weight (Kg)-Linked Item No. & Customer No."""';
                }
                field("Period RPM Whse. Overh. Cust."; rec."Period RPM Whse. Overh. Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Period Warehouse Overheads RPM & Customer"" / ""Period Net Weight (Kg)-Linked Item No. & Customer No.""  "';
                }
                field("Period RPM Whse. Handl. Cust."; rec."Period RPM Whse. Handl. Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Period Warehouse Handling RPM & Customer"" / ""Period Picking Factor Linked Item No. & Customer No.""  "';
                }
                field("Period Gen. Overheads IT"; rec."Period Gen. Overheads IT")
                {
                    ToolTip = 'Specifies the value of the Period General Overheads RPM Internal Transfers field.';

                    trigger OnDrillDown();
                    begin
                        //HEI.03<<
                        CLEAR(InternalTransferAllocPage);

                        ShipCostAllocation.RESET();
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Only RPM Transportation", true);
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total);

                        InternalTransferAllocPage.SETTABLEVIEW(ShipCostAllocation);
                        InternalTransferAllocPage.LOOKUPMODE(true);
                        if InternalTransferAllocPage.RUNMODAL() = ACTION::LookupOK then;
                        //HEI.03<<
                    end;
                }
                field("Period Whse. Overheads IT"; rec."Period Whse. Overheads IT")
                {
                    ToolTip = 'Specifies the value of the Period Warehouse Overheads RPM Internal Transfers field.';

                    trigger OnDrillDown();
                    begin
                        //HEI.03<<
                        CLEAR(InternalTransferAllocPage);

                        ShipCostAllocation.RESET();
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Own Fleet");

                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Only RPM Transportation", true);
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total);

                        InternalTransferAllocPage.SETTABLEVIEW(ShipCostAllocation);
                        InternalTransferAllocPage.LOOKUPMODE(true);
                        if InternalTransferAllocPage.RUNMODAL() = ACTION::LookupOK then;
                        //HEI.03<<
                    end;
                }
                field("Period Whse. Handling IT"; rec."Period Whse. Handling IT")
                {
                    ToolTip = 'Specifies the value of the Period Warehouse Handling RPM Internal Transfers field.';

                    trigger OnDrillDown();
                    begin
                        //HEI.03<<
                        CLEAR(InternalTransferAllocPage);

                        ShipCostAllocation.RESET();
                        ShipCostAllocation.SETCURRENTKEY(ShipCostAllocation."Period Date", ShipCostAllocation."Item No.", ShipCostAllocation."Destination No.", ShipCostAllocation."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Period Date", rec."Period Date");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Item No.", rec."RPM Item No.");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Own Fleet", rec."Own Fleet");
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Only RPM Transportation", true);
                        ShipCostAllocation.SETRANGE(ShipCostAllocation."Distribution Type", ShipCostAllocation."Distribution Type"::Total);

                        InternalTransferAllocPage.SETTABLEVIEW(ShipCostAllocation);
                        InternalTransferAllocPage.LOOKUPMODE(true);
                        if InternalTransferAllocPage.RUNMODAL() = ACTION::LookupOK then;
                        //HEI.03<<
                    end;
                }
                field("Period RPM Gen. Overh. IT"; rec."Period RPM Gen. Overh. IT")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Period General Overheads RPM Internal Transfers"" / ""Period Net Weight (Kg)-Linked Item No.""  "';
                }
                field("Period RPM Whse. Overh. IT"; rec."Period RPM Whse. Overh. IT")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Period Warehouse Overheads RPM Internal Transfers"" / ""Period Net Weight (Kg)-Linked Item No.""  "';
                }
                field("Period RPM Whse. Handl. IT"; rec."Period RPM Whse. Handl. IT")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Period Warehouse Handling RPM Internal Transfers"" / ""Period Picking Factor Linked Item No."" "';
                }
                field("Period Net Weight Sold Cust."; rec."Period Net Weight Sold Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Sum of the field Period Net Weight (Kg)-Linked Item No. & Customer No. for the couple RPM Item No. & Customer No. for the allocated period';
                }
                field("RPM Unit Cost Sold Cust."; rec."RPM Unit Cost Sold Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Period Primary Allocated Amount Customer / Period Net Weight sold per RPM & Customer No (for the couple RPM Item No. & Customer No. for the allocated period)';
                }
                field("Period Net Weight Transf."; rec."Period Net Weight Transf.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'The sum of the field Period Net Weight (Kg)-Linked Item No. for the field RPM Item No. for the allocated period';
                }
                field("RPM Unit Cost Transferred"; rec."RPM Unit Cost Transferred")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Period Primary Allocated Amount Internal Transfers / Period Net Weight transferred per RPM';
                }
                field("Period Pick. Factor Sold Cust."; rec."Period Pick. Factor Sold Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'The sum of the field Period Picking Factor-Linked Item No. & Customer No. for the couple RPM Item No. & Customer No. for the allocated period';
                }
                field("RPM Whse. Hand Unit Cost Cust."; rec."RPM Whse. Hand Unit Cost Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'the unit cost of the rpm returned based on the finished goods net weight delivered for a specific customer.Formula: Period Warehouse Handling RPM & Customer combination / Period Picking Factor sold per RPM & Customer No';
                }
                field("Period Pick. Factor Transf."; rec."Period Pick. Factor Transf.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'The sum of the field Period Picking Factor-Linked Item No. for the field RPM Item No. for the allocated period';
                }
                field("RPM Whse. Hand Unit Cost T."; rec."RPM Whse. Hand Unit Cost T.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'The unit cost of the RPM transferred internally based on the finished goods net weight delivered. Formula: Period Warehouse Handling RPM Internal Transfers / Period Picking Factor transferred per RPM';
                }
                field("RPM Gen. Over. Unit Cost Cust."; rec."RPM Gen. Over. Unit Cost Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Formula: Period General Overheads RPM & Customer combination / Period Net Weight sold per RPM & Customer No (for the couple RPM Item No. & Customer No. for the allocated period)';
                }
                field("RPM Gen. Over. Unit Cost T"; rec."RPM Gen. Over. Unit Cost T")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Formula: Period General Overheads RPM Internal Transfers / Period Net Weight transferred per RPM';
                }
                field("RPM Whse. Over. Unit Cost Cust"; rec."RPM Whse. Over. Unit Cost Cust")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Formula: Period Warehouse Overheads RPM & Customer combination / Period Net Weight sold per RPM & Customer No (for the couple RPM Item No. & Customer No. for the allocated period)';
                }
                field("RPM Whse. Over. Unit Cost T"; rec."RPM Whse. Over. Unit Cost T")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Formula: Period Warehouse Overheads RPM Internal Transfers / Period Net Weight transferred per RPM';
                }
                field("Processing Date"; rec."Processing Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Processing Date field.';
                }
                field("OVE Prd. RPM Whse. Handl. Cust"; rec."OVE Prd. RPM Whse. Handl. Cust")
                {
                    ToolTip = 'Specifies the value of the OVE Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No. field.';
                }
                field("TRP Prd. RPM Whse. Handl. Cust"; rec."TRP Prd. RPM Whse. Handl. Cust")
                {
                    ToolTip = 'Specifies the value of the TRP Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No. field.';
                }
                field("FIX Prd. RPM Whse. Handl. Cust"; rec."FIX Prd. RPM Whse. Handl. Cust")
                {
                    ToolTip = 'Specifies the value of the FIX Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No. field.';
                }
                field("OVE Prd. RPM Whse. Handl. IT"; rec."OVE Prd. RPM Whse. Handl. IT")
                {
                    ToolTip = 'Specifies the value of the OVE Period RPM Whse Handling Unit Cost per Linked Item No._Internal TransfersWhse. Hand. ST Trans. Exp. field.';
                }
                field("TRP Prd. RPM Whse. Handl. IT"; rec."TRP Prd. RPM Whse. Handl. IT")
                {
                    ToolTip = 'Specifies the value of the TRP Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers field.';
                }
                field("FIX Prd. RPM Whse. Handl. IT"; rec."FIX Prd. RPM Whse. Handl. IT")
                {
                    ToolTip = 'Specifies the value of the FIX Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers field.';
                }
                field("OVE RPM Whs H Unit Cost Cust"; rec."OVE RPM Whs H Unit Cost Cust")
                {
                    ToolTip = 'Specifies the value of the OVE RPM Whse Handling Unit Cost Sold by RPM & Customer No field.';
                }
                field("TRP RPM Whs H Unit Cost Cust"; rec."TRP RPM Whs H Unit Cost Cust")
                {
                    ToolTip = 'Specifies the value of the TRP RPM Whse Handling Unit Cost Sold by RPM & Customer No field.';
                }
                field("FIX RPM Whs H Unit Cost Cust"; rec."FIX RPM Whs H Unit Cost Cust")
                {
                    ToolTip = 'Specifies the value of the FIX RPM Whse Handling Unit Cost Sold by RPM & Customer No field.';
                }
                field("OVE Prd Whse. Handling Cust."; rec."OVE Prd Whse. Handling Cust.")
                {
                    ToolTip = 'Specifies the value of the OVE Period Warehouse Handling RPM & Customer field.';
                }
                field("TRP Prd Whse. Handling Cust."; rec."TRP Prd Whse. Handling Cust.")
                {
                    ToolTip = 'Specifies the value of the TRP Period Warehouse Handling RPM & Customer field.';
                }
                field("FIX Prd Whse. Handling Cust."; rec."FIX Prd Whse. Handling Cust.")
                {
                    ToolTip = 'Specifies the value of the FIX Period Warehouse Handling RPM & Customer field.';
                }
                field("OVE Period Whse. Handling IT"; rec."OVE Period Whse. Handling IT")
                {
                    ToolTip = 'Specifies the value of the OVE Period Warehouse Handling RPM Internal Transfers field.';
                }
                field("TRP Period Whse. Handling IT"; rec."TRP Period Whse. Handling IT")
                {
                    ToolTip = 'Specifies the value of the TRP Period Warehouse Handling RPM Internal Transfers field.';
                }
                field("FIX Period Whse. Handling IT"; rec."FIX Period Whse. Handling IT")
                {
                    ToolTip = 'Specifies the value of the FIX Period Warehouse Handling RPM Internal Transfers field.';
                }
            }
        }
    }

    actions
    {
    }

    var
        ShipCostAllocation: Record "Shipping Cost Archive FND";
        DeliverytoCustPage: Page "Delivery to Customers Archive";
        InternalTransferAllocPage: Page "Internal Transfers Archive";
        RPMTransportsPage: Page "RPM Transports Archive";
}

