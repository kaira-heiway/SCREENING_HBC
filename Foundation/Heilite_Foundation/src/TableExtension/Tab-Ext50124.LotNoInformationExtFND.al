tableextension 50124 LotNoInformationExtFND extends "Lot No. Information"
{
    // version NAVW17.00,QXL11.01,DITW110.00.11,HEI.01
    //HEI.01 -BC Upgrade PATHAA02- On Drinkit Field-Quality Status, Heilite customisation is done(Update of captions for Quality Status & Function written on CU50001 and called in this object-->WHSUTILS.OnAfterValidateQualityStatusLotNoInformation(Rec,xRec);)
    //BC Upgrade PATHAA02-Commented all DrinkIT fields, variables and text constants

    //BC Upgrade Kamnay01  Created this table  extension to add the field  for "Your Reference" . This field is required for FDD-DTW 006

    fields
    {
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 2)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Test Quality")
        {
            CaptionML = ENU = 'Test Quality', FRA = 'Contrôle qualité';
            OptionCaptionML = ENU = ' ,Good,Average,Bad', FRA = ' ,Bon,Moyen,Mauvais';
        }
        modify("Certificate Number")
        {
            CaptionML = ENU = 'Certificate Number', FRA = 'N° certificat';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 14)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Inventory)
        {

            //Unsupported feature: Change CalcFormula on "Inventory(Field 20)". Please convert manually.

            CaptionML = ENU = 'Inventory', FRA = 'Stocks';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify("Bin Filter")
        {

            //Unsupported feature: Change TableRelation on ""Bin Filter"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Bin Filter', FRA = 'Filtre emplacement';
        }
        modify("Expired Inventory")
        {

            //Unsupported feature: Change CalcFormula on ""Expired Inventory"(Field 24)". Please convert manually.

            CaptionML = ENU = 'Expired Inventory', FRA = 'Stock expiré';
        }

        field(54000; "Your Reference FND"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = ToBeClassified;
        }

        //Unsupported feature: CodeInsertion on ""Item No."(Field 1)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<QXL9.00.001 DAT 23/03/2016
        Getitem;
        Description := Item.Description;
        //>>QXL9.00.001 DAT 23/03/2016
        */
        //end;


        //Unsupported feature: CodeInsertion on "Blocked(Field 13)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //var  //BC Upgrade PATHAA02
        // LotWarning: Page "Lot Warning"; //BC Upgrade PATHAA02
        //begin
        /*
        //<<QXL9.00.001 DAT 23/03/2016
        Getitem;
        // <<DITW18.00.06 DDR 28/04/2015 DIT-770 #805
        if QualitySetup.READPERMISSION then begin
        // >>DITW18.00.06 DDR DIT-770 #805
          Item.CALCFIELDS("Quality Tracked");
          if Item."Quality Tracked" then
            if USERID <> '' then begin
              if QualityUser.GET(USERID) then begin
                if xRec.Blocked then QualityUser.TESTFIELD("Unblock Quality Tracked Lots",true)
                  else QualityUser.TESTFIELD("Block Quality Tracked Lots",true);
                LotWarning.SETTABLEVIEW(Rec);
                LotWarning.SETRECORD(Rec);
                if xRec.Blocked then
                  LotWarning.SetAction(1)
                else
                  LotWarning.SetAction(0);
                //<< DITW18.00.07 VSC 11/01/2016 DIT-770 #1748
                if LotWarning.RUNMODAL <> ACTION::Yes then
                //>> DITW18.00.07 VSC DIT-770 #1748
                  Blocked := xRec.Blocked;
                CLEAR(LotWarning);
              end else
                if xRec.Blocked then
                  ERROR(Text2035100,Text2035102)
                else
                  ERROR(Text2035100,Text2035101);
            end;
          end;
        //>>QXL9.00.001 DAT 23/03/2016
        */
        //end;
        //BC Upgrade PATHAA02>>
        // field(2014065;"Inventory On Bin";Decimal)
        // {
        //     CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" WHERE ("Item No."=FIELD("Item No."),
        //                                                              "Variant Code"=FIELD("Variant Code"),
        //                                                              "Lot No."=FIELD("Lot No."),
        //                                                              "Location Code"=FIELD("Location Filter"),
        //                                                              "Bin Code"=FIELD("Bin Filter")));
        //     CaptionML = ENU='Inventory on BIN',
        //                 FRA='Inventoir sur BIN';
        //     Description = '#1331';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035051;"SSCC Inventory";Decimal)
        // {
        //     CalcFormula = Sum("SSCC Ledger Entry".Quantity WHERE ("Item No."=FIELD("Item No."),
        //                                                           "Variant Code"=FIELD("Variant Code"),
        //                                                           "Lot No."=FIELD("Lot No."),
        //                                                           "Location Code"=FIELD("Location Filter")));
        //     CaptionML = ENU='SSCC Inventory',
        //                 FRA='Stocks SSCC';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.38 #1139';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035098;"Your Reference";Text[30])
        // {
        //     CaptionML = ENU='Your Reference',
        //                 FRA='Votre référence';
        //     Description = 'QXL9.00.001';
        // }
        // field(2035101;"Buy-from Vendor No.";Code[20])
        // {
        //     CaptionML = ENU='Buy-from Vendor No.',
        //                 FRA='N° preneur d''ordre';
        //     Description = 'QXL9.00.001';
        // }
        // field(2035102;"Quality Status";Option)
        // {
        //     CaptionML = ENU='Quality Status',
        //                 FRA='Status qualité';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     OptionCaptionML = ENU='Quality Hold,Unrestricted,Blocked,Concession,Rejected,Pending',
        //                       FRA='Quarantaine,Bon,Mauvais,Concession,Refusé,Suspendu';
        //     OptionMembers = Quarantine,Pass,Fail,Concession,Rejected,Pending;

        //     trigger OnValidate();
        //     begin
        //         //<<QXL9.00.001 DAT 23/03/2016
        //         if ("Quality Status" = "Quality Status"::Pass) or ("Quality Status" = "Quality Status"::Concession) or
        //           ("Quality Status" = "Quality Status"::Pending)
        //           then
        //           Blocked := false
        //         else
        //           Blocked := true;
        //         //>>QXL9.00.001 DAT 23/03/2016
        //         //<< QXL10.01 VSC 30/10/2017 NRQ#43357
        //         //<< QXL10.01 VSC 01/11/2017 NRQ#43357
        //         if QualitySetup.GET and (CurrFieldNo = FIELDNO("Quality Status")) then begin
        //         //>> QXL10.01 VSC NRQ#43357
        //           if not QualityUser.GET(USERID) then
        //             QualityUser.INIT;
        //           if (xRec.Blocked <> Blocked) then begin
        //             if Blocked then
        //               QualityUser.TESTFIELD("Block Quality Tracked Lots",true)
        //             else
        //               QualityUser.TESTFIELD("Unblock Quality Tracked Lots",true);
        //           end;
        //         end;
        //         //>> QXL10.01 VSC NRQ#43357
        //         //HEI.01>>
        //         WHSUTILS.OnAfterValidateQualityStatusLotNoInformation(Rec,xRec);
        //         //HEI.01<<
        //     end;
        // }
        // field(2035103;"Expiration Date";Date)
        // {
        //     Caption = 'Expiration Date';
        //     Description = 'QXL11.01';
        // }
        // field(2035172;"Gyle No.";Code[20])
        // {
        //     CaptionML = ENU='Gyle No.',
        //                 FRA='Gyle N°';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        //BC Upgrade PATHAA02<<
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemTrackingComment.SETRANGE(Type,ItemTrackingComment.Type::"Lot No.");
    ItemTrackingComment.SETRANGE("Item No.","Item No.");
    ItemTrackingComment.SETRANGE("Variant Code","Variant Code");
    ItemTrackingComment.SETRANGE("Serial/Lot No.","Lot No.");
    ItemTrackingComment.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    //<<QXL9.00.001 DAT 23/03/2016
    QualityTestHeader.RESET;
    QualityTestHeader.SETCURRENTKEY("Lot No.",Status);
    QualityTestHeader.SETRANGE("Lot No.","Lot No.");
    QualityTestHeader.SETRANGE(Status,QualityTestHeader.Status::Quarantine);
    if not QualityTestHeader.ISEMPTY then
      QualityTestHeader.DELETEALL(true);
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //begin
    /*
    //<<QXL9.00.001 DAT 23/03/2016
    if "Item No." <> '' then
      VALIDATE("Item No.");
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        Item: Record Item;
    //BC Upgrade PATHAA02>>
    // QualityUser : Record "Quality User";
    // QualityTestHeader : Record "Quality Test Header";
    // QualitySetup : Record "Quality Setup";
    // LotWarning : Page "Lot Warning";

    // Text2035100 : TextConst ENU='You do not have permission to %1 lots.\\Please contact your system administrator if you need your permissions changing.',FRA='Vous n''êtes pas autorisé à modifier les lots %1.\\Contactez votre administrateur systSme si avez besoin de modifier vos autorisations.';
    // Text2035101 : TextConst ENU='block',FRA='Bloquer';
    // Text2035102 : TextConst ENU='unblock',FRA='débloquer';        
    // WHSUTILS : Codeunit "WHS-UTILS";
    //BC Upgrade PATHAA02<<
}

