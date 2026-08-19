tableextension 50213 WorkflowStepBufferExtFND extends "Workflow Step Buffer"
{
    // HEI.01 CHG2231326 HB3599 YADAVM09 IBM 07.02.2024 # Restrict users to connect or disconnect RTR journal templates from the Workflow approval on Opco level.
    //     # New function Added #OnBeforeOpenEventConditions

    //   BC Upgrade KUMARS145 Table Ext
    //   BC Upgrade KUMARS145 alternative for HEI.01 CHG2231326 HB3599 YADAVM09 IBM 07.02.2024 In codeunit 50282 "Heineken Table Cu" <<

    fields
    {
        modify("Order")
        {
            CaptionML = ENU = 'Order', FRA = 'Commande';
        }
        modify(Indent)
        {
            CaptionML = ENU = 'Indent', FRA = 'Indenter';
        }
        modify("Event Description")
        {
            CaptionML = ENU = 'Event Description', FRA = 'Description événement';
        }
        modify(Condition)
        {
            CaptionML = ENU = 'Condition', FRA = 'Condition';
        }
        modify("Response Description")
        {
            CaptionML = ENU = 'Response Description', FRA = 'Description réponse';
        }
        modify("Event Step ID")
        {
            CaptionML = ENU = 'Event Step ID', FRA = 'ID étape d''événement';
        }
        modify("Response Step ID")
        {
            CaptionML = ENU = 'Response Step ID', FRA = 'ID étape réponse';
        }
        modify("Workflow Code")
        {
            CaptionML = ENU = 'Workflow Code', FRA = 'Code flux de travail';
        }
        modify("Parent Event Step ID")
        {
            CaptionML = ENU = 'Parent Event Step ID', FRA = 'ID étape événement parent';
        }
        modify("Previous Workflow Step ID")
        {
            CaptionML = ENU = 'Previous Workflow Step ID', FRA = 'ID étape de flux de travail précédente';
        }
        modify("Response Description Style")
        {
            CaptionML = ENU = 'Response Description Style', FRA = 'Style de description de réponse';
        }
        modify("Entry Point")
        {
            CaptionML = ENU = 'Entry Point', FRA = 'Point d''entrée';
        }
        modify("Sequence No.")
        {
            CaptionML = ENU = 'Sequence No.', FRA = 'N° séquence';
        }
        modify("Next Step Description")
        {
            CaptionML = ENU = 'Next Step Description', FRA = 'Description étape suivante';
        }
        modify(Argument)
        {
            CaptionML = ENU = 'Argument', FRA = 'Argument';
        }
        modify(Template)
        {
            CaptionML = ENU = 'Template', FRA = 'Modèle';
        }
    }
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.

    var
        Ishandled: Boolean;
    //Unsupported feature: PropertyModification on "ThenTextForMultipleResponsesTxt(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ThenTextForMultipleResponsesTxt : ENU=(+) %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ThenTextForMultipleResponsesTxt : ENU=(+) %1;FRA=(+) %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SelectResponseTxt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SelectResponseTxt : ENU=<Select Response>;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectResponseTxt : ENU=<Select Response>;FRA=<Sélectionner la réponse>;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "EventNotExistErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //EventNotExistErr : @@@="%1 = event description (e.g. The workflow event A general journal batch is does not exist.)";ENU=The workflow event %1 does not exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //EventNotExistErr : @@@="%1 = event description (e.g. The workflow event A general journal batch is does not exist.)";ENU=The workflow event %1 does not exist.;FRA=L'événement de flux de travail %1 n'existe pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "WhenMissingErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //WhenMissingErr : ENU=You must select a When statement first.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WhenMissingErr : ENU=You must select a When statement first.;FRA=Vous devez d'abord sélectionner une condition (Si).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "AlwaysTxt(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AlwaysTxt : ENU=<Always>;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AlwaysTxt : ENU=<Always>;FRA=<Toujours>;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ResponseNotExistErr(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ResponseNotExistErr : @@@="%1 = response description (e.g. The workflow response Remove record does not exist.)";ENU=The workflow response %1 does not exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ResponseNotExistErr : @@@="%1 = response description (e.g. The workflow response Remove record does not exist.)";ENU=The workflow response %1 does not exist.;FRA=La réponse de flux de travail %1 n'existe pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "WhenNextStepDescTxt(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //WhenNextStepDescTxt : ENU=Next when "%1";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WhenNextStepDescTxt : ENU=Next when "%1";FRA=Si suivant « %1 »;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ThenNextStepDescTxt(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ThenNextStepDescTxt : ENU=Next then "%1";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ThenNextStepDescTxt : ENU=Next then "%1";FRA=Alors suivant « %1 »;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CombinedConditionTxt(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CombinedConditionTxt : @@@={Locked};ENU="%1; %2";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CombinedConditionTxt : @@@={Locked};ENU="%1; %2";FRA="%1; %2";
    //Variable type has not been exported.
}


