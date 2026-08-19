tableextension 50134 ResourcesSetupExtFND extends "Resources Setup"
{
    // version NAVW17.00,FINXL8.00

    // FINXL8.00.001 BSA 25/05/2015 #176 : Added Field "Register Abscence on Timesheet"

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Resource Nos.")
        {
            CaptionML = ENU = 'Resource Nos.', FRA = 'N° ressource';
        }
        modify("Time Sheet Nos.")
        {
            CaptionML = ENU = 'Time Sheet Nos.', FRA = 'N° de feuilles de temps';
        }
        modify("Time Sheet First Weekday")
        {
            CaptionML = ENU = 'Time Sheet First Weekday', FRA = 'Premier jour de la semaine de la feuille de temps';
            OptionCaptionML = ENU = 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday', FRA = 'Lundi,Mardi,Mercredi,Jeudi,Vendredi,Samedi,Dimanche';
        }
        modify("Time Sheet by Job Approval")
        {
            CaptionML = ENU = 'Time Sheet by Job Approval', FRA = 'Feuille de temps par approbation de projet';
            OptionCaptionML = ENU = 'Never,Machine Only,Always', FRA = 'Jamais,Machine uniquement,Toujours';
        }

        //Unsupported feature: CodeModification on ""Time Sheet First Weekday"(Field 951).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Time Sheet First Weekday" <> xRec."Time Sheet First Weekday" THEN BEGIN
          TimeSheetHeader.RESET;
          IF NOT TimeSheetHeader.ISEMPTY THEN
            ERROR(Text002,FIELDCAPTION("Time Sheet First Weekday"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Time Sheet First Weekday" <> xRec."Time Sheet First Weekday" then begin
          TimeSheetHeader.RESET;
          if not TimeSheetHeader.ISEMPTY then
            ERROR(Text002,FIELDCAPTION("Time Sheet First Weekday"));
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Time Sheet by Job Approval"(Field 952).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Time Sheet by Job Approval" <> xRec."Time Sheet by Job Approval" THEN BEGIN
          TimeSheetLine.RESET;
          TimeSheetLine.SETRANGE(Type,TimeSheetLine.Type::Job);
          TimeSheetLine.SETRANGE(Status,TimeSheetLine.Status::Submitted);
          IF NOT TimeSheetLine.ISEMPTY THEN
            ERROR(Text001,FIELDCAPTION("Time Sheet by Job Approval"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Time Sheet by Job Approval" <> xRec."Time Sheet by Job Approval" then begin
        #2..4
          if not TimeSheetLine.ISEMPTY then
            ERROR(Text001,FIELDCAPTION("Time Sheet by Job Approval"));
        end;
        */
        //end;
        // field(2029610; "Register Abscence on Timesheet"; Boolean)
        // {
        //     Caption = 'Register Abscence on Timesheet';
        //     Description = 'FINXL8.00.001';
        // }  // BC Upgrade NANDIS03 - APtean code blocked
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU="%1 cannot be changed, because there is at least one submitted time sheet line with Type=Job.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU="%1 cannot be changed, because there is at least one submitted time sheet line with Type=Job.";FRA=%1 ne peut pas être modifié car il existe au moins une ligne feuille de temps soumise avec le type Projet.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=%1 cannot be changed, because there is at least one time sheet.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=%1 cannot be changed, because there is at least one time sheet.;FRA=%1 ne peut pas être modifié car il existe au moins une feuille de temps.;
    //Variable type has not been exported.
}

