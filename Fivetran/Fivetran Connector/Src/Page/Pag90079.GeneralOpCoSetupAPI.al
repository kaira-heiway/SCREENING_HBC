namespace fivetran.fivetran;

page 90079 "General OpCo Setup API"
{
    APIGroup = 'customEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'General OpCo Setup API';
    DelayedInsert = true;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    EntityName = 'generalOpCoSetupFND';
    EntitySetName = 'generalOpCoSetupFND';
    PageType = API;
    SourceTable = "General OpCo Setup FND";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(primaryKey; Rec."Primary Key")
                {
                    Caption = 'Primary Key';
                }
                field(payrollReportID; Rec."Payroll Report ID")
                {
                    Caption = 'Payroll Report ID';
                }
                field(unloadingNoteReportID; Rec."Unloading Note Report ID")
                {
                    Caption = 'Unloading Note Report ID';
                }
                field(rcLocationCode; Rec."RC Location Code")
                {
                    Caption = 'RC Location Code';
                }
                field(rcBrewingZoneCode; Rec."RC Brewing Zone code")
                {
                    Caption = 'RC Brewing Zone code';
                }
                field(rcFMatZoneCode; Rec."RC F&Mat Zone Code")
                {
                    Caption = 'RC F&Mat Zone Code';
                }
                field(rcFMixZoneCode; Rec."RC F&Mix Zone Code")
                {
                    Caption = 'RC F&Mix Zone Code';
                }
                field(rcPackagingZoneCode; Rec."RC Packaging Zone Code")
                {
                    Caption = 'RC Packaging Zone Code';
                }
                field(enableRequestOrder; Rec."Enable Request Order")
                {
                    Caption = 'Enable Request Order';
                }
                field(enableDigitalCheckPrintout; Rec."Enable Digital Check Printout")
                {
                    Caption = 'Enable Digital Check Printout';
                }
                field(enableSendToMaraki; Rec."Enable Send to Maraki")
                {
                    Caption = 'Enable Send to Maraki';
                }
                field(enableBVMIntegration; Rec."Enable BVM Integration")
                {
                    Caption = 'Enable BVM Integration';
                }
                field(exportPath; Rec."Export Path")
                {
                    Caption = 'Export Path';
                }
                field(genJournalTemplate; Rec."Gen. Journal Template")
                {
                    Caption = 'Payroll Gen. Journal Template';
                }
                field(genJournalBatch; Rec."Gen. Journal Batch")
                {
                    Caption = 'Payroll Gen. Journal Batch';
                }
                field(employeePayrollDimension; Rec."Employee Payroll Dimension")
                {
                    Caption = 'Employee Payroll Dimension';
                }
                field(sparePartConsumption; Rec."Spare Part Consumption")
                {
                    Caption = 'Spare Part Consumption';
                }
                field(brcLocationCode; Rec."BRC Location Code")
                {
                    Caption = 'BRC Location Code';
                }
                field(localVendorType; Rec."Local Vendor type")
                {
                    Caption = 'Local Vendor type';
                }
                field(itemCategory; Rec."Item Category")
                {
                    Caption = 'Item Category';
                }
                field(depositOnTheNetPrice; Rec."Deposit% on the net price")
                {
                    Caption = 'Deposit% on the net price';
                }
                field(bankName3; Rec."Bank Name 3")
                {
                    Caption = 'Bank Name 3';
                }
                field(bankAccountNo3; Rec."Bank Account No. 3")
                {
                    Caption = 'Bank Account No. 3';
                }
                field(iban3; Rec."IBAN 3")
                {
                    Caption = 'IBAN 3';
                }
                field(swiftCode3; Rec."SWIFT Code 3")
                {
                    Caption = 'SWIFT Code 3';
                }
                field(bankName4; Rec."Bank Name 4")
                {
                    Caption = 'Bank Name 4';
                }
                field(bankAccountNo4; Rec."Bank Account No. 4")
                {
                    Caption = 'Bank Account No. 4';
                }
                field(iban4; Rec."IBAN 4")
                {
                    Caption = 'IBAN 4';
                }
                field(swiftCode4; Rec."SWIFT Code 4")
                {
                    Caption = 'SWIFT Code 4';
                }
                field(bankName5; Rec."Bank Name 5")
                {
                    Caption = 'Bank Name 5';
                }
                field(bankAccountNo5; Rec."Bank Account No. 5")
                {
                    Caption = 'Bank Account No. 5';
                }
                field(iban5; Rec."IBAN 5")
                {
                    Caption = 'IBAN 5';
                }
                field(swiftCode5; Rec."SWIFT Code 5")
                {
                    Caption = 'SWIFT Code 5';
                }
                field(bankName6; Rec."Bank Name 6")
                {
                    Caption = 'Bank Name 6';
                }
                field(bankAccountNo6; Rec."Bank Account No. 6")
                {
                    Caption = 'Bank Account No. 6';
                }
                field(iban6; Rec."IBAN 6")
                {
                    Caption = 'IBAN 6';
                }
                field(swiftCode6; Rec."SWIFT Code 6")
                {
                    Caption = 'SWIFT Code 6';
                }
                field(reportInvoiceType3; Rec."Report Invoice Type 3")
                {
                    Caption = 'Report Invoice Type 3';
                }
                field(reportInvoiceType4; Rec."Report Invoice Type 4")
                {
                    Caption = 'Report Invoice Type 4';
                }
                field(reportInvoiceType5; Rec."Report Invoice Type 5")
                {
                    Caption = 'Report Invoice Type 5';
                }
                field(reportInvoiceType6; Rec."Report Invoice Type 6")
                {
                    Caption = 'Report Invoice Type 6';
                }
                field(currency3; Rec."Currency 3")
                {
                    Caption = 'Currency 3';
                }
                field(frenchPaymentRemittance; Rec."French Payment Remittance")
                {
                    Caption = 'French Payment Remittance';
                }
                field(paymentRemittanceLanguage; Rec."Payment Remittance Language")
                {
                    Caption = 'Payment Remittance Language';
                }
                field(ebfSCOARangeStartPosition; Rec."EBF SCOA Range Start Position")
                {
                    Caption = 'EBF SCOA Range Start Position';
                }
                field(ebfSCOARangeDigitNos; Rec."EBF SCOA Range Digit Nos.")
                {
                    Caption = 'EBF SCOA Range Digit Nos.';
                }
                field(ebfOperatorFilter; Rec."EBF Operator Filter")
                {
                    Caption = 'EBF Operator Filter';
                }
                field(ebfDimFilterStartPosition; Rec."EBF Dim Filter Start Position")
                {
                    Caption = 'EBF Dim Filter Start Position';
                }
                field(ebfDimFilterDigitNos; Rec."EBF Dim Filter Digit Nos.")
                {
                    Caption = 'EBF Dim Filter Digit Nos.';
                }
                field(enableNewEBFMatrixVersion; Rec."Enable New EBF Matrix Version")
                {
                    Caption = 'Enable New EBF Matrix Version';
                }
                field(excludeInterregWISAndMSV; Rec."Exclude Interreg. WIS and MSV")
                {
                    Caption = 'Exclude Interreg. WIS and MSV';
                }
                field(validateDimensionValueEBF; Rec."Validate Dimension Value (EBF)")
                {
                    Caption = 'Validate Dimension Value (EBF)';
                }
                field(spanishPaymentRemittance; Rec."Spanish Payment Remittance")
                {
                    Caption = 'Spanish Payment Remittance';
                }
                field(paymentRemittanceLanguageSp; Rec."Payment Remittance Language Sp")
                {
                    Caption = 'Payment Remittance Language Sp';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
