pageextension 51030 ResourcesSetupExtCBN extends "Resources Setup"
{
    // version NAVW110.0,FINXL8.00.001
    // BC UPGRADE PATHAA02 01/09/25
    InsertAllowed = false; //BC Upgrade 
    DeleteAllowed = false; //BC Upgrade 
    layout
    {
        modify(Numbering)
        {
            CaptionML = ENU = 'Numbering', FRA = 'Numérotation';
        }
        modify("Resource Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code you can use to assign numbers to resources.', FRA = 'Spécifie le code souche de numéros à utiliser pour affecter des numéros aux ressources.';
        }
        modify("Time Sheet Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code you can use to assign document numbers to time sheets.', FRA = 'Spécifie le code souche de numéros à utiliser pour affecter des numéros de document aux feuilles de temps.';
        }
        modify("Time Sheet First Weekday")
        {
            ToolTipML = ENU = 'Specifies the first weekday to use on a time sheet. The default is Monday.', FRA = 'Spécifie le premier jour de la semaine à utiliser dans une feuille de temps. Le lundi par défaut.';
        }
        modify("Time Sheet by Job Approval")
        {
            ToolTipML = ENU = 'Specifies whether time sheets must be approved on a per job basis by the user specified for the job.', FRA = 'Spécifie si les feuilles de temps doivent être approuvées ou non par projet par l''utilisateur spécifié pour le projet.';
        }
        //BC UPGRADE PATHAA02-DIT fields>>
        // addafter(Numbering)
        // {
        //     group(Extra)
        //     {
        //         CaptionML = ENU = 'Extra',
        //                     FRA = 'Extra';
        //         field("Register Abscence on Timesheet"; "Register Abscence on Timesheet")
        //         {
        //         }
        //     }
        // }
        //BC UPGRADE PATHAA02<<
    }


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

