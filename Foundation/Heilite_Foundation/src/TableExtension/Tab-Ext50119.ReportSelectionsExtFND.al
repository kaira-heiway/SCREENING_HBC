tableextension 50119 ReportSelectionsExtFND extends "Report Selections"
{
    // version NAVW110.0.00.15052,FINXL10.00,DITW110.00.08,HEI.04
    // DITW15.00.00.35 DDR 11/09/2009 Removed unuseful property OptionCaptionML (overflow)
    //                                Added Purchase service - optionstring for field "Usage"
    //                                  ',,,,,PM.Quote,PM.Order,PM.Invoice,PM.Cr.Memo,PM.Contract Quote,PM.Contract,PM.Test,PM.Receipt'
    // DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                Added field Usage on optionstring "S.Pick","S.Shpt"
    //                 KCO 16/06/2011 issue 1352 Added captions
    // DITW16.00.00.40 DDR 25/01/2012 #1460 Bugfix "Usage" field optionstring property
    //                     13/02/2012 #1460 Renamed optionstring/caption "Sales Order Picking List" -> "S.Order Pick"

    // FINXL7.00.001 RBE 20/03/2013: Added Usage = Pro-Forma

    // DITW17.00.02 SR 10/16/2013 DIT-770 #155 : New Option Added in Usage
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 RPG 18/12/2013 DIT-770 #235 Added New option "Shipment Specification" in Usage field
    // DITW17.10.03 MSF 23/04/2014 DIT-770 #542 :  Sales Return control document
    //                                             Added New option "Return Control" in Usage field
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.07 MVN 12/01/2016 DIT-770 #1740 Merge DIT W1 R7 2016 W1
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014410 "Document Subtype Code"
    // DITW18.00.07 DDR 19/04/2016 DIT-770 #1488 Rename 'Combined Shipment' -> 'Load List'
    // DITW18.00.07 AKH 20/04/2016 DIT-770 #1508 Added field 2014411 "Document Subtype Filter" and updated TableRelation for "Document Subtype Code"
    //                                           Added function SetDocSubtypeFilter()
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 03/02/2017 NRQ#20678 Renumber field 50000 -> 2014500 Usage DIT
    //                                        Modified Primary Key
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 Renamed field2014411 "Document Subtype Filter"
    //                                        Deleted function SEtDocSubtypeFilter()
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL10.00 DDR 03/02/2017 NRQ#20678 UPGRADE NAV 2017 CU1 Added field 2030000 Usage XL
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // HEI.01 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # Added option "WHT Certificate" to Usage field.
    // HEI.02 FDD-OTCGAP022 IBM ISYED01 23.08.2017 # Cash collection ORder
    //   # Added option "Cash.Collection" to Usage field.
    // HEI.03 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    //   # New option "Load List (Pst Whse. Shopment) added to Usage Fields
    // HEI.04 FDD-LB-GAPLOG09 IBM CHAUHB01 18.07.2018 # Loading Note Almaza
    //   # New option "Combined Pick (Whs Shipment)" added to Usage Fields
    // HEI.05  IBM HORTOC01  14.08.2018 - add new usage option "Loading Notes (Whse. Ship)"

    // HEI.06 IBM.NAIKH01 06.09.2018
    //   #Added a new optionstring "Zone (Whse Movement)" on Usage Field

    // HEI.07 IBM.NAIKH01 26.10.2018
    //   #Added a new optionstring "Delivery Note(Whse Ship)" on Usage Field
    // HEI.08 IBM HORTOC01 19.04.2019 # add new options "Unloading Note(Whse. receipt),Picking List By Lot"
    // HEI.09 CHG2011091 IBM GAVANM01 23.05.2019
    //   # add new option "Gate Entry Document" on Usage Field
    // HEI.10 FDD- HB597 IBM BULIMC01 24.05.2019
    //   # add new option "Picking List By SO" on Usage Field
    // HEI.11 FDD- HT465 IBM SURYAS01 28.08.2019
    //   # add new option "Delivery Note(SUR)" on Usage Field
    // HEI.13 FDD-HB503 IBM NASTAA02 30.01.2019 # Post & Print
    //   # Renamed Option of Field "Usage" from "Delivery Note(Local)" to "Delivery Note(Sales Invoice)"
    // HEI.14 CHG2070787 IBM GAVANM01 03.09.2020 - Update all Billing documents in line with Global (for the BAHAMAS)
    //   # add new option "Debit Note" on Usage field
    // HEI.15 CHG2111686 DefectID #6306 IBM GAVANM01 25.05.2021 - Pro-Forma invoice not printed for Domestique customer
    //   # code changes
    fields
    {
        modify(Usage)
        {
            CaptionML = ENU = 'Usage', FRA = 'Activité';
            // OptionCaptionML = ENU = 'S.Quote,S.Order,S.Invoice,S.Cr.Memo,S.Test,P.Quote,P.Order,P.Invoice,P.Cr.Memo,P.Receipt,P.Ret.Shpt.,P.Test,B.Stmt,B.Recon.Test,B.Check,Reminder,Fin.Charge,Rem.Test,F.C.Test,Prod. Order,S.Blanket,P.Blanket,M1,M2,M3,M4,Inv1,Inv2,Inv3,SM.Quote,SM.Order,SM.Invoice,SM.Credit Memo,SM.Contract Quote,SM.Contract,SM.Test,S.Return,P.Return,S.Shipment,S.Ret.Rcpt.,S.Work Order,Invt. Period Test,SM.Shipment,S.Test Prepmt.,P.Test Prepmt.,S.Arch. Quote,S.Arch. Order,P.Arch. Quote,P.Arch. Order,S. Arch. Return Order,P. Arch. Return Order,Asm. Order,P.Assembly Order,S.Order Pick Instruction,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,C.Statement,V.Remittance,JQ,S.Invoice Draft,,,,,,,,,,CustomDIT,CustomXL,Cash.Collection,WHT Certificate,Load List (Pst. Whse. Shipment),Combined Pick (Whs Shipment),Loading Note(Whse Ship),Zone (Whse Movement),Delivery Note(Whse Ship),Unloading Note(Whse. Receipt),Picking List By Lot,Gate Entry Document,Picking List By SO,Delivery Note(Sales Invoice),Debit Note', FRA = 'S.Quote,S.Order,S.Invoice,S.Cr.Memo,S.Test,P.Quote,P.Order,P.Invoice,P.Cr.Memo,P.Receipt,P.Ret.Shpt.,P.Test,B.Stmt,B.Recon.Test,B.Check,Reminder,Fin.Charge,Rem.Test,F.C.Test,Prod. Order,S.Blanket,P.Blanket,M1,M2,M3,M4,Inv1,Inv2,Inv3,SM.Quote,SM.Order,SM.Invoice,SM.Credit Memo,SM.Contract Quote,SM.Contract,SM.Test,S.Return,P.Return,S.Shipment,S.Ret.Rcpt.,S.Work Order,Invt. Period Test,SM.Shipment,S.Test Prepmt.,P.Test Prepmt.,S.Arch. Quote,S.Arch. Order,P.Arch. Quote,P.Arch. Order,S. Arch. Return Order,P. Arch. Return Order,Asm. Order,P.Assembly Order,S.Order Pick Instruction,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,C.Statement,V.Remittance,JQ,S.Invoice Draft,,,,,,,,,,CustomDIT,CustomXL,Cash.Collection,WHT Certificate,Load List (Pst. Whse. Shipment),Combined Pick (Whs Shipment),Loading Note(Whse Ship),Zone (Whse Movement),Delivery Note(Whse Ship),Unloading Note(Whse. Receipt),Picking List By Lot,Gate Entry DocumentPicking List By SO,Delivery Note(Sales Invoice),Debit Note';

            //Unsupported feature: Change OptionString on "Usage(Field 1)". Please convert manually.


            //Unsupported feature: Change Description on "Usage(Field 1)". Please convert manually.

        }
        modify(Sequence)
        {
            CaptionML = ENU = 'Sequence', FRA = 'Séquence';
        }
        modify("Report ID")
        {

            //Unsupported feature: Change TableRelation on ""Report ID"(Field 3)". Please convert manually.

            CaptionML = ENU = 'Report ID', FRA = 'ID état';
        }
        modify("Report Caption")
        {

            //Unsupported feature: Change CalcFormula on ""Report Caption"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Report Caption', FRA = 'Légende de l''état';
        }
        modify("Custom Report Layout Code")
        {

            //Unsupported feature: Change TableRelation on ""Custom Report Layout Code"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Custom Report Layout Code', FRA = 'Code présentation état personnalisé';
        }
        modify("Use for Email Attachment")
        {

            //Unsupported feature: Change InitValue on ""Use for Email Attachment"(Field 19)". Please convert manually.

            CaptionML = ENU = 'Use for Email Attachment', FRA = 'Utiliser comme pièce jointe';
        }
        modify("Use for Email Body")
        {
            CaptionML = ENU = 'Use for Email Body', FRA = 'Utiliser pour le corps du message e-mail';
        }
        modify("Email Body Layout Code")
        {

            //Unsupported feature: Change TableRelation on ""Email Body Layout Code"(Field 21)". Please convert manually.

            CaptionML = ENU = 'Email Body Layout Code', FRA = 'Code présentation du corps du message e-mail';
        }
        modify("Email Body Layout Description")
        {

            //Unsupported feature: Change CalcFormula on ""Email Body Layout Description"(Field 22)". Please convert manually.

            CaptionML = ENU = 'Email Body Layout Description', FRA = 'Description de la présentation du corps du message e-mail';
        }

        //Unsupported feature: CodeInsertion on "Usage(Field 1)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW110.00.08 DDR 03/02/2017 NRQ#20678
        if Usage <> Usage::CustomDIT then
          UsageDIT := UsageDIT::" ";
        // >>DITW110.00.08 DDR NRQ#20678
        //<<FINXL10.00 DDR 03/02/2017 NRQ#20678
        if Usage <> Usage::CustomXL then
          UsageXL := UsageXL::" ";
        //>>FINXL10.00 DDR 03/02/2017 NRQ#20678
        */
        //end;


        //Unsupported feature: CodeModification on ""Report ID"(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CALCFIELDS("Report Caption");
        VALIDATE("Use for Email Body",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CALCFIELDS("Report Caption");
        VALIDATE("Use for Email Body",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Use for Email Attachment"(Field 19).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Use for Email Body" THEN
          VALIDATE("Email Body Layout Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Use for Email Body" then
          VALIDATE("Email Body Layout Code",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Use for Email Body"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Use for Email Body" THEN
          VALIDATE("Email Body Layout Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Use for Email Body" then
          VALIDATE("Email Body Layout Code",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Email Body Layout Code"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Email Body Layout Code" <> '' THEN
          TESTFIELD("Use for Email Body",TRUE);
        CALCFIELDS("Email Body Layout Description");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Email Body Layout Code" <> '' then
          TESTFIELD("Use for Email Body",true);
        CALCFIELDS("Email Body Layout Description");
        */
        //end;


        //Unsupported feature: CodeModification on ""Email Body Layout Description"(Field 22).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CustomReportLayout.LookupLayoutOK("Report ID") THEN
          VALIDATE("Email Body Layout Code",CustomReportLayout.Code);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CustomReportLayout.LookupLayoutOK("Report ID") then
          VALIDATE("Email Body Layout Code",CustomReportLayout.Code);
        */
        //end;

        //BC UPGRADE VAMSIU01 - Document Subtype code field added >>
        field(50000; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FIELD("Doc Subtype Filter Table FND"));
        }
        field(50001; "Doc Subtype Filter Table FND"; Option)
        {
            CaptionML = ENU = 'Document Subtype Filter',
                        FRA = 'Filtre Sous-Type Document';
            FieldClass = FlowFilter;
            OptionCaption = 'Sales,Purchase,,,,Inventory,Service,,,,,,,,,,,,Fin.Contract';
            OptionMembers = Sales,Purchase,BankAcc,Reminder,CashFlow,Inventory,Service,"P.Service","Prod.Order",,,,,,,,,,"Fin.Contract";
            TableRelation = "Document Subtype Code FND";
        }
        //BC UPGRADE VAMSIU01 - Document Subtype code field added <<

        // field(2014410; "Document Subtype Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Document Subtype Code',
        //                 FRA = 'Code Sous-Type Document';
        //     Description = 'DITW18.00.07 DIT-770#1508';
        //     TableRelation = "Document Subtype Code".Code where("Report Selection Type" = FIELD("Document Subtype Filter Table"));
        // }
        // field(2014411; "Document Subtype Filter Table"; Option)
        // {
        //     CaptionML = ENU = 'Document Subtype Filter',
        //                 FRA = 'Filtre Sous-Type Document';
        //     Description = 'DITW18.00.07 DIT-770#1508 NRQ#20755';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = 'Sales,Purchase,BankAcc,Reminder,CashFlow,Inventory,Service,P.Service,Prod.Order,,,,,,,,,,Fin.Contract',
        //                       FRA = 'Vente,Achat,Cpte.Banc,Relance,Trésorerie,Stock,Service,Service.A,O.F,,,,,,,,,,Contrat.Fin';
        //     OptionMembers = Sales,Purchase,BankAcc,Reminder,CashFlow,Inventory,Service,"P.Service","Prod.Order",,,,,,,,,,"Fin.Contract";
        //     TableRelation = "Document Subtype Code";
        // }
        // field(2014500; UsageDIT; Option)
        // {
        //     CaptionML = ENU = 'Usage DIT',
        //                 FRA = 'Usage DIT';
        //     Description = '#1230 #1460 NRQ#20678';
        //     OptionCaptionML = ENU = ' ,PM.Quote,PM.Order,PM.Invoice,PM.Credit Memo,PM.Contract Quote,PM.Contract,PM.Test,PM.Receipt,S.Order Pick,S.Picking List,S.Shipping List,S.Order Shpt.,S.Comb.Pick,S.Load List,Shpt.Spec.,Ret.Control,P.Ship.Agent Notice',
        //                       FRA = ' ,PM.Quote,PM.Order,PM.Invoice,PM.Credit Memo,PM.Contract Quote,PM.Contract,PM.Test,PM.Receipt,S.Order Pick,S.Picking List,S.Shipping List,S.Order Shpt.,S.Comb.Pick,S.Load List,Shpt.Spec.,Ret.Control,P.Ship.Agent Notice';
        //     OptionMembers = " ","PM.Quote","PM.Order","PM.Invoice","PM.Credit Memo","PM.Contract Quote","PM.Contract","PM.Test","PM.Receipt","S.Order Pick","S.Picking List","S.Shipping List","S.Order Shpt.","S.Comb.Pick","S.Load List","Shpt.Spec.","Ret.Control","P.Ship.Agent Notice";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW110.00.08 DDR 03/02/2017 NRQ#20678
        //         if UsageDIT <> UsageDIT::" " then
        //             Usage := Usage::CustomDIT;
        //         // >>DITW110.00.08 DDR NRQ#20678
        //     end;
        // }
        // field(2030000; UsageXL; Option)
        // {
        //     CaptionML = ENU = 'Usage XL',
        //                 FRA = 'Usage XL';
        //     Description = 'NRQ#20678';
        //     OptionCaptionML = ENU = ' ,Pro-Forma',
        //                       FRA = ' ,Pro-Forma';
        //     OptionMembers = " ","Pro-Forma";

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL10.00 DDR 03/02/2017 NRQ#20678
        //         if UsageXL <> UsageXL::" " then
        //             Usage := Usage::CustomXL;
        //         //>>FINXL10.00 DDR 03/02/2017 NRQ#20678
        //     end;
        // }  // BC Upgrade NANDIS03
    }

    keys
    {

        //Unsupported feature: Deletion on ""Usage,Sequence"(Key)". Please convert manually.

        // key(Key1; Usage, UsageDIT, UsageXL, Sequence)
        // {
        // }  // BC Upgrade NANDIS03
    }
    // BC Upgrade SHUKLP03 >> Added FilterDocSubTypeTable.
    procedure FilterDocSubType(ReportSelectionPageType: Option Sales,Purchase,BankAcc,Reminder,CashFlow,Inventory,Service,"P.Service","Prod.Order")
    var
        DummyDocSubtype: Record "Document Subtype Code FND";
    begin
        // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
        SETRANGE("Doc Subtype Filter Table FND");
        CASE ReportSelectionPageType OF
            ReportSelectionPageType::Sales:
                SETFILTER("Doc Subtype Filter Table FND", '%1|%2',
                  DummyDocSubtype."Report Selection Type"::Sales,
                  DummyDocSubtype."Report Selection Type"::"Fin.Contract");
            ReportSelectionPageType::Purchase:
                SETFILTER("Doc Subtype Filter Table FND", '%1',
                  DummyDocSubtype."Report Selection Type"::Purchase);
            ReportSelectionPageType::BankAcc:
                ;
            ReportSelectionPageType::Reminder:
                ;
            ReportSelectionPageType::CashFlow:
                ;
            ReportSelectionPageType::Inventory:
                SETFILTER("Doc Subtype Filter Table FND", '%1',
                  DummyDocSubtype."Report Selection Type"::Inventory);
            ReportSelectionPageType::Service:
                SETFILTER("Doc Subtype Filter Table FND", '%1',
                  DummyDocSubtype."Report Selection Type"::Service);
            ReportSelectionPageType::"P.Service":
                ;
            ReportSelectionPageType::"Prod.Order":
                ;
        END;
    end;
    // BC Upgrade SHUKLP03 >> Added FilterDocSubTypeTable.


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "MustSelectAndEmailBodyOrAttahmentErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MustSelectAndEmailBodyOrAttahmentErr : @@@="%1 = Usage, for example Sales Invoice";ENU=You must select an email body or attachment in report selection for %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MustSelectAndEmailBodyOrAttahmentErr : @@@="%1 = Usage, for example Sales Invoice";ENU=You must select an email body or attachment in report selection for %1.;FRA=Vous devez sélectionner un corps de message e-mail ou une pièce jointe dans la sélection d'état pour %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "EmailBodyIsAlreadyDefinedErr(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //EmailBodyIsAlreadyDefinedErr : @@@="%1 = Usage, for example Sales Invoice";ENU=An email body is already defined for %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //EmailBodyIsAlreadyDefinedErr : @@@="%1 = Usage, for example Sales Invoice";ENU=An email body is already defined for %1.;FRA=Un corps de message e-mail est déjà défini pour %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotBeUsedAsAnEmailBodyErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotBeUsedAsAnEmailBodyErr : @@@="%1 = Report ID,%2 = Type";ENU=Report %1 uses the %2 which cannot be used as an email body.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotBeUsedAsAnEmailBodyErr : @@@="%1 = Report ID,%2 = Type";ENU=Report %1 uses the %2 which cannot be used as an email body.;FRA=L'état %1 utilise %2 qui ne peut pas être utilisé comme corps de message e-mail.;
    //Variable type has not been exported.
}

