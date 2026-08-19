pageextension 54020 RegisteredWhseActivityListExt extends "Registered Whse. Activity List"
{
    /*  HEI.01 FDD-HT623 CHG2022293 IBM GAVANM01 02.07.2019
          # New fields added: 'Transfer From Bin', 'Transfer To Bin', 'Registering Date'
          # New global variable 'EthiopiaVisible'
          # Visible property set to EthiopiaVisible for the following fields: "In-Transit Zone", "In-Transit Bin", "Transfer From Bin", "Transfer To Bin", "Registering Date"
          # 'Registering date' field moved after the 'Whse. Activity No.' field
        HEI.02 FDD-HT623 CHG2022293 IBM GAVANM01 06.08.2019
          # visible property set to TRUE for the following fields: "Transfer From Bin", "Transfer To Bin", "Registering Date"
          # visible property set to FALSE for the following fields: "In-Transit Zone", "In-Transit Bin"
        HEI.03 CHG2069354 IBM.AK 14.10.20
        # Attached new report-R50449 to Page Action
        HEI.04 IBM.AK 11.03.21
         # Added new fields Shipping Agent, shipping Agent service code, Truck code, Driver Code,
        HEI.05 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
          # Added New Fields - External Document No.
                             - External Document No.2 */
    // version NAVW110.0,HEI.05
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea Property in all Fields.
    // BC Upgrade BHARAD11 <<
    layout
    {
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of activity that the warehouse performed on the lines attached to the header, such as put-away, pick or movement.', FRA = 'Spécifie le type d''activité effectuée par l''entrepôt sur les lignes jointes à l''en-tête (par exemple, Rangement, Prélèvement ou Mouvement).';
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
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the employee who is responsible for the document and assigned to perform the warehouse activity.', FRA = 'Spécifie le code de l''employé responsable du document et qui est affecté à l''activité entrepôt.';
        }
        modify("Sorting Method")
        {
            ToolTipML = ENU = 'Specifies the method by which the lines were sorted on the warehouse header, such as by item, or bin code.', FRA = 'Spécifie la méthode de tri des lignes de l''en-tête entrepôt, telle que par article ou par code emplacement.';
        }
        modify("No. Series")
        {
            ToolTipML = ENU = 'Specifies the number series code used if a number was assigned to the registered warehouse activity header.', FRA = 'Spécifie le code de la souche de numéros utilisée si un numéro a été affecté à l''en-tête activité entrepôt enregistrée.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Whse. Activity No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Whse. Activity No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Assigned User ID"(Control 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Assigned User ID"(Control 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sorting Method"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sorting Method"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Series"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Series"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        addafter("Whse. Activity No.")
        {
            field("Registering Date"; Rec."Registering Date")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("Transfer Type"; Rec."Transfer Type FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field("From Zone Code"; Rec."From Zone Code FND")
            {
                ApplicationArea = All;
            }
            field("To Zone Code"; Rec."To Zone Code FND")
            {
                ApplicationArea = All;
            }
            field("In-Transit Zone"; Rec."In-Transit Zone FND")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("In-Transit Bin"; Rec."In-Transit Bin FND")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("No. Series")
        {
            field("Transfer From Bin"; Rec."Transfer From Bin FND")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("Transfer To Bin"; Rec."Transfer To Bin FND")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code FND")
            {
                ApplicationArea = All;
            }
            field("Shipping Agent Service Code"; Rec."Shipping Agent Service Cod FND")
            {
                ApplicationArea = All;
            }
            field("Truck Code"; Rec."Truck Code FND")
            {
                ApplicationArea = All;
            }
            field("Driver Code"; Rec."Driver Code FND")
            {
                ApplicationArea = All;
            }
            field("External Document No."; Rec."External Document No. FND")
            {
                ApplicationArea = All;
            }
            field("External Document No.2"; Rec."External Document No.2 FND")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Line"(Action 17)". Please convert manually.



        //Unsupported feature: CodeModification on "Card(Action 19).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        case Type of
          Type::"Put-away":
            PAGE.RUN(PAGE::"Registered Put-away",Rec);
          Type::Pick:
            PAGE.RUN(PAGE::"Registered Pick",Rec);
          Type::Movement:
            PAGE.RUN(PAGE::"Registered Movement",Rec);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CASE Type OF
        #2..7
        END;
        */
        //end;

        //Unsupported feature: PropertyDeletion on "Card(Action 19)". Please convert manually.

        addafter(Card)
        {
            action("Zone WH Reconciliation")
            {
                ApplicationArea = All;
                Image = Zones;
                RunObject = Report "WH Zone Movements Recon CBN";
            }
        }
    }


    //Unsupported feature: PropertyModification on "RegisteredWhseActivHeader(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RegisteredWhseActivHeader : "Registered Whse. Activity Hdr.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RegisteredWhseActivHeader : 5772;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "WMSManagement(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //WMSManagement : "WMS Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WMSManagement : 7302;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text000(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Registered Whse. Put-away List;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Registered Whse. Put-away List;FRA=Liste rangements entrep. enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Registered Whse. Pick List;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Registered Whse. Pick List;FRA=Liste prélèvements entrep. enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Registered Whse. Movement List;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Registered Whse. Movement List;FRA=Liste mouvements entrep. enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Registered Whse. Activity List;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Registered Whse. Activity List;FRA=Liste activités entrep. enreg.;
    //Variable type has not been exported.

    var
        EthiopiaVisible: Boolean;


    //Unsupported feature: CodeModification on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if FIND(Which) then begin
      RegisteredWhseActivHeader := Rec;
      while true do begin
        if WMSManagement.LocationIsAllowed("Location Code") then
          exit(true);
        if NEXT(1) = 0 then begin
          Rec := RegisteredWhseActivHeader;
          if FIND(Which) then
            while true do begin
              if WMSManagement.LocationIsAllowed("Location Code") then
                exit(true);
              if NEXT(-1) = 0 then
                exit(false);
            end;
        end;
      end;
    end;
    exit(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF FIND(Which) THEN BEGIN
      RegisteredWhseActivHeader := Rec;
      WHILE TRUE DO BEGIN
        IF WMSManagement.LocationIsAllowed("Location Code") THEN
          EXIT(TRUE);
        IF NEXT(1) = 0 THEN BEGIN
          Rec := RegisteredWhseActivHeader;
          IF FIND(Which) THEN
            WHILE TRUE DO BEGIN
              IF WMSManagement.LocationIsAllowed("Location Code") THEN
                EXIT(TRUE);
              IF NEXT(-1) = 0 THEN
                EXIT(FALSE);
            END;
        END;
      END;
    END;
    EXIT(FALSE);
    */
    //end;


    //Unsupported feature: CodeModification on "OnNextRecord". Please convert manually.

    //trigger OnNextRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Steps = 0 then
      exit;

    RegisteredWhseActivHeader := Rec;
    repeat
      NextSteps := NEXT(Steps / ABS(Steps));
      if WMSManagement.LocationIsAllowed("Location Code") then begin
        RealSteps := RealSteps + NextSteps;
        RegisteredWhseActivHeader := Rec;
      end;
    until (NextSteps = 0) or (RealSteps = Steps);
    Rec := RegisteredWhseActivHeader;
    FIND;
    exit(RealSteps);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Steps = 0 THEN
      EXIT;

    RegisteredWhseActivHeader := Rec;
    REPEAT
      NextSteps := NEXT(Steps / ABS(Steps));
      IF WMSManagement.LocationIsAllowed("Location Code") THEN BEGIN
        RealSteps := RealSteps + NextSteps;
        RegisteredWhseActivHeader := Rec;
      END;
    UNTIL (NextSteps = 0) OR (RealSteps = Steps);
    Rec := RegisteredWhseActivHeader;
    FIND;
    EXIT(RealSteps);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //HEI.01>>
    IF (TENANTID = 'ethiopia') {OR (TENANTID = 'default')} THEN
      EthiopiaVisible := TRUE
    ELSE
      EthiopiaVisible := FALSE;
    //HEI.01<<
    */
    //end;


    //Unsupported feature: CodeModification on "FormCaption(PROCEDURE 1)". Please convert manually.

    //procedure FormCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    case Type of
      Type::"Put-away":
        exit(Text000);
      Type::Pick:
        exit(Text001);
      Type::Movement:
        exit(Text002);
      else
        exit(Text003);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CASE Type OF
      Type::"Put-away":
        EXIT(Text000);
      Type::Pick:
        EXIT(Text001);
      Type::Movement:
        EXIT(Text002);
      ELSE
        EXIT(Text003);
    END;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

