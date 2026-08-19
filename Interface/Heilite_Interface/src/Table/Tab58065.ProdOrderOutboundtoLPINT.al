table 58065 "Prod. Order Outbound to LP INT"
{
    // Heilite Navision Old Id - 50235
    // version HEI.01

    // HEI.01 CHG2129985 IBM.LS      21.02.2022
    //   # Created New Table: 50235 - Prod. Order Outbound to LP
    //   # Added Code
    //   # Added CaptionML for all fields
    // HEI.02 CHG2129985 IBM.LS      04.03.2022
    //   # Modified Shelf Life field datatype from Date to Text
    //************************************************************************************************
    //BC UPGRADE PATHAA02 17.11.25 Done
    //01->"LookupUserID" Function of NAV was missing in BC--> CU-"User Managment", same logic added into this Object-->Functions added-->'LookupUserID' & 'LookupUser'.
    //02-->"LooupUserID" removed and replaced with function in BC-"DisplayUserInformation"
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Description = 'HEI.01';
        }
        field(2; "Prod. Order Interface"; Code[20])
        {
            Caption = 'Prod. Order Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(3; "Interface Status"; Option)
        {
            Caption = 'Interface Status';
            Description = 'HEI.01';
            OptionCaption = 'Pending,Error,Processed,Cancelled,Manual Entry';
            OptionMembers = Pending,Error,Processed,Cancelled,"Manual Entry";
        }
        field(5; "Sync. Date-Time"; DateTime)
        {
            Caption = 'Sync. Date-Time';
            Description = 'HEI.01';
        }
        field(6; "Archive Date-Time"; DateTime)
        {
            Caption = 'Archive Date-Time';
            Description = 'HEI.01';
        }
        field(7; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            Description = 'HEI.01';
        }
        field(8; "Ready for LogoPak"; Boolean)
        {
            Caption = 'Ready for LogoPak';
            Description = 'HEI.01';
        }
        field(10; "Prod. Order Status"; Option)
        {
            CaptionML = ENU = 'Prod. Order Status',
                        FRA = 'Statut';
            Description = 'HEI.01';
            OptionCaptionML = ENU = 'Simulated,Planned,Firm Planned,Released,Finished',
                              FRA = 'Simulé,Planifié,Planifié ferme,Lancé,Terminé';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
        }
        field(11; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Description = 'HEI.01';
            TableRelation = "Prod. Order Line"."Prod. Order No." WHERE(Status = CONST(Released));
        }
        field(12; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HEI.01';
        }
        field(13; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Description = 'HEI.01';
            TableRelation = Location;
        }
        field(14; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            Description = 'HEI.01';
            TableRelation = Item;
        }
        field(15; Description; Text[50])
        {
            Caption = 'Description';
            Description = 'HEI.01';
        }
        field(16; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Description = 'HEI.01';
        }
        field(17; "Planned Quantity"; Decimal)
        {
            Caption = 'Planned Quantity';
            Description = 'HEI.01';
        }
        field(18; "Quantity (Full Pallet)"; Decimal)
        {
            Caption = 'Quantity (Full Pallet)';
            Description = 'HEI.01';
        }
        field(19; EAN; Code[20])
        {
            Caption = 'EAN';
            Description = 'HEI.01';
        }
        field(20; "Ccc Code"; Code[20])
        {
            Caption = 'Ccc Code';
            Description = 'HEI.01';
        }
        field(21; "Gross Weight of Pallet in KG"; Decimal)
        {
            Caption = 'Gross Weight of Pallet in KG';
            Description = 'HEI.01';
        }
        field(22; "Shelf Life"; Text[30])
        {
            Caption = 'Shelf Life';
            Description = 'HEI.01,HEI.02';
        }
        field(23; "Item Category Code"; Code[20])
        {
            CaptionML = ENU = 'Item Category Code',
                        FRA = 'Code catégorie article';
            Description = 'HEI.01';
            TableRelation = "Item Category";
        }
        field(30; "Last Modified Date-Time"; DateTime)
        {
            CaptionML = ENU = 'Last Modified Date-Time',
                        FRA = 'Date-heure dernière modification';
            Description = 'HEI.01';
        }
        field(31; "Last Modified By User ID"; Code[50])
        {
            CaptionML = ENU = 'Last Modified By User ID',
                        FRA = 'Dernière modification par ID utilisateur';
            Description = 'HEI.01';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup();
            var
                UserMgtL: Codeunit "User Management";
            begin
                //HEI.01>>
                // UserMgtL.LookupUserID("Created By");//BC UPGRADE PATHAA02                
                UserMgtL.DisplayUserInformation("Last Modified By User ID");//BC UPGRADE PATHAA02
                //HEI.01<<    
            end;
        }
        field(32; "Created By"; Code[50])
        {
            CaptionML = ENU = 'Created By',
                        FRA = 'Créé par';
            Description = 'HEI.01';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup();
            var
                UserMgtL: Codeunit "User Management";
            begin
                //HEI.01>>
                // UserMgtL.LookupUserID("Created By");//BC UPGRADE PATHAA02
                UserMgtL.DisplayUserInformation("Created By");//BC UPGRADE PATHAA02
                //HEI.01<<               
            end;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //HEI.01>>
        "Created By" := USERID;
        //HEI.01<<
    end;

    trigger OnModify();
    begin
        //HEI.01>>
        "Last Modified Date-Time" := CURRENTDATETIME;
        "Last Modified By User ID" := USERID;
        //HEI.01<<
    end;

    //BC UPGRADE commented>>
    /*
        //BC UPGRADE PATHAA02>>
        local procedure LookupUserID(VAR UserName: Code[50])
        var
            SID: Guid;
        begin
            LookupUser(UserName, SID);
        end;

        local procedure LookupUser(VAR UserName: Code[50]; VAR SID: GUID): Boolean
        var
            user: Record User;
        begin
            User.RESET;
            User.SETCURRENTKEY("User Name");
            User."User Name" := UserName;
            IF User.FIND('=><') THEN;
            IF PAGE.RUNMODAL(PAGE::Users, User) = ACTION::LookupOK THEN BEGIN
                UserName := User."User Name";
                SID := User."User Security ID";
                EXIT(TRUE);
            END;

            EXIT(FALSE);
        end;
        //BC UPGRADE PATHAA02<<
    */
    //BC UPGRADE commented<<
}

