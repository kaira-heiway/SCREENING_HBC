page 54012 "Run Calculation WIP"
{
    // version HEI.05
    //BC Upgrade Kamnay01 Original(Heilite) page id 50419
    // Code      Date( DDMMYYY)     DEV     CHANGE ID      DESCRIPTION
    // -----------------------------------------------------------------
    // HEI.01   10.07.2020       FCE      CHG2060993    Calculation of the WIP for Releease open Production Orders
    // Hei.02   16.07.2020       FCE      CHG2060993    Added values for the Zone filtering
    // Hei.03   29.07.2020       FCE      Increased thee code from 10 to 20 for thee journal and the batch code
    // hei.04 24.03.21 IBM.Ak changed the function
    // HEI.05 CHG2118099 11.05.22 IBM PATHAA02
    //  # field on Request Page-"DocumentCode" made editable
    //  # field on Request Page-"Posting date" made editable
    //  # Code written on openpage()

    //Bc Upgrade YADAVM09 Application Area added for page and fields.

    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Documents; //BC Upgrade Kamnay01 

    layout
    {
        area(content)
        {
            group("WIP Related Setup")
            {

                Caption = 'WIP Related Setup';
            }
            field(PostingDate; PostingDate)
            {
                ApplicationArea = all;
                Caption = 'Posting Date';
                NotBlank = true;

                trigger OnValidate();
                begin

                    CreatedocumentNumber();
                end;
            }
            field(JournalTemplate; JournalTemplate)
            {
                ApplicationArea = all;
                Caption = 'Journal Template';
                TableRelation = "Gen. Journal Template".Name;
            }
            field("Template Batch"; "Template Batch")
            {
                ApplicationArea = all;
                Caption = 'Template Batch';

                trigger OnLookup(var Text: Text): Boolean
                var
                    GenJournalBatch: Record "Gen. Journal Batch";
                begin
                    GenJournalBatch.RESET();
                    GenJournalBatch.SETRANGE(GenJournalBatch."Journal Template Name", JournalTemplate);
                    GenJournalBatch.FILTERGROUP(0);
                    if PAGE.RUNMODAL(0, GenJournalBatch) = ACTION::LookupOK then
                        "Template Batch" := GenJournalBatch.Name;
                end;
            }
            field(MaterialPercentage; MaterialPercentage)
            {
                Caption = 'Percentage Materials';
                Editable = false;
                Enabled = false;
                ToolTip = 'Value is taken from setting in General Ledger Setup';
                Visible = false;
            }
            field(CapacityPercentage; CapacityPercentage)
            {
                Caption = '"Percentage Capacity "';
                Editable = false;
                Enabled = false;
                ToolTip = 'Value is taken from setting in General Ledger Setup';
                Visible = false;
            }
            field("GeneralLedgerSetup.""WIP Output Zone Filtering"""; GeneralLedgerSetup."WIP Output Zone Filtering FND")
            {
                Caption = 'Zone Filtering Values';
                Editable = false;
                Enabled = false;
                ShowCaption = true;
                Visible = LimitZoneOutput;
            }
            field(DocumentCode; DocumentCode)
            {
                ApplicationArea = all;
                Caption = 'Document Code';
            }
            field(IncludeAlreadyPostedEntries; IncludeAlreadyPostedEntries)
            {
                ApplicationArea = all;
                Caption = 'Include only Posted Entries in Calculation';
            }
        }
    }

    actions
    {
        area(creation)
        {

            action("Run Calculation")
            {
                Image = "Action";
                Promoted = true;

                trigger OnAction();
                var
                    WIPCalculation: Codeunit "WIP Calculation";
                    Proceed: Boolean;
                    ResultMessage: Text;
                begin
                    // Run Calculation
                    if (PostingDate = 0D) or (JournalTemplate = '') or ("Template Batch" = '') then
                        ERROR(HEI02);
                    // Check on Excisting General Journal Lines
                    Proceed := true;
                    if GeneralJournalLinesExcist() then
                        if not CONFIRM(HEI04, false) then
                            Proceed := false;

                    // Before Posting check if there are GL Entries with document type =9 and document code is same as in Page
                    if Proceed then begin
                        if GLPostingsExcist() then
                            if not CONFIRM(HEI03, false) then
                                Proceed := false;

                        if Proceed then begin
                            WIPCalculation.SetParameters(JournalTemplate, "Template Batch", PostingDate, MaterialPercentage, CapacityPercentage, DocumentCode, LimitZoneOutput, IncludeAlreadyPostedEntries);
                            ResultMessage := WIPCalculation.CalculateValue(); //hei.04
                            MESSAGE(ResultMessage);
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnInit();
    begin
        // Retrieve evalues from Setups
        GeneralLedgerSetup.GET();
        MaterialPercentage := GeneralLedgerSetup."WIP Accrual. Mat. Perc. FND";
        CapacityPercentage := GeneralLedgerSetup."WIP Accrual. Cap. Perc. FND";
        //CurrPage.UPDATE(FALSE);
        LimitZoneOutput := (GeneralLedgerSetup."WIP Output Zone Filtering FND" <> '');
        IncludeAlreadyPostedEntries := true;
    end;

    trigger OnOpenPage();
    begin
        //HEI.05>>
        PostingDate := CALCDATE('<CM>', TODAY);
        CreatedocumentNumber();
        //HEI.05<<
    end;

    var
        PostingDate: Date;
        JournalTemplate: Code[20];
        "Template Batch": Code[20];
        MaterialPercentage: Decimal;
        CapacityPercentage: Decimal;
        LimitZoneOutput: Boolean;
        DocumentCode: Code[20];
        HEI01: Label 'POAC';
        HEI02: Label 'You have not filled in all the required fields';
        HEI03: Label 'There seems to be Postings in the selected period. Do you llike to continue?';
        HEI04: Label 'There seem to be lines created in the General Journal for the selected period. Do you like to proceed?';
        GeneralLedgerSetup: Record "General Ledger Setup";
        HEI05: Label 'Lines have been created, but many issues with Production Orders';
        IncludeAlreadyPostedEntries: Boolean;

    local procedure CreatedocumentNumber();
    begin
        // Define the Document number based on month and year
        DocumentCode := HEI01 + FORMAT(DATE2DMY(PostingDate, 2)) + '_' + FORMAT(DATE2DMY(PostingDate, 3));
    end;

    local procedure GLPostingsExcist(): Boolean;
    var
        GLEntries: Record "G/L Entry";
    begin
        GLEntries.RESET();

        GLEntries.SETRANGE(GLEntries."Document No.", DocumentCode);
        exit(GLEntries.FINDFIRST());
    end;

    local procedure GeneralJournalLinesExcist(): Boolean;
    var
        GenJournalLines: Record "Gen. Journal Line";
    begin
        GenJournalLines.RESET();

        GenJournalLines.SETRANGE("Document No.", DocumentCode);
        exit(GenJournalLines.FINDFIRST());
    end;
}

