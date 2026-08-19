tableextension 50070 FAJournalSetupExtFND extends "FA Journal Setup"
{
    // version NAVW110.0,DITW110.00.08
    // DITW15.00.00.38 DDR 05/01/2011 issue 822 Added fields
    //                                            2034926 Exists Jnl. FA Posting Type
    //                                          Added to delete FA Jnl per posting type records
    //                                          Added function SetFAPostingType()

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    fields
    {
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("FA Jnl. Template Name")
        {
            CaptionML = ENU = 'FA Jnl. Template Name', FRA = 'Nom modèle feuille immo.';
        }
        modify("FA Jnl. Batch Name")
        {

            //Unsupported feature: Change TableRelation on ""FA Jnl. Batch Name"(Field 4)". Please convert manually.

            CaptionML = ENU = 'FA Jnl. Batch Name', FRA = 'Nom feuille immo.';
        }
        modify("Gen. Jnl. Template Name")
        {
            CaptionML = ENU = 'Gen. Jnl. Template Name', FRA = 'Nom modèle feuille cpta. immo.';
        }
        modify("Gen. Jnl. Batch Name")
        {

            //Unsupported feature: Change TableRelation on ""Gen. Jnl. Batch Name"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Gen. Jnl. Batch Name', FRA = 'Nom feuille cpta. immo.';
        }
        modify("Insurance Jnl. Template Name")
        {
            CaptionML = ENU = 'Insurance Jnl. Template Name', FRA = 'Nom modèle feuille assurance';
        }
        modify("Insurance Jnl. Batch Name")
        {

            //Unsupported feature: Change TableRelation on ""Insurance Jnl. Batch Name"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Insurance Jnl. Batch Name', FRA = 'Nom feuille assurance';
        }
        // BC Upgrade NANDIS03 - Blocked DIT field >>
        // field(2034926; "Exists Jnl. FA Posting Type"; Boolean)
        // {
        //     // CalcFormula = Exist("FA Journal Setup Posting Type" WHERE ("Depreciation Book Code"=FIELD("Depreciation Book Code"),
        //     //                                                            "User ID"=FIELD("User ID"))); //BC Upgrade KAPOOV01-drink-it
        //     CaptionML = ENU = 'Exists FA Posting Type',
        //                 FRA = 'Existe Type compta. immo.';
        //     Description = 'DITW15.00.00.38 #822';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // BC Upgrade NANDIS03 - Blocked DIT field <<
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    var
    //FAJnlSetupType: Record "FA Journal Setup Posting Type";//BC Upgrade KAPOOV01-drink-it
    //begin
    /*
    // <<DITW15.00.00.38 DDR 05/01/2011 #822
    FAJnlSetupType.SETRANGE("Depreciation Book Code","Depreciation Book Code");
    FAJnlSetupType.SETRANGE("User ID","User ID");
    FAJnlSetupType.DELETEALL;
    // >>DITW15.00.00.38 DDR #822
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You must specify %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You must specify %1.;FRA=Vous devez spécifier une valeur %1.;
    //Variable type has not been exported.

    var
        //FAJnlSetupType: Record "FA Journal Setup Posting Type";//BC Upgrade KAPOOV01-drink-it
        FAJnlPostingType: Option "Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance,"Salvage Value";
}

