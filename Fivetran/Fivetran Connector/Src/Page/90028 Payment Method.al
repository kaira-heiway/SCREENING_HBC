page 90028 "Payment Method"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Payment Method';
    EntitySetCaption = 'Payment Methods';
    ODataKeyFields = SystemId;
    EntityName = 'paymentMethod';
    EntitySetName = 'paymentMethods';
    SourceTable = "Payment Method";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(directDebit; Rec."Direct Debit")
                {
                    Caption = 'Direct Debit';
                }
                field(directDebitPmtTermsCode; Rec."Direct Debit Pmt. Terms Code")
                {
                    Caption = 'Direct Debit Pmt. Terms Code';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(pmtExportLineDefinition; Rec."Pmt. Export Line Definition")
                {
                    Caption = 'Pmt. Export Line Definition';
                }
                // field(satMethodOfPayment; Rec."SAT Method of Payment")
                // {
                //     Caption = 'SAT Method of Payment';
                // }
                // field(satPaymentMethodCode; Rec."SAT Payment Method Code")
                // {
                //     Caption = 'SAT Payment Method Code';
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
