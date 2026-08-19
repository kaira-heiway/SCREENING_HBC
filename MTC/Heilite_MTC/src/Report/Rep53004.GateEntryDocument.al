report 53004 "Gate Entry Document"
{
    // version HEI.01

    // HEI:EDD001:1:1 03/07/10 SKS
    //   # Report created
    // HEI-I:EDD039:1:1 02/10/10 TECTURA.AT
    //   # Added controls to display Client No and Shipment Method
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Report from HEI2.0
    // HEI.03 CHG2144396 IBM GHOSHS05 28.01.2022 Added PrintingTime to show proper time in both Webclient and RTC

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    //    - Old: ApplicationArea property not available in report.
    //    - New: ApplicationArea = All;
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC searchability.
    //    - Old: UsageCategory property not available in report.
    //    - New: UsageCategory = ReportsAndAnalysis;
    // 3. Blocked Drink-IT dependent dataset columns from "Gate Entry Header" dataitem.
    //    - Old: Vehicle_No_______WhseShipTruck_Description column was printing Truck details using Drink-IT table.
    //      column(Vehicle_No_______WhseShipTruck_Description; "Vehicle No." + ' ' + WhseShipTruck.Description)
    //    - New: Column commented/blocked.
    //    - Old: Driver_Code__WhseShipDriver_Description column was printing Driver details using Drink-IT table.
    //      column(Driver_Code__WhseShipDriver_Description; "Driver Code" + WhseShipDriver.Description)
    //    - New: Column commented/blocked.
    // 4. Blocked Drink-IT lookup logic in OnAfterGetRecord() due to missing custom tables.
    //    - Old:
    //        WhseShipDriver.GET("Driver Code");
    //        WhseShipTruck.GET("Vehicle No.");
    //    - New: Commented out the above GET statements to remove DIT dependency.
    // 5. Commented out variable declarations for Drink-IT custom tables to avoid compilation issues in BC.
    //    - Old:
    //        WhseShipTruck: Record "2014068";
    //        WhseShipDriver: Record "2014063";
    //    - New: Variables commented/blocked.
    // 6. Removed Drink-IT fields from report layout (RDLC) to align dataset changes.
    //    - Old Layout Fields: "Vehicle No.", WhseShipTruck.Description, "Driver Code", WhseShipDriver.Description
    //    - New Layout: Above DIT related columns removed/blocked from layout.
    // 7. No functional change in core report logic (Gate Entry Header/Line, Purchase/Sales/Transfer/Warehouse dataitems),
    //    only removal of Drink-IT dependency for BC upgrade compatibility.
    // 8. Old Report ID- 50189
    // BC Upgrade RAHUL<<


    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade RAHUL 21-01-2026++
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL 21-01-2026++
    RDLCLayout = '.\src\ReportsLayout\Gate Entry Document.rdl';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Gate Entry Header FND"; "Gate Entry Header FND")
        {
            DataItemTableView = sorting("Gate Entry Document No.");
            RequestFilterFields = "Gate Entry Document No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(PrintingTime; PrintingTime)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(USERID; UserId)
            {
            }
            column(Gate_Entry_Header__Gate_Entry_Document_No__; "Gate Entry Document No.")
            {
            }
            column(Gate_Entry_Header__Gate_Keeper_ID_; "Gate Keeper ID")
            {
            }
            // BC Upgrade RAHUL Blocking DIT Fields
            // column(Vehicle_No_______WhseShipTruck_Description; "Vehicle No." + ' ' + WhseShipTruck.Description)
            // {
            // }
            // column(Driver_Code__WhseShipDriver_Description; "Driver Code" + WhseShipDriver.Description)
            // {
            // }
            // BC Upgrade RAHUL Blocking DIT Fields
            column(Gate_Entry_Header__Gate_Entry_Type_; "Gate Entry Type")
            {
            }
            column(Gate_Entry_Header__Document_Type_; "Document Type")
            {
            }
            column(Gate_Entry_Header__Document_No__; "Document No.")
            {
            }
            column(Gate_Entry_Header__Location_Code_; "Location Code")
            {
            }
            column(Gate_Entry_Header_Description; Description)
            {
            }
            column(Gate_Entry_Header_Status; Status)
            {
            }
            column(Gate_Entry_Header__Date_In_; "Date In")
            {
            }
            column(Gate_Entry_Header__Time_In_; "Time In")
            {
            }
            column(Gate_Entry_Header__Date_Out_; "Date Out")
            {
            }
            column(Gate_Entry_Header__Time_Out_; "Time Out")
            {
            }
            column(Gate_Entry_Header__Total_Weight_on_Arrival_; "Total Weight on Arrival")
            {
            }
            column(Gate_Entry_Header__Total_Weight_on_Departure_; "Total Weight on Departure")
            {
            }
            column(Gate_Entry_Header__Posted_Weight_Inbound_; "Posted Weight Inbound")
            {
            }
            column(Gate_Entry_Header__Posted_Weight_Outbound_; "Posted Weight Outbound")
            {
            }
            column(Gate_Entry_Header__Weight_Difference_; "Weight Difference")
            {
            }
            column(Gate_Entry_Header__Linked_Gate_Entry_No__; "Linked Gate Entry No.")
            {
            }
            column(Gate_Entry_Header_Registered; Registered)
            {
            }
            column(Gate_EntryCaption; Gate_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Gate_KeeperCaption; Gate_KeeperCaptionLbl)
            {
            }
            column(Truck_CodeCaption; Truck_CodeCaptionLbl)
            {
            }
            column(Driver_CodeCaption; Driver_CodeCaptionLbl)
            {
            }
            column(Gate_Entry_TypeCaption; Gate_Entry_TypeCaptionLbl)
            {
            }
            column(Document_TypeCaption; Document_TypeCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(Location_CodeCaption; Location_CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Gate_Entry_Header_StatusCaption; FieldCaption(Status))
            {
            }
            column(Gate_Entry_Header__Date_In_Caption; FieldCaption("Date In"))
            {
            }
            column(Gate_Entry_Header__Time_In_Caption; FieldCaption("Time In"))
            {
            }
            column(Gate_Entry_Header__Date_Out_Caption; FieldCaption("Date Out"))
            {
            }
            column(Gate_Entry_Header__Time_Out_Caption; FieldCaption("Time Out"))
            {
            }
            column(Gate_Entry_Header__Total_Weight_on_Arrival_Caption; FieldCaption("Total Weight on Arrival"))
            {
            }
            column(Gate_Entry_Header__Total_Weight_on_Departure_Caption; FieldCaption("Total Weight on Departure"))
            {
            }
            column(Gate_Entry_Header__Posted_Weight_Inbound_Caption; FieldCaption("Posted Weight Inbound"))
            {
            }
            column(Gate_Entry_Header__Posted_Weight_Outbound_Caption; FieldCaption("Posted Weight Outbound"))
            {
            }
            column(Gate_Entry_Header__Weight_Difference_Caption; FieldCaption("Weight Difference"))
            {
            }
            column(Gate_Entry_Header__Linked_Gate_Entry_No__Caption; FieldCaption("Linked Gate Entry No."))
            {
            }
            column(Gate_Entry_Header_RegisteredCaption; FieldCaption(Registered))
            {
            }
            dataitem("Gate Entry Line FND"; "Gate Entry Line FND")
            {
                DataItemLink = "Gate Entry Document No." = field("Gate Entry Document No.");
                DataItemTableView = sorting("Gate Entry Document No.", "Line No.")
                                    order(ascending);
                column(Gate_Entry_Line_Type; Type)
                {
                }
                column(Gate_Entry_Line__No__; "No.")
                {
                }
                column(Gate_Entry_Line__Unit_Of_Measure_Code_; "Unit Of Measure Code")
                {
                }
                column(Gate_Entry_Line_Description; Description)
                {
                }
                column(Gate_Entry_Line__Quantity_on_Arrival_; "Quantity on Arrival")
                {
                }
                column(Gate_Entry_Line__Quantity_on_Departure_; "Quantity on Departure")
                {
                }
                column(Gate_Entry_Line_TypeCaption; FieldCaption(Type))
                {
                }
                column(Gate_Entry_Line__No__Caption; FieldCaption("No."))
                {
                }
                column(Gate_Entry_Line__Unit_Of_Measure_Code_Caption; FieldCaption("Unit Of Measure Code"))
                {
                }
                column(Gate_Entry_Line_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(Gate_Entry_Line__Quantity_on_Arrival_Caption; FieldCaption("Quantity on Arrival"))
                {
                }
                column(Gate_Entry_Line__Quantity_on_Departure_Caption; FieldCaption("Quantity on Departure"))
                {
                }
                column(Gate_Entry_Line_Gate_Entry_Document_No_; "Gate Entry Document No.")
                {
                }
                column(Gate_Entry_Line_Line_No_; "Line No.")
                {
                }
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "No." = field("Document No.");
                DataItemTableView = sorting("Document Type", "No.")
                                    order(ascending);
                column(Purchase_Header__No__; "No.")
                {
                }
                column(Purchase_Header__Document_Type_; "Document Type")
                {
                }
                column(Purchase_Header__Location_Code_; "Location Code")
                {
                }
                column(Purchase_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Purchase_Header__Buy_from_Vendor_No__; "Buy-from Vendor No.")
                {
                }
                column(Purchase_Header__Shipment_Method_Code_; "Shipment Method Code")
                {
                }
                column(Purchase_Header__No__Caption; FieldCaption("No."))
                {
                }
                column(Purchase_Header__Document_Type_Caption; FieldCaption("Document Type"))
                {
                }
                column(Purchase_Header__Location_Code_Caption; FieldCaption("Location Code"))
                {
                }
                column(Purchase_Header__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(TypeCaption; TypeCaptionLbl)
                {
                }
                column(No_Caption_Control1000000075; No_Caption_Control1000000075Lbl)
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(Unit_of_MeasureCaption; Unit_of_MeasureCaptionLbl)
                {
                }
                column(Expected_Receipt_DateCaption; Expected_Receipt_DateCaptionLbl)
                {
                }
                column(DescriptionCaption_Control1000000083; DescriptionCaption_Control1000000083Lbl)
                {
                }
                column(Purchase_Header__Buy_from_Vendor_No__Caption; FieldCaption("Buy-from Vendor No."))
                {
                }
                column(Purchase_Header__Shipment_Method_Code_Caption; FieldCaption("Shipment Method Code"))
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLink = "Document Type" = field("Document Type"),
                                   "Document No." = field("No.");
                    DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                        order(ascending);
                    column(Purchase_Line_Type; Type)
                    {
                    }
                    column(Purchase_Line__No__; "No.")
                    {
                    }
                    column(Purchase_Line_Quantity; Quantity)
                    {
                    }
                    column(Purchase_Line__Unit_of_Measure_; "Unit of Measure")
                    {
                    }
                    column(Purchase_Line__Expected_Receipt_Date_; "Expected Receipt Date")
                    {
                    }
                    column(Purchase_Line_Description; Description)
                    {
                    }
                    column(Purchase_Line_Document_Type; "Document Type")
                    {
                    }
                    column(Purchase_Line_Document_No_; "Document No.")
                    {
                    }
                    column(Purchase_Line_Line_No_; "Line No.")
                    {
                    }
                }
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "No." = field("Document No.");
                DataItemTableView = sorting("Document Type", "No.")
                                    order(ascending);
                column(Sales_Header__No__; "No.")
                {
                }
                column(Sales_Header__Document_Type_; "Document Type")
                {
                }
                column(Sales_Header__Location_Code_; "Location Code")
                {
                }
                column(Sales_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
                {
                }
                column(Sales_Header__Shipment_Method_Code_; "Shipment Method Code")
                {
                }
                column(QuantityCaption_Control1000000098; QuantityCaption_Control1000000098Lbl)
                {
                }
                column(Sales_Header__No__Caption; FieldCaption("No."))
                {
                }
                column(Sales_Header__Document_Type_Caption; FieldCaption("Document Type"))
                {
                }
                column(Sales_Header__Location_Code_Caption; FieldCaption("Location Code"))
                {
                }
                column(Sales_Header__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(TypeCaption_Control1000000107; TypeCaption_Control1000000107Lbl)
                {
                }
                column(No_Caption_Control1000000108; No_Caption_Control1000000108Lbl)
                {
                }
                column(Unit_of_MeasureCaption_Control1000000109; Unit_of_MeasureCaption_Control1000000109Lbl)
                {
                }
                column(Shipment_DateCaption; Shipment_DateCaptionLbl)
                {
                }
                column(DescriptionCaption_Control1000000111; DescriptionCaption_Control1000000111Lbl)
                {
                }
                column(Sales_Header__Sell_to_Customer_No__Caption; FieldCaption("Sell-to Customer No."))
                {
                }
                column(Sales_Header__Shipment_Method_Code_Caption; FieldCaption("Shipment Method Code"))
                {
                }
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document Type" = field("Document Type"),
                                   "Document No." = field("No.");
                    DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                        order(ascending);
                    column(Sales_Line_Type; Type)
                    {
                    }
                    column(Sales_Line__No__; "No.")
                    {
                    }
                    column(Sales_Line_Quantity; Quantity)
                    {
                    }
                    column(Sales_Line__Unit_of_Measure_; "Unit of Measure")
                    {
                    }
                    column(Sales_Line__Shipment_Date_; "Shipment Date")
                    {
                    }
                    column(Sales_Line_Description; Description)
                    {
                    }
                    column(Sales_Line_Document_Type; "Document Type")
                    {
                    }
                    column(Sales_Line_Document_No_; "Document No.")
                    {
                    }
                    column(Sales_Line_Line_No_; "Line No.")
                    {
                    }
                }
            }
            dataitem("Transfer Header"; "Transfer Header")
            {
                DataItemLink = "No." = field("Document No.");
                DataItemTableView = sorting("No.")
                                    order(ascending);
                column(Transfer_Header__No__; "No.")
                {
                }
                column(Transfer_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Transfer_Header__Transfer_from_Code_; "Transfer-from Code")
                {
                }
                column(Transfer_Header__Transfer_to_Code_; "Transfer-to Code")
                {
                }
                column(Transfer_Header__Shipment_Method_Code_; "Shipment Method Code")
                {
                }
                column(QuantityCaption_Control1000000118; QuantityCaption_Control1000000118Lbl)
                {
                }
                column(Transfer_Header__No__Caption; FieldCaption("No."))
                {
                }
                column(Transfer_Header__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(No_Caption_Control1000000128; No_Caption_Control1000000128Lbl)
                {
                }
                column(Unit_of_MeasureCaption_Control1000000129; Unit_of_MeasureCaption_Control1000000129Lbl)
                {
                }
                column(Shipment_DateCaption_Control1000000130; Shipment_DateCaption_Control1000000130Lbl)
                {
                }
                column(DescriptionCaption_Control1000000131; DescriptionCaption_Control1000000131Lbl)
                {
                }
                column(Transfer_Header__Transfer_from_Code_Caption; FieldCaption("Transfer-from Code"))
                {
                }
                column(Transfer_Header__Transfer_to_Code_Caption; FieldCaption("Transfer-to Code"))
                {
                }
                column(Receipt_DateCaption; Receipt_DateCaptionLbl)
                {
                }
                column(Transfer_Header__Shipment_Method_Code_Caption; FieldCaption("Shipment Method Code"))
                {
                }
                dataitem("Transfer Line"; "Transfer Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Document No.", "Line No.")
                                        order(ascending);
                    column(Transfer_Line__Item_No__; "Item No.")
                    {
                    }
                    column(Transfer_Line_Quantity; Quantity)
                    {
                    }
                    column(Transfer_Line__Unit_of_Measure_; "Unit of Measure")
                    {
                    }
                    column(Transfer_Line__Shipment_Date_; "Shipment Date")
                    {
                    }
                    column(Transfer_Line_Description; Description)
                    {
                    }
                    column(Transfer_Line__Receipt_Date_; "Receipt Date")
                    {
                    }
                    column(Transfer_Line_Document_No_; "Document No.")
                    {
                    }
                    column(Transfer_Line_Line_No_; "Line No.")
                    {
                    }
                }
            }
            dataitem("Warehouse Receipt Header"; "Warehouse Receipt Header")
            {
                DataItemLink = "No." = field("Document No.");
                DataItemTableView = sorting("No.")
                                    order(ascending);
                column(Warehouse_Receipt_Header__No__; "No.")
                {
                }
                column(Warehouse_Receipt_Header__Location_Code_; "Location Code")
                {
                }
                column(Warehouse_Receipt_Header__Posting_Date_; "Posting Date")
                {
                }
                column(QuantityCaption_Control1000000144; QuantityCaption_Control1000000144Lbl)
                {
                }
                column(Warehouse_Receipt_Header__No__Caption; FieldCaption("No."))
                {
                }
                column(Warehouse_Receipt_Header__Location_Code_Caption; FieldCaption("Location Code"))
                {
                }
                column(Warehouse_Receipt_Header__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(No_Caption_Control1000000154; No_Caption_Control1000000154Lbl)
                {
                }
                column(Unit_of_MeasureCaption_Control1000000155; Unit_of_MeasureCaption_Control1000000155Lbl)
                {
                }
                column(Due_DateCaption; Due_DateCaptionLbl)
                {
                }
                column(DescriptionCaption_Control1000000157; DescriptionCaption_Control1000000157Lbl)
                {
                }
                dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
                {
                    DataItemLink = "No." = field("No.");
                    DataItemTableView = sorting("No.", "Line No.")
                                        order(ascending);
                    column(Warehouse_Receipt_Line__Item_No__; "Item No.")
                    {
                    }
                    column(Warehouse_Receipt_Line_Quantity; Quantity)
                    {
                    }
                    column(Warehouse_Receipt_Line__Warehouse_Receipt_Line___Unit_of_Measure_Code_; "Warehouse Receipt Line"."Unit of Measure Code")
                    {
                    }
                    column(Warehouse_Receipt_Line__Due_Date_; "Due Date")
                    {
                    }
                    column(Warehouse_Receipt_Line_Description; Description)
                    {
                    }
                    column(Warehouse_Receipt_Line_No_; "No.")
                    {
                    }
                    column(Warehouse_Receipt_Line_Line_No_; "Line No.")
                    {
                    }
                }
            }
            dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
            {
                DataItemLink = "No." = field("Document No.");
                DataItemTableView = sorting("No.")
                                    order(ascending);
                column(Warehouse_Shipment_Header__No__; "No.")
                {
                }
                column(Warehouse_Shipment_Header__Location_Code_; "Location Code")
                {
                }
                column(Warehouse_Shipment_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Warehouse_Shipment_Header__Shipment_Method_Code_; "Shipment Method Code")
                {
                }
                column(QuantityCaption_Control1000000164; QuantityCaption_Control1000000164Lbl)
                {
                }
                column(Warehouse_Shipment_Header__No__Caption; FieldCaption("No."))
                {
                }
                column(Warehouse_Shipment_Header__Location_Code_Caption; FieldCaption("Location Code"))
                {
                }
                column(Warehouse_Shipment_Header__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(No_Caption_Control1000000171; No_Caption_Control1000000171Lbl)
                {
                }
                column(Unit_of_MeasureCaption_Control1000000172; Unit_of_MeasureCaption_Control1000000172Lbl)
                {
                }
                column(Due_DateCaption_Control1000000173; Due_DateCaption_Control1000000173Lbl)
                {
                }
                column(DescriptionCaption_Control1000000174; DescriptionCaption_Control1000000174Lbl)
                {
                }
                column(Warehouse_Shipment_Header__Shipment_Method_Code_Caption; FieldCaption("Shipment Method Code"))
                {
                }
                dataitem("Warehouse Shipment Line"; "Warehouse Shipment Line")
                {
                    DataItemLink = "No." = field("No.");
                    DataItemTableView = sorting("No.", "Line No.")
                                        order(ascending);
                    column(Warehouse_Shipment_Line__Item_No__; "Item No.")
                    {
                    }
                    column(Warehouse_Shipment_Line_Quantity; Quantity)
                    {
                    }
                    column(Warehouse_Shipment_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                    {
                    }
                    column(Warehouse_Shipment_Line__Due_Date_; "Due Date")
                    {
                    }
                    column(Warehouse_Shipment_Line_Description; Description)
                    {
                    }
                    column(Warehouse_Shipment_Line_No_; "No.")
                    {
                    }
                    column(Warehouse_Shipment_Line_Line_No_; "Line No.")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord();
            begin
                TestField(Status, Status::Released);
                //  WhseShipDriver.GET("Driver Code"); // BC Upgrade RAHUL Drink -IT Field 
                // WhseShipTruck.GET("Vehicle No."); // BC Upgrade RAHUL  Drink -IT Field
                //IF User.GET(USERID) THEN;
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

    trigger OnPostReport();
    begin

        if not CurrReport.Preview then begin
            "Gate Entry Header FND".TestField("Gate Entry Header FND".Status, "Gate Entry Header FND".Status::Released);
            "Gate Entry Header FND"."No. Printed" += 1;
            "Gate Entry Header FND".Modify();
        end;

    end;

    trigger OnPreReport();
    begin
        //HEI.03>>
        PrintingTime := CurrentDateTime
        //HEI.03<<
    end;

    var
        PrintingTime: DateTime;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DescriptionCaption_Control1000000083Lbl: Label 'Description';
        DescriptionCaption_Control1000000111Lbl: Label 'Description';
        DescriptionCaption_Control1000000131Lbl: Label 'Description';
        DescriptionCaption_Control1000000157Lbl: Label 'Description';
        DescriptionCaption_Control1000000174Lbl: Label 'Description';
        Due_DateCaption_Control1000000173Lbl: Label 'Due Date';
        Due_DateCaptionLbl: Label 'Due Date';
        Expected_Receipt_DateCaptionLbl: Label 'Expected Receipt Date';
        //   WhseShipTruck: Record "2014068"; // BC Upgrade RAHUL Drink -IT Variables
        //  WhseShipDriver: Record "2014063"; // BC Upgrade RAHUL Drink -IT Variables
        Gate_EntryCaptionLbl: Label 'Gate Entry';
        No_Caption_Control1000000075Lbl: Label 'No.';
        No_Caption_Control1000000108Lbl: Label 'No.';
        No_Caption_Control1000000128Lbl: Label 'No.';
        No_Caption_Control1000000154Lbl: Label 'No.';
        No_Caption_Control1000000171Lbl: Label 'No.';
        QuantityCaption_Control1000000098Lbl: Label 'Quantity';
        QuantityCaption_Control1000000118Lbl: Label 'Quantity';
        QuantityCaption_Control1000000144Lbl: Label 'Quantity';
        QuantityCaption_Control1000000164Lbl: Label 'Quantity';
        QuantityCaptionLbl: Label 'Quantity';
        Receipt_DateCaptionLbl: Label 'Receipt Date';
        Shipment_DateCaption_Control1000000130Lbl: Label 'Shipment Date';
        Shipment_DateCaptionLbl: Label 'Shipment Date';
        TypeCaption_Control1000000107Lbl: Label 'Type';
        TypeCaptionLbl: Label 'Type';
        Unit_of_MeasureCaption_Control1000000109Lbl: Label 'Unit of Measure';
        Unit_of_MeasureCaption_Control1000000129Lbl: Label 'Unit of Measure';
        Unit_of_MeasureCaption_Control1000000155Lbl: Label 'Unit of Measure';
        Unit_of_MeasureCaption_Control1000000172Lbl: Label 'Unit of Measure';
        Unit_of_MeasureCaptionLbl: Label 'Unit of Measure';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Description';
        Document_No_CaptionLbl: TextConst ENU = '"Document No."', FRA = '"Document No."';
        Document_TypeCaptionLbl: TextConst ENU = '"Document Type"', FRA = '"Document Type"';
        Driver_CodeCaptionLbl: TextConst ENU = 'Driver Code', FRA = 'Driver Code';
        Gate_Entry_TypeCaptionLbl: TextConst ENU = 'Gate Entry Type', FRA = 'Gate Entry Type';
        Gate_KeeperCaptionLbl: TextConst ENU = 'Gate Keeper', FRA = 'Gate Keeper';
        Location_CodeCaptionLbl: TextConst ENU = 'Location Code', FRA = 'Location Code';
        No_CaptionLbl: TextConst ENU = 'No.', FRA = 'No.';
        Truck_CodeCaptionLbl: TextConst ENU = 'Truck Code', FRA = 'Truck Code';
}

