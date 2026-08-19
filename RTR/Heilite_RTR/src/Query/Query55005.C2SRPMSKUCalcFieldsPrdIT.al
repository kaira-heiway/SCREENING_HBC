query 55005 "C2S RPM SKU CalcFields Prd IT"
{
    // version HEI.01

    // HEI.01 CHG2162842 IBM SAMANR01 07/07/202022 #C2S optimazation
    //   # New query object  created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50026


    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            filter(FilterPostingDate; "Posting Date")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            dataitem(RPMSKURelationshipChld1; "RPM - SKU Relationship FND")
            {
                DataItemLink = "Period Date" = Shipping_Cost_Allocation."Period Date", "Linked Item No." = Shipping_Cost_Allocation."Item No.", "Own Fleet" = Shipping_Cost_Allocation."Own Fleet";
                SqlJoinType = InnerJoin;
                column(PeriodRPMGenOverhIT; "Period RPM Gen. Overh. IT")
                {
                    Method = Sum;
                }
                column(PeriodRPMWhseHandlIT; "Period RPM Whse. Handl. Cust.")
                {
                    Method = Sum;
                }
                column(PeriodRPMWhseOverhIT; "Period RPM Whse. Overh. Cust.")
                {
                    Method = Sum;
                }
            }
        }
    }
}

