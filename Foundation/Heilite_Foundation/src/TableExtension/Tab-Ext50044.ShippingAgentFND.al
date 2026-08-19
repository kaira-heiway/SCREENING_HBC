tableextension 50044 ShippingAgentExtFND extends "Shipping Agent"
{
    // version NAVW110.0,DITW110.00.10
    // DITW15.00.00.21 DDR 13/06/2008 Added fields
    //                                  2014065 Vendor No.
    //                                  2014066 Contact No.
    //                                Added text constant Text2014060,Text2014061,Text2014062
    //                                Added functions GetVend(),UpdateFromCont(),UpdateFromVend()
    //                                Added key "Vendor No.,Contact No."
    // DITW15.00.00.28 DDR 26/11/2008 Added fields
    //                                  2013736 Name 2
    //                                  2013737 Address
    //                                  2013738 Address 2
    //                                  2013739 City
    //                                  2013740 Contact
    //                                  2013741 Phone No.
    //                                  2013742 Telex No.
    //                                  2013743 Country/Region Code
    //                                  2013744 Fax No.
    //                                  2013745 Post Code
    //                                  2013746 E-Mail
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added flowfields
    //                                  2014093 Vendor Currency Code
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    // DITW15.00.00.38 DDR 25/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014272 Transport Arranger Type
    //                                    2014273 Consignor Guarantee
    //                                    2014274 Transporter Guarantee
    //                                    2014275 Owner Guarantee
    //                                    2014276 Consignee Guarantee
    //                     23/11/2010 issue 1217 (DIT711 56)
    //                                  Added functions TestTransportGuarantee()
    //                                  Added text constants Text2014260
    //                     23/12/2010 issue 1217 (DIT711 106)
    //                                  Added fields
    //                                    2014480 Language Code
    //                                    2014481 VAT Registration No.
    //                                  Added keys
    //                                    "VAT Registration No."
    // DITW16.00.00.40 DDR 12/06/2012 DIT-715 #334
    //                                  Added fields
    //                                    2014293 First Transporter Trader
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.05 MSF 20/10/2014 DIT-770 #831 Change Id of table 2014577 to  2035391
    // DITW18.00.06 MSF 13/05/2015 DIT-770 #1212 #1213 #1214 Added Fields
    //                                                                   2014410 "Responsibility Center"
    //                                                                   2014411 "Physical Location Group Code"
    // DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214 Added Function LookupShipmentAgent
    // DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214 Delete Field Physical location group code

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 MSF 07/07/2017 NRQ#16224 Return Registration part 3
    //                                  Added fields : "Customer No."
    //                                        Function :GetCust

    // HEI.01 CHG0255774_FDD_TC_Calculation_Enhancement IBM NANDIS01 08.07.2019
    //   New field "Own Logistics" added for making agent as own logistics
    // HEI.02 FDD-HT678, HT679 IBM SURYAS01 22.08.2019
    //   #Created New Field - "Auto Mail on release Order"
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
        modify("Internet Address")
        {
            CaptionML = ENU = 'Internet Address', FRA = 'Adresse Internet';
        }
        modify("Account No.")
        {
            CaptionML = ENU = 'Account No.', FRA = 'N° compte';
        }
        field(50000; "Own Logistics FND"; Boolean)
        {
            Description = 'HEI.01';
            Caption = 'Own Logistics';

            trigger OnValidate();
            begin
                // BC Upgrade NANDIS03 >>
                // //HEI.01>>
                // if "Own Logistics" then begin
                //     if ("Vendor No." <> '') then begin
                //         "Vendor No." := '';
                //         MODIFY;
                //     end;
                // end;
                // //HEI.01<<
                // BC Upgrade NANDIS03 <<
            end;
        }
        field(50001; "Auto Mail on release Order FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'Auto Mail on release Order';
        }
        // field(2013736;"Name 2";Text[50])
        // {
        //     CaptionML = ENU='Name 2',
        //                 FRA='Nom 2';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013737;Address;Text[50])
        // {
        //     CaptionML = ENU='Address',
        //                 FRA='Adresse';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013738;"Address 2";Text[50])
        // {
        //     CaptionML = ENU='Address 2',
        //                 FRA='Adresse 2';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013739;City;Text[30])
        // {
        //     CaptionML = ENU='City',
        //                 FRA='Ville';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW17.00.01 DDR 13/02/2013 DIT-770 #001
        //         rPostCode.ValidateCity(City,"Post Code",DummyCounty,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        //         // >>DITW17.00.01 DDR DIT-770 #001
        //     end;
        // }
        // field(2013740;Contact;Text[50])
        // {
        //     CaptionML = ENU='Contact',
        //                 FRA='Contact';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013741;"Phone No.";Text[30])
        // {
        //     CaptionML = ENU='Phone No.',
        //                 FRA='N° téléphone';
        //     Description = 'DITW15.00.00.28';
        //     ExtendedDatatype = PhoneNo;
        // }
        // field(2013742;"Telex No.";Text[30])
        // {
        //     CaptionML = ENU='Telex No.',
        //                 FRA='N° télex';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013743;"Country/Region Code";Code[10])
        // {
        //     CaptionML = ENU='Country/Region Code',
        //                 FRA='Code pays/région';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "Country/Region";
        // }
        // field(2013744;"Fax No.";Text[30])
        // {
        //     CaptionML = ENU='Fax No.',
        //                 FRA='N° télécopie';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013745;"Post Code";Code[20])
        // {
        //     CaptionML = ENU='Post Code',
        //                 FRA='Code Postal';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "Post Code";
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW17.00.01 DDR 13/02/2013 DIT-770 #001
        //         rPostCode.ValidatePostCode(City,"Post Code",DummyCounty,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        //         // >>DITW17.00.01 DDR DIT-770 #001
        //     end;
        // }
        // field(2013746;"E-Mail";Text[80])
        // {
        //     CaptionML = ENU='E-Mail',
        //                 FRA='E-mail';
        //     Description = 'DITW15.00.00.28';
        //     ExtendedDatatype = EMail;
        // }
        // field(2014065;"Vendor No.";Code[20])
        // {
        //     CaptionML = ENU='Vendor No.',
        //                 FRA='N° fournisseur';
        //     Description = 'DITW15.00.00.21';
        //     TableRelation = Vendor;

        //     trigger OnValidate();
        //     begin
        //         // <<DIT15.00.00.21 DDR 19/06/2008 - DITW15.00.00.35 DDR 19/08/2009
        //         if "Vendor No." <> '' then begin
        //         GetVend("Vendor No.");
        //         rVend.CheckBlockedVendOnDocs(rVend,false);
        //         rVend.TESTFIELD("Gen. Bus. Posting Group");
        //         if not blnSkipContact then begin
        //           UpdateFromCont("Vendor No.");
        //         end;
        //         end;
        //         // >>DIT15.00.00.35 DDR
        //         // <<DITW15.00.00.35 DDR 19/08/2009
        //         CALCFIELDS("Vendor Currency Code");
        //         // >>DITW15.00.00.35 DDR
        //     end;
        // }
        // field(2014066;"Contact No.";Code[20])
        // {
        //     CaptionML = ENU='Contact No.',
        //                 FRA='N° contact';
        //     Description = 'DITW15.00.00.21';
        //     TableRelation = Contact;

        //     trigger OnLookup();
        //     var
        //         lrContBusinessRelation : Record "Contact Business Relation";
        //         lrCont : Record Contact;
        //     begin
        //         // <<DIT15.00.00.21 DDR 19/06/2008
        //         if ("Vendor No." <> '') and lrCont.GET("Contact No.") then
        //           lrCont.SETRANGE("Company No.",lrCont."Company No.")
        //         else
        //           if "Vendor No." <> '' then begin
        //             lrContBusinessRelation.RESET;
        //             lrContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
        //             lrContBusinessRelation.SETRANGE("Link to Table",lrContBusinessRelation."Link to Table"::Vendor);
        //             lrContBusinessRelation.SETRANGE("No.","Vendor No.");
        //             if lrContBusinessRelation.FINDFIRST then
        //               lrCont.SETRANGE("Company No.",lrContBusinessRelation."Contact No.");
        //           end else
        //             lrCont.SETFILTER("Company No.",'<>''''');

        //         if "Contact No." <> '' then
        //           if lrCont.GET("Contact No.") then ;
        //         if PAGE.RUNMODAL(0,lrCont) = ACTION::LookupOK then begin
        //           xRec := Rec;
        //           VALIDATE("Contact No.",lrCont."No.");
        //         end;
        //         // >>DIT15.00.00.21 DDR
        //     end;

        //     trigger OnValidate();
        //     var
        //         lrContBusinessRelation : Record "Contact Business Relation";
        //         lrCont : Record Contact;
        //     begin
        //         // <<DIT15.00.00.21 DDR 19/06/2008
        //         if ("Vendor No." <> '') and ("Contact No." <> '') then begin
        //           lrCont.GET("Contact No.");
        //           lrContBusinessRelation.RESET;
        //           lrContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
        //           lrContBusinessRelation.SETRANGE("Link to Table",lrContBusinessRelation."Link to Table"::Vendor);
        //           lrContBusinessRelation.SETRANGE("No.","Vendor No.");
        //           if lrContBusinessRelation.FINDFIRST then
        //             if lrContBusinessRelation."Contact No." <> lrCont."Company No." then
        //               ERROR(Text2014061,lrCont."No.",lrCont.Name,"Vendor No.");
        //         end;

        //         UpdateFromVend("Contact No.");
        //         // >>DIT15.00.00.21 DDR
        //     end;
        // }
        // field(2014067;"Customer No.";Code[20])
        // {
        //     Caption = 'Customer No.';
        //     Description = 'NRQ#16224';
        //     TableRelation = Customer;

        //     trigger OnValidate();
        //     begin
        //         //<<DITW110.00.10 MSF 07/07/2017 NRQ#16224
        //         if "Customer No." <> '' then begin
        //           GetCust("Customer No.");
        //           rCust.CheckBlockedCustOnDocs(rCust,1,true,true);
        //           rCust.TESTFIELD("Gen. Bus. Posting Group");
        //          end;
        //     end;
        // }
        // field(2014093;"Vendor Currency Code";Code[10])
        // {
        //     CalcFormula = Lookup(Vendor."Currency Code" WHERE ("No."=FIELD("Vendor No.")));
        //     CaptionML = ENU='Vendor Currency Code (Shipping)',
        //                 FRA='Code devise fournisseur (Transport)';
        //     Description = 'DITW15.00.00.35';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = Currency;
        // }
        // field(2014272;"Transport Arranger Type";Option)
        // {
        //     CaptionML = ENU='Transport Arranger',
        //                 FRA='Organisateur de transport';
        //     Description = 'DITW15.00.00.38 #1217';
        //     OptionCaptionML = ENU=' ,Consignor,Consignee,Owner of Goods,Other',
        //                       FRA=' ,Expéditeur,Destinataire,Propriétaire des marchandises,Autre';
        //     OptionMembers = " ",Consignor,Consignee,"Owner of Goods",Other;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         TestTransportGuarantee();
        //         // >>DITW15.00.00.38 #1217
        //         // <<DITW16.00.00.40 DDR 12/06/2012 DIT-715 #334
        //         if ("Transport Arranger Type" <> "Transport Arranger Type"::"Owner of Goods") and
        //           ("Transport Arranger Type" <> "Transport Arranger Type"::Other)
        //         then
        //           "First Transporter Trader" := '';
        //         // >>DITW16.00.00.40 DDR DIT-715 #334
        //     end;
        // }
        // field(2014273;"Consignor Guarantee";Boolean)
        // {
        //     CaptionML = ENU='Consignor Guarantee',
        //                 FRA='Expéditeur de garantie';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         TestTransportGuarantee();
        //         // >>DITW15.00.00.38 #1217
        //     end;
        // }
        // field(2014274;"Transporter Guarantee";Boolean)
        // {
        //     CaptionML = ENU='Transporter Guarantee',
        //                 FRA='Transporteur de garantie';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         TestTransportGuarantee();
        //         // >>DITW15.00.00.38 #1217
        //     end;
        // }
        // field(2014275;"Owner Guarantee";Boolean)
        // {
        //     CaptionML = ENU='Owner Guarantee',
        //                 FRA='Propriétaire de garantie';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         TestTransportGuarantee();
        //         // >>DITW15.00.00.38 #1217
        //     end;
        // }
        // field(2014276;"Consignee Guarantee";Boolean)
        // {
        //     CaptionML = ENU='Consignee Guarantee',
        //                 FRA='Destinataire de garantie';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         TestTransportGuarantee();
        //         // >>DITW15.00.00.38 #1217
        //     end;
        // }
        // field(2014293;"First Transporter Trader";Code[20])
        // {
        //     CaptionML = ENU='First Transporter',
        //                 FRA='Premier Transporteur';
        //     Description = 'DITW16.00.00.40 DIT-715 #334';
        //     TableRelation = Contact;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.40 DDR 12/06/2012 DIT-715 #334
        //         if ("Transport Arranger Type" <> "Transport Arranger Type"::"Owner of Goods") and
        //           ("Transport Arranger Type" <> "Transport Arranger Type"::Other)
        //         then
        //           TESTFIELD("First Transporter Trader",'');
        //     end;
        // }
        // field(2014410;"Responsibility Center";Code[10])
        // {
        //     CaptionML = ENU='Responsibility Center',
        //                 FRA='Centre de gestion';
        //     Description = 'DITW18.00.06 MSF 13/05/2015 DIT-770 #1212 #1213 #1214';
        //     TableRelation = "Responsibility Center";

        //     trigger OnValidate();
        //     var
        //         LocationCode : Code[10];
        //     begin
        //     end;
        // }
        // field(2014480;"Language Code";Code[10])
        // {
        //     CaptionML = ENU='Language Code',
        //                 FRA='Code langue';
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 106)';
        //     TableRelation = Language;
        // }
        // field(2014481;"VAT Registration No.";Text[20])
        // {
        //     CaptionML = ENU='VAT Registration No.',
        //                 FRA='N° identif. intracomm.';
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 106)';

        //     trigger OnValidate();
        //     var
        //         VATRegNoFormat : Record "VAT Registration No. Format";
        //     begin
        //         VATRegNoFormat.Test("VAT Registration No.","Country/Region Code",Code,DATABASE::"Shipping Agent");
        //     end;
        // }  // BC Upgrade NANDIS03
    }
    // keys
    // {
    //     key(Key1;"Vendor No.","Contact No.")
    //     {
    //     }
    //     key(Key2;"VAT Registration No.")
    //     {
    //     }
    // }  // BC Upgrade NANDIS03

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        rCust: Record Customer;
        rPostCode: Record "Post Code";
        ResponsibilityCenter: Record "Responsibility Center";
        rVend: Record Vendor;
        blnSkipContact: Boolean;
        blnSkipFromContact: Boolean;
        DummyCounty: Text[30];
        Text2014060: TextConst ENU = 'Contact %1 %2 is not related to vendor %3.', FRA = 'Le contact %1 %2 n''est pas associé au fournisseur %3.';
        Text2014061: TextConst ENU = 'Contact %1 %2 is related to a different company than vendor %3.', FRA = 'Le contact %1 %2 est associé à une société différente de celle du fournisseur %3.';
        Text2014062: TextConst ENU = 'Contact %1 %2 is not related to a vendor.', FRA = 'Le contact %1 %2 n''est pas associé à un fournisseur.';
        Text2014260: TextConst ENU = ' is %5 and you must either specify and/or %1; %2; %3; %4', FRA = ' est %5 et vous devez spécifier et/ou %1; %2; %3; %4';
    //"_HEI.01TxtConst_": ;  // BC Upgrade NANDIS03
}

