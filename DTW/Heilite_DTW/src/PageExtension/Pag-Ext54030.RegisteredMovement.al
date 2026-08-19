pageextension 54030 RegisteredMovementExt extends "Registered Movement"
{
    // version NAVW110.0,HEI.01

    //     HEI.01 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
    //   # Added New Fields - External Document No.
    //                      - External Document No.2

    //Bc Upgrade YADAVM09 Page field property Added.
    //Bc Upgrade YADAVM09 Drink it field blocked.


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the registered warehouse activity number.', FRA = 'Indique le numéro de l''activité entrepôt enregistrée.';
        }
        modify("Whse. Activity No.")
        {
            ToolTipML = ENU = 'Specifies the warehouse activity number from which the activity was registered.', FRA = 'Spécifie le numéro d''activité entrepôt à partir duquel l''activité a été enregistrée.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location in which the registered warehouse activity occurred.', FRA = 'Spécifie le code du magasin où a eu lieu l''activité entrepôt enregistrée.';
        }
        modify("Registering Date")
        {
            ToolTipML = ENU = 'This object supports the program infrastructure and is intended for internal use.', FRA = 'Cet objet prend en charge l''infrastructure du programme et est destiné à un usage interne.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the employee who is responsible for the document and assigned to perform the warehouse activity.', FRA = 'Spécifie le code de l''employé responsable du document et qui est affecté à l''activité entrepôt.';
        }
        modify("Assignment Date")
        {
            ToolTipML = ENU = 'Specifies the date the user was assigned the activity.', FRA = 'Spécifie la date à laquelle l''utilisateur a été affecté à l''activité.';
        }
        modify("Assignment Time")
        {
            ToolTipML = ENU = 'Specifies the time of day the user was assigned the activity.', FRA = 'Spécifie l''heure à laquelle l''utilisateur a été affecté à l''activité.';
        }
        modify("Sorting Method")
        {
            ToolTipML = ENU = 'Specifies the method by which the lines were sorted on the warehouse header, such as by item, or bin code.', FRA = 'Spécifie la méthode de tri des lignes de l''en-tête entrepôt, telle que par article ou par code emplacement.';
          //  OptionCaptionML = ENU = ' ,Item,,Bin Code,Due Date,,Bin Ranking,Action Type', FRA = ' ,Article,,Code emplacement,Délai,,Priorité emplacement,Type action';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies the number of times the warehouse activity has been printed.', FRA = 'Spécifie le nombre de fois où l''activité entrepôt a été imprimée.';
        }
        addafter("Location Code")
        {
            field("From Zone Code"; Rec."From Zone Code FND")

            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("To Zone Code"; Rec."To Zone Code FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("In-Transit Zone"; Rec."In-Transit Zone FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("In-Transit Bin"; Rec."In-Transit Bin FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("Transfer Type"; Rec."Transfer Type FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }
        addafter("No. Printed")
        {
            field("External Document No."; Rec."External Document No. FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("External Document No.2"; Rec."External Document No.2 FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }
    }
    actions
    {
        modify("&Movement")
        {
            CaptionML = ENU = '&Movement', FRA = '&Mouvement';
        }
        modify(List)
        {
            CaptionML = ENU = 'List', FRA = 'Lister';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

