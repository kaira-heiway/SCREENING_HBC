query 55035 "Shipping Cost Allocation"
{
    // version HEI.11

    // HEI.01 CHG2095415 IBM BULIMC01 11.04.2021#new object created
    // HEI.02 CHG2130188 IBM BULIMC01 04/11/2021 #new field added - DistributionType
    // HEI.03 CHG2132177 IBM BULIMC01 06/12/2021 #new fields added - OwnFleet, TotalDistance,TotalDrops
    // HEI.04 FDD-HB2761 BULIMC01 IBM 13/04/2022#new fields added
    // HEI.05 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport - new fields added
    // HEI.06 CHG2162842 IBM SAMANR01 23/06/202022 #C2S optimazation
    //   # Add No. in filter and NoOfLines in colum
    //   # Period G/L Cost Delivery Cust.
    //   # Period G/L Cost Gen. Overheads
    //   # Period G/L Cost Whse. Handling
    //   # Period G/L Cost Whse. Overhead
    //   # Period G/L Cost Own Fleet
    //   # Weight Allocation Own Fleet
    //   # No. of Drops All. Own Fleet
    //   # Distance Allocation Own Fleet
    // HEI.07 CHG2162842 IBM SAMANR01 04/07/202022 #C2S optimazation
    //   # Add filed "FldParentLineNo"
    // HEI.08 CHG2169207 IBM SISUM01 25/08/2022 #roll back HEI.07
    // HEI.09 CHG2178734 IBM SISU01  07/11/2022 #add Item Category Code as filter
    // HEI.10 CHG2167931 IBM SISUM01 19/11/2022 #add new fields starting with OVE, TRP and FIX (split Handlig allocation)
    // HEI.11 CHG2175297 IBM SISUM01 30/03/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #add new column for C2S Reconcilation report

    // BC Upgrade POENAB02: Original (HeiLite) query id 50014

    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            filter(No; "No.")
            {
            }
            filter(PostingDate; "Posting Date")
            {
            }
            filter(SourceDocument; "Source Document")
            {
            }
            filter(LotDestination; "Lot No. & Destination No.")
            {
            }
            filter(ItemNo; "Item No.")
            {
            }
            filter(EntryNo; "Entry No.")
            {
            }
            filter(OriginialLotLocation; "Originial Lot & Location Code")
            {
            }
            filter(Destination; "Destination No.")
            {
            }
            filter(Location; "Location Code")
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
            filter(ParentLineNo; "Parent Line No.")
            {
            }
            filter(ItemCategoryCode; "Item Category Code")
            {
            }
            column(TotalPickingFactor; "Picking Factor")
            {
                Method = Sum;
            }
            column(TotalNetWeight; "Net Weight (Kg)")
            {
                Method = Sum;
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
            column(TotalDistance; Distance)
            {
                Method = Sum;
            }
            column(TotalDrops; "No. of Drops")
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
            column(NoOfLines)
            {
                Method = Count;
            }
            column(TotalPeriodGLCostDeliveryCust; "Period G/L Cost Delivery Cust.")
            {
                Method = Sum;
            }
            column(TotalPeriodGLCostGenOverheads; "Period G/L Cost Gen. Overheads")
            {
                Method = Sum;
            }
            column(TotalPeriodGLCostWhseHandling; "Period G/L Cost Whse. Handling")
            {
                Method = Sum;
            }
            column(TotalPeriodGLCostWhseOverhead; "Period G/L Cost Whse. Overhead")
            {
                Method = Sum;
            }
            column(TotalPeriodGLCostOwnFleet; "Period G/L Cost Own Fleet")
            {
                Method = Sum;
            }
            column(TotalWeightAllocationOwnFleet; "Weight Allocation Own Fleet")
            {
                Method = Sum;
            }
            column(TotalNoofDropsAllOwnFleet; "No. of Drops All. Own Fleet")
            {
                Method = Sum;
            }
            column(TotaDistanceAllocationOwnFleet; "Distance Allocation Own Fleet")
            {
                Method = Sum;
            }
            column(TotalOVEWarehouseHandling; "OVE Warehouse Handling")
            {
                Method = Sum;
            }
            column(TotalTRPWarehouseHandling; "TRP Warehouse Handling")
            {
                Method = Sum;
            }
            column(TotalFIXWarehouseHandling; "FIX Warehouse Handling")
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

