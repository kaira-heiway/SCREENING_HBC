page 90006 "Contact"
{
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Contact';
    EntitySetCaption = 'Contacts';
    DelayedInsert = true;
    EntityName = 'contact';
    EntitySetName = 'contacts';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = Contact;

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
                field(calcdCurrentValueLCY; Rec."Calcd. Current Value (LCY)")
                {
                    Caption = 'Calcd. Current Value (LCY)';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(companyName; Rec."Company Name")
                {
                    Caption = 'Company Name';
                }
                field(companyNo; Rec."Company No.")
                {
                    Caption = 'Company No.';
                }
                field(contactBusinessRelation; Rec."Contact Business Relation")
                {
                    Caption = 'Contact Business Relation';
                }
                field(correspondenceType; Rec."Correspondence Type")
                {
                    Caption = 'Correspondence Type';
                }
                field(costLCY; Rec."Cost (LCY)")
                {
                    Caption = 'Cost (LCY)';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(coupledToDataverse; Rec."Coupled to Dataverse")
                {
                    Caption = 'Coupled to Dataverse';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(dateOfLastInteraction; Rec."Date of Last Interaction")
                {
                    Caption = 'Date of Last Interaction';
                }
                field(durationMin; Rec."Duration (Min.)")
                {
                    Caption = 'Duration (Min.)';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(eMail2; Rec."E-Mail 2")
                {
                    Caption = 'Email 2';
                }
                field(estimatedValueLCY; Rec."Estimated Value (LCY)")
                {
                    Caption = 'Estimated Value (LCY)';
                }
                field(excludeFromSegment; Rec."Exclude from Segment")
                {
                    Caption = 'Exclude from Segment';
                }
                field(extensionNo; Rec."Extension No.")
                {
                    Caption = 'Extension No.';
                }
                field(externalID; Rec."External ID")
                {
                    Caption = 'External ID';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(firstName; Rec."First Name")
                {
                    Caption = 'First Name';
                }
                field(formatRegion; Rec."Format Region")
                {
                    Caption = 'Format Region';
                }
                field(image; Rec.Image)
                {
                    Caption = 'Image';
                }
                field(initials; Rec.Initials)
                {
                    Caption = 'Initials';
                }
                field(jobTitle; Rec."Job Title")
                {
                    Caption = 'Job Title';
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }
                field(lastDateAttempted; Rec."Last Date Attempted")
                {
                    Caption = 'Last Date Attempted';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(lastTimeModified; Rec."Last Time Modified")
                {
                    Caption = 'Last Time Modified';
                }
                field(lookupContactNo; Rec."Lookup Contact No.")
                {
                    Caption = 'Lookup Contact No.';
                }
                field(middleName; Rec."Middle Name")
                {
                    Caption = 'Middle Name';
                }
                field(minor; Rec.Minor)
                {
                    Caption = 'Minor';
                }
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(nextTaskDate; Rec."Next Task Date")
                {
                    Caption = 'Next Task Date';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(noOfBusinessRelations; Rec."No. of Business Relations")
                {
                    Caption = 'No. of Business Relations';
                }
                field(noOfIndustryGroups; Rec."No. of Industry Groups")
                {
                    Caption = 'No. of Industry Groups';
                }
                field(noOfInteractions; Rec."No. of Interactions")
                {
                    Caption = 'No. of Interactions';
                }
                field(noOfJobResponsibilities; Rec."No. of Job Responsibilities")
                {
                    Caption = 'No. of Job Responsibilities';
                }
                field(noOfMailingGroups; Rec."No. of Mailing Groups")
                {
                    Caption = 'No. of Mailing Groups';
                }
                field(noOfOpportunities; Rec."No. of Opportunities")
                {
                    Caption = 'No. of Opportunities';
                }
                field(opportunityEntryExists; Rec."Opportunity Entry Exists")
                {
                    Caption = 'Opportunity Entry Exists';
                }
                field(organizationalLevelCode; Rec."Organizational Level Code")
                {
                    Caption = 'Organizational Level Code';
                }
                field(pager; Rec.Pager)
                {
                    Caption = 'Pager';
                }
                field(parentalConsentReceived; Rec."Parental Consent Received")
                {
                    Caption = 'Parental Consent Received';
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
                field(registrationNumber; Rec."Registration Number")
                {
                    Caption = 'Registration No.';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(salutationCode; Rec."Salutation Code")
                {
                    Caption = 'Salutation Code';
                }
                field(searchEMail; Rec."Search E-Mail")
                {
                    Caption = 'Search Email';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(surname; Rec.Surname)
                {
                    Caption = 'Surname';
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
                field(taskEntryExists; Rec."Task Entry Exists")
                {
                    Caption = 'Task Entry Exists';
                }
                field(telexAnswerBack; Rec."Telex Answer Back")
                {
                    Caption = 'Telex Answer Back';
                }
                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }
                field(territoryCode; Rec."Territory Code")
                {
                    Caption = 'Territory Code';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                }
                field(xrmId; Rec."Xrm Id")
                {
                    Caption = 'Xrm Id';
                }
                field(actionTakenFilter; Rec."Action Taken Filter")
                {
                    Caption = 'Action Taken Filter';
                }
                field(calcdCurrentValueFilter; Rec."Calcd. Current Value Filter")
                {
                    Caption = 'Calcd. Current Value Filter';
                }
                field(campaignFilter; Rec."Campaign Filter")
                {
                    Caption = 'Campaign Filter';
                }
                field(chancesOfSuccessFilter; Rec."Chances of Success % Filter")
                {
                    Caption = 'Chances of Success % Filter';
                }
                field(closeOpportunityFilter; Rec."Close Opportunity Filter")
                {
                    Caption = 'Close Opportunity Filter';
                }
                field(completedFilter; Rec."Completed % Filter")
                {
                    Caption = 'Completed % Filter';
                }
                field(dateFilter; Rec."Date Filter")
                {
                    Caption = 'Date Filter';
                }
                field(estimatedValueFilter; Rec."Estimated Value Filter")
                {
                    Caption = 'Estimated Value Filter';
                }
                field(jobResponsibilityFilter; Rec."Job Responsibility Filter")
                {
                    Caption = 'Job Responsibility Filter';
                }
                field(priorityFilter; Rec."Priority Filter")
                {
                    Caption = 'Priority Filter';
                }
                field(probabilityFilter; Rec."Probability % Filter")
                {
                    Caption = 'Probability % Filter';
                }
                field(salesCycleFilter; Rec."Sales Cycle Filter")
                {
                    Caption = 'Sales Cycle Filter';
                }
                field(salesCycleStageFilter; Rec."Sales Cycle Stage Filter")
                {
                    Caption = 'Sales Cycle Stage Filter';
                }
                field(salespersonFilter; Rec."Salesperson Filter")
                {
                    Caption = 'Salesperson Filter';
                }
                field(taskClosedFilter; Rec."Task Closed Filter")
                {
                    Caption = 'Task Closed Filter';
                }
                field(taskStatusFilter; Rec."Task Status Filter")
                {
                    Caption = 'Task Status Filter';
                }
                field(teamFilter; Rec."Team Filter")
                {
                    Caption = 'Team Filter';
                }
            }
        }
    }
}
