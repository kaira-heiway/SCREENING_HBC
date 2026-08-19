query 55034 "Shipping Cost Archive"
{
    // version HEI.03

    // HEI.01 FDD-HB2761 BULIMC01 IBM 13/04/2022#new query created to reconcile the archived entries
    // HEI.02 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport - new fields added
    // HEI.03 CHG2175297 IBM SISUM01 30/03/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #Add Whse Handling Splits fields and delete unused fields

    // BC Upgrade POENAB02: Original (HeiLite) query id 50013

    elements
    {
        dataitem(Shipping_Cost_Archive; "Shipping Cost Archive FND")
        {
            filter(PostingDate; "Posting Date")
            {
            }
            filter(SourceDocument; "Source Document")
            {
            }
            filter(DestinationType; "Destination Type")
            {
            }
            filter(OnlyRPM; "Only RPM Transportation")
            {
            }
            filter(DistributionType; "Distribution Type")
            {
            }
            filter(OwnFleet; "Own Fleet")
            {
            }
            column(TotalGenOverheads; "General Overheads")
            {
                Method = Sum;
            }
            column(TotalWhseHandling; "Warehouse Handling")
            {
                Method = Sum;
            }
            column(TotalWhseOverheads; "Warehouse Overheads")
            {
                Method = Sum;
            }
            column(InternalTransfer; "Primary Allocated Amount")
            {
                Method = Sum;
            }
            column(TotalGenOverheadsST; "General Overheads ST")
            {
                Method = Sum;
            }
            column(TotalWhseOverheadsST; "Warehouse Overheads ST")
            {
                Method = Sum;
            }
            column(TotalWhseHandlingST; "Warehouse Handling ST")
            {
                Method = Sum;
            }
            column(InternalTransferST; "Internal Transfer ST")
            {
                Method = Sum;
            }
            column(RPM_SO; "RPM SO")
            {
                Method = Sum;
            }
            column(RPM_ST; "RPM ST")
            {
                Method = Sum;
            }
            column(Gen_Overheads_RPM_SO; "Gen. Overheads RPM SO")
            {
                Method = Sum;
            }
            column(Gen_Overheads_RPM_ST; "Gen. Overheads RPM ST")
            {
                Method = Sum;
            }
            column(Whse_Overheads_RPM_SO; "Whse. Overheads RPM SO")
            {
                Method = Sum;
            }
            column(Whse_Overheads_RPM_ST; "Whse. Overheads RPM ST")
            {
                Method = Sum;
            }
            column(Whse_Handling_RPM_SO; "Whse. Handling RPM SO")
            {
                Method = Sum;
            }
            column(Whse_Handling_RPM_ST; "Whse. Handling RPM ST")
            {
                Method = Sum;
            }
            column(FIX_Warehouse_Handling; "FIX Warehouse Handling")
            {
                Method = Sum;
            }
            column(OVE_Warehouse_Handling; "OVE Warehouse Handling")
            {
                Method = Sum;
            }
            column(TRP_Warehouse_Handling; "TRP Warehouse Handling")
            {
                Method = Sum;
            }
            column(FIX_Whse_Hand_ST; "FIX Whse. Hand. ST")
            {
                Method = Sum;
            }
            column(OVE_Whse_Hand_ST; "OVE Whse. Hand. ST")
            {
                Method = Sum;
            }
            column(TRP_Whse_Hand_ST; "TRP Whse. Hand. ST")
            {
                Method = Sum;
            }
            column(FIX_Whse_Handling_RPM_SO; "FIX Whse. Handling RPM SO")
            {
                Method = Sum;
            }
            column(FIX_Whse_Handling_RPM_ST; "FIX Whse. Handling RPM ST")
            {
                Method = Sum;
            }
            column(OVE_Whse_Handling_RPM_SO; "OVE Whse. Handling RPM SO")
            {
                Method = Sum;
            }
            column(OVE_Whse_Handling_RPM_ST; "OVE Whse. Handling RPM ST")
            {
                Method = Sum;
            }
            column(TRP_Whse_Handling_RPM_SO; "TRP Whse. Handling RPM SO")
            {
                Method = Sum;
            }
            column(TRP_Whse_Handling_RPM_ST; "TRP Whse. Handling RPM ST")
            {
                Method = Sum;
            }
        }
    }
}

