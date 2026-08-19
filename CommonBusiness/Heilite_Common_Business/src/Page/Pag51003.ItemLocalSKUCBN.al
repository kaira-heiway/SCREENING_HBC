page 51003 "Item Local SKU CBN"
{
    // version HEI.01

    // HEI.01 FDD PRDGAP061 IBM NAIKH01 18.12.2018
    //   # Addded New fields  "Lead Time Calculation","Reorder Point","Reorder Quantity","Reordering Policy"
    // HEI.02 IBM.AK INC3500698/CHG2112738 02-06-21
    //   # Added new field Backorder type
    // HEI.03 CHG2142222-HT2493 BHANDS01 24.12.2021
    //   # Added new field "CCC Dim. Code"

    // BC Upgrade MISHRS14 >> 
    // Added AsInteger type conversion inside OnAfterGetRecord trigger - in Plant Specific Material Status, Flushing Method, Replenishment System, RPM Solution and Reordering Policy
    // BC Upgrade MISHRS14 <<

    Editable = false;
    PageType = ListPart;
    SourceTable = "Stockkeeping Unit";
    ApplicationArea = All;  // BC Upgrade Priya

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code (for example, the warehouse or distribution center) to which the SKU applies.';
                }
                field("Plant-Specific Material Status"; PlantSpecificMaterialStatus)
                {
                    Caption = 'Plant-Specific Material Status';
                    ToolTip = 'Specifies the value of the Plant-Specific Material Status field.';
                }
                //BC Upgrade GUNREM01 >> added DrinkIT field
                field(Blocked; Rec."Blocked FND")
                {
                    ApplicationArea = all;
                } //BC Upgrade GUNREM01 << added DrinkIT field
                field("Standard Cost"; Rec."Standard Cost")
                {
                    ToolTip = 'Specifies the unit cost that is used as an estimation to be adjusted with variances later. It is typically used in assembly and production where costs can vary. Warning: If the SKU is supplied through production, then this field is not used when invoicing and adjusting the actual cost of the produced item. Instead, the Standard Cost field on the underlying item card is used, and any variances are calculated against the cost shares of that item.';
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Flushing Method"; FlushingMethod)
                {
                    CaptionML = ENU = 'Flushing Method',
                                FRA = 'Méthode consommation';
                    ToolTip = 'Specifies the value of the FlushingMethod field.';
                }
                field("Replenishment System"; ReplenishmentSystem)
                {
                    CaptionML = ENU = 'Replenishment System',
                                FRA = 'Système réappro.';
                    ToolTip = 'Specifies the value of the ReplenishmentSystem field.';
                }
                field("Phys Invt Counting Period Code"; Rec."Phys Invt Counting Period Code")
                {
                    ToolTip = 'Specifies the code of the counting period that indicates how often you want to count the SKU in a physical inventory.';
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ToolTip = 'Specifies the production BOM that is used to manufacture this item.';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ToolTip = 'Specifies the production route that contains the operations needed to manufacture this item.';
                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ToolTip = 'Specifies the value of the Scrap % field.';
                }
                //BC Upgrade Priya>> DrinkIT
                // field("Overhead Rate";Rec."Overhead Rate")
                // {
                // }
                // field("Indirect Cost %";Rec."Indirect Cost %")
                // {
                // }
                // field("Quality Standard No.";Rec."Quality Standard No.")
                // {
                // } //BC Upgrade Priya<< DrinkIT
                field("Quarantine Posting Policy"; QuarantinePostingPolicy)
                {
                    Caption = 'Quarantine Posting Policy';
                    ToolTip = 'Specifies the value of the Quarantine Posting Policy field.';
                }
                field("RPM Solution"; RPMSolution)
                {
                    ToolTip = 'Specifies the value of the RPMSolution field.';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                field(ReorderingPolicy; ReorderingPolicy)
                {
                    ToolTip = 'Specifies the value of the ReorderingPolicy field.';
                }
                field("Reorder Point"; Rec."Reorder Point")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Time Bucket"; Rec."Time Bucket")
                {
                    ToolTip = 'Specifies a time period for the recurring planning horizon of the SKU when you use Fixed Reorder Qty. or Maximum Qty. reordering policies.';
                }
                field("Overflow Level"; Rec."Overflow Level")
                {
                    ToolTip = 'Specifies a quantity you allow projected inventory to exceed the reorder point before the system suggests to decrease existing supply orders.';
                }
                field(backordertype; backordertype)
                {
                    ToolTip = 'Specifies the value of the backordertype field.';
                }
                field("CCC Dim. Code"; Rec."CCC Dim. Code FND")
                {
                    ToolTip = 'Specifies the value of the CCC Dim. Code field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        // QuarantinePostingPolicy := Rec."Quarantine Posting Policy"; //BC Upgrade Priya<< DrinkIT

        // BC Upgrade MISHRS14 >> 
        // Added AsInteger type conversion in Plant Specific Material Status, Flushing Method, Replenishment System, RPM Solution and Reordering Policy due to warning.
        PlantSpecificMaterialStatus := Rec."Plant Spec.Material Status FND".AsInteger();
        FlushingMethod := Rec."Flushing Method".AsInteger();
        ReplenishmentSystem := Rec."Replenishment System".AsInteger();
        RPMSolution := Rec."RPM Solution FND".AsInteger();
        ReorderingPolicy := Rec."Reordering Policy".AsInteger();//HEI.01
                                                                // BC Upgrade MISHRS14 <<

        // backordertype:= Rec."Backorder Type"; //HEI.02 //BC Upgrade Priya<< DrinkIT

    end;

    var
        backordertype: Integer;
        FlushingMethod: Integer;
        PlantSpecificMaterialStatus: Integer;
        QuarantinePostingPolicy: Integer;
        ReorderingPolicy: Integer;
        ReplenishmentSystem: Integer;
        RPMSolution: Integer;
}

