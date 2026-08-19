

pageextension 53045 "Ext Warehouse Shipment MTC" extends "Warehouse Shipment"
{

    //BC UPGRADE KUMARR78 FDD-MTC-007
    actions
    {
        modify(CreateGateEntryOutbound)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
                CU_BatchPostCollec: Codeunit BatchPostCollector;
            begin
                CU_BatchPostCollec.CreateGateEntryOutbound(Rec); //HEI.04
            end;
        }
        //BC UPGRADE KUMARR78 FDD-MTC-007
    }
}
