namespace STP.STP;

using Microsoft.FixedAssets.Journal;

// 1.These fields will hide those records from the page where the value is set to true, and this value will be marked as true when the process is UNDO from SRM.
// BC Upgrade BHARAD11 <<
pageextension 52028 "FixedAssetG/LJournalExt" extends "Fixed Asset G/L Journal"
{
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(0);
        Rec.SetRange("GR Validation Temp Line FND", false);
        Rec.FilterGroup(2);
    end;
}
