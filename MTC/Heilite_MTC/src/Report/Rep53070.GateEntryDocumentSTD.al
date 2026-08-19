report 53070 "Gate Entry Document STD"
{
    // HEI:EDD001:1:1 03/07/10 SKS
    //   # Report created
    // HEI-I:EDD039:1:1 02/10/10 TECTURA.AT
    //   # Added controls to display Client No and Shipment Method
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Report from HEI2.0
    // HEI.02 CHG2144396 IBM GHOSHS05 01.02.2022 Added PrintingTime to show proper time in both Webclient and RTC
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID - 50261.
    // 2. Add layout path and Change extension RDLC to RDL.
    // 3. Remove Drink-IT Record("Whse. Shipping Truck","Whse. Shipping Driver") and related columns and code .
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Gate Entry Document STD.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Gate Entry Header FND"; "Gate Entry Header FND")
        {
            DataItemTableView = SORTING("Gate Entry Document No.");
            RequestFilterFields = "Gate Entry Document No.";
            column(PrintingTime; PrintingTime)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Gate_Entry_Header__Gate_Entry_Document_No__; "Gate Entry Document No.")
            {
            }
            column(Gate_Entry_Header__Gate_Keeper_ID_; "Gate Keeper ID")
            {
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Records (WhseShipTruck,WhseShipDriver)
            // column(Vehicle_No_______WhseShipTruck_Description; "Vehicle No." + ' ' + WhseShipTruck.Description)
            // {
            // }
            // column(Driver_Code__WhseShipDriver_Description; "Driver Code" + WhseShipDriver.Description)
            // {
            // }
            column(Vehicle_No_______WhseShipTruck_Description; "Vehicle No.")
            {
            }
            column(Driver_Code__WhseShipDriver_Description; "Driver Code")
            {
            }
            // BC Upgrade BHARDA11 << ----Drink-IT Records (WhseShipTruck,WhseShipDriver)
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
            column(Gate_Entry_Header_StatusCaption; Gate_Entry_Header_StatusCaption)
            {
            }
            column(Gate_Entry_Header__Date_In_Caption; Gate_Entry_Header__Date_In_Caption)
            {
            }
            column(Gate_Entry_Header__Time_In_Caption; Gate_Entry_Header__Time_In_Caption)
            {
            }
            column(Gate_Entry_Header__Date_Out_Caption; Gate_Entry_Header__Date_Out_Caption)
            {
            }
            column(Gate_Entry_Header__Time_Out_Caption; Gate_Entry_Header__Time_Out_Caption)
            {
            }
            column(Gate_Entry_Header__Total_Weight_on_Arrival_Caption; Gate_Entry_Header__Total_Weight_on_Arrival_Caption)
            {
            }
            column(Gate_Entry_Header__Total_Weight_on_Departure_Caption; Gate_Entry_Header__Total_Weight_on_Departure_Caption)
            {
            }
            column(Gate_Entry_Header__Posted_Weight_Inbound_Caption; Gate_Entry_Header__Posted_Weight_Inbound_Caption)
            {
            }
            column(Gate_Entry_Header__Posted_Weight_Outbound_Caption; Gate_Entry_Header__Posted_Weight_Outbound_Caption)
            {
            }
            column(Gate_Entry_Header__Weight_Difference_Caption; Gate_Entry_Header__Weight_Difference_Caption)
            {
            }
            column(Gate_Entry_Header__Linked_Gate_Entry_No__Caption; Gate_Entry_Header__Linked_Gate_Entry_No__Caption)
            {
            }
            column(Gate_Entry_Header_RegisteredCaption; Gate_Entry_Header_RegisteredCaption)
            {
            }
            dataitem("Gate Entry Line FND"; "Gate Entry Line FND")
            {
                DataItemLink = "Gate Entry Document No." = FIELD("Gate Entry Document No.");
                DataItemTableView = SORTING("Gate Entry Document No.", "Line No.") ORDER(Ascending);
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
                column(Gate_Entry_Line_TypeCaption; FIELDCAPTION(Type))
                {
                }
                column(Gate_Entry_Line__No__Caption; Gate_Entry_Line__No__Caption)
                {
                }
                column(Gate_Entry_Line__Unit_Of_Measure_Code_Caption; Gate_Entry_Line__Unit_Of_Measure_Code_Caption)
                {
                }
                column(Gate_Entry_Line_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Gate_Entry_Line__Quantity_on_Arrival_Caption; Gate_Entry_Line__Quantity_on_Arrival_Caption)
                {
                }
                column(Gate_Entry_Line__Quantity_on_Departure_Caption; Gate_Entry_Line__Quantity_on_Departure_Caption)
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
                DataItemLink = "No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending);
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
                column(Purchase_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Purchase_Header__Document_Type_Caption; FIELDCAPTION("Document Type"))
                {
                }
                column(Purchase_Header__Location_Code_Caption; FIELDCAPTION("Location Code"))
                {
                }
                column(Purchase_Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
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
                column(Purchase_Header__Buy_from_Vendor_No__Caption; FIELDCAPTION("Buy-from Vendor No."))
                {
                }
                column(Purchase_Header__Shipment_Method_Code_Caption; FIELDCAPTION("Shipment Method Code"))
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending);
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
                DataItemLink = "No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending);
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
                column(Sales_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Sales_Header__Document_Type_Caption; FIELDCAPTION("Document Type"))
                {
                }
                column(Sales_Header__Location_Code_Caption; FIELDCAPTION("Location Code"))
                {
                }
                column(Sales_Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
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
                column(Sales_Header__Sell_to_Customer_No__Caption; FIELDCAPTION("Sell-to Customer No."))
                {
                }
                column(Sales_Header__Shipment_Method_Code_Caption; FIELDCAPTION("Shipment Method Code"))
                {
                }
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending);
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
                DataItemLink = "No." = FIELD("Document No.");
                DataItemTableView = SORTING("No.") ORDER(Ascending);
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
                column(Transfer_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Transfer_Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
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
                column(Transfer_Header__Transfer_from_Code_Caption; FIELDCAPTION("Transfer-from Code"))
                {
                }
                column(Transfer_Header__Transfer_to_Code_Caption; FIELDCAPTION("Transfer-to Code"))
                {
                }
                column(Receipt_DateCaption; Receipt_DateCaptionLbl)
                {
                }
                column(Transfer_Header__Shipment_Method_Code_Caption; FIELDCAPTION("Shipment Method Code"))
                {
                }
                dataitem("Transfer Line"; "Transfer Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
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
                DataItemLink = "No." = FIELD("Document No.");
                DataItemTableView = SORTING("No.") ORDER(Ascending);
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
                column(Warehouse_Receipt_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Warehouse_Receipt_Header__Location_Code_Caption; FIELDCAPTION("Location Code"))
                {
                }
                column(Warehouse_Receipt_Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
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
                    DataItemLink = "No." = FIELD("No.");
                    DataItemTableView = SORTING("No.", "Line No.") ORDER(Ascending);
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
                DataItemLink = "No." = FIELD("Document No.");
                DataItemTableView = SORTING("No.") ORDER(Ascending);
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
                column(Warehouse_Shipment_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Warehouse_Shipment_Header__Location_Code_Caption; FIELDCAPTION("Location Code"))
                {
                }
                column(Warehouse_Shipment_Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
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
                column(Warehouse_Shipment_Header__Shipment_Method_Code_Caption; FIELDCAPTION("Shipment Method Code"))
                {
                }
                dataitem("Warehouse Shipment Line"; "Warehouse Shipment Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemTableView = SORTING("No.", "Line No.") ORDER(Ascending);
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
                TESTFIELD(Status, Status::Released);
                // BC Upgrade BHARDA11 >> ----Drink-IT Record("Whse. Shipping Truck","Whse. Shipping Driver")
                // WhseShipDriver.GET("Driver Code");
                // WhseShipTruck.GET("Vehicle No.");
                // BC Upgrade BHARDA11 << ----Drink-IT Record("Whse. Shipping Truck","Whse. Shipping Driver")
                //IF User.GET(USERID) THEN;
            end;

            trigger OnPreDataItem();
            begin
                //HEI.02>>
                PrintingTime := CURRENTDATETIME;
                //HEI.02<<
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
        if not CurrReport.PREVIEW then begin
            "Gate Entry Header FND".TESTFIELD("Gate Entry Header FND".Status, "Gate Entry Header FND".Status::Released);
            "Gate Entry Header FND"."No. Printed" += 1;
            "Gate Entry Header FND".MODIFY;
        end;
    end;

    var
        // BC Upgrade BHARDA11 >> ----Drink-IT Record("Whse. Shipping Truck","Whse. Shipping Driver")
        // WhseShipTruck: Record "Whse. Shipping Truck"; 
        // WhseShipDriver: Record "Whse. Shipping Driver";
        // BC Upgrade BHARDA11 << ----Drink-IT Record("Whse. Shipping Truck","Whse. Shipping Driver")
        Gate_EntryCaptionLbl: TextConst ENU = 'Gate Entry', FRA = 'Porte d''entrée';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No_CaptionLbl: TextConst ENU = 'No.', FRA = 'N°';
        Gate_KeeperCaptionLbl: TextConst ENU = 'Gate Keeper', FRA = 'Gardien de porte';
        Truck_CodeCaptionLbl: TextConst ENU = 'Truck Code', FRA = 'Code du camion';
        Driver_CodeCaptionLbl: TextConst ENU = 'Driver Code', FRA = 'Code du chauffeur';
        Gate_Entry_TypeCaptionLbl: TextConst ENU = 'Gate Entry Type', FRA = 'Type d''entrée de la porte';
        Document_TypeCaptionLbl: TextConst ENU = 'Document Type', FRA = 'Type de document';
        Document_No_CaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        Location_CodeCaptionLbl: TextConst ENU = 'Location Code', FRA = 'Code du magasin';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Description';
        TypeCaptionLbl: Label 'Type';
        No_Caption_Control1000000075Lbl: Label 'No.';
        QuantityCaptionLbl: Label 'Quantity';
        Unit_of_MeasureCaptionLbl: Label 'Unit of Measure';
        Expected_Receipt_DateCaptionLbl: Label 'Expected Receipt Date';
        DescriptionCaption_Control1000000083Lbl: Label 'Description';
        QuantityCaption_Control1000000098Lbl: Label 'Quantity';
        TypeCaption_Control1000000107Lbl: Label 'Type';
        No_Caption_Control1000000108Lbl: Label 'No.';
        Unit_of_MeasureCaption_Control1000000109Lbl: Label 'Unit of Measure';
        Shipment_DateCaptionLbl: Label 'Shipment Date';
        DescriptionCaption_Control1000000111Lbl: Label 'Description';
        QuantityCaption_Control1000000118Lbl: Label 'Quantity';
        No_Caption_Control1000000128Lbl: Label 'No.';
        Unit_of_MeasureCaption_Control1000000129Lbl: Label 'Unit of Measure';
        Shipment_DateCaption_Control1000000130Lbl: Label 'Shipment Date';
        DescriptionCaption_Control1000000131Lbl: Label 'Description';
        Receipt_DateCaptionLbl: Label 'Receipt Date';
        QuantityCaption_Control1000000144Lbl: Label 'Quantity';
        No_Caption_Control1000000154Lbl: Label 'No.';
        Unit_of_MeasureCaption_Control1000000155Lbl: Label 'Unit of Measure';
        Due_DateCaptionLbl: Label 'Due Date';
        DescriptionCaption_Control1000000157Lbl: Label 'Description';
        QuantityCaption_Control1000000164Lbl: Label 'Quantity';
        No_Caption_Control1000000171Lbl: Label 'No.';
        Unit_of_MeasureCaption_Control1000000172Lbl: Label 'Unit of Measure';
        Due_DateCaption_Control1000000173Lbl: Label 'Due Date';
        DescriptionCaption_Control1000000174Lbl: Label 'Description';
        Gate_Entry_Header__Date_In_Caption: TextConst ENU = 'Date In', FRA = 'Date en';
        Gate_Entry_Header__Time_In_Caption: TextConst ENU = 'Time In', FRA = 'Temps dans';
        Gate_Entry_Header__Date_Out_Caption: TextConst ENU = 'Date Out', FRA = 'Date de sortie';
        Gate_Entry_Header__Time_Out_Caption: TextConst ENU = 'Time Out', FRA = 'Temps libre';
        Gate_Entry_Header_StatusCaption: TextConst ENU = 'Status', FRA = 'Statut';
        Gate_Entry_Header_RegisteredCaption: TextConst ENU = 'Registered', FRA = 'Immatriculé';
        Gate_Entry_Header__Linked_Gate_Entry_No__Caption: TextConst ENU = 'Linked Gate Entry No.', FRA = 'Entrée de porte liée';
        Gate_Entry_Line__No__Caption: TextConst ENU = 'No.', FRA = 'N°';
        Gate_Entry_Line__Unit_Of_Measure_Code_Caption: TextConst ENU = 'Unit of measure code', FRA = 'Code unité';
        Gate_Entry_Line__Quantity_on_Arrival_Caption: TextConst ENU = 'Quantity on Arrival', FRA = 'Quantité à l''arrivée';
        Gate_Entry_Line__Quantity_on_Departure_Caption: TextConst ENU = 'Quantity on Departure', FRA = 'Quantité au départ';
        Gate_Entry_Header__Total_Weight_on_Arrival_Caption: TextConst ENU = 'Total Weight on Arrival', FRA = 'Poids total à l''arrivée';
        Gate_Entry_Header__Total_Weight_on_Departure_Caption: TextConst ENU = 'Total Weight on Departure', FRA = 'Poids total au départ';
        Gate_Entry_Header__Posted_Weight_Inbound_Caption: TextConst ENU = 'Posted Weight Inbound', FRA = 'Posté Poids Entrant';
        Gate_Entry_Header__Posted_Weight_Outbound_Caption: TextConst ENU = 'Posted Weight Outbound', FRA = 'Poids affiché sortant';
        Gate_Entry_Header__Weight_Difference_Caption: TextConst ENU = 'Weight Difference', FRA = 'Différence de poids';
        PrintingTime: DateTime;
}

