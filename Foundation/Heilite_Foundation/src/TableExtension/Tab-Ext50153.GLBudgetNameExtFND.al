tableextension 50153 GLBudgetNameExtFND extends "G/L Budget Name"
{
    // version NAVW19.00
    // HEI.01 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added fileds "Data Version Refrence" table 

    fields
    {
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Budget Dimension 1 Code")
        {
            CaptionML = ENU = 'Budget Dimension 1 Code', FRA = 'Code axe budget 1';
        }
        modify("Budget Dimension 2 Code")
        {
            CaptionML = ENU = 'Budget Dimension 2 Code', FRA = 'Code axe budget 2';
        }
        modify("Budget Dimension 3 Code")
        {
            CaptionML = ENU = 'Budget Dimension 3 Code', FRA = 'Code axe budget 3';
        }
        modify("Budget Dimension 4 Code")
        {
            CaptionML = ENU = 'Budget Dimension 4 Code', FRA = 'Code axe budget 4';
        }
        field(50000; "Data Version Refrence FND"; Code[20])
        {
            CaptionML = ENU = 'Data Version Refrence',
                        FRA = 'Data Version Refrence';
            Description = 'HEI.01';
        }
        field(50001; "Chk. When Pstg. Purch Doc FND"; Boolean)
        {
            caption = 'Check When Posting Purch Doc';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=%1\You cannot use the same dimension twice in the same budget.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=%1\You cannot use the same dimension twice in the same budget.;FRA=%1\Vous ne pouvez pas utiliser le même axe analytique deux fois dans le même budget.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Updating budget entries @1@@@@@@@@@@@@@@@@@@;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Updating budget entries @1@@@@@@@@@@@@@@@@@@;FRA=Mise à jour des écritures budget @1@@@@@@@@@@@@@@@@@@;
    //Variable type has not been exported.
}

