page 90154 "Vendor Bank Account API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Vendor Bank Account';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Vendor Bank Account';
    EntitySetCaption = 'Vendor Bank Account';
    EntityName = 'VendorBankAccount';
    EntitySetName = 'VendorBankAccount';
    SourceTable = "Vendor Bank Account";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(accountType; Rec."Account Type FND")
                {
                    Caption = 'Account Type';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(bankBranchNo; Rec."Bank Branch No.")
                {
                    Caption = 'Bank Branch No.';
                }
                field(bankClearingCode; Rec."Bank Clearing Code")
                {
                    Caption = 'Bank Clearing Code';
                }
                field(bankClearingStandard; Rec."Bank Clearing Standard")
                {
                    Caption = 'Bank Clearing Standard';
                }
                field(bankMethod; Rec."Bank Method FND")
                {
                    Caption = 'Bank Method';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(code; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(compensationBank; Rec."Compensation Bank FND")
                {
                    Caption = 'Compensation Bank';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(domesticBankBranchNo; Rec."Domestic - Bank Branch No. FND")
                {
                    Caption = 'Domestic - Bank Branch No.';
                }
                field(email; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }
                field(iban; Rec.IBAN)
                {
                    Caption = 'IBAN';
                }
                field(intermediaryBankMethod; Rec."Intermediary Bank Method FND")
                {
                    Caption = 'Intermediary Bank Method';
                }
                field(intermediaryRoute; Rec."Intermediary Route FND")
                {
                    Caption = 'Intermediary Route';
                }
                field(intermBankBICSWIFTCode; Rec."Interm. Bank BIC/SWIFT Cod FND")
                {
                    Caption = 'Interm. Bank BIC/SWIFT Code';
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }
                field(markedForDeletion; Rec."Marked for Deletion FND")
                {
                    Caption = 'Marked for Deletion';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(oldBankAccountNo; Rec."Old Bank Account No. FND")
                {
                    Caption = 'Old Bank Account No.';
                }
                field(oldBankBranchNo; Rec."Old Bank Branch No. FND")
                {
                    Caption = 'Old Bank Branch No.';
                }
                field(oldIBAN; Rec."Old IBAN FND")
                {
                    Caption = 'Old IBAN';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(swiftCode; Rec."SWIFT Code")
                {
                    Caption = 'SWIFT Code';
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
                field(telexAnswerBack; Rec."Telex Answer Back")
                {
                    Caption = 'Telex Answer Back';
                }
                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }
                field(transitNo; Rec."Transit No.")
                {
                    Caption = 'Transit No.';
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
            }
        }
    }
}
