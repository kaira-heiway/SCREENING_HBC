tableextension 50155 ProductionBOMVersionExtFND extends "Production BOM Version"
{
    // version NAVW110.0,DITW110.00.09,HEI.07

    // DITW17.10.04 AKH 23/11/2014 DIT-770 #1005 Updated the length of the field "Description" to 80
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 RFC-CHG0257267 IBM.AB 15.10.2018
    //   # New field Active created
    //   # Code added to validate Activation of BOM Version
    // HEI.02 FDD_HB1029 BULIMC01 IBM 09.07.2020#new fields added:
    //   #50001: "Certify Status"
    //   #50002: "New Status"
    //   #50003: "Close Status"

    // HEI.03 CHG2150741 IBM GOKULS01 01/07/2022 #Validation added in status feild
    // #To validated the starting date must have value
    // #to check all the bom lines has the routing link code
    // #To check same routing link code not tagged in multiple bom's

    // HEI.04 CHG2150741 IBM GOKULS01 11/07/2022 #Validation added in status feild
    // #To Remove check same routing link code not ragged in multiple BOM's

    // HEI.05 CHG2150741 NORRIQ KOROLA04 05.10.2022
    //   #Starting Date - OnValidate() modified
    //   #Status - OnValidate() modified
    //   #ValidateData - function added

    // HEI.06 CHG2150741 NORRIQ KOROLA04 11.10.2022
    //   #Starting Date - OnValidate() modified

    // HEI.07 CHG2150741 NORRIQ KOROLA04 18.10.2022
    //   #GetWeekNo - added

    //BC upgrade Kamnay01 created the table extension for the field group changes for the drop down fields added as part of Gap
    fields
    {
        modify("Production BOM No.")
        {
            CaptionML = ENU = 'Production BOM No.', FRA = 'N° nomenclature production';
        }
        modify("Version Code")
        {
            CaptionML = ENU = 'Version Code', FRA = 'Code version';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
            //BCUpgrade YADAVM09>>
            trigger OnAfterValidate()
            begin
                //HEI.05 >>
                IF Status = Status::Certified THEN
                    FIELDERROR(Status);
                //HEI.05 <<
            end;
            //BCUpgrade YADAVM09<<
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            // OptionCaptionML = ENU = 'New,Certified,Under Development,Closed', FRA = 'Création en cours,Validée,Modification en cours,Clôturée';
            //BCUpgrade YADAVM09>>
            trigger OnBeforeValidate()
            var
                ProdBOMLine: Record "Production BOM Line";
            begin
                //HEI.05 >>
                //>>HEI.03
                IF Status = Status::Certified THEN BEGIN
                    TESTFIELD("Starting Date"); //Validate starting date must have value
                                                //checking routing link code exists for all the lines
                    ProdBOMLine.RESET();
                    ProdBOMLine.SETRANGE("Production BOM No.", "Production BOM No.");
                    ProdBOMLine.SETRANGE("Version Code", "Version Code");
                    ProdBOMLine.SETFILTER("Routing Link Code", '%1', '');
                    IF ProdBOMLine.FINDLAST() THEN
                        ERROR(Text001, ProdBOMLine."Line No.", ProdBOMLine."No.");
                    //checking same routing link not mapped in multiple Production BOM's.
                    //   {ProdBOMLine.RESET;
                    //                     ProdBOMLine.SETRANGE("Production BOM No.", "Production BOM No.");
                    //                     ProdBOMLine.SETRANGE("Version Code", "Version Code");
                    //                     ProdBOMLine.SETFILTER("Routing Link Code", '<>%1', '');
                    //                     IF ProdBOMLine.FINDFIRST THEN BEGIN
                    //                         RoutingLinkCode := ProdBOMLine."Routing Link Code";
                    //                         ProdBOMLine.RESET;
                    //                         ProdBOMLine.SETFILTER("Production BOM No.", '<>%1', "Production BOM No.");
                    //                         ProdBOMLine.SETFILTER("Routing Link Code", '%1', RoutingLinkCode);
                    //                         IF ProdBOMLine.FINDFIRST THEN
                    //                             ERROR(Text002, ProdBOMLine."Production BOM No.", ProdBOMLine."Version Code");
                    //                     end;}//HEI.04 Code commented not required
                    ValidateData();//HEI.06
                end;
                //<<HEI.03
                // ValidateData;//HEI.06
                //HEI.05 <<
            end;

            trigger OnAfterValidate()
            begin
                //HEI.01>>
                IF (Status <> xRec.Status) AND (Status <> Status::Certified) THEN BEGIN
                    "Active FND" := FALSE;
                    MODIFY(TRUE);
                end;
                //HEI.01<<
            end;
            //BCUpgrade YADAVM09<<
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        //Unsupported feature: CodeInsertion on ""Starting Date"(Field 10)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.05 >>
        if Status = Status::Certified then
          FIELDERROR(Status);
        //HEI.05 <<
        */
        //end;


        //Unsupported feature: CodeModification on "Status(Field 45).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if (Status <> xRec.Status) and (Status = Status::Certified) then begin
          ProdBOMCheck.ProdBOMLineCheck("Production BOM No.","Version Code");
          TESTFIELD("Unit of Measure Code");
        #4..7
        end;
        MODIFY(true);
        COMMIT;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.05 >>
        //>>HEI.03
        if Status = Status::Certified then begin
          TESTFIELD("Starting Date"); //Validate starting date must have value
          //checking routing link code exists for all the lines
          ProdBOMLine.RESET;
          ProdBOMLine.SETRANGE("Production BOM No.","Production BOM No.");
          ProdBOMLine.SETRANGE("Version Code","Version Code");
          ProdBOMLine.SETFILTER("Routing Link Code",'%1','');
          if ProdBOMLine.FINDLAST then
            ERROR(Text001,ProdBOMLine."Line No.",ProdBOMLine."No.");
          //checking same routing link not mapped in multiple Production BOM's.
          {ProdBOMLine.RESET;
          ProdBOMLine.SETRANGE("Production BOM No.","Production BOM No.");
          ProdBOMLine.SETRANGE("Version Code","Version Code");
          ProdBOMLine.SETFILTER("Routing Link Code",'<>%1','');
          IF ProdBOMLine.FINDFIRST THEN BEGIN
            RoutingLinkCode := ProdBOMLine."Routing Link Code";
            ProdBOMLine.RESET;
            ProdBOMLine.SETFILTER("Production BOM No.",'<>%1',"Production BOM No.");
            ProdBOMLine.SETFILTER("Routing Link Code",'%1',RoutingLinkCode);
            IF ProdBOMLine.FINDFIRST THEN
              ERROR(Text002,ProdBOMLine."Production BOM No.",ProdBOMLine."Version Code");
          end;}//HEI.04 Code commented not required
          ValidateData;//HEI.06
        end;
        //<<HEI.03
        // ValidateData;//HEI.06
        //HEI.05 <<
        #1..10
        //HEI.01>>
        if (Status <> xRec.Status) and (Status <> Status::Certified) then begin
            Active := false;
            MODIFY(true);
        end;
        //HEI.01<<
        */
        //end;
        field(50000; "Active FND"; Boolean)
        {
            Description = 'HEI.01';

            trigger OnValidate();
            var
                ProdBOMVersionL: Record "Production BOM Version";
                Text001: Label 'Production BOM Version %1 is already active. So, please deactivate the same before you activate the current Production BOM Version';
            begin
                //HEI.01>>
                TESTFIELD(Status, Status::Certified);
                if "Active FND" then begin
                    ProdBOMVersionL.RESET();
                    ProdBOMVersionL.SETRANGE(ProdBOMVersionL."Production BOM No.", "Production BOM No.");
                    ProdBOMVersionL.SETRANGE(ProdBOMVersionL."Active FND", true);
                    if ProdBOMVersionL.FINDFIRST() then
                        ERROR(Text001, ProdBOMVersionL."Version Code");
                end;
                //HEI.01<<
            end;
        }
        field(50001; "Certify Status FND"; Boolean)
        {
            Description = 'HEI.02';
        }
        field(50002; "New Active FND"; Boolean)
        {
            Description = 'HEI.02';
        }
        field(50003; "Close Status FND"; Boolean)
        {
            Description = 'HEI.02';
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Production BOM No.", Status, "Version Code", Description)
        {

        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        ProdBOMLine: Record "Production BOM Line";
        RoutingLinkCode: Code[20];
        Text001: Label 'Provide the Routing Link Code for line no : %1 and Item No. : %2';
        Text002: Label 'Routing Link Code tagged in another BOM No.: %1 Version Code : %2';


    //Unsupported feature: PropertyModification on "Text001(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot rename the %1 when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot rename the %1 when %2 is %3.;FRA=Vous ne pouvez pas renommer l'enregistrement %1 lorsque la valeur %2 est %3.;
    //Variable type has not been exported.
    procedure ValidateData()
    var
        ProdBOMLine: Record "Production BOM Line";
        ProdBOMVersion: Record "Production BOM Version";
        RoutingLinkCode: Code[20];
        CurStDate: Text;
        ExistStDate: Text;
    begin
        //HEI.05 >>
        //The same Routing Link Code
        ProdBOMLine.RESET();
        ProdBOMLine.SETRANGE("Production BOM No.", "Production BOM No.");
        ProdBOMLine.SETRANGE("Version Code", "Version Code");
        ProdBOMLine.FINDFIRST();
        RoutingLinkCode := ProdBOMLine."Routing Link Code";
        ProdBOMLine.SETFILTER("Routing Link Code", '<>%1', RoutingLinkCode);
        IF ProdBOMLine.FINDFIRST() THEN
            ProdBOMLine.FIELDERROR("Routing Link Code");

        //Starting Date must be on different weeks
        TESTFIELD("Starting Date");//HEI.06
        CurStDate := GetWeekNo("Starting Date");//HEI.07
        ProdBOMLine.RESET();
        ProdBOMLine.SETRANGE("Production BOM No.", "Production BOM No.");
        ProdBOMLine.SETRANGE("Routing Link Code", RoutingLinkCode);
        ProdBOMLine.SETFILTER("Version Code", '<>%1', "Version Code");
        IF ProdBOMLine.findset(false) THEN
            REPEAT
                IF ProdBOMVersion.GET(ProdBOMLine."Production BOM No.", ProdBOMLine."Version Code") THEN
                    IF (ProdBOMVersion."Starting Date" <> 0D) AND (ProdBOMVersion.Status = ProdBOMVersion.Status::Certified) THEN BEGIN
                        ExistStDate := GetWeekNo(ProdBOMVersion."Starting Date");//HEI.07
                        IF CurStDate = ExistStDate THEN
                            ERROR(Text003);
                    end;
            UNTIL ProdBOMLine.NEXT() = 0;
        //HEI.05 <<
    end;

    LOCAL procedure GetWeekNo(InputDate: Date): Text[30]
    var
        MonthStr: Text;
        YearStr: Text;
    begin
        //HEI.07 >>
        YearStr := FORMAT(DATE2DWY(InputDate, 3));
        MonthStr := FORMAT(DATE2DWY(InputDate, 2));
        IF STRLEN(MonthStr) = 1 THEN
            MonthStr := '0' + MonthStr;

        EXIT(YearStr + MonthStr);
        //HEI.07 <<
    end;

    var
        Text003: Label 'Production BOM Version in Certified satatus with the same Starting Week No. already exists.';
}

