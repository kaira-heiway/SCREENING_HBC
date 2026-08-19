page 52027 "User Connection Details"
{
    // version HEI.01

    // HEI.01 CHG2128096 SAMANR01 28-09-2021
    //   # Create Object from copy of P9506

    // BC Upgrade KUMARR78 >>
    //
    // Old Page ID and Name:
    //     50154 "User Connection Details"
    //
    // 1. Added ApplicationArea property at page level.
    //    Old:
    //         - ApplicationArea property was not defined at page level.
    //    New:
    //         - ApplicationArea = All;
    //
    // 2. Modified layout fields to use Rec explicitly.
    //    Old:
    //         - Fields were defined without explicit Rec reference.
    //           Example:
    //               field("User ID"; "User ID")
    //    New:
    //         - Fields updated to use Rec reference.
    //           Example:
    //               field("User ID"; Rec."User ID")
    //
    // 3. Updated separator control definition in actions.
    //    Old:
    //         - separator()
    //    New:
    //         - separator(Processing)   // Explicit name provided for BC compliance.
    //
    // BC Upgrade KUMARR78 <<

    // BC Upgrade PATELS08 >>
    // # Changed Seperator name 'Processing' to ProcessingSeperator, as 'Processsing' is a reserved name for area type.
    // BC Upgrade PATELS08 <<

    CaptionML = ENU = 'User Connection Details',
                FRA = 'Détails de connexion de l''utilisateur';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Session,SQL Trace,Events',
                                 FRA = 'Nouveau,Traitement,État,Session,Trace SQL,Événements';
    RefreshOnActivate = true;
    SourceTable = "Active Session";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'User ID',
                                FRA = 'Code utilisateur';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the user name of the user who is logged on to the active session.',
                                FRA = 'Spécifie le nom d''utilisateur de l''utilisateur qui est connecté à la session active.';
                }
                field(UserFullName; UserFullName)
                {
                    Caption = 'User Name';
                }
                field(UserEmailID; UserEmailID)
                {
                    Caption = 'Email ID';
                }
                field("Client Type"; ClientTypeText)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Client Type',
                                FRA = 'Type de client';
                    Editable = false;
                }
                field("Login Datetime"; Rec."Login Datetime")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Login Date',
                                FRA = 'Date connexion';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the date and time that the session started on the Microsoft Dynamics NAV Server instance.',
                                FRA = 'Spécifie la date et l''heure auxquelles la session a démarré sur l''instance Microsoft Dynamics NAV Server.';
                }
                field("Server Computer Name"; Rec."Server Computer Name")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Server Computer Name',
                                FRA = 'Nom du serveur';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the fully qualified domain name (FQDN) of the computer on which the Microsoft Dynamics NAV Server instance runs.',
                                FRA = 'Spécifie le nom de domaine complet (FQDN) de l''ordinateur sur lequel l''instance Microsoft Dynamics NAV Server est exécutée.';
                }
                field("Server Instance ID"; Rec."Server Instance ID")
                {
                }
                field("Server Instance Name"; Rec."Server Instance Name")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Server Instance Name',
                                FRA = 'Nom d''instance de serveur';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the name of the Microsoft Dynamics NAV Server instance to which the session is connected. The server instance name comes from the Session Event table.',
                                FRA = 'Spécifie le nom de l''instance Microsoft Dynamics NAV Server à laquelle la session est connectée. Le nom de l''instance de serveur provient de la table Événement de session.';
                }
                field("Client Computer Name"; Rec."Client Computer Name")
                {
                }
                field("Database Name"; Rec."Database Name")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // BC Upgrade PATELS08 >> # Changed Seperator name 'Processing', as 'Processsing' is a reserved name for area type.
            // separator(Processing)//BC UPGRADE KUMARR78 Passing Name Processing.
            separator(ProcessingSeperator)//BC UPGRADE KUMARR78 Passing Name Processing.
            // BC Upgrade PATELS08 <<
            {
            }
        }
    }

    trigger OnAfterGetRecord();
    begin

        // If this is the empty row, clear the Session ID and Client Type
        if Rec."Session ID" = 0 then begin
            SessionIdText := '';
            ClientTypeText := '';
        end else begin
            SessionIdText := Format(Rec."Session ID");
            ClientTypeText := Format(Rec."Client Type");
        end;

        if UserSetup.Get(Rec."User ID") then
            UserEmailID := UserSetup."E-Mail"
        else
            UserEmailID := '';
        if User.Get(Rec."User SID") then
            UserFullName := User."Full Name"
        else
            UserFullName := '';
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    begin

        // If the session list is empty, insert an empty row to carry the button state to the client
        if not Rec.Find(Which) then begin
            Rec.Init;
            Rec."Session ID" := 0;
        end;

        exit(true);
    end;

    trigger OnOpenPage();
    begin
        Rec.FilterGroup(2);
        Rec.FilterGroup(0);
    end;

    var
        User: Record User;
        UserSetup: Record "User Setup";
        ClientTypeText: Text;
        SessionIdText: Text;
        UserEmailID: Text;
        UserFullName: Text;
        Text2029612: TextConst ENU = 'Do You want to kill this session ?', FRA = 'Voulez-vous arrêter la session ?';
}

