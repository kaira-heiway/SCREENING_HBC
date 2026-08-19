namespace GenExt.GenExt;

using Microsoft.Warehouse.Request;

tableextension 50232 WarehouseRequestExtFND extends "Warehouse Request"
{
    //BC UPGRADE ATHUKS01 FDDSTP_GAP11 Added new field for Maximo Purchase Receipt.
    fields
    {
        field(50001; "Warehouse Rcpt/Shpt No. FND"; Code[20])
        {
            Caption = 'Warehouse Rcpt/Shpt No.';
            DataClassification = ToBeClassified;
        }
    }
}
