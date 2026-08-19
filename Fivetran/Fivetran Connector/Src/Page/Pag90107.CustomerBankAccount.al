page 90107 "API - Customer Bank Accounts"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityName = 'customerBankAccount';
    EntitySetName = 'customerBankAccounts';
    SourceTable = "Customer Bank Account";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }

                field(code; Rec.Code)
                {
                    Caption = 'Code';
                }

                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }

                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }

                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }

                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }

                field(city; Rec.City)
                {
                    Caption = 'City';
                }

                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }

                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }

                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }

                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }

                field(bankBranchNo; Rec."Bank Branch No.")
                {
                    Caption = 'Bank Branch No.';
                }

                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }

                field(transitNo; Rec."Transit No.")
                {
                    Caption = 'Transit No.';
                }

                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }

                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }

                field(county; Rec.County)
                {
                    Caption = 'County';
                }

                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }

                field(telexAnswerBack; Rec."Telex Answer Back")
                {
                    Caption = 'Telex Answer Back';
                }

                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }

                field(email; Rec."E-Mail")
                {
                    Caption = 'Email';
                }

                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }

                field(iban; Rec.IBAN)
                {
                    Caption = 'IBAN';
                }

                field(swiftCode; Rec."SWIFT Code")
                {
                    Caption = 'SWIFT Code';
                }

                field(bankClearingCode; Rec."Bank Clearing Code")
                {
                    Caption = 'Bank Clearing Code';
                }

                field(bankClearingStandard; Rec."Bank Clearing Standard")
                {
                    Caption = 'Bank Clearing Standard';
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