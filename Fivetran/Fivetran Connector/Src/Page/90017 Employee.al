page 90017 "Employee"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'employee';
    EntitySetCaption = 'mployees';
    ODataKeyFields = SystemId;
    EntityName = 'employee';
    EntitySetName = 'employees';
    SourceTable = Employee;

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
                field(altAddressCode; Rec."Alt. Address Code")
                {
                    Caption = 'Alt. Address Code';
                }
                field(altAddressEndDate; Rec."Alt. Address End Date")
                {
                    Caption = 'Alt. Address End Date';
                }
                field(altAddressStartDate; Rec."Alt. Address Start Date")
                {
                    Caption = 'Alt. Address Start Date';
                }
                field(applicationMethod; Rec."Application Method")
                {
                    Caption = 'Application Method';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(bankBranchNo; Rec."Bank Branch No.")
                {
                    Caption = 'Bank Branch No.';
                }
                field(birthDate; Rec."Birth Date")
                {
                    Caption = 'Birth Date';
                }
                field(causeOfInactivityCode; Rec."Cause of Inactivity Code")
                {
                    Caption = 'Cause of Inactivity Code';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(companyEMail; Rec."Company E-Mail")
                {
                    Caption = 'Company Email';
                }
                field(costCenterCode; Rec."Cost Center Code")
                {
                    Caption = 'Cost Center Code';
                }
                field(costObjectCode; Rec."Cost Object Code")
                {
                    Caption = 'Cost Object Code';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(employeePostingGroup; Rec."Employee Posting Group")
                {
                    Caption = 'Employee Posting Group';
                }
                field(employmentDate; Rec."Employment Date")
                {
                    Caption = 'Employment Date';
                }
                field(emplymtContractCode; Rec."Emplymt. Contract Code")
                {
                    Caption = 'Emplymt. Contract Code';
                }
                field(extension; Rec.Extension)
                {
                    Caption = 'Extension';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(firstName; Rec."First Name")
                {
                    Caption = 'First Name';
                }
                field(gender; Rec.Gender)
                {
                    Caption = 'Gender';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(groundsForTermCode; Rec."Grounds for Term. Code")
                {
                    Caption = 'Grounds for Term. Code';
                }
                field(iban; Rec.IBAN)
                {
                    Caption = 'IBAN';
                }
                field(image; Rec.Image)
                {
                    Caption = 'Image';
                }
                field(inactiveDate; Rec."Inactive Date")
                {
                    Caption = 'Inactive Date';
                }
                field(initials; Rec.Initials)
                {
                    Caption = 'Initials';
                }
                field(jobTitle; Rec."Job Title")
                {
                    Caption = 'Job Title';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(lastName; Rec."Last Name")
                {
                    Caption = 'Last Name';
                }
                // field(licenseNo; Rec."License No.")
                // {
                //     Caption = 'License No.';
                // }
                field(managerNo; Rec."Manager No.")
                {
                    Caption = 'Manager No.';
                }
                field(middleName; Rec."Middle Name")
                {
                    Caption = 'Middle Name';
                }
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(pager; Rec.Pager)
                {
                    Caption = 'Pager';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(privacyBlocked; Rec."Privacy Blocked")
                {
                    Caption = 'Privacy Blocked';
                }
                // field(rfcNo; Rec."RFC No.")
                // {
                //     Caption = 'RFC No.';
                // }
                field(resourceNo; Rec."Resource No.")
                {
                    Caption = 'Resource No.';
                }
                field(swiftCode; Rec."SWIFT Code")
                {
                    Caption = 'SWIFT Code';
                }
                field(salespersPurchCode; Rec."Salespers./Purch. Code")
                {
                    Caption = 'Salespers./Purch. Code';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(socialSecurityNo; Rec."Social Security No.")
                {
                    Caption = 'Social Security No.';
                }
                field(statisticsGroupCode; Rec."Statistics Group Code")
                {
                    Caption = 'Statistics Group Code';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
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
                field(terminationDate; Rec."Termination Date")
                {
                    Caption = 'Termination Date';
                }
                field(title; Rec.Title)
                {
                    Caption = 'Title';
                }
                field(totalAbsenceBase; Rec."Total Absence (Base)")
                {
                    Caption = 'Total Absence (Base)';
                }
                field(unionCode; Rec."Union Code")
                {
                    Caption = 'Union Code';
                }
                field(unionMembershipNo; Rec."Union Membership No.")
                {
                    Caption = 'Union Membership No.';
                }
                field(causeOfAbsenceFilter; Rec."Cause of Absence Filter")
                {
                    Caption = 'Cause of Absence Filter';
                }
                field(dateFilter; Rec."Date Filter")
                {
                    Caption = 'Date Filter';
                }
                field(employeeNoFilter; Rec."Employee No. Filter")
                {
                    Caption = 'Employee No. Filter';
                }
                field(globalDimension1Filter; Rec."Global Dimension 1 Filter")
                {
                    Caption = 'Global Dimension 1 Filter';
                }
                field(globalDimension2Filter; Rec."Global Dimension 2 Filter")
                {
                    Caption = 'Global Dimension 2 Filter';
                }
            }
        }
    }
}
