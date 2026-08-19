tableextension 50219 StandardServiceLineExtFND extends "Standard Service Line"
{
    //   DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                               Added functions GetCaptionClassPM(),SetCaptionClassPM()
    //                                               Added flowfilters
    //                                                 2034942 Plant Maintenance Caption
    //                   DDR 17/09/2012 DIT-715 #297 Bugfix length local variables for function GetCaptionClassPM()

    //   FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 DDR 15/04/2015 DIT-770 #983 Review functions GetCaptionClassPM(),SetCaptionClassPM()
    //   DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    //   HEI.01 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //     # Description made non-Editable

    // BC Upgrade KUMARS145 Table Extension Created
    // BC Upgrade KUMARS145 Description field's property "Editable"  is not changeable.
    fields
    {
        modify("Standard Service Code")
        {
            CaptionML = ENU = 'Standard Service Code', FRA = 'Code prestation standard';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = ' ,Item,Resource,Cost,G/L Account', FRA = ' ,Article,Ressource,Coût,Compte général';
        }
        modify("No.")
        {
            //Unsupported feature: Change TableRelation on ""No."(Field 4)". Please convert manually.
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
            //Unsupported feature: Change Description on "Description(Field 5)". Please convert manually.
            //Unsupported feature: Change Editable on "Description(Field 5)". Please convert manually.
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Amount Excl. VAT")
        {
            CaptionML = ENU = 'Amount Excl. VAT', FRA = 'Montant HT';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        //BC Upgrade KUMARS145 DWIT Commented ....>>
        // field(2034942; "Plant Maintenance Caption"; Boolean)
        // {
        //     CaptionML = ENU = 'Plant Maintenance Caption',
        //                 FRA = 'Label Maintenance Usine';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     FieldClass = FlowFilter;
        // }
        //BC Upgrade KUMARS145 DWIT Commented .....<<
    }
    //BC Upgrade KUMARS145 DWIT Code Commented....>>
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyModification on "Text000(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=must not be %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=must not be %1;FRA=ne doit pas être %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=must be positive;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=must be positive;FRA=doit être de signe positif;
    //Variable type has not been exported.

    // var
    //     RunModeCaptionPM: Boolean;
    // BC Upgrade KUMARS145....<<
}

