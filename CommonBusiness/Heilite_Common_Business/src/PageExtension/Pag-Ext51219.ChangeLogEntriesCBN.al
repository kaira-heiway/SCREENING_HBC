pageextension 51219 ChangeLogEntriesExtCBN extends "Change Log Entries"
{
    // version NAVW110.0,HEI.01

    //   HEI.01 CHG2229002 IBM SAMANR01 28.11.2023 - Remove dynamic and FlowFields from the Change Log Entry Page/Table
    //   # Remove below flow field
    //     "Table Caption"
    //     "Field Caption"
    //     "Primary Key Field 1 Caption"
    //     "Primary Key Field 2 Caption"
    //     "Primary Key Field 3 Caption"

    layout
    {

        //Unsupported feature: Change Name on "Control1900000001(Control 1900000001)". Please convert manually.

        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number given to the entry.', FRA = 'Spécifie le numéro d''écriture donné à l''écriture.';
        }
        modify("Date and Time")
        {
            ToolTipML = ENU = 'Specifies the date and time when this change log entry was created.', FRA = 'Spécifie la date et l''heure de création de cette écriture journal modification.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the user ID of the user who made the change to the field.', FRA = 'Spécifie le code utilisateur de la personne ayant modifié le champ.';
        }
        modify("Table No.")
        {

            //Unsupported feature: Change Lookup on ""Table No."(Control 10)". Please convert manually.

            ToolTipML = ENU = 'Specifies the number of the table containing the changed field.', FRA = 'Spécifie le numéro de la table contenant le champ modifié.';
        }
        modify("Primary Key")
        {
            ToolTipML = ENU = 'Specifies the primary key or keys of the changed field.', FRA = 'Spécifie la ou les clés primaires du champ modifié.';
        }
        modify("Primary Key Field 1 No.")
        {

            //Unsupported feature: Change Lookup on ""Primary Key Field 1 No."(Control 26)". Please convert manually.

            ToolTipML = ENU = 'Specifies the field number of the first primary key for the changed field.', FRA = 'Spécifie le numéro de champ de la première clé primaire du champ modifié.';
        }
        modify("Primary Key Field 1 Value")
        {
            ToolTipML = ENU = 'Specifies the value of the first primary key for the changed field.', FRA = 'Spécifie la valeur de la première clé primaire du champ modifié.';
        }
        modify("Primary Key Field 2 No.")
        {

            //Unsupported feature: Change Lookup on ""Primary Key Field 2 No."(Control 32)". Please convert manually.

            ToolTipML = ENU = 'Specifies the field number of the second primary key for the changed field.', FRA = 'Spécifie le numéro de champ de la deuxième clé primaire du champ modifié.';
        }
        modify("Primary Key Field 2 Value")
        {
            ToolTipML = ENU = 'Specifies the value of the second primary key for the changed field.', FRA = 'Spécifie la valeur de la deuxième clé primaire du champ modifié.';
        }
        modify("Primary Key Field 3 No.")
        {

            //Unsupported feature: Change Lookup on ""Primary Key Field 3 No."(Control 38)". Please convert manually.

            ToolTipML = ENU = 'Specifies the field number of the third primary key for the changed field.', FRA = 'Spécifie le numéro de champ de la troisième clé primaire du champ modifié.';
        }
        modify("Primary Key Field 3 Value")
        {
            ToolTipML = ENU = 'Specifies the value of the third primary key for the changed field.', FRA = 'Spécifie la valeur de la troisième clé primaire du champ modifié.';
        }
        modify("Field No.")
        {

            //Unsupported feature: Change Lookup on ""Field No."(Control 14)". Please convert manually.

            ToolTipML = ENU = 'Specifies the field number of the changed field.', FRA = 'Spécifie le numéro du champ modifié.';
        }
        modify("Type of Change")
        {
            ToolTipML = ENU = 'Specifies the type of change made to the field.', FRA = 'Spécifie le type de modification apportée au champ.';
        }
        modify("Old Value")
        {
            ToolTipML = ENU = 'Specifies the value that the field had before a user made changes to the field.', FRA = 'Spécifie la valeur du champ avant modification.';
        }
        modify("Old Value Local")
        {
            CaptionML = ENU = 'Old Value (Local)', FRA = 'Ancienne valeur (locale)';
            ToolTipML = ENU = 'Specifies the value that the field had before a user made changes to the field.', FRA = 'Spécifie la valeur du champ avant modification.';
        }
        modify("New Value")
        {
            ToolTipML = ENU = 'Specifies the value that the field had after a user made changes to the field.', FRA = 'Spécifie la valeur du champ après modification.';
        }
        modify("New Value Local")
        {
            CaptionML = ENU = 'New Value (Local)', FRA = 'Nouvelle valeur (locale)';
            ToolTipML = ENU = 'Specifies the value that the field had after a user made changes to the field.', FRA = 'Spécifie la valeur du champ après modification.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Date and Time"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Date and Time"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""User ID"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""User ID"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Table No."(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Table No."(Control 10)". Please convert manually.

        modify("Table Caption")
        {
            Visible = false;
        }

        //Unsupported feature: PropertyDeletion on ""Primary Key"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key Field 1 No."(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key Field 1 No."(Control 26)". Please convert manually.

        modify("Primary Key Field 1 Caption")
        {
            Visible = false;
        }

        //Unsupported feature: PropertyDeletion on ""Primary Key Field 1 Value"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key Field 1 Value"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key Field 2 No."(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key Field 2 No."(Control 32)". Please convert manually.

        modify("Primary Key Field 2 Caption")
        {
            Visible = false;
        }

        //Unsupported feature: PropertyDeletion on ""Primary Key Field 2 Value"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key Field 2 Value"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key Field 3 No."(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key Field 3 No."(Control 38)". Please convert manually.

        modify("Primary Key Field 3 Caption")
        {
            Visible = false;
        }

        //Unsupported feature: PropertyDeletion on ""Primary Key Field 3 Value"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Primary Key Field 3 Value"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Field No."(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Field No."(Control 14)". Please convert manually.

        modify("Field Caption")
        {
            Visible = false;
        }

        //Unsupported feature: PropertyDeletion on ""Type of Change"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Type of Change"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Old Value"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Old Value"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Old Value Local"(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""New Value"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""New Value"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""New Value Local"(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

    }
    actions
    {
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
            //Promoted = Yes;
            Promoted = True;
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: CodeModification on ""&Print"(Action 47).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        REPORT.RUN(REPORT::"Change Log Entries",true,false,Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        REPORT.RUN(REPORT::"Change Log Entries",TRUE,FALSE,Rec);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""&Print"(Action 47)". Please convert manually.

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

