page 58121 "MDM SEPA Direct Debit Mandate"
{
    // HEI.01 CHG2132219 HB2607 IBM GAVANM01 25.01.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # new page created, to be added as subform to MDM Customer Interface (page 50215)
    // HEI.02 CHG2132219 HB2607 IBM GAVANM01 08.02.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # new field add: ID

    // BC UPGRADE PATELP08 >>
    //    # old object id - 50273
    //    # new object id - 58121
    // added application area and usage category
    // in fields added Rec. before field name as per new syntax change in BC upgrade
    // BC UPGRADE PATELP08 <<

    // BC Upgrade PATELS08 >>
    // # Changed page type to listpart, to be added as part in MDM Customer Interface page (58115)
    // BC Upgrade PATELS08 <<

    Caption = 'MDM SEPA Direct Debit Mandate';
    DeleteAllowed = false;
    Editable = false;
    // BC Upgrade PATELS08 >> # Changed page type to listpart, to be added as part in MDM Customer Interface page (58115)
    // PageType = List;
    PageType = ListPart;
    // BC Upgrade PATELS08 <<
    SourceTable = "SEPA Direct Debit Mandate";

    // BC UPGRADE PATELP08 >> added application area and usage category
    ApplicationArea = All;
    UsageCategory = Lists;
    // BC UPGRADE PATELP08 <<
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    Description = 'HEI.02';
                }
                field("Customer Bank Account Code"; Rec."Customer Bank Account Code")
                {
                }
                field("Valid From"; Rec."Valid From")
                {
                }
                field("Valid To"; Rec."Valid To")
                {
                }
                field("Date of Signature"; Rec."Date of Signature")
                {
                }
                field("Type of Payment"; Rec."Type of Payment")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Expected Number of Debits"; Rec."Expected Number of Debits")
                {
                }
                field(Closed; Rec.Closed)
                {
                }
            }
        }
    }

    actions
    {
    }
}

