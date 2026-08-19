pageextension 51091 GeneralJnltemplateListExt extends "General Journal Template List"
{
    //     HEI.01 FDD-CHG2022328 IBM POENAB02 07.07.2019 # External document No. duplication in journal
    //   #New fields added "Customer Mandate", "Ext. Doc. No. Mandatory", "Restrct Duplicate Extrn Doc"
    // HEI.02 CHG2238142 IBM YADAVM09 21.03.2024 #Harmonization of RTR templates plus disabling old templates
    //   #Filters added on page as per user general setup
    // HEI.03 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #New field added-Blocked.
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
            ToolTipML = ENU = 'Specifies the journal type.', FRA = 'Indique le type de feuille.';
        }
        modify(Recurring)
        {
            ToolTipML = ENU = 'Specifies whether the journal template will be a recurring journal.', FRA = 'Spécifie si le modèle feuille est une feuille récurrente.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the source code linked to the journal template.', FRA = 'Spécifie le code source lié au modèle feuille.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies a reason code that will be inserted on the journal lines.', FRA = 'Spécifie un code motif qui va être inséré dans les lignes feuille.';
        }
        modify("Force Doc. Balance")
        {
            ToolTipML = ENU = 'Specifies whether transactions that are posted in the general journal must balance by document number and document type.', FRA = 'Indique si les transactions qui sont validées dans la feuille doivent être équilibrées par numéro et par type de document.';
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
        addafter(Description)
        {
            field(Blocked; Rec."Blocked FND")
            {
                ApplicationArea = All;
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
        addafter("Force Posting Report")
        {
            field("Customer Mandate"; Rec."Customer Mandate FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Mandate field.';
            }
            field("Ext. Doc. No. Mandatory"; Rec."Ext. Doc. No. Mandatory FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ext. Doc. No. Mandatory field.';
            }
            field("Restrct Duplicate Extrn Doc"; Rec."Restrct Dplct. Extrn Doc FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Restrct Duplicate Extrn Doc field.';
            }
        }
    }
    //BC Upgrade Kamnay01>>
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.02
        CLEAR(BatchName);
        UserGenJournalSetup.RESET();
        UserGenJournalSetup.SETRANGE("User ID", USERID);
        UserGenJournalSetup.SETRANGE("Journal Type", UserGenJournalSetup."Journal Type"::General);
        IF UserGenJournalSetup.findset(false) THEN
            REPEAT
                IF BatchName <> '' THEN
                    BatchName := BatchName + '|' + UserGenJournalSetup."Gen. Journal Template Name"
                else
                    BatchName := UserGenJournalSetup."Gen. Journal Template Name";
            UNTIL UserGenJournalSetup.NEXT() = 0;

        IF BatchName <> '' THEN
            Rec.SETFILTER(Name, BatchName)
        else
            Rec.SETRANGE(Name, '');
        //HEI.02
    end;
    //BC Upgrade Kamnay01<<
    var
        UserGenJournalSetup: Record "User Gen. Journal Setup FND";
        BatchName: Text;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //HEI.02
    CLEAR(BatchName);
    UserGenJournalSetup.RESET;
    UserGenJournalSetup.SETRANGE("User ID",USERID);
    UserGenJournalSetup.SETRANGE("Journal Type",UserGenJournalSetup."Journal Type"::General);
    if UserGenJournalSetup.findset(false,false) then
      repeat
        if BatchName <> '' then
          BatchName := BatchName +'|' +UserGenJournalSetup."Gen. Journal Template Name"
        else
          BatchName := UserGenJournalSetup."Gen. Journal Template Name";
      until UserGenJournalSetup.NEXT =0;

    if BatchName <> '' then
      SETFILTER(Name,BatchName)
    else
      SETRANGE(Name,'');
    //HEI.02
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

