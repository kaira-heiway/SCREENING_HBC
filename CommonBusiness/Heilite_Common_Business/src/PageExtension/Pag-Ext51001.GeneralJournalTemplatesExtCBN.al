pageextension 51001 GeneralJournalTemplatesExtCBN extends "General Journal Templates"
{
    // version NAVW110.0,FINXL7.00,DITW110.00.08,HEI.03
    // FINXL7.00.001 RBE 04/06/2013: Added field: "Credit Memo"

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HNK LOGGAP001 03/10/2018 IBM.CHAUHB01
    //   #New field added "Save Batch"
    // HEI.02 FDD-CHG2022328 IBM POENAB02 07.07.2019 # External document No. duplication in journal
    //   #New fields added: "Customer Mandate", "RPM Payment", "Ext. Doc. No. Mandatory", "Restrct Duplicate Extrn Doc"
    // HEI.04 FDD-CD-HT1350 IBM BULIMC01 16.07.2020#new field added:"SO Cash Application"

    // HEI.01 CHG2127493 IBM YADAVP04 27.11.2021 HB2527 Development of Payroll interface in Heilite Base V1.6 #PayrollBooleanfield added
    // HEI.02 CHG2190168 IBM POENAB02 25.01.2023 HB2330 BKT-EFT Citi bank payment file update for DRC
    //   #New field 50008 DRC - Show Pay. Method
    //   # 25.01.2023 Old CHG CHG2117475 was replaced with CHG2190168. Initial change was on 13.12.2021.
    // HEI.03 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #New field added-"Blocked".
    //   #Modified Trigger/Functions- Blocked - OnValidate()
    layout
    {
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the journal template you are creating.', FRA = 'Spécifie le nom du modèle de feuille que vous créez.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a brief description of the journal template you are creating.', FRA = 'Spécifie une brève description du modèle de feuille que vous créez.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the journal type. The type determines what the window will look like.', FRA = 'Spécifie le type de feuille. Ce dernier détermine l''aspect de la fenêtre.';
        }
        modify(Recurring)
        {
            ToolTipML = ENU = 'Specifies whether the journal template will be a recurring journal.', FRA = 'Spécifie si le modèle feuille est une feuille récurrente.';
        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the code for the balancing account type that should be used in this general journal template.', FRA = 'Spécifie le code du type de compte contrepartie à utiliser dans ce modèle feuille.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the balancing account that should be used in this general journal template.', FRA = 'Spécifie le numéro du compte contrepartie à utiliser dans ce modèle feuille.';
        }
        modify("No. Series")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign document numbers to journal lines in this general journal template.', FRA = 'Spécifie le code des souches de numéros qui sont utilisées pour affecter des numéros de document aux lignes feuille de ce modèle feuille comptabilité.';
        }
        modify("Posting No. Series")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign document numbers to ledger entries that are posted from journals using this template.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros de document aux écritures comptables validées à partir de feuilles créées d''après ce modèle.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the code linked to the journal template.', FRA = 'Spécifie le code lié à ce modèle feuille.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies a reason code that will be inserted on the journal lines.', FRA = 'Spécifie un code motif qui va être inséré dans les lignes feuille.';
        }
        modify("Force Doc. Balance")
        {
            ToolTipML = ENU = 'Specifies whether transactions that are posted in the general journal must balance by document number and document type, in addition to balancing by date.', FRA = 'Indique si les transactions qui sont validées dans la feuille comptabilité doivent être équilibrées par numéro et par type de document, en plus d''une contrepartie par date.';
        }
        modify("Copy VAT Setup to Jnl. Lines")
        {
            ToolTipML = ENU = 'Specifies whether the program to calculate VAT for accounts and balancing accounts on the journal line of the selected journal template.', FRA = 'Spécifie si le programme doit calculer la TVA pour les comptes et les comptes contrepartie dans la ligne feuille du modèle feuille sélectionné.';
        }
        modify("Allow VAT Difference")
        {
            ToolTipML = ENU = 'Specifies whether to allow the manual adjustment of VAT amounts in journals.', FRA = 'Spécifie s''il faut autoriser l''ajustement manuel des montants de TVA dans les feuilles.';
        }
        modify("Page ID")
        {
            ToolTipML = ENU = 'Specifies the window number used by the program for this journal template.', FRA = 'Spécifie le numéro de la fenêtre utilisée par le programme pour ce modèle feuille.';
        }
        modify("Page Caption")
        {
            ToolTipML = ENU = 'Specifies the name of the journal template''s window.', FRA = 'Spécifie le nom de la fenêtre du modèle feuille.';
        }
        modify("Test Report ID")
        {
            ToolTipML = ENU = 'Specifies the test report that is printed when you click Test Report.', FRA = 'Spécifie le test qui est imprimé lorsque vous cliquez sur Impression test.';
        }
        modify("Test Report Caption")
        {
            ToolTipML = ENU = 'Specifies the name of the test report that is printed when you print a journal under this journal template.', FRA = 'Spécifie le nom de l''impression test qui est imprimée lorsque vous imprimez une feuille dans ce modèle feuille.';
        }
        modify("Posting Report ID")
        {
            ToolTipML = ENU = 'Specifies the posting report that is printed when you choose Post and Print.', FRA = 'Spécifie l''état de validation qui est imprimé lorsque vous cliquez sur Valider et imprimer.';
        }
        modify("Posting Report Caption")
        {
            ToolTipML = ENU = 'Specifies the name of the report that is printed when you print the journal.', FRA = 'Spécifie le nom de l''état qui est imprimé lorsque vous imprimez la feuille.';
        }
        modify("Force Posting Report")
        {
            ToolTipML = ENU = 'Specifies whether a report is printed automatically when you post.', FRA = 'Spécifie si un état est automatiquement imprimé lorsque vous validez.';
        }
        modify("Cust. Receipt Report ID")
        {
            ToolTipML = ENU = 'Specifies how to print customer receipts when you post.', FRA = 'Spécifie le mode d''impression des réceptions client lors de la validation.';
        }
        modify("Cust. Receipt Report Caption")
        {
            ToolTipML = ENU = 'Specifies how to print customer receipts when you post.', FRA = 'Spécifie le mode d''impression des réceptions client lors de la validation.';
        }
        modify("Vendor Receipt Report ID")
        {
            ToolTipML = ENU = 'Specifies how to print customer receipts when you post.', FRA = 'Spécifie le mode d''impression des réceptions client lors de la validation.';
        }
        modify("Vendor Receipt Report Caption")
        {
            ToolTipML = ENU = 'Specifies how to print vendor receipts when you post.', FRA = 'Spécifie le mode d''impression des réceptions fournisseur lors de la validation.';
            Visible = true;// BC Upgrade NANDIS03
        }

        //Unsupported feature: CodeModification on ""Copy VAT Setup to Jnl. Lines"(Control 43).OnValidate". Please convert manually.

        //trigger  Lines"(Control 43)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Copy VAT Setup to Jnl. Lines" <> xRec."Copy VAT Setup to Jnl. Lines" THEN
          IF NOT CONFIRM(Text001,TRUE,FIELDCAPTION("Copy VAT Setup to Jnl. Lines")) THEN
            ERROR(Text002);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Copy VAT Setup to Jnl. Lines" <> xRec."Copy VAT Setup to Jnl. Lines" then
          if not CONFIRM(Text001,true,FIELDCAPTION("Copy VAT Setup to Jnl. Lines")) then
            ERROR(Text002);
        */
        //end;


        //Unsupported feature: CodeModification on ""Allow VAT Difference"(Control 45).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Allow VAT Difference" <> xRec."Allow VAT Difference" THEN
          IF NOT CONFIRM(Text001,TRUE,FIELDCAPTION("Allow VAT Difference")) THEN
            ERROR(Text002);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Allow VAT Difference" <> xRec."Allow VAT Difference" then
          if not CONFIRM(Text001,true,FIELDCAPTION("Allow VAT Difference")) then
            ERROR(Text002);
        */
        //end;
        addafter(Description)
        {
            field(Blocked; Rec."Blocked FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Blocked field.';
                trigger OnValidate();
                begin
                    //HEI.03>>
                    Rec.MODIFY();
                    CurrPage.UPDATE();
                    //HEI.03<<
                end;
            }
        }
        addafter("Vendor Receipt Report Caption")
        {
            // BC Upgrade NANDIS03 - Blocked DIT field >>
            // field("Credit Memo"; Rec."Credit Memo")
            // {
            //     Description = 'FINXL7.00.001';
            // }
            // BC Upgrade NANDIS03 - Blocked DIT field <<
            field("Save Batch"; Rec."Save Batch FND")
            {
                Visible = true;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Save Batch field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                     ToolTip = 'Specifies the value of the Save Batch field.';

            }
            field("Customer Mandate"; Rec."Customer Mandate FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Mandate field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Customer Mandate field.';

            }
            field("RPM Payment"; Rec."RPM Payment FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Payment field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the RPM Payment field.';

            }
            field("Ext. Doc. No. Mandatory"; Rec."Ext. Doc. No. Mandatory FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = true;
                ToolTip = 'Specifies the value of the Ext. Doc. No. Mandatory field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Ext. Doc. No. Mandatory field.';

            }
            field("Restrct Duplicate Extrn Doc"; Rec."Restrct Dplct. Extrn Doc FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Restrct Duplicate Extrn Doc field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Restrct Duplicate Extrn Doc field.';

            }
            field("SO Cash Application"; Rec."SO Cash Application FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SO Cash Application field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the SO Cash Application field.';

            }
            field(Payroll; Rec."Payroll FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payroll field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Payroll field.';

            }
            field("DRC - Show Pay. Method"; Rec."DRC - Show Pay. Method FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the DRC - Show Payment Method field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the DRC - Show Payment Method field.';

            }
        }

    }
    actions
    {
        modify("Te&mplate")
        {
            CaptionML = ENU = 'Te&mplate', FRA = '&Modèle';
        }
        modify(Batches)
        {
            CaptionML = ENU = 'Batches', FRA = 'Noms feuilles';
            ToolTipML = ENU = 'Set up multiple general journals for a specific template. You can use batches when you need multiple journals of a certain type.', FRA = 'Configurez plusieurs feuilles comptabilité pour un modèle spécifique. Vous pouvez utiliser des lots lorsque vous avez besoin de plusieurs feuilles d''un certain type.';

            //Unsupported feature: Change RunPageLink on "Batches(Action 39)". Please convert manually.

        }
    }


    //Unsupported feature: PropertyModification on "Text001(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Do you want to update the %1 field on all general journal batches?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Do you want to update the %1 field on all general journal batches?;FRA=Voulez-vous mettre à jour le champ %1 sur tous les noms feuilles comptabilité ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Canceled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Canceled.;FRA=Annulé.;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

