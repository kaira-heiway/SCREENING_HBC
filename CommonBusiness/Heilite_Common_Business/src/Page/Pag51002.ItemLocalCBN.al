page 51002 "Item Local CBN"
{
    // version HEI.01

    // HEI.01 RFC254 IBM HORTOC01 21.05.2018 - new field -"WHT Product Posting Group"
    // HEI.02 FDD-PRDGAP061 IBM HORTOC01 14.01.2019 - new fields "Order TRacking Policy","Minimum Order Quantity","Maximum Order Quantity","Safety Stock Quantity","Order Multiple","Safety Lead Time","Time Bucket","Overflow Level"
    // HEI.03 FDD PBRD HT401 IBM BULIMC01 28.05.2019 - add new field "Sales Price Warning"
    // HEI.04 FDD BRDHT393 IBM BULIMC01 24.06.2019 #new field Inventory Value Zero added
    // HEI.05 CHG2013123 TUDOSG01 IBM 11.03.2020 - added new fields: StrengthMethod, StrengthSpecificCode, StrengthSpecValue
    // HEI.06 CHG2013123 IBM.LS 16.03.2020
    //   # Code added.
    // HEI.07 CHG2060049 HT1098 IBM.GUNERE01 20/04/2020 # Commodity Code field added
    // HEI.08 CHG2112882 IBM.LS      08.06.2021
    //   # Added Field - Global Dimension 2 Code
    // HEI.09 CHG2140629 HB2723 BHANDS01    25.02.2022
    //   # Added Fields - "Deposit Value Method" and "Deposit Value"
    //**********************************************************************
    //HEI.10 BC UPGRADE PATHAA02 16.03.26 #Inventory UoM functionality added.
    //# DIT field-"inventory Unit of Measure" added to page and code added in OnAfterGetRecord trigger to set the value to International Standard Code of the unit of measure.

    Editable = false;
    PageType = Document;
    SourceTable = Item;
    ApplicationArea = All;  // BC Upgrade Priya
    UsageCategory = Documents;  // BC Upgrade Priya

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; REC."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Inventory Posting Group"; REC."Inventory Posting Group")
                {
                    ToolTip = 'Specifies links between business transactions made for the item and an inventory account in the general ledger, to group amounts for that item type.';
                }
                field("Item Disc. Group"; REC."Item Disc. Group")
                {
                    ToolTip = 'Specifies an item group code that can be used as a criterion to grant a discount when the item is sold to a certain customer.';
                }
                field("Allow Invoice Disc."; REC."Allow Invoice Disc.")
                {
                    ToolTip = 'Specifies if the item should be included in the calculation of an invoice discount on documents where the item is traded.';
                }
                field("Costing Method"; CostingMethod)
                {
                    CaptionML = ENU = 'Costing Method',
                                FRA = 'Mode évaluation stock';
                    ToolTip = 'Specifies the value of the CostingMethod field.';
                }
                field("Price Includes VAT"; REC."Price Includes VAT")
                {
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on sales document lines for this item should be shown with or without VAT.';
                }
                field("Gen. Prod. Posting Group"; REC."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                }
                field("VAT Prod. Posting Group"; REC."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field(Reserve; ReserveAsInteger)
                {
                    CaptionML = ENU = 'Reserve',
                                FRA = 'Réserver';
                    ToolTip = 'Specifies the value of the ReserveAsInteger field.';
                }
                field("Sales Unit of Measure"; REC."Sales Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure code used when you sell the item.';
                }
                field("Purch. Unit of Measure"; REC."Purch. Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure code used when you purchase the item.';
                }
                field("Item Tracking Code"; REC."Item Tracking Code")
                {
                    ToolTip = 'Specifies how serial, lot or package numbers assigned to the item are tracked in the supply chain.';
                }
                field("Lot Nos."; REC."Lot Nos.")
                {
                    ToolTip = 'Specifies the number series code that will be used when assigning lot numbers.';
                }
                field("Expiration Calculation"; REC."Expiration Calculation")
                {
                    ToolTip = 'Specifies the date formula for calculating the expiration date on the item tracking line. Note: This field will be ignored if the involved item has Require Expiration Date Entry set to Yes on the Item Tracking Code page.';
                }
                //BC Upgrade Priya>> Drink IT
                //field("Item DDeposit Group Code";REC."Item DDeposit Group Code")
                //{
                //}
                //field("Split Deposit on Invoice";REC."Split Deposit on Invoice")
                //{
                //}
                //field("Item DTax Group Code";REC."Item DTax Group Code")
                //{
                //}
                //field("Tax Spec. View Code";REC."Tax Spec. View Code")
                //{
                //}
                //field("Allow VAT Calculation (Free)";"Allow VAT Calculation (Free)")
                //{
                //}
                //field("Gen. Prod. Posting Free Group";"Gen. Prod. Posting Free Group")
                //{
                //} //BC Upgrade Priya<< Drink IT
                field("Free Item Posting Type"; FreeItemPostingType)
                {
                    CaptionML = ENU = 'Calculate Price on Free',
                                FRA = 'Calculer Prix sur gratuit';
                    ToolTip = 'Specifies the value of the FreeItemPostingType field.';
                }
                //BC Upgrade Priya>> Drink IT
                //field("Free Item";"Free Item")
                //{
                //}
                //field("Free Reason Code";"Free Reason Code")
                //{
                //}
                //field("Return Reason Code";"Return Reason Code")
                //{
                //}
                //field("Manco/Surplus Tolerance %";"Manco/Surplus Tolerance %")
                //{
                //}
                //field("Reverse Location Code";"Reverse Location Code")
                //{
                //}
                //field("Gift Box Item";"Gift Box Item")
                //{
                //}//BC Upgrade Priya<< Drink IT
                field("Batch Number Policy"; BatchNumberPolicy)
                {
                    Caption = 'Batch Number Policy';
                    ToolTip = 'Specifies the value of the Batch Number Policy field.';
                }
                field("Serial Nos."; REC."Serial Nos.")
                {
                    ToolTip = 'Specifies a number series code to assign consecutive serial numbers to items produced.';
                }
                field("Service Item Group"; REC."Service Item Group")
                {
                    ToolTip = 'Specifies the value of the Service Item Group field.';
                }
                field("Item Segmentation"; ItemSegmentation)
                {
                    Caption = 'Item Segmentation';
                    ToolTip = 'Specifies the value of the Item Segmentation field.';
                }
                field("Certification Required"; REC."Certification Required FND")
                {
                    ToolTip = 'Specifies the value of the Certification Required field.';
                }
                field("Rotating Item"; REC."Rotating Item FND")
                {
                    ToolTip = 'Specifies the value of the Rotating Item field.';
                }
                field("Machine Reference Number"; REC."Machine Reference Number FND")
                {
                    ToolTip = 'Specifies the value of the Machine Reference Number field.';
                }
                field("Rounding Precision"; REC."Rounding Precision")
                {
                    ToolTip = 'Specifies how calculated consumption quantities are rounded when entered on consumption journal lines.';
                }
                field("RPM Solution"; RPMSolution)
                {
                    ToolTip = 'Specifies the value of the RPMSolution field.';
                }
                //BC Upgrade Priya>> Drink IT
                //field("Production Unit of Measure";REC."Production Unit of Measure")
                //{
                //}
                //HEI.10>>
                field("Inventory Unit of Measure"; Rec."Inventory Unit of Measure FND")
                {
                    ApplicationArea = all;
                }
                //HEI.10<<
                field("WHT Product Posting Group"; REC."WHT Product Posting Group FND")
                {
                    ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
                }
                field(OrderTrackingPolicy; OrderTrackingPolicy)
                {
                    ToolTip = 'Specifies the value of the OrderTrackingPolicy field.';
                }
                field("Sales Price Warning"; SalesPriceWarning)
                {
                    Caption = 'Sales Price Warning';
                    ToolTip = 'Specifies the value of the Sales Price Warning field.';
                }
                field("Strength Method"; StrengthMethod)
                {
                    Caption = 'Strength Method';
                    ToolTip = 'Specifies the value of the Strength Method field.';
                }
                field("Strength Spec. Value"; StrengthSpecValue)
                {
                    CaptionML = ENU = 'Strength Spec. Value',
                                FRA = 'Valeur contrainte spécification';
                    ToolTip = 'Specifies the value of the StrengthSpecValue field.';
                }
                field("Inventory Value Zero"; Rec."Inventory Value Zero")
                {
                    ToolTip = 'Specifies whether the item on inventory must be excluded from inventory valuation. This is relevant if the item is kept on inventory on someone else''s behalf.';
                }
                field("Commodity Code"; Rec."Tariff No.")
                {
                    CaptionML = ENU = 'Commodity Code',
                                FRA = 'Nomenclature produits';
                    ToolTip = 'Specifies a code for the item''s tariff number.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Deposit Value Method"; DepositValueMethod)
                {
                    Caption = 'Deposit Value Method';
                    ToolTip = 'Specifies the value of the Deposit Value Method field.';
                }
                //BC Upgrade Priya>> Drink IT
                //field("Deposit Value";Rec."Deposit Value")
                //{
                //} //BC Upgrade Priya<< Drink IT
            }
            part(Control50029; "Item Local SKU CBN")
            {
                SubPageLink = "Item No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }

    //BC Upgrade Priya>> Drink IT
    // trigger OnAfterGetCurrRecord();
    // begin
    //     //HEI.06>>
    //     case "Strength Method" of
    //         "Strength Method"::Fix:
    //             StrengthMethod := true;
    //         "Strength Method"::Variable:
    //             StrengthMethod := false;
    //     end;

    //     if "Strength Spec. Value" = 0 then
    //         StrengthSpecValue := ''
    //     else
    //         StrengthSpecValue := FORMAT("Strength Spec. Value");
    //     //HEI.06<<
    // end;
    //BC Upgrade Priya<< Drink IT

    //BC Upgrade Priya>> Drink IT fields are used.
    trigger OnAfterGetRecord();
    begin
        if UnitofMeasure.GET(Rec."Sales Unit of Measure") then
            Rec."Sales Unit of Measure" := UnitofMeasure."International Standard Code";

        if UnitofMeasure.GET(Rec."Purch. Unit of Measure") then
            Rec."Purch. Unit of Measure" := UnitofMeasure."International Standard Code";

        // if UnitofMeasure.GET(Rec."Production Unit of Measure") then
        //   "Production Unit of Measure" := UnitofMeasure."International Standard Code";

        //HEI.10>>
        if UnitofMeasure.GET(Rec."Inventory Unit of Measure FND") then
            Rec."Inventory Unit of Measure FND" := UnitofMeasure."International Standard Code";
        //HEI.10<<

        //     CostingMethod := Rec."Costing Method";
        //     ReserveAsInteger := rec.Reserve;
        //     FreeItemPostingType := "Free Item Posting Type"; 
        //     BatchNumberPolicy := Rec."Batch Number Policy";
        //     ItemSegmentation := Rec."Item Segmentation";
        //     RPMSolution := Rec."RPM Solution";
        //     OrderTrackingPolicy := Rec."Order Tracking Policy";//HEI.02
        //     SalesPriceWarning := "Sales Price Warning"; //HEI.03  
        //     //HEI.06>>
        //     case "Strength Method" of
        //         "Strength Method"::Fix:
        //             StrengthMethod := true;
        //         "Strength Method"::Variable:
        //             StrengthMethod := false;
        //     end;

        //     if "Strength Spec. Value" = 0 then
        //         StrengthSpecValue := ''
        //     else
        //         StrengthSpecValue := FORMAT("Strength Spec. Value");
        //     //HEI.06<<

        //     DepositValueMethod := "Deposit Value Method"; // HEI.09
    end;
    // BC Upgrade Priya<< Drink IT fields are used.

    var
        UnitofMeasure: Record "Unit of Measure";
        StrengthMethod: Boolean;
        BatchNumberPolicy: Integer;
        CostingMethod: Integer;
        DepositValueMethod: Integer;
        FreeItemPostingType: Integer;
        ItemSegmentation: Integer;
        OrderTrackingPolicy: Integer;
        ReserveAsInteger: Integer;
        RPMSolution: Integer;
        SalesPriceWarning: Integer;
        StrengthSpecValue: Text[30];
}

