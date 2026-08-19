page 51094 "Standard Cost Aging Info CBN"
{
    // version HEI.03

    // HEI.01 CHG2167977 NORRIQ KOROLA04 18.08.2022
    //   #Page created
    // HEI.02 CHG2207110 SAHAL01 27.06.2023 Update Standard Cost Aging Info table with blocked/unblocked information
    //   # Added New Field - Block or Unblock Date
    // HEI.03 CHG2237893 PRASAA03 21.03.2024 Std cost aging info / add new filters
    //   # Added New Fields: 10 - Old Standard Cost
    //   # Added New Fields: 11 - New Standard Cost
    //   # Added New Fields: 12 - User ID

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Standard Cost Aging Info FND";
    SourceTableView = ORDER(Descending);
    ApplicationArea = All; // BC Upgrade Manisha
    UsageCategory = Lists;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Location Code"; rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Item No."; rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Description"; rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field(Blocked; rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Block or Unblock Date"; rec."Block or Unblock Date")
                {
                    ToolTip = 'Specifies the value of the Block or Unblock Date field.';
                }
                field("Date of Change"; rec."Date of Change")
                {
                    ToolTip = 'Specifies the value of the Date of Change field.';
                }
                field("Legal Entity"; rec."Legal Entity")
                {
                    ToolTip = 'Specifies the value of the Legal Entity field.';
                }
                field("Old Standard Cost"; rec."Old Standard Cost")
                {
                    ToolTip = 'Specifies the value of the Old Standard Cost field.';
                }
                field("New Standard Cost"; rec."New Standard Cost")
                {
                    ToolTip = 'Specifies the value of the New Standard Cost field.';
                }
                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
            }
        }
    }

    actions
    {
    }
}

