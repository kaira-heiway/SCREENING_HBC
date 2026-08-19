page 58122 "Ortec Orders"
{
    // HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new page
    //BC Upgrade MISHRS14  >>
    // #Old object id-50326
    // #new object id-58122
    // ADDED ApplicationArea AND UsageCategory
    // blocking Drinkit field- Delivery Times, Link Sales Document No.
    // blocking Drinkit field- Total Eq. UOM Quantity, Total Cubage
    // blocked OnOpenPage Trigger -- Drinkit Field- Document Subtype Code and Route
    //BC Upgrade MISHRS14  <<

    Caption = 'Ortec Orders';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    //BC Upgrade MISHRS14  >> ADDED ApplicationArea AND UsageCategory
    ApplicationArea = All;
    UsageCategory = Lists;
    //BC Upgrade MISHRS14  <<
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type", "No.")
                      WHERE("Document Type" = FILTER(Order),
                            Status = FILTER(Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order Number"; Rec."No.")
                {
                    CaptionML = ENU = 'Order Number',
                                FRA = 'N°';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field(Name; Rec."Sell-to Customer Name")
                {
                    CaptionML = ENU = 'Name',
                                FRA = 'Nom du donneur d''ordre';
                }
                field(Name3; Rec."Sell-to Customer Name 2")
                {
                    CaptionML = ENU = 'Name 3',
                                FRA = 'Nom du donneur d''ordre 2';
                }
                field(Street; Rec."Sell-to Address")
                {
                    CaptionML = ENU = 'Street',
                                FRA = 'Adresse donneur d''ordre';
                }
                field("House Number"; CustomerAttributes."House No. 1")
                {
                    Caption = 'House Number';
                }
                field("Zip Code"; Rec."Sell-to Post Code")
                {
                    CaptionML = ENU = 'Zip Code',
                                FRA = 'Code postal donneur d''ordre';
                }
                field(City; Rec."Sell-to City")
                {
                    CaptionML = ENU = 'City',
                                FRA = 'Ville donneur d''ordre';
                }
                field(Country; Rec."Sell-to Country/Region Code")
                {
                    CaptionML = ENU = 'Country',
                                FRA = 'Code pays/région donneur d''ordre';
                }
                field("X Coordinate (longitude)"; Customer."Longitude Coordinate FND")
                {
                    Caption = 'X Coordinate (longitude)';
                }
                field("X Coordinate (latitude)"; Customer."Latitude Coordinate FND")
                {
                    Caption = 'X Coordinate (latitude)';
                }
                field("Delivery Date"; Rec."Shipment Date")
                {
                    CaptionML = ENU = 'Delivery Date',
                                FRA = 'Date de préparation';
                }
                // BC Upgrade MISHRS14 >> ----Drinkit field -DeliveryTimes
                // field("Time Window 1 from";DeliveryTimes."Delivery Time 1 From")
                // {
                //     CaptionML = ENU='Time Window 1 from',
                //                 FRA='Heure de livraison 1 de';
                // }
                // field("Time Window 1 till";DeliveryTimes."Delivery Time 1 To")
                // {
                //     CaptionML = ENU='Time Window 1 till',
                //                 FRA='Heure de livraison 1 à';
                // }
                // field("Time Window 2 from";DeliveryTimes."Delivery Time 2 From")
                // {
                //     CaptionML = ENU='Time Window 2 from',
                //                 FRA='Heure de livraison 2 de';
                // }
                // field("Time Window 2 till";DeliveryTimes."Delivery Time 2 To")
                // {
                //     CaptionML = ENU='Time Window 2 till',
                //                 FRA='Heure de livraison 2 à';
                // }
                // BC Upgrade MISHRS14 <<
                field("Depo ID"; Rec."Location Code")
                {
                    CaptionML = ENU = 'Depo ID',
                                FRA = 'Code magasin';
                }
                // BC Upgrade MISHRS14 >> ----Drinkit field -Total Eq. UOM Quantity
                // field("Delivery No. of Crates";"Total Eq. UOM Quantity")
                // {
                //     CaptionML = ENU='Delivery No. of Crates',
                //                 FRA='Total Unité de mesure Eq.';
                // }
                // BC Upgrade MISHRS14 <<
                field("Delivery  weight in kg"; TotalCubageSO)
                {
                    CaptionML = ENU = 'Delivery  weight in kg ',
                                FRA = 'Volume (Cubage) total';
                }
                // BC Upgrade MISHRS14 >> ----Drinkit field -Total Eq. UOM Quantity
                // field("Loading No. of Crates ";SalesHeaderSRO."Total Eq. UOM Quantity")
                // {
                //     CaptionML = ENU='Loading No. of Crates ',
                //                 FRA='Total Unité de mesure Eq.';
                // }
                // BC Upgrade MISHRS14 <<
                field("Loading weight in Kgs"; TotalCubageSRO)
                {
                    CaptionML = ENU = 'Loading weight in Kgs',
                                FRA = 'Volume (Cubage) total';
                }
                field("Fix loading time in minutes"; CustomerHandlingTimeTruck."Unloading Time  Fixed")
                {
                    Caption = 'Fix loading time in minutes';
                }
                field("Variable loading time in minutes  per crate"; CustomerHandlingTimeTruck."Unloading Time Variable")
                {
                    Caption = 'Variable loading time in minutes  per crate';
                }
                field("Variable delivery time in minutes  per crate"; CustomerHandlingTimeTruck."Loading Time Variable")
                {
                    Caption = 'Variable delivery time in minutes  per crate';
                }
                field("Fix delivery time in minutes"; CustomerHandlingTimeTruck."Loading Time Fixed")
                {
                    Caption = 'Fix delivery time in minutes';
                }
                field("Truck Type 1 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 1")
                {
                    Caption = 'Truck Type 1 allowed?';
                }
                field("Truck Type 2 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 2")
                {
                    Caption = 'Truck Type 2 allowed?';
                }
                field("Truck Type 3 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 3")
                {
                    Caption = 'Truck Type 3 allowed?';
                }
                field("Truck Type 4 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 4")
                {
                    Caption = 'Truck Type 4 allowed?';
                }
                field("Truck Type 5 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 5")
                {
                    Caption = 'Truck Type 5 allowed?';
                }
                field("Truck Type 6 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 6")
                {
                    Caption = 'Truck Type 6 allowed?';
                }
                field("Truck Type 7 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 7")
                {
                    Caption = 'Truck Type 7 allowed?';
                }
                field("Truck Type 8 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 8")
                {
                    Caption = 'Truck Type 8 allowed?';
                }
                field("Truck Type 9 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 9")
                {
                    Caption = 'Truck Type 9 allowed?';
                }
                field("Truck Type 10 allowed"; CustomerHandlingTimeTruck."Truck Type Allowed 10")
                {
                    Caption = 'Truck Type 10 allowed?';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        if CustomerAttributes.GET(Rec."Sell-to Customer No.") then;
        if CustomerHandlingTimeTruck.GET(Rec."Sell-to Customer No.") then;
        if Customer.GET(Rec."Sell-to Customer No.") then;

        // BC Upgrade MISHRS14 >> ----Drinkit table -Delivery Times
        // DeliveryTimes.RESET;
        // DeliveryTimes.SETRANGE(Rec."No.", Customer."No.");
        // if DeliveryTimes.FINDFIRST then;

        // BC Upgrade MISHRS14 >> ----Drinkit field - Total Eq.UOM Quantity and Total cubage
        // CALCFIELDS("Total Eq. UOM Quantity", "Total Cubage");
        // TotalCubageSO := ROUND("Total Cubage" / 1000000, 0.02, '>');
        // BC Upgrade MISHRS14 <<

        // BC Upgrade MISHRS14 >> ----Drink It field-Link Sales Document No., Total Eq. UOM Quantity and Total cubage 
        // SalesHeaderSRO.RESET();
        // SalesHeaderSRO.SETRANGE("Document Type", SalesHeaderSRO."Document Type"::"Return Order");
        // SalesHeaderSRO.SETRANGE(Rec."Link Sales Document No.",Rec."No.");
        // SalesHeaderSRO.SETRANGE(Status, SalesHeaderSRO.Status::Released);
        // if SalesHeaderSRO.FINDFIRST then begin
        //   SalesHeaderSRO.CALCFIELDS("Total Eq. UOM Quantity","Total Cubage");
        //   TotalCubageSRO := ROUND(SalesHeaderSRO."Total Cubage" / 1000000,0.02,'>');
        // end else
        //   TotalCubageSRO := 0;
        // BC Upgrade MISHRS14 <<
    end;

    trigger OnInit();
    begin
        OrtecInterfaceSetup.GET();
        OrtecInterfaceSetup.TESTFIELD("Default Route");
        OrtecInterfaceSetup.TESTFIELD("Exclude Doc. Subtype Code");
    end;
    //BC Upgrade MISHRS14  >> Blocking this because of drink it fields - Default Route and Document Subtype Code
    trigger OnOpenPage();
    begin
        //SETRANGE(Route,OrtecInterfaceSetup."Default Route");
        Rec.SETFILTER("Document Subtype Code FND", '<>%1', OrtecInterfaceSetup."Exclude Doc. Subtype Code");//BC Upgrade VAMSIU01 Added >>
    end;
    //BC Upgrade MISHRS14  <<
    var
        CustomerAttributes: Record "Customer Attributes FND";
        CustomerHandlingTimeTruck: Record "Cust  Handling Time Truck FND";
        Customer: Record Customer;
        OrtecInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        SalesHeaderSRO: Record "Sales Header";
        //BC Upgrade MISHRS14  >> DeliveryTimes : Record "Delivery Times"; --Drinkit Table
        //BC Upgrade MISHRS14  <<
        TotalCubageSO: Decimal;
        TotalCubageSRO: Decimal;
}

