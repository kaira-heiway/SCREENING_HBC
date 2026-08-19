table 50132 "Export Protocol FND"
{
    // HEI.01 V1.05 HT84 IBM POENAB02 04.04.2019 # New table for Bank Connectivity interface

    // BC Upgrade PATELS08 >>
    // # For 'Check Object Name' Field, Replaced deprecated system table Object reference in CalcFormula with supported AllObj table
    // BC Upgrade PATELS08 <<
    Caption = 'Export Protocol';

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code',
                        FRB = 'Code',
                        NLB = 'Code';
            NotBlank = true;
        }
        field(21; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        FRB = 'Désignation',
                        NLB = 'Omschrijving';
        }
        field(25; "Check Object ID"; Integer)
        {
            CaptionML = ENU = 'Check Object ID',
                        FRB = 'Vérifier ID objet',
                        NLB = 'Controleer object-ID';
            //TableRelation = Object.ID WHERE (Type=CONST(Codeunit));  // BC Upgrade NANDIS03 - Own Code

            trigger OnValidate();
            begin
                CALCFIELDS("Check Object Name");
            end;
        }
        field(26; "Check Object Name"; Text[30])
        {
            // BC Upgrade PATELS08 >> # Replaced deprecated system table Object reference in CalcFormula with supported AllObj table
            //CalcFormula = Lookup(Object.Name WHERE (Type=CONST(Codeunit),ID=FIELD("Check Object ID")));  // BC Upgrade NANDIS03 - Own Code
            CalcFormula = Lookup(AllObj."Object Name" WHERE("Object Type" = CONST(Codeunit), "Object ID" = FIELD("Check Object ID")));
            // BC Upgrade PATELS08 <<

            CaptionML = ENU = 'Check Object Name',
                        FRB = 'Vérifier nom objet',
                        NLB = 'Controleer objectnaam';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Export Object ID"; Integer)
        {
            CaptionML = ENU = 'Export Object ID',
                        FRB = 'Exporter ID objet',
                        NLB = 'Export object-ID';
            /*TableRelation = IF ("Export Object Type" = CONST(Report)) Object.ID where(Type = CONST(Report))
            else IF ("Export Object Type" = CONST(XMLPort)) Object.ID where(Type = CONST(XMLport));*/  // BC Upgrade NANDIS03 - Own Code
        }
        field(32; "Export No. Series"; Code[10])
        {
            CaptionML = ENU = 'Export No. Series',
                        FRB = 'Souche de n° d''exportation',
                        NLB = 'Exportnr. series';
            TableRelation = "No. Series".Code;
        }
        field(33; "Export Object Type"; Option)
        {
            CaptionML = ENU = 'Export Object Type',
                        FRB = 'Exporter type objet',
                        NLB = 'Objecttype exporteren';
            OptionCaptionML = ENU = 'Report,XMLPort',
                              FRB = 'État,XMLPort',
                              NLB = 'Rapport,XMLPoort';
            OptionMembers = "Report","XMLPort";
        }
        field(40; "Code Expenses"; Option)
        {
            CaptionML = ENU = 'Code Expenses',
                        FRB = 'Code frais',
                        NLB = 'Kostencode';
            OptionCaptionML = ENU = ' ,SHA,BEN,OUR',
                              FRB = ' ,SHA,BEN,OUR',
                              NLB = ' ,SHA,BEN,OUR';
            OptionMembers = " ",SHA,BEN,OUR;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ExportAgainQst: TextConst ENU = 'The selected items have already been exported. Do you want to export again?', FRB = 'Les articles sélectionnés ont déjà été exportés. Voulez-vous les réexporter ?', NLB = 'De geselecteerde items zijn al geëxporteerd. Wilt u opnieuw exporteren?';

    procedure CheckPaymentLines(var PmtJnlLine: Record "Gen. Journal Line"): Boolean;
    var
        PmtJnlLineToCheck: Record "Gen. Journal Line";
    begin
        /*
        IF ("Export Object Type" = "Export Object Type"::XMLPort) AND ("Check Object ID" = 0) THEN
          EXIT(TRUE);
        
        TESTFIELD("Check Object ID");
        PmtJnlLineToCheck.COPY(PmtJnlLine);
        PmtJnlLineToCheck.SETRANGE(Status,PmtJnlLineToCheck.Status::Created);
        EXIT(CODEUNIT.RUN("Check Object ID",PmtJnlLineToCheck));
        */

    end;

    procedure ExportPaymentLines(var PmtJnlLine: Record "Gen. Journal Line");
    var
        GenJnlLine: Record "Gen. Journal Line";
        PmtJnlLineToExport: Record "Gen. Journal Line";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        SEPACTExportFile: Codeunit "SEPA CT-Export File";
    begin
        /*
        IF CheckPaymentLines(PmtJnlLine) THEN BEGIN
          TESTFIELD("Export Object ID");
          PmtJnlLineToExport.COPY(PmtJnlLine);
          PmtJnlLineToExport.SETRANGE(Status,PmtJnlLineToExport.Status::Created);
          PmtJnlLineToExport.SETRANGE("Export Protocol Code",Code);
          PmtJnlLineToExport.SETRANGE("Journal Batch Name",PmtJnlLine."Journal Batch Name");
          PmtJnlLineToExport.SETRANGE("Journal Template Name",PmtJnlLine."Journal Template Name");
        
          IF "Export Object Type"="Export Object Type"::Report THEN
            REPORT.RUNMODAL("Export Object ID",TRUE,FALSE,PmtJnlLineToExport)
          else BEGIN
            IF PmtJnlLine."Exported To File" THEN
              IF NOT CONFIRM(ExportAgainQst) THEN
                EXIT;
        
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Journal Batch Name",PmtJnlLine."Journal Batch Name");
            GenJnlLine.SETRANGE("Journal Template Name",PmtJnlLine."Journal Template Name");
            GenJnlLine.SETFILTER("Line No.",SelectionFilterManagement.GetSelectionFilterForEBPaymentJournal(PmtJnlLineToExport));
            SEPACTExportFile.Export(GenJnlLine,"Export Object ID");
            PmtJnlLine."Exported To File" := TRUE;
            PmtJnlLine.MODIFY;
          end;
        end;
        */

    end;
}

