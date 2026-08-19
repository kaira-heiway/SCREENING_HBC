tableextension 50084 DimensionSelectionBufferExtFND extends "Dimension Selection Buffer"
{
    // version NAVW19.00,DITW18.00,HEI.01
    // HEI.BC.01 28.04.2025 SAHAL01 (Version Upgrade BC252)
    // Migrated Customizations in the Table(52764) extn.

    fields
    {
        modify(Code)
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Selected)
        {
            CaptionML = ENU = 'Selected', FRA = 'Sélectionné';
        }
        modify("New Dimension Value Code")
        {
            CaptionML = ENU = 'New Dimension Value Code', FRA = 'Nouveau code section';
            TableRelation = IF (Code = const('G/L Account')) "G/L Account"."No." else IF (Code = const('Business Unit')) "Business Unit".Code else
            "Dimension Value".Code where("Dimension Code" = field(Code));
        }
        modify("Dimension Value Filter")
        {
            CaptionML = ENU = 'Dimension Value Filter', FRA = 'Filtre section';
            TableRelation = IF ("Filter Lookup Table No." = CONST(15)) "G/L Account"."No." else IF ("Filter Lookup Table No." = CONST(220)) "Business Unit".Code else IF ("Filter Lookup Table No." = CONST(841)) "Cash Flow Account"."No." else IF ("Filter Lookup Table No." = CONST(840)) "Cash Flow Forecast"."No." else
            "Dimension Value".Code where("Dimension Code" = FIELD(Code));
        }
        modify(Level)
        {
            CaptionML = ENU = 'Level', FRA = 'Niveau';
            OptionCaptionML = ENU = ' ,Level 1,Level 2,Level 3,Level 4', FRA = ' ,Niveau 1,Niveau 2,Niveau 3,Niveau 4';
        }
        modify("Filter Lookup Table No.")
        {
            CaptionML = ENU = 'Filter Lookup Table No.', FRA = 'N° table consultation filtres';
        }
    }
}