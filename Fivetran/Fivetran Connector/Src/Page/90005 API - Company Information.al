page 90005 "API - Company Information"
{
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIGroup = 'standardEndpoints';
    EntityCaption = 'Company Information';
    EntitySetCaption = 'Company Information';
    DelayedInsert = true;
    DeleteAllowed = false;
    EntityName = 'companyInformation';
    EntitySetName = 'companyInformation';
    InsertAllowed = false;
    ODataKeyFields = SystemId;
    PageType = API;
    SaveValues = true;
    SourceTable = "Company Information";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(allowBlankPaymentInfo; Rec."Allow Blank Payment Info.")
                {
                    Caption = 'Allow Blank Payment Info.';
                }
                field(alternativeLanguageCode; Rec."Alternative Language Code")
                {
                    Caption = 'Alternative Language Code';
                }
                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(bankBranchNo; Rec."Bank Branch No.")
                {
                    Caption = 'Bank Branch No.';
                }
                field(bankName; Rec."Bank Name")
                {
                    Caption = 'Bank Name';
                }
                field(baseCalendarCode; Rec."Base Calendar Code")
                {
                    Caption = 'Base Calendar Code';
                }
                field(brandColorCode; Rec."Brand Color Code")
                {
                    Caption = 'Brand Color Code';
                }
                field(brandColorValue; Rec."Brand Color Value")
                {
                    Caption = 'Brand Color Value';
                }
                // field(curpNo; Rec."CURP No.")
                // {
                //     Caption = 'CURP No.';
                // }
                field(calConvergenceTimeFrame; Rec."Cal. Convergence Time Frame")
                {
                    Caption = 'Cal. Convergence Time Frame';
                }
                field(checkAvailPeriodCalc; Rec."Check-Avail. Period Calc.")
                {
                    Caption = 'Check-Avail. Period Calc.';
                }
                field(checkAvailTimeBucket; Rec."Check-Avail. Time Bucket")
                {
                    Caption = 'Check-Avail. Time Bucket';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(contactPerson; Rec."Contact Person")
                {
                    Caption = 'Contact Person';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(createdDateTime; Rec."Created DateTime")
                {
                    Caption = 'Created DateTime';
                }
                field(customSystemIndicatorText; Rec."Custom System Indicator Text")
                {
                    Caption = 'Custom System Indicator Text';
                }
                field(customsPermitDate; Rec."Customs Permit Date")
                {
                    Caption = 'Customs Permit Date';
                }
                field(customsPermitNo; Rec."Customs Permit No.")
                {
                    Caption = 'Customs Permit No.';
                }
                field(demoCompany; Rec."Demo Company")
                {
                    Caption = 'Demo Company';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(eoriNumber; Rec."EORI Number")
                {
                    Caption = 'EORI Number';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                // field(federalIDNo; Rec."Federal ID No.")
                // {
                //     Caption = 'Federal ID No.';
                // }
                field(gln; Rec.GLN)
                {
                    Caption = 'GLN';
                }
                field(giroNo; Rec."Giro No.")
                {
                    Caption = 'Giro No.';
                }
                field(iban; Rec.IBAN)
                {
                    Caption = 'IBAN';
                }
                field(industrialClassification; Rec."Industrial Classification")
                {
                    Caption = 'Industrial Classification';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(paymentRoutingNo; Rec."Payment Routing No.")
                {
                    Caption = 'Payment Routing No.';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(phoneNo2; Rec."Phone No. 2")
                {
                    Caption = 'Phone No. 2';
                }
                field(picture; Rec.Picture)
                {
                    Caption = 'Picture';
                }
                field(pictureLastModDateTime; Rec."Picture - Last Mod. Date Time")
                {
                    Caption = 'Picture - Last Mod. Date Time';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(primaryKey; Rec."Primary Key")
                {
                    Caption = 'Primary Key';
                }
                // field(provincialTaxAreaCode; Rec."Provincial Tax Area Code")
                // {
                //     Caption = 'Provincial Tax Area Code';
                // }
                // field(qstRegistrationNo; Rec."QST Registration No.")
                // {
                //     Caption = 'QST Registration No.';
                // }
                // field(rfcNumber; Rec."RFC Number")
                // {
                //     Caption = 'RFC Number';
                // }
                field(registrationNo; Rec."Registration No.")
                {
                    Caption = 'Registration No.';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                // field(satPostalCode; Rec."SAT Postal Code")
                // {
                //     Caption = 'SAT Postal Code';
                // }
                // field(satTaxRegimeClassification; Rec."SAT Tax Regime Classification")
                // {
                //     Caption = 'SAT Tax Regime Classification';
                // }

                field(swiftCode; Rec."SWIFT Code")
                {
                    Caption = 'SWIFT Code';
                }
                field(shipToAddress; Rec."Ship-to Address")
                {
                    Caption = 'Ship-to Address';
                }
                field(shipToAddress2; Rec."Ship-to Address 2")
                {
                    Caption = 'Ship-to Address 2';
                }
                field(shipToCity; Rec."Ship-to City")
                {
                    Caption = 'Ship-to City';
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact';
                }
                field(shipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    Caption = 'Ship-to Country/Region Code';
                }
                field(shipToCounty; Rec."Ship-to County")
                {
                    Caption = 'Ship-to County';
                }
                field(shipToName; Rec."Ship-to Name")
                {
                    Caption = 'Ship-to Name';
                }
                field(shipToName2; Rec."Ship-to Name 2")
                {
                    Caption = 'Ship-to Name 2';
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code';
                }
                // field(shipToUPSZone; Rec."Ship-to UPS Zone")
                // {
                //     Caption = 'Ship-to UPS Zone';
                // }
                // field(softwareIdentificationCode; Rec."Software Identification Code")
                // {
                //     Caption = 'Software Identification Code';
                // }
                // field(stateInscription; Rec."State Inscription")
                // {
                //     Caption = 'State Inscription';
                // }
                field(systemIndicator; Rec."System Indicator")
                {
                    Caption = 'System Indicator';
                }
                field(systemIndicatorStyle; Rec."System Indicator Style")
                {
                    Caption = 'System Indicator Style';
                }
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
                // field(taxAreaCode; Rec."Tax Area Code")
                // {
                //     Caption = 'Tax Area Code';
                // }
                // field(taxExemptionNo; Rec."Tax Exemption No.")
                // {
                //     Caption = 'Tax Exemption No.';
                // }
                // field(taxScheme; Rec."Tax Scheme")
                // {
                //     Caption = 'Tax Scheme';
                // }
                field(telexAnswerBack; Rec."Telex Answer Back")
                {
                    Caption = 'Telex Answer Back';
                }
                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }
                // field(upsShipperID; Rec."UPS Shipper ID")
                // {
                //     Caption = 'UPS Shipper ID';
                // }
                field(useGLNInElectronicDocument; Rec."Use GLN in Electronic Document")
                {
                    Caption = 'Use GLN in Electronic Documents';
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                }
                //BC UPGRADE KUMARR78 >>
                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }

                field(languageCode; Rec."Language Code FND")
                {
                    Caption = 'Language Code';
                }

                field(reportingEntity; Rec."Reporting Entity FND")
                {
                    Caption = 'Reporting Entity';
                }

                field(businessType; Rec."Business Type FND")
                {
                    Caption = 'Business Type';
                }

                field(whtRegistrationID; Rec."WHT Registration ID FND")
                {
                    Caption = 'WHT Registration ID';
                }

                field(rdoCode; Rec."RDO Code FND")
                {
                    Caption = 'RDO Code';
                }

                field(capSocial; Rec."Cap. Social FND")
                {
                    Caption = 'Cap. Social';
                }

                field(checkDigit; Rec."Check Digit FND")
                {
                    Caption = 'Check Digit';
                }

                field(invoiceName; Rec."Invoice Name FND")
                {
                    Caption = 'Invoice Name';
                }

                field(invoiceAddress; Rec."Invoice Address FND")
                {
                    Caption = 'Invoice Address';
                }

                field(invoiceAddress2; Rec."Invoice Address2 FND")
                {
                    Caption = 'Invoice Address2';
                }

                field(invoiceCity; Rec."Invoice City FND")
                {
                    Caption = 'Invoice City';
                }

                field(invoicePostCode; Rec."Invoice Post Code FND")
                {
                    Caption = 'Invoice Post Code';
                }

                field(rccmLegalEntityCode; Rec."RCCM Legal entity code FND")
                {
                    Caption = 'RCCM Legal entity code';
                }

                field(opCoLogo; Rec."OpCo Logo FND")
                {
                    Caption = 'OpCo Logo';
                }

                field(enterpriseNo; Rec."Enterprise No. FND")
                {
                    Caption = 'Enterprise No.';
                }

                field(enterpriseNoAccountant; Rec."Enterprise No. Accountant FND")
                {
                    Caption = 'Enterprise No. Accountant';
                }

                field(opCoFooterImage; Rec."OpCo Footer image FND")
                {
                    Caption = 'OpCo Footer image';
                }

                field(enableFrenchLocalization; Rec."Enable French Localization FND")
                {
                    Caption = 'Enable French Localization';
                }

                field(poLegalTextBoxEMail; Rec."PO Legal Text Box E-Mail FND")
                {
                    Caption = 'PO Legal Text Box E-Mail';
                }

                field(addAddress; Rec."Add. Address FND")
                {
                    Caption = 'Add. Address';
                }

                field(addCity; Rec."Add. City FND")
                {
                    Caption = 'Add. City';
                }

                field(addPhoneNo; Rec."Add. Phone No. FND")
                {
                    Caption = 'Add. Phone No.';
                }

                field(addPostCode; Rec."Add. Post Code FND")
                {
                    Caption = 'Add. Post Code';
                }

                field(plantOpeningHrs; Rec."Plant Opening Hrs. FND")
                {
                    Caption = 'Plant Opening Hrs.';
                }

                field(signatureImage; Rec."Signature Image FND")
                {
                    Caption = 'Signature Image';
                }

                field(currency; Rec."Currency FND")
                {
                    Caption = 'Currency';
                }

                field(currency2; Rec."Currency 2 FND")
                {
                    Caption = 'Currency 2';
                }

                field(opCoCodeForCFAO; Rec."OpCo Code for CFAO FND")
                {
                    Caption = 'OpCo Code for CFAO';
                }

                field(legalEntityCode; Rec."Legal Entity Code FND")
                {
                    Caption = 'Legal Entity Code';
                }

                field(AddressPositiononDocuments; Rec."Address Position on Docs FND")
                {
                    Caption = 'Address Position on Documents';
                }

                field(BankName2; Rec."Bank Name 2 FND")
                {
                    Caption = 'Bank Name 2';
                }

                field(BankAccountNo2; Rec."Bank Account No. 2 FND")
                {
                    Caption = 'Bank Account No. 2';
                }

                field(IBAN2; Rec."IBAN 2 FND")
                {
                    Caption = 'IBAN 2';
                }

                field(SWIFTCode2; Rec."SWIFT Code 2 FND")
                {
                    Caption = 'SWIFT Code 2';
                }

                field(AccountPayableEmailFND; Rec."Account Payable Email FND")
                {
                    Caption = 'Account Payable Email FND';
                }
                //BC UPGRADE KUMARR78 <<
            }
        }
    }
}
