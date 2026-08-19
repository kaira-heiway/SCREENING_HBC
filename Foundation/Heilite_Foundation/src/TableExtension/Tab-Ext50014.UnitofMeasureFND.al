tableextension 50014 UnitofMeasureExtFND extends "Unit of Measure"
{
    // version NAVW19.00,IPLXL9.00.001,DITW18.00.07,HEI.01

    // DITW15.00.00.23 DDR 28/07/2008 Added fields
    //                                  2014439 Code Caption
    // DITW15.00.00.28 DDR 26/11/2008 Added functions GetMLName(),GetMLCodeCaption(),GetUnitMeasureTrans()
    // DITW15.00.00.38 DDR 12/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014476 Packaging Type Code
    //                                  Added text constant Text2014410
    // DITW15.00.00.38 DDR 16/02/2011 issue 1217 (DIT711 148) Added validate with field "Packaging Type Code"
    // DITW17.00.02 AT  12/09/2013 DIT-770 #154
    //                             Added field 2014060 Picking Type
    // DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    //                                           Added caption field2014060 Picking Type
    // IPLXL9.00.001 IMI 15/06/2015: Added field "EDI Unit of Measure"

    // HEI.01 FDD-PURGAPINT002 IBM LAZARE02 18.10.2017 # New field for Maximo: "Commercial ISO Code"

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("International Standard Code")
        {
            CaptionML = ENU = 'International Standard Code', FRA = 'Code norme internationale';
        }
        field(50000; "Commercial ISO Code FND"; Code[10])
        {
            Caption = 'Commercial ISO Code';
            Description = 'HEI.01';
        }
        // field(2014060;"Picking Type";Option)
        // {
        //     CaptionML = ENU='Picking Type',
        //                 FRA='Type de prélèvement';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     OptionCaptionML = ENU=' ,Order,Combined',
        //                       FRA=' ,Commande,Regroupée';
        //     OptionMembers = " ","Order",Combined;
        // }
        // field(2014439;"Code Caption";Text[30])
        // {
        //     CaptionML = ENU='Code Caption',
        //                 FRA='Code libellé';
        //     Description = 'DITW15.00.00.23';
        // }
        // field(2014476;"Packaging Type Code";Code[10])
        // {
        //     CaptionML = ENU='Packaging Type Code',
        //                 FRA='Code Type de Conditionnement';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Packaging Type";

        //     trigger OnValidate();
        //     var
        //         Confirmed : Boolean;
        //     begin
        //         // <<DITW15.00.00.38 DDR 25/08/2010 #1217
        //         if CurrFieldNo = FIELDNO("Packaging Type Code") then
        //           Confirmed :=
        //              CONFIRM(
        //                   STRSUBSTNO(
        //                     Text2014410,
        //                     FIELDCAPTION("Packaging Type Code"),
        //                     ItemUOM.FIELDCAPTION("Packaging Type Code"),
        //                     ItemUOM.TABLECAPTION),
        //                     true)
        //         else
        //           Confirmed := true;

        //         if Confirmed then begin
        //           ItemUOM.RESET;
        //           ItemUOM.SETRANGE(Code,Code);
        //           // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
        //           ItemUOM.SETFILTER("Packaging Type Code",'<>%1',"Packaging Type Code");
        //           if ItemUOM.findset(true,false) then
        //             repeat
        //               ItemUOM2 := ItemUOM;
        //               ItemUOM2.VALIDATE("Packaging Type Code","Packaging Type Code");
        //               ItemUOM2.MODIFY;
        //             until ItemUOM.NEXT = 0;
        //           // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        //         end;
        //     end;
        // }
        // field(2030010;"EDI Unit of Measure";Boolean)
        // {
        //     CaptionML = ENU='EDI Unit of Measure',
        //                 FRA='Unité de mesure EDI';
        //     Description = 'IPLXL9.00.001';
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        ItemUOM: Record "Item Unit of Measure";
        ItemUOM2: Record "Item Unit of Measure";
        Text2013660: TextConst ENU = 'Value %1 is already used with %2 %3.', FRA = 'Valeur %1 est déjà utilisé avec %2 %3.';
        Text2014410: TextConst ENU = 'Do you want to update the %2 field on %3 to reflect the new value of %1?', FRA = 'Souhaitez-vous mettre à jour le champ %2 sur %3 pour refléter la nouvelle valeur de %1 ?';
}

