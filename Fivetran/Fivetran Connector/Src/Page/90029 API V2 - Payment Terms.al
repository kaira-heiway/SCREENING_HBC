page 90029 "API V2 - Payment Terms"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Payment Term';
    EntitySetCaption = 'Payment Terms';
    ODataKeyFields = SystemId;
    EntityName = 'paymentTerm';
    EntitySetName = 'paymentTerms';
    SourceTable = "Payment Terms";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(calcPmtDiscOnCrMemos; Rec."Calc. Pmt. Disc. on Cr. Memos")
                {
                    Caption = 'Calc. Pmt. Disc. on Cr. Memos';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(discount; Rec."Discount %")
                {
                    Caption = 'Discount %';
                }
                field(discountDateCalculation; Rec."Discount Date Calculation")
                {
                    Caption = 'Discount Date Calculation';
                }
                field(dueDateCalculation; Rec."Due Date Calculation")
                {
                    Caption = 'Due Date Calculation';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                // field(satPaymentTerm; Rec."SAT Payment Term")
                // {
                //     Caption = 'SAT Payment Term';
                // }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
