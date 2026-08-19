page 58036 "Interface Entry Lines VIP"
{
    // Heilite Navision Old Id - 50369

    // version HEI.11

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Page created
    // HEI.02 CHG2129985 IBM.LS      21.02.2022
    //   # Added New Fields: 110 - Planned Quantity
    //                       111 - Quantity (Full Pallet)
    //                       112 - Quantity (Full/Partial Pallet)
    //                       113 - EAN
    //                       114 - Ccc Code
    //                       115 - Gross Weight of Pallet in KG
    //                       116 - Shelf Life
    //                       117 - Batch No. (Lot No.)
    //                       118 - Production Date
    //                       119 - Best Before Date
    // HEI.03 CHG2147859 SAHAL01 07.09.2022
    //   # Added New Fields: 120 - Best Before Handled
    //                       121 - Part Group-1
    //                       122 - Part Group-2
    //                       515 - Traceability Code
    //                       560 - Flag
    //                       562 - Classification
    //                       613 - Base UOM
    //                       616 - Item Type
    //                       623 - Sales UOM
    //                       530 - Width Reflex 1st
    //                       533 - Height Reflex 1st
    //                       527 - Length Reflex 1st
    //                       536 - Weight Reflex 1st
    // HEI.04 CHG2149734 SAHAL01 01.11.2022
    //   # Added New Fields: 100 - Prod. Order Status
    //                       101 - Prod. Order No.
    //                       102 - Prod. Order Line No.
    //                       103 - Zone Code
    //                       104 - Bin Code
    //                       105 - Due Date
    //                       106 - Starting Date
    //                       107 - Starting Time
    //                       108 - Ending Date
    //                       109 - Ending Time
    //                       125 - Work Center No.
    //                       129 - Starting Date-Time
    //                       130 - Ending Date-Time
    //                       135 - Prod. Order Comp. Line No.
    //                       136 - Prod. Order Comp. No.
    //                       137 - Prod. Order Comp. Description
    //                       138 - Prod. Order Comp. Location
    //                       139 - Prod. Order Comp. Zone Code
    //                       140 - Prod. Order Comp. Bin Code
    //                       141 - Prod. Order Comp. Quantity
    //   # Added Fields:   1 - Header Entry No.
    //                   635 - Service Zone Code
    // HEI.05 CHG2154367 SAHAL01 12.09.2022
    //   # Added New Field: 149 - Quality Status
    // HEI.06 CHG2154382 SAHAL01 20.10.2022
    //   # Added Fields: 608 - Telex No.
    //                   610 - Fax No.
    // HEI.07 CHG2174146 SAHAL01 09.03.2023 Assembly Order Outbound and Inbound interfaces HeiLite -- Astro WMS
    //   # Added Fields: 549 - Name
    //                   557 - Phone No.
    // HEI.08 CHG2210794 SAHAL01 07.12.2023 Zycus - BASE HL Integration Master Dimension
    //   # Added Fields: 548 - Customer Code
    //                   550 - Name 2
    // HEI.09 CHG2210794 SAHAL01 17.01.2024 Zycus - BASE HL Integration Master Dimension
    //   # Added Field: 558 - E-mail
    // HEI.10 CHG2210794 SAHAL01 19.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 160 - Action Code
    //                         163 - External Order No.
    //                         164 - External Order Line No.
    //                         166 - Global No.
    //                         167 - Fixed Asset No.
    //                         168 - Currency Code 2
    //                         169 - Item Charge Value
    //                         170 - Direct Unit Cost
    //                         171 - Direct Unit Cost 2
    //                         172 - CMG Code
    //                         173 - Expected Receipt Date
    //                         174 - Delivery Finalized
    //                         175 - Ship-to Code
    //                         176 - Ship-to City
    //                         177 - Ship-to Post Code
    //                         178 - Ship-to Country/Region Code
    // HEI.11 CHG2210794 MAJUMS03 21.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Added Field: 612 - No. 2, Visible = FALSE.

    Caption = 'Interface Entry Lines VIP';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Entry Line VIP INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Header Entry No."; Rec."Header Entry No.")
                {
                    ToolTip = 'Specifies the value of the Header Entry No. field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    ToolTip = 'Specifies the value of the Source Line No. field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("No. 2"; Rec."No. 2")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the No. 2 field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ToolTip = 'Specifies the value of the Unit Amount field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ToolTip = 'Specifies the value of the VAT % field.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ToolTip = 'Specifies the value of the Customer Code field.';
                }
                field("External Contract No."; Rec."External Contract No.")
                {
                    ToolTip = 'Specifies the value of the External Contract No. field.';
                }
                field("External Contract Line No."; Rec."External Contract Line No.")
                {
                    ToolTip = 'Specifies the value of the External Contract Line No. field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("Message ID"; Rec."Message ID")
                {
                    ToolTip = 'Specifies the value of the Message ID field.';
                }
                field("Severity Code"; Rec."Severity Code")
                {
                    ToolTip = 'Specifies the value of the Severity Code field.';
                }
                field("Log Message"; Rec."Log Message")
                {
                    ToolTip = 'Specifies the value of the Log Message field.';
                }
                field("Message Code"; Rec."Message Code")
                {
                    ToolTip = 'Specifies the value of the Message Code field.';
                }
                field("Message Type"; Rec."Message Type")
                {
                    ToolTip = 'Specifies the value of the Message Type field.';
                }
                field("Message Class"; Rec."Message Class")
                {
                    ToolTip = 'Specifies the value of the Message Class field.';
                }
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {
                    ToolTip = 'Specifies the value of the Data Exch. Entry No. field.';
                }
                field("Prod. Order Status"; Rec."Prod. Order Status")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Status field.';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order No. field.';
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Line No. field.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ToolTip = 'Specifies the value of the Zone Code field.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ToolTip = 'Specifies the value of the Starting Time field.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.';
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ToolTip = 'Specifies the value of the Ending Time field.';
                }
                field("Planned Quantity"; Rec."Planned Quantity")
                {
                    ToolTip = 'Specifies the value of the Planned Quantity field.';
                }
                field("Quantity (Full Pallet)"; Rec."Quantity (Full Pallet)")
                {
                    ToolTip = 'Specifies the value of the Quantity (Full Pallet) field.';
                }
                field("Quantity (Full/Partial Pallet)"; Rec."Quantity (Full/Partial Pallet)")
                {
                    ToolTip = 'Specifies the value of the Quantity (Full/Partial Pallet) field.';
                }
                field(EAN; Rec.EAN)
                {
                    ToolTip = 'Specifies the value of the EAN field.';
                }
                field("Ccc Code"; Rec."Ccc Code")
                {
                    ToolTip = 'Specifies the value of the Ccc Code field.';
                }
                field("Gross Weight of Pallet in KG"; Rec."Gross Weight of Pallet in KG")
                {
                    ToolTip = 'Specifies the value of the Gross Weight of Pallet in KG field.';
                }
                field("Shelf Life"; Rec."Shelf Life")
                {
                    ToolTip = 'Specifies the value of the Shelf Life field.';
                }
                field("Batch No. (Lot No.)"; Rec."Batch No. (Lot No.)")
                {
                    ToolTip = 'Specifies the value of the Batch No. (Lot No.) field.';
                }
                field("Production Date"; Rec."Production Date")
                {
                    ToolTip = 'Specifies the value of the Production Date field.';
                }
                field("Best Before Date"; Rec."Best Before Date")
                {
                    ToolTip = 'Specifies the value of the Best Before Date field.';
                }
                field("Best Before Handled"; Rec."Best Before Handled")
                {
                    ToolTip = 'Specifies the value of the Best Before Handled field.';
                }
                field("Part Group-1"; Rec."Part Group-1")
                {
                    ToolTip = 'Specifies the value of the Part Group-1 field.';
                }
                field("Part Group-2"; Rec."Part Group-2")
                {
                    ToolTip = 'Specifies the value of the Part Group-2 field.';
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    ToolTip = 'Specifies the value of the Work Center No. field.';
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ToolTip = 'Specifies the value of the Starting Date-Time field.';
                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ToolTip = 'Specifies the value of the Ending Date-Time field.';
                }
                field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Comp. Line No. field.';
                }
                field("Prod. Order Comp. No."; Rec."Prod. Order Comp. No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Comp. No. field.';
                }
                field("Prod. Order Comp. Description"; Rec."Prod. Order Comp. Description")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Comp. Description field.';
                }
                field("Prod. Order Comp. Location"; Rec."Prod. Order Comp. Location")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Comp. Location Code field.';
                }
                field("Prod. Order Comp. Zone Code"; Rec."Prod. Order Comp. Zone Code")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Comp. Zone Code field.';
                }
                field("Prod. Order Comp. Bin Code"; Rec."Prod. Order Comp. Bin Code")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Comp. Bin Code field.';
                }
                field("Prod. Order Comp. Quantity"; Rec."Prod. Order Comp. Quantity")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Comp. Quantity field.';
                }
                field("Traceability Code"; Rec."Traceability Code")
                {
                    ToolTip = 'Specifies the value of the Traceability Code field.';
                }
                field(Flag; Rec.Flag)
                {
                    ToolTip = 'Specifies the value of the Flag field.';
                }
                field(Classification; Rec.Classification)
                {
                    ToolTip = 'Specifies the value of the Classification field.';
                }
                field("Base UOM"; Rec."Base UOM")
                {
                    ToolTip = 'Specifies the value of the Base UOM field.';
                }
                field("Item Type"; Rec."Item Type")
                {
                    ToolTip = 'Specifies the value of the Item Type field.';
                }
                field("Sales UOM"; Rec."Sales UOM")
                {
                    ToolTip = 'Specifies the value of the Sales UOM field.';
                }
                field("Width Reflex 1st"; Rec."Width Reflex 1st")
                {
                    ToolTip = 'Specifies the value of the Width Reflex 1st field.';
                }
                field("Height Reflex 1st"; Rec."Height Reflex 1st")
                {
                    ToolTip = 'Specifies the value of the Height Reflex 1st field.';
                }
                field("Length Reflex 1st"; Rec."Length Reflex 1st")
                {
                    ToolTip = 'Specifies the value of the Length Reflex 1st field.';
                }
                field("Weight Reflex 1st"; Rec."Weight Reflex 1st")
                {
                    ToolTip = 'Specifies the value of the Weight Reflex 1st field.';
                }
                field("Quality Status"; Rec."Quality Status")
                {
                    ToolTip = 'Specifies the value of the Quality Status field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ToolTip = 'Specifies the value of the Telex No. field.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the value of the Fax No. field.';
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ToolTip = 'Specifies the value of the Service Zone Code field.';
                }
                field("E-mail"; Rec."E-mail")
                {
                    ToolTip = 'Specifies the value of the E-mail field.';
                }
                field("Action Code"; Rec."Action Code")
                {
                    ToolTip = 'Specifies the value of the Action Code field.';
                }
                field("External Order No."; Rec."External Order No.")
                {
                    ToolTip = 'Specifies the value of the External Order No. field.';
                }
                field("External Order Line No."; Rec."External Order Line No.")
                {
                    ToolTip = 'Specifies the value of the External Order Line No. field.';
                }
                field("Global No."; Rec."Global No.")
                {
                    ToolTip = 'Specifies the value of the Global No. field.';
                }
                field("Fixed Asset No."; Rec."Fixed Asset No.")
                {
                    ToolTip = 'Specifies the value of the Fixed Asset No. field.';
                }
                field("Currency Code 2"; Rec."Currency Code 2")
                {
                    ToolTip = 'Specifies the value of the Currency Code 2 field.';
                }
                field("Item Charge Value"; Rec."Item Charge Value")
                {
                    ToolTip = 'Specifies the value of the Item Charge Value field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Direct Unit Cost field.';
                }
                field("Direct Unit Cost 2"; Rec."Direct Unit Cost 2")
                {
                    ToolTip = 'Specifies the value of the Direct Unit Cost 2 field.';
                }
                field("CMG Code"; Rec."CMG Code")
                {
                    ToolTip = 'Specifies the value of the CMG Code field.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the value of the Expected Receipt Date field.';
                }
                field("Delivery Finalized"; Rec."Delivery Finalized")
                {
                    ToolTip = 'Specifies the value of the Delivery Finalized field.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the value of the Ship-to City field.';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Post Code field.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Country/Region Code field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Line)
            {
                Caption = 'Line';
                Image = "Action";
                action(ShowDescription)
                {
                    Caption = 'Show Description';
                    Image = Description;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Show Description action.';

                    trigger OnAction();
                    begin
                        Rec.ShowNotes();
                    end;
                }
            }
        }
    }
}

