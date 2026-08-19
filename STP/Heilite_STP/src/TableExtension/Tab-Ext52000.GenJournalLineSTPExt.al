namespace STP.STP;

using Microsoft.Finance.GeneralLedger.Journal;

// BC Upgrade BHARDA11 >>
// 1. We created this field so that when we run the SRM-GR-VALIDATION-REQUEST from SRM, if any error occurs in a line and it creates a general journal line, we can use this field to hide those lines. 
// BC Upgrade BHARAD11 <<
tableextension 52000 GenJournalLineSTPExt extends "Gen. Journal Line"
{
    fields
    {
        field(52000; "GR Validation Temp Line FND"; Boolean)
        {
            caption = 'GR Validation Temp Line';
            DataClassification = ToBeClassified;
        }
    }
}

