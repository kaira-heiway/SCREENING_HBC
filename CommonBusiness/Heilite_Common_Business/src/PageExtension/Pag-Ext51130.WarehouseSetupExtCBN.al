pageextension 51130 WarehouseSetupExtCBN extends "Warehouse Setup"
{   // In Heilite warehouse Setup page is renamed to Warehouse Mgt. Setup
    // version NAVW110.0
    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Field added: Request Order Nos.
    //   # Field "Request Order Nos." is visible just when "Enable Request Order" is ticked on OpCo Setup
    // HEI.02 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Fields added: "Gate Entry Nos.", "Gate Entry Weight Tolerance %", "Allow Collect Lines", "Auto Insert Qty. Collected Lin"
    // HEI.03 FDD-BA-LOGGAP03 IBM NASTAA02 01.10.2018 # Sales Invoice Layout
    //   # New Field added: Shortcut Unit of Measure2 Filter
    // HEI.04 FDD-RW-GAPLOG10 IBM ISYED01 30-10-2018 RPM Breakages
    //   #added new filed "Customer diff RPM mandatory"
    // HEI.05 Defect#3416 IBM NASTAA02 07.11.2018 # Sales Invoice Layout - Cosmetic adjustments
    //   # New Field added: "Shortcut Unit of Measure4 Code"
    // HEI.06 FDD-HT658 IBM.GUNERE01 29.08.2019 # "Copy Distance" field added
    // HEI.07 FDD-HT658 IBM.GUNERE01 28.10.2019 # "Doc. Shipping Cost Creation" field added
    // HEI.08 FDD-HT1075 CHG2039144 IBM.GUNERE01 13.01.2020 # Ask Ship. Info on Second Rcpt. added on General tab
    // HEI.09 FDD-HB503 IBM NASTAA02 30.01.2019 # Post & Print
    //   # Hidden Field "Print Delivery Note"
    // HEI.10 FDD-HB503 IBM NASTAA02 31.03.2020 # Post & Print
    //   # New Field added: "Enable Post and Print based on Location"
    // HEI.11 CHG2095415 IBM BULIMC01 22.03.2021# new tab created for Cost to serve
    // HEI.12 CHG2141694 BULIMC01 IBM 21/02/2021#new fields added to C2S tab
    // HEI.13 CHG2135085 SAHAL01      24.03.2022
    //   # Added New Tab - Standard Production Cost
    //   # Added New Fields - COGS JobQ Run Pre-Close Date
    //                      - COGS JobQ Run Close Date
    // HEI.14 IBM CHG2132673 BULIMC01 13/04/2022 #C2S Allocation
    //   #new fields added to "C2S allocation" tab: "SCOA Financial Statement Version","SCOA Financial State Opt."
    //   #new action group created: "C2S SCOA Financial Statement"
    // HEI.15 INC4122240 - CHG2159877 IBM NASTAA02 27/05/2022 # Please stop sending C2S allocation for previous periods to archived table
    //   # New Field added: "C2S COGS Job Queue Cat Code"
    // HEI.16 CHG2162842 IBM SAMANR01 20/06/202022 #C2S optimazation & archiving
    //   # New field added: "Archive JQ Date Calculation"    
    // HEI.18 CHG2253923 IBM POENAB02 21.11.2024 HB3943 Stock in transit - enablement of updating standard cost
    //   # New group added - "Transfer Receipt Logs"
    //   # New fields added in "Transfer Receipt Logs" group:
    //     50036 "StockInTransLogRetention(Days)"
    //     50037 "Enable Stock in Trans. Funct"
    // HEI.19 CHG2278211 IBM PATHAA02 16/12/2024 Deletion of Obsolete Heilite TOs
    //   # New Field:50358 "Transfer Order Shipping Date"
    // HEI.20 CHG2278211 IBM KAMNAY01 18/12/2024 Deletion of Obsolete Heilite TOs
    //   # New Field:50359 "Exclude Location Filter"
    //********************************************************************
    //BC UPGRADE PATHAA02 03.11.25
    //// In Heilite warehouse Setup page is renamed to Warehouse Mgt. Setup//1.HEI.01-done(vissibilityadded),HEI.02-DOne,HEI.03-Done, .HEI.04 -Customer diff RPM mandatory field is missing in Page and Table
    //2. HEI.05-DOne, HEI.06-DIT,HEI.07-Done, HEI.08-DOne,HEI.09-DOne, HEI.10-DOne,HEI.11&HEI.12-C2S-DOne,HEI.13-DOne
    //HEI.14-DOne,HEI.15-done, hei.16-done, hei.18-done, HEI.19-DOne, HEI.20-Done
    //******************************************************************************

    // InsertAllowed = false; //BC UPGRADE PATHAA02
    // DeleteAllowed = false; //BC UPGRADE PATHAA02
    //Caption = 'Warehouse Mgt. Setup';//BC UPGRADE PATHAA02

    layout
    {
        addafter("Registered Whse. Movement Nos.")
        {
            //HEI.01>>
            field(requestOrderNos; Rec."Request Order Nos. FND")
            {
                ApplicationArea = All;
                Caption = 'Request Order Nos.';
                ToolTip = 'Specifies the number series code used to assign numbers to request orders.';
                Visible = RequestOrderEnabled;
                AccessByPermission = TableData "Transfer Header" = R;
            }
            //HEI.01<<
            field("Gate Entry Nos."; Rec."Gate Entry Nos. FND")
            {
                ApplicationArea = All;
                Caption = 'Gate Entry Nos.';
                ToolTip = 'Specifies the gate entry numbers that can be used in the warehouse.';
                Visible = true;//BC UPGRDAE KUMARR78 FDD-MTC-007
            }
            field("Gate Entry Weight Tolerance %"; Rec."Gate Entry Weight Tole % FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gate Entry Weight Tolerance % field.';

            }
            field("Allow Collect Lines"; Rec."Allow Collect Lines FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Collect Lines field.';

            }
            field("Auto Insert Qty. Collected Lin"; Rec."Allow Collect Lines FND")
            {
                ApplicationArea = All;
                Visible = true;//BC UPGRDAE KUMARR78 FDD-MTC-007
                ToolTip = 'Specifies the value of the Allow Collect Lines field.';

            }
            field("Short Unit of Measure2 Filter"; Rec."Short Unit of Meas2 Filt FND")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Unit of Measure2 Filter';
                ToolTip = 'Specifies a filter for the second shortcut unit of measure.';
                Visible = true;
            }
            // field("Customer diff RPM mandatory"; Rec."Customer diff RPM mandatory")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Customer diff RPM mandatory';
            //     ToolTip = 'Specifies that entering a customer-specific RPM is mandatory when posting a sales order or sales invoice.';
            //     Visible = true;
            // } HEI.04 removed as per request
            field("Shortcut Unit of Measure4 Code"; Rec."Shortcut Unit of Meas4Code FND")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Unit of Measure4 Code';
                ToolTip = 'Specifies a code for the fourth shortcut unit of measure.';
                Visible = true;
            }
            //BC UPGRADE PATHAA02 >>DIT table Field 
            // field("Copy Distance"; Rec."Copy Distance")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Copy Distance';
            //     ToolTip = 'Specifies the distance within which items are copied when you use the Copy function.';
            //     Visible = true;
            // }
            //BC UPGRADE PATHAA02 <<DIT table Field 

            field("Doc. Shipping Cost Creation"; Rec."Doc. Ship Cost Creation FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Doc. Shipping Cost Creation field.';

            }
            field("Ask Ship. Info on Second Rcpt."; Rec."Ask Ship. Info on SecRcpt. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ask Confirmation Shipping Information On Second Receipt field.';

            }

            field("Enable Post & Print on Loc"; Rec."Enable Post & Print on Loc FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Post and Print based on Location field.';

            }
            field("Transfer Order Shipping Date"; Rec."Transfer Order Ship Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer Order Shipping Date field.';

            }
            field("Exclude Location Filter"; Rec."Exclude Location Filter FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exclude Location Filter for TO Deletion field.';

            }
            field("Print Delivery Note"; Rec."Print Delivery Note FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Print Delivery Note field.';
                //BC UPGRADE PATHAA02                ToolTip = 'Specifies the value of the Print Delivery Note field.';

            }


            group("Standard Production Cost")
            {
                Caption = 'Standard Production Cost';
                field("COGS JobQ Run Pre-Close Date"; Rec."COGS JobQ Run PreCloseDt FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the COGS Job Queue Run Pre-Close Date Calculation field.';

                }
                field("COGS JobQ Run Close Date"; Rec."COGS JobQ Run Close Date FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the COGS Job Queue Run Close Date Calculation field.';

                }
            }


            //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "General(Control 1)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Require Receive"(Control 22)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Require Receive"(Control 22)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Require Put-away"(Control 30)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Require Put-away"(Control 30)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Require Shipment"(Control 10)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Require Shipment"(Control 10)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Require Pick"(Control 32)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Require Pick"(Control 32)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Last Whse. Posting Ref. No."(Control 26)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Last Whse. Posting Ref. No."(Control 26)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Receipt Posting Policy"(Control 28)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Receipt Posting Policy"(Control 28)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Shipment Posting Policy"(Control 34)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Shipment Posting Policy"(Control 34)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Numbering(Control 1904569201)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Receipt Nos."(Control 2)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Receipt Nos."(Control 2)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Ship Nos."(Control 24)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Ship Nos."(Control 24)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Internal Put-away Nos."(Control 44)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Internal Put-away Nos."(Control 44)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Internal Pick Nos."(Control 48)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Internal Pick Nos."(Control 48)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Put-away Nos."(Control 4)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Put-away Nos."(Control 4)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Pick Nos."(Control 8)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Pick Nos."(Control 8)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Posted Whse. Receipt Nos."(Control 38)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Posted Whse. Receipt Nos."(Control 38)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Posted Whse. Shipment Nos."(Control 42)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Posted Whse. Shipment Nos."(Control 42)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Registered Whse. Put-away Nos."(Control 18)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Registered Whse. Put-away Nos."(Control 18)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Registered Whse. Pick Nos."(Control 12)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Registered Whse. Pick Nos."(Control 12)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Movement Nos."(Control 52)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Whse. Movement Nos."(Control 52)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Registered Whse. Movement Nos."(Control 6)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Registered Whse. Movement Nos."(Control 6)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        }
        addlast(content)
        {
            //HEI.11>>
            group(CosttoServe)
            {
                Caption = 'Cost To Serve';

                field("Net Weight UoM (Kg) FND"; Rec."Net Weight UoM (Kg) FND")
                {
                    ApplicationArea = All;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Net Weight UoM (Kg) field.';
                }

                field("Net Weight UoM (G) FND"; Rec."Net Weight UoM (G) FND")
                {
                    ApplicationArea = All;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Net Weight UoM (G) field.';
                }

                field("Picking Coeff. Non-Pallet FND"; Rec."Picking Coeff. Non-Pallet FND")
                {
                    ApplicationArea = All;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Picking Coefficient Non-Pallet field.';
                }

                field("C2S Base Calendar Code"; Rec."C2S Base Calendar Code FND")
                {
                    ApplicationArea = All;
                    Visible = true;
                    ToolTip = 'Specifies the value of the C2S Base Calendar Code field.';
                }
                field("Job Queue Run Pre-Close Date"; Rec."Job Queue Run PreCloseDate FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Queue Run Pre-Close Date Calculation field.';
                }
                field("Job Queue Run Close Date"; Rec."Job Queue Run Close Date FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Queue Run Close Date Calculation field.';
                }
                field("Job Q. Run Pre-Close Date Dec."; Rec."Job Q. Run PreCloseDt Dec. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Queue Run Pre-Close Date Calculation December field.';
                }
                field("Job Queue Run Close Date Dec."; Rec."Job Que RunCloseDate Dec. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Queue Run Close Date Calculation December field.';
                }
                field("Report ID for Job Queue"; Rec."Report ID for Job Queue FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report ID for Job Queue field.';
                }
                field("Report Name for Job Queue"; Rec."Report Name for Job Queue FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report Name for Job Queue field.';
                }
                field("C2S COGS Job Queue Cat Code"; Rec."C2S COGS Job Que Cat Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the C2S / COGS Allocation Job Queue Category Code field.';
                }
                field("SCOA Financial Statement"; Rec."SCOA Financial Statement FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SCOA Financial Statement Version field.';
                }
                field("SCOA Financial Statement Opt."; Rec."SCOA Financial State Opt. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SCOA Financial Statement Version Options field.';
                }
                field("Archive JQ Date Calculation"; Rec."Archive JQ Date Calc FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Archive Job Queue Date Calculation field.';
                }
            }
            //HEI.11<<
            //HEI.18>>
            group("Transfer Receipt Logs")
            {
                Caption = 'Transfer Receipt Logs';
                field(StockInTransLogRetention; Rec."StockInTransLogRetention FND")
                {
                    ApplicationArea = All;
                    Caption = 'StockInTransLogRetention(Days)';
                    ToolTip = 'Specifies the number of days to retain stock in transit logs.';
                    Visible = true;
                }
                field("Enable Stock in Trans. Funct"; Rec."En Stock in Trans. Funct FND")
                {
                    ApplicationArea = All;
                    Caption = 'Enable Stock in Trans. Funct';
                    ToolTip = 'Specifies whether the stock in transit functionality is enabled.';
                    Visible = true;
                }
            }
            //HEI.18<<
        }
    }


    actions
    {
        addfirst(Navigation)
        {
            group("C2S SCOA Financial Statement")
            {
                Caption = 'C2S SCOA Financial Statement';
                Image = Action;
                //HEI.14<<

                action("Add Option")
                {
                    ApplicationArea = All;
                    Caption = 'Add SCOA Financial Option';
                    ToolTip = 'Adds the selected SCOA Financial Statement option to the list of options.';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Add;
                    trigger OnAction()
                    begin
                        AddSCOAFinancialOption(); //HEI.14
                    end;
                }
                action("Remove Option")
                {
                    ApplicationArea = All;
                    Caption = 'Remove SCOA Financial Option';
                    ToolTip = 'Removes the selected SCOA Financial Statement option from the list of options.';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Delete;
                    trigger OnAction()
                    begin
                        RemoveSCOAFinancialOption(); //HEI.14
                    end;
                }
            }
        }
    }





    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.01>>
        GeneralOpCoSetup.GET();
        RequestOrderEnabled := GeneralOpCoSetup."Enable Request Order"
        //HEI.01<<
    end;

    trigger OnClosePage()
    begin
        ClearSCOAFinancialOption(); //HEI.14
    end;

    local procedure ClearSCOAFinancialOption()
    var
        myInt: Integer;
    begin
        //HEI.14<<
        Rec."SCOA Financial State Opt. FND" := Rec."SCOA Financial State Opt. FND"::" ";
        Rec.MODIFY();
        //HEI.14>>
    end;

    local procedure AddSCOAFinancialOption()
    var
        myInt: Integer;
    begin
        //HEI.14<<
        IF STRPOS(Rec."SCOA Financial Statement FND", FORMAT(Rec."SCOA Financial State Opt. FND")) = 0 THEN BEGIN
            IF Rec."SCOA Financial Statement FND" = '' THEN BEGIN
                IF Rec."SCOA Financial State Opt. FND" = Rec."SCOA Financial State Opt. FND"::" " THEN
                    Rec."SCOA Financial Statement FND" += ''' '''
                else
                    Rec."SCOA Financial Statement FND" += FORMAT(Rec."SCOA Financial State Opt. FND")
            end else BEGIN
                IF Rec."SCOA Financial State Opt. FND" = Rec."SCOA Financial State Opt. FND"::" " THEN
                    Rec."SCOA Financial Statement FND" += '|' + ''' '''
                else
                    Rec."SCOA Financial Statement FND" += '|' + FORMAT(Rec."SCOA Financial State Opt. FND");
            end;
            Rec.MODIFY();
        end;
        //HEI.14>>
    end;

    local procedure RemoveSCOAFinancialOption()
    var
        myInt: Integer;
    begin
        //HEI.14<<
        IF STRPOS(Rec."SCOA Financial Statement FND", FORMAT(Rec."SCOA Financial State Opt. FND")) <> 0 THEN BEGIN
            IF STRPOS(Rec."SCOA Financial Statement FND", FORMAT(Rec."SCOA Financial State Opt. FND")) <= 2 THEN BEGIN
                IF Rec."SCOA Financial State Opt. FND" = Rec."SCOA Financial State Opt. FND"::" " THEN
                    Rec."SCOA Financial Statement FND" := DELSTR(Rec."SCOA Financial Statement FND", STRPOS(Rec."SCOA Financial Statement FND", FORMAT(Rec."SCOA Financial State Opt. FND")) - 1, STRLEN(FORMAT(Rec."SCOA Financial State Opt. FND")) + 2)
                else
                    Rec."SCOA Financial Statement FND" := DELSTR(Rec."SCOA Financial Statement FND", STRPOS(Rec."SCOA Financial Statement FND", FORMAT(Rec."SCOA Financial State Opt. FND")), STRLEN(FORMAT(Rec."SCOA Financial State Opt. FND")) + 1)
            end else BEGIN
                IF Rec."SCOA Financial State Opt. FND" = Rec."SCOA Financial State Opt. FND"::" " THEN
                    Rec."SCOA Financial Statement FND" := DELSTR(Rec."SCOA Financial Statement FND", STRPOS(Rec."SCOA Financial Statement FND", FORMAT(Rec."SCOA Financial State Opt. FND")) - 2, STRLEN(FORMAT(Rec."SCOA Financial State Opt. FND")) + 3)
                else
                    Rec."SCOA Financial Statement FND" := DELSTR(Rec."SCOA Financial Statement FND", STRPOS(Rec."SCOA Financial Statement FND", FORMAT(Rec."SCOA Financial State Opt. FND")) - 1, STRLEN(FORMAT(Rec."SCOA Financial State Opt. FND")) + 1);
            end;
            Rec.MODIFY();
        end;
        //HEI.14>>
    end;

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        RequestOrderEnabled: Boolean;

}

