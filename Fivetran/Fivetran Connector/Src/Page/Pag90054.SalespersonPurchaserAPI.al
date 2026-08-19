namespace INTERFACES.INTERFACES;

using Microsoft.CRM.Team;

page 90054 "Salesperson_Purchaser"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Salesperson/Purchaser API';
    DelayedInsert = true;
    EntityName = 'salespersonPurchaser';
    EntitySetName = 'salespersonPurchaser';
    PageType = API;
    SourceTable = "Salesperson/Purchaser";
    odataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(commission; Rec."Commission %")
                {
                    Caption = 'Commission %';
                }
                field(image; Rec.Image)
                {
                    Caption = 'Image';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(jobTitle; Rec."Job Title")
                {
                    Caption = 'Job Title';
                }
                field(searchEMail; Rec."Search E-Mail")
                {
                    Caption = 'Search Email';
                }
                field(eMail2; Rec."E-Mail 2")
                {
                    Caption = 'Email 2';
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
