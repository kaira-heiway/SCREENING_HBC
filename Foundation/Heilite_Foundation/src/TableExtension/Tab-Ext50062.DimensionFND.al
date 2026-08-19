tableextension 50062 DimensionExtFND extends Dimension
{
    // version NAVW110.0,HEI.01
    // HEI.BC.01 22.09.2025 SAHAL01 (Version Upgrade BC260)
    // Migrated Customizations in the Table(50062) extn.

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Code Caption")
        {
            CaptionML = ENU = 'Code Caption', FRA = 'Libellé code';
        }
        modify("Filter Caption")
        {
            CaptionML = ENU = 'Filter Caption', FRA = 'Libellé filtre';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Consolidation Code")
        {
            CaptionML = ENU = 'Consolidation Code', FRA = 'Code consolidation';
        }
        modify("Map-to IC Dimension Code")
        {
            CaptionML = ENU = 'Map-to IC Dimension Code', FRA = 'Code axe IC à faire corresp.';
        }
        field(50000; "Mandatory Customer FND"; Boolean)
        {
            Caption = 'Mandatory Customer';
            Description = 'HEI.01';
        }
    }

    var

        Text000: TextConst ENU = '%1\This dimension is also used in posted or budget entries.\You cannot delete it.', FRA = '%1\Cet axe analytique est aussi utilisé dans des écritures enregistrées ou des écritures budget.\Vous ne pouvez pas le supprimer.';
        Text001: TextConst ENU = '%1\You cannot delete it.', FRA = '%1\Vous ne pouvez pas supprimer l enregistrement.';
        Text002: TextConst ENU = 'You cannot delete this dimension value, because it has been used in one or more documents or budget entries.', FRA = 'Vous ne pouvez pas supprimer la valeur de cet axe analytique car elle est utilisée dans un ou plusieurs documents ou écritures budget.';
        Text006: TextConst ENU = 'Period', FRA = 'Période';
        Text007: TextConst ENU = '%1 can not be %2, %3, %4, %5 or Period. These names are used internally by the system.', FRA = '%1 ne peut pas être %2, %3, %4, %5 ou Période. Ces noms sont utilisés en interne par le système.';
        Text008: TextConst ENU = 'Code', FRA = 'Code';
        Text009: TextConst ENU = 'Filter', FRA = 'Filtre';
        Text010: TextConst ENU = 'This dimension is used in the following setup: ', FRA = 'Cet axe analytique est utilisé dans les paramètres suivants : ';
        Text011: TextConst ENU = 'General Ledger Setup, ', FRA = 'paramètres comptabilité, ';
        Text012: TextConst ENU = 'G/L Budget Names, ', FRA = 'Noms budgets comptables, ';
        Text013: TextConst ENU = 'Analysis View Card, ', FRA = 'fiche vue d analyse, ';
        Text014: TextConst ENU = 'Item Budget Names, ', FRA = 'Noms budget article, ';
        Text015: TextConst ENU = 'Item Analysis View Card ', FRA = 'Fiche vue d analyse article ';
}

