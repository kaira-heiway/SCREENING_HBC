page 90015 "Dimension Value"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Dimension Value';
    EntitySetCaption = 'Dimension Values';
    ODataKeyFields = SystemId;
    EntityName = 'dimensionValue';
    EntitySetName = 'dimensionValues';
    SourceTable = "Dimension Value";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(consolidationCode; Rec."Consolidation Code")
                {
                    Caption = 'Consolidation Code';
                }
                field(dimensionCode; Rec."Dimension Code")
                {
                    Caption = 'Dimension Code';
                }
                field(dimensionId; Rec."Dimension Id")
                {
                    Caption = 'Dimension Id';
                }
                field(dimensionValueID; Rec."Dimension Value ID")
                {
                    Caption = 'Dimension Value ID';
                }
                field(dimensionValueType; Rec."Dimension Value Type")
                {
                    Caption = 'Dimension Value Type';
                }
                field(globalDimensionNo; Rec."Global Dimension No.")
                {
                    Caption = 'Global Dimension No.';
                }
                field(indentation; Rec.Indentation)
                {
                    Caption = 'Indentation';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(mapToICDimensionCode; Rec."Map-to IC Dimension Code")
                {
                    Caption = 'Map-to IC Dimension Code';
                }
                field(mapToICDimensionValueCode; Rec."Map-to IC Dimension Value Code")
                {
                    Caption = 'Map-to IC Dimension Value Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
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
                field(totaling; Rec.Totaling)
                {
                    Caption = 'Totaling';
                }
                field(businessTypeDimValueCode; REC."Business TypeDimValue Code FND")
                {
                    Caption = 'Business Type Dim Value Code';
                }
                field(cilCode; Rec."CIL Code FND")
                {
                    Caption = 'CIL Code';
                }
                field(approverID; Rec."Approver ID FND")
                {
                    Caption = 'Approver ID';
                }
                field(businessTypeDimensionCode; Rec."Business Type Dime. Code FND")
                {
                    Caption = 'Business Type Dimension Code';
                }
                field(approverName; Rec."Approver Name FND")
                {
                    Caption = 'Approver Name';
                }
                field(reportingEntity; Rec."Reporting Entity FND")
                {
                    Caption = 'Reporting Entity';
                }
                field(linkedDimensionCode; Rec."Linked Dimension Code FND")
                {
                    Caption = 'Linked Dimension Code';
                }
                field(linkedDimensionValueCode; Rec."Linked Dime. Value Code FND")
                {
                    Caption = 'Linked Dimension Value Code';
                }
                field(minOrderValueLimit; Rec."Min. Order Value Limit FND")
                {
                    Caption = 'Min. Order Value Limit';
                }
                field(minOrderValueLimitType; Rec."Min. Ord. Value Limit Type FND")
                {
                    Caption = 'Min. Order Value Limit Type';
                }
                field(licenseExpirationDate; Rec."License Expiration Date FND")
                {
                    Caption = 'License Expiration Date';
                }
                field(sendWMSAstro; Rec."Send WMS Astro FND")
                {
                    Caption = 'Send WMS Astro';
                }
                field(coDCoCNumber; Rec."CoD/CoC Number FND")
                {
                    Caption = 'CoD/CoC Number';
                }
                field(lastDateTimeModifiedZycus; Rec."Last DateTime Modif. Zycus FND")
                {
                    Caption = 'Last Date-Time Modified Zycus';
                }
                field(updatedSpecialCharZycus; Rec."Updated Special Char Zycus FND")
                {
                    Caption = 'Updated Special Char Zycus';
                }
                field(businessTypeDimValueCodeFND; Rec."Business TypeDimValue Code FND")
                {
                    Caption = 'Business Type Dimension Value Code';
                }
                field(cilCodeFND; Rec."CIL Code FND")
                {
                    Caption = 'CIL Code';
                }
                field(approverIDFND; Rec."Approver ID FND")
                {
                    Caption = 'Approver ID';
                }
                field(businessTypeDimensionCodeFND; Rec."Business Type Dime. Code FND")
                {
                    Caption = 'Business Type Dimension Code';
                }
                field(approverNameFND; Rec."Approver Name FND")
                {
                    Caption = 'Approver Name';
                }
                field(reportingEntityFND; Rec."Reporting Entity FND")
                {
                    Caption = 'Reporting Entity';
                }
                field(linkedDimensionCodeFND; Rec."Linked Dimension Code FND")
                {
                    Caption = 'Linked Dimension Code';
                }
                field(linkedDimensionValueCodeFND; Rec."Linked Dime. Value Code FND")
                {
                    Caption = 'Linked Dimension Value Code';
                }
                field(minOrderValueLimitFND; Rec."Min. Order Value Limit FND")
                {
                    Caption = 'Min. Order Value Limit';
                }
                field(minOrderValueLimitTypeFND; Rec."Min. Ord. Value Limit Type FND")
                {
                    Caption = 'Min. Order Value Limit Type';
                }
                field(licenseExpirationDateFND; Rec."License Expiration Date FND")
                {
                    Caption = 'License Expiration Date';
                }
                field(sendWMSAstroFND; Rec."Send WMS Astro FND")
                {
                    Caption = 'Send WMS Astro';
                }
                field(coDCoCNumberFND; Rec."CoD/CoC Number FND")
                {
                    Caption = 'CoD/CoC Number';
                }
                field(lastDateTimeModifiedZycusFND; Rec."Last DateTime Modif. Zycus FND")
                {
                    Caption = 'Last Date-Time Modified Zycus';
                }
                field(updatedSpecialCharZycusFND; Rec."Updated Special Char Zycus FND")
                {
                    Caption = 'Updated Special Char Zycus';
                }

            }
        }
    }
}
