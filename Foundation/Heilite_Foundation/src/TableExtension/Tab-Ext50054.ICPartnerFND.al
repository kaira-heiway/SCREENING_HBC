tableextension 50054 ICPartnerExtFND extends "IC Partner"
{
    // version NAVW110.0
    // FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Include Intercompany Interface XL
    //                                Added Field Auto Send IC Document
    // HEI.01 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Field created : 50000 - Location Code

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Inbox Type")
        {
            CaptionML = ENU = 'Inbox Type', FRA = 'Type de boîte de réception';
            //OptionCaptionML = ENU = 'File Location,Database,Email,No IC Transfer', FRA = 'Emplacement du fichier,Base de données,E-mail,Pas de transfert intersociété';
        }
        modify("Inbox Details")
        {

            //Unsupported feature: Change TableRelation on ""Inbox Details"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Inbox Details', FRA = 'Détails sur la boîte de réception';
        }
        modify("Receivables Account")
        {

            //Unsupported feature: Change TableRelation on ""Receivables Account"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Receivables Account', FRA = 'Compte client';
        }
        modify("Payables Account")
        {

            //Unsupported feature: Change TableRelation on ""Payables Account"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Payables Account', FRA = 'Compte fournisseur';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 11)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
        }
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Outbound Sales Item No. Type")
        {
            CaptionML = ENU = 'Outbound Sales Item No. Type', FRA = 'Type n° article vente sortant';
            //OptionCaptionML = ENU = 'Internal No.,Common Item No.,Cross Reference', FRA = 'N° interne,N° article commun,Référence externe';
        }
        modify("Outbound Purch. Item No. Type")
        {
            CaptionML = ENU = 'Outbound Purch. Item No. Type', FRA = 'Type n° article achat sortant';
            //OptionCaptionML = ENU = 'Internal No.,Common Item No.,Cross Reference,Vendor Item No.', FRA = 'N° interne,N° article commun,Référence externe,Référence fournisseur';
        }
        modify("Cost Distribution in LCY")
        {
            CaptionML = ENU = 'Cost Distribution in LCY', FRA = 'Distribution des coûts DS';
        }

        //Unsupported feature: CodeModification on ""Inbox Type"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Inbox Type" <> xRec."Inbox Type" THEN
          "Inbox Details" := '';
        IF "Inbox Type" = "Inbox Type"::Email THEN BEGIN
          IF "Customer No." <> '' THEN BEGIN
            IF Cust.GET("Customer No.") THEN
              "Inbox Details" := Cust."E-Mail";
          end else
            IF "Vendor No." <> '' THEN
              IF Vend.GET("Vendor No.") THEN
                "Inbox Details" := Vend."E-Mail";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Inbox Type" <> xRec."Inbox Type" then
          "Inbox Details" := '';
        if "Inbox Type" = "Inbox Type"::Email then begin
          if "Customer No." <> '' then begin
            if Cust.GET("Customer No.") then
              "Inbox Details" := Cust."E-Mail";
          end else
            if "Vendor No." <> '' then
              if Vend.GET("Vendor No.") then
                "Inbox Details" := Vend."E-Mail";
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Inbox Details"(Field 5).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Inbox Type" OF
          "Inbox Type"::Database:
            BEGIN
              Company.SETFILTER(Name,'<>%1',COMPANYNAME);
              Companies.SETTABLEVIEW(Company);
              Companies.LOOKUPMODE := TRUE;
              IF Companies.RUNMODAL = ACTION::LookupOK THEN BEGIN
                Companies.GETRECORD(Company);
                "Inbox Details" := Company.Name;
              end;
            end;
          "Inbox Type"::"File Location":
            BEGIN
              IF "Inbox Details" = '' THEN
                FileName := STRSUBSTNO('%1.xml',Code)
              else
                FileName := "Inbox Details" + STRSUBSTNO('\%1.xml',Code);

              FileName2 := FileMgt.SaveFileDialog(Text005,FileName,'');
              IF FileName <> FileName2 THEN BEGIN
                Path := FileMgt.GetDirectoryName(FileName2);
                IF Path <> '' THEN
                  "Inbox Details" := COPYSTR(Path,1,250);
              end;
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        case "Inbox Type" of
          "Inbox Type"::Database:
            begin
              Company.SETFILTER(Name,'<>%1',COMPANYNAME);
              Companies.SETTABLEVIEW(Company);
              Companies.LOOKUPMODE := true;
              if Companies.RUNMODAL = ACTION::LookupOK then begin
                Companies.GETRECORD(Company);
                "Inbox Details" := Company.Name;
              end;
            end;
          "Inbox Type"::"File Location":
            begin
              if "Inbox Details" = '' then
                FileName := STRSUBSTNO('%1.xml',Code)
              else
        #17..19
              if FileName <> FileName2 then begin
                Path := FileMgt.GetDirectoryName(FileName2);
                if Path <> '' then
                  "Inbox Details" := COPYSTR(Path,1,250);
              end;
            end;
        end;
        */
        //end;
        field(50000; "Location Code FND"; Code[20])
        {
            Caption = 'Location Code';
            Description = 'HEI.01';
            TableRelation = Location;
        }
        // field(2029618; "Auto Send IC Document"; Boolean)
        // {
        //     Caption = 'Auto Send IC Document';
        //     Description = 'FINXL14.00.15 MSF 13/05/2020 NRQ#117628';
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLEntry.SETRANGE("IC Partner Code",Code);
    AccountingPeriod.SETRANGE(Closed,FALSE);
    IF AccountingPeriod.FINDFIRST THEN
      GLEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
    IF NOT GLEntry.ISEMPTY THEN
      ERROR(Text000,xRec.Code);

    GLSetup.GET;
    IF GLSetup."Allow G/L Acc. Deletion Before" <> 0D THEN BEGIN
      GLEntry.SETFILTER("Posting Date",'>=%1',GLSetup."Allow G/L Acc. Deletion Before");
      IF NOT GLEntry.ISEMPTY THEN
        ERROR(Text001,Code,GLSetup."Allow G/L Acc. Deletion Before");
    end;

    IF "Customer No." <> '' THEN
      IF Cust.GET("Customer No.") THEN
        ERROR(Text002,Code,Cust.TABLECAPTION,Cust."No.");

    IF "Vendor No." <> '' THEN
      IF Vend.GET("Customer No.") THEN
        ERROR(Text002,Code,Vend.TABLECAPTION,Vend."No.");

    ICInbox.SETRANGE("IC Partner Code",Code);
    IF NOT ICInbox.ISEMPTY THEN
      ERROR(Text003,Code,ICInbox.TABLECAPTION);

    ICOutbox.SETRANGE("IC Partner Code",Code);
    IF NOT ICOutbox.ISEMPTY THEN
      ERROR(Text003,Code,ICOutbox.TABLECAPTION);

    GLEntry.RESET;
    GLEntry.SETCURRENTKEY("IC Partner Code");
    GLEntry.SETRANGE("IC Partner Code",Code);
    GLEntry.MODIFYALL("IC Partner Code",'');

    CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"IC Partner");
    CommentLine.SETRANGE("No.",Code);
    CommentLine.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GLEntry.SETRANGE("IC Partner Code",Code);
    AccountingPeriod.SETRANGE(Closed,false);
    if AccountingPeriod.FINDFIRST then
      GLEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
    if not GLEntry.ISEMPTY then
    #6..8
    if GLSetup."Allow G/L Acc. Deletion Before" <> 0D then begin
      GLEntry.SETFILTER("Posting Date",'>=%1',GLSetup."Allow G/L Acc. Deletion Before");
      if not GLEntry.ISEMPTY then
        ERROR(Text001,Code,GLSetup."Allow G/L Acc. Deletion Before");
    end;

    if "Customer No." <> '' then
      if Cust.GET("Customer No.") then
        ERROR(Text002,Code,Cust.TABLECAPTION,Cust."No.");

    if "Vendor No." <> '' then
      if Vend.GET("Customer No.") then
    #21..23
    if not ICInbox.ISEMPTY then
    #25..27
    if not ICOutbox.ISEMPTY then
    #29..38
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot delete IC Partner %1 because it has ledger entries in a fiscal year that has not been closed yet.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot delete IC Partner %1 because it has ledger entries in a fiscal year that has not been closed yet.;FRA=Vous ne pouvez pas supprimer le partenaire IC %1, car il comporte des écritures comptables appartenant à un exercice comptable qui n'a pas encore été clôturé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot delete IC Partner %1 because it has ledger entries after %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot delete IC Partner %1 because it has ledger entries after %2.;FRA=Vous ne pouvez pas supprimer le partenaire IC %1, car il comporte des écritures comptables postérieures à %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot delete IC Partner %1 because it is used for %2 %3;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot delete IC Partner %1 because it is used for %2 %3;FRA=Vous ne pouvez pas supprimer le partenaire IC %1, car il est utilisé pour %2 %3;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=You cannot delete IC Partner %1 because it is used in %2;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=You cannot delete IC Partner %1 because it is used in %2;FRA=Vous ne pouvez pas supprimer le partenaire IC %1, car il est utilisé dans %2;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=%1 %2 is linked to a blocked IC Partner.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=%1 %2 is linked to a blocked IC Partner.;FRA=%1 %2 est lié à un partenaire IC bloqué.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=File Location for IC files;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=File Location for IC files;FRA=Emplacement des fichiers IC;
    //Variable type has not been exported.
}

