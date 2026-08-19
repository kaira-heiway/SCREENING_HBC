tableextension 50063 DimensionValueExtFND extends "Dimension Value"
{
    // version NAVW110.0,DITW110.00.10,BPMGAP016,HEI.15
    // HEI.BC.01 22.09.2025 SAHAL01 (Version Upgrade BC260)
    // Migrated Customizations in the Table(50063) extn.

    fields
    {
        modify("Dimension Code")
        {
            CaptionML = ENU = 'Dimension Code', FRA = 'Code axe';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            trigger OnAfterValidate()
            begin
                FinancialUtils.MaintainCapexDim("Dimension Code");//HEI.01 BPMGAP016
                //HEI.13>>
                //SetLastModifiedDateTime; //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
                //HEI.13<<
                //HEI.15>>
                //UpdateDimValueCodeZycus(false); //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
                //HEI.15<<
            end;
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            trigger OnAfterValidate()
            begin
                FinancialUtils.MaintainCapexDim("Dimension Code");//HEI.01 BPMGAP016
                //HEI.13>>
                //SetLastModifiedDateTime; //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
                //HEI.13<<
            end;
        }
        modify("Dimension Value Type")
        {
            CaptionML = ENU = 'Dimension Value Type', FRA = 'Type section';
            OptionCaptionML = ENU = 'Standard,Heading,Total,Begin-Total,End-Total', FRA = 'Standard,Titre,Total,Début total,Fin total';
        }
        modify(Totaling)
        {
            CaptionML = ENU = 'Totaling', FRA = 'Totalisation';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
            trigger OnAfterValidate()
            begin
                //HEI.13>>
                //SetLastModifiedDateTime; //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
                //HEI.13<<
            end;
        }
        modify("Consolidation Code")
        {
            CaptionML = ENU = 'Consolidation Code', FRA = 'Code consolidation';
        }
        modify(Indentation)
        {
            CaptionML = ENU = 'Indentation', FRA = 'Indentation';
        }
        modify("Global Dimension No.")
        {
            CaptionML = ENU = 'Global Dimension No.', FRA = 'N° axe principal';
        }
        modify("Map-to IC Dimension Code")
        {
            CaptionML = ENU = 'Map-to IC Dimension Code', FRA = 'Code axe IC à faire corresp.';
        }
        modify("Map-to IC Dimension Value Code")
        {
            CaptionML = ENU = 'Map-to IC Dimension Value Code', FRA = 'Code sect an. axe IC => corres';
        }
        modify("Dimension Value ID")
        {
            CaptionML = ENU = 'Dimension Value ID', FRA = 'ID section analytique';
        }
        field(50000; "Business TypeDimValue Code FND"; Code[20])
        {
            CaptionML = ENU = 'Business Type Dimension Value Code', FRA = 'Business Type Dimension Value Code';
            Description = 'HEI.03';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Business Type Dime. Code FND"));
        }
        field(50001; "CIL Code FND"; Code[10])
        {
            Description = 'HEI.01';
            Caption = 'CIL Code';
        }
        field(50002; "Approver ID FND"; Code[20])
        {
            Caption = 'Approver ID';
            Description = 'HEI.02';
            trigger OnLookup();
            var
                UserMgt: Codeunit "User Management";
            begin
                //HEI.02>>
                UserMgt.DisplayUserInformation("Approver ID FND");
                //HEI.02<<
            end;

            trigger OnValidate();
            var
                UserL: Record User;
                UserMgt: Codeunit "User Management";
            begin
                //HEI.02>>
                //UserMgt.ValidateUserID("Approver ID"); //BC Update SAHAL01 (Function removed by Microsoft)
                //HEI.02<<

                //HEI.13>>
                //SetLastModifiedDateTime; //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
                //HEI.13<<
            end;
        }
        field(50003; "Business Type Dime. Code FND"; Code[20])
        {
            CaptionML = ENU = 'Business Type Dimension Code',
                        FRA = 'Business Type Dimension Code';
            Description = 'HEI.03';
            Editable = false;
        }
        field(50004; "Approver Name FND"; Code[20])
        {
            Caption = 'Approver Name';
            Description = 'HEI.02';
        }
        field(50005; "Reporting Entity FND"; Code[20])
        {
            Description = 'HEI.04';
            Caption = 'Reporting Entity';
            trigger OnValidate();
            begin
                //HEI.05>>
                GLSetup.GET();
                GLSetup.TESTFIELD("OPCO Dimension Code FND", "Dimension Code");
                //HEI.05<<
            end;
        }
        field(50006; "Linked Dimension Code FND"; Code[20])
        {
            Caption = 'Linked Dimension Code';
            Description = 'HEI.06';
            TableRelation = Dimension.Code;
        }
        field(50007; "Linked Dime. Value Code FND"; Code[20])
        {
            Caption = 'Linked Dimension Value Code';
            Description = 'HEI.06';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Linked Dimension Code FND"));
        }
        field(50010; "Min. Order Value Limit FND"; Decimal)
        {
            Description = 'HEI.08';
            Caption = 'Minimum Order Value Limit';
        }
        field(50011; "Min. Ord. Value Limit Type FND"; Option)
        {
            Description = 'HEI.08';
            Caption = 'Minimum Order Value Limit Type';
            OptionCaption = 'None,Warning,Blocking';
            OptionMembers = "None",Warning,Blocking;
        }
        field(50012; "Bank issued the License FND"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            Caption = 'Bank issued the License';
        }
        field(50013; "License Expiration Date FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            Caption = 'License Expiration Date';
        }
        field(50014; "Send WMS Astro FND"; Boolean)
        {
            Caption = 'Send WMS Astro';
            Description = 'HEI.11';
        }
        field(50015; "CoD/CoC Number FND"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
            Caption = 'CoD/CoC Number';
        }
        field(50016; "Last DateTime Modif. Zycus FND"; DateTime)
        {
            Caption = 'Last Date-Time Modified Zycus';
            Description = 'HEI.13,HEI.14';
            Editable = false;
        }
        field(50017; "Updated Special Char Zycus FND"; Boolean)
        {
            Caption = 'Updated Special Char Zycus';
            Description = 'HEI.13,HEI.14,HEI.15';
            trigger OnValidate();
            var
                //ZycusInterfaceSetupL: Record "Zycus Interface Setup INT"; //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
                UpdatedL: Boolean;
            begin
            end;
        }
    }
    keys
    {
        key(Key4; "Dimension Value Type", Blocked)
        {
        }
    }
    trigger OnDelete();
    begin
        FinancialUtils.MaintainCapexDim("Dimension Code");//HEI.01 BPMGAP016

        //HEI.15>>
        //UpdateDimValueCodeZycus(true); //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
        //HEI.15<<
    end;

    trigger OnInsert();
    begin
        FinancialUtils.MaintainCapexDim("Dimension Code");//HEI.01 BPMGAP016

        //HEI.13>>
        //SetLastModifiedDateTime; //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
        //HEI.13<<
        //HEI.15>>
        //UpdateDimValueCodeZycus(false); //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
        //HEI.15<<
    end;

    trigger OnModify();
    begin
        //HEI.10>>
        if "Dimension Code" <> xRec."Dimension Code" then begin
            //HEI.10<<
            "Global Dimension No." := GetGlobalDimensionNodv();
            if CostAccSetup.GET() then begin
                CostAccMgt.UpdateCostCenterFromDim(Rec, xRec, 1);
                CostAccMgt.UpdateCostObjectFromDim(Rec, xRec, 1);
            end;
            //HEI.10>>
        end;
        //HEI.10<<

        FinancialUtils.MaintainCapexDim("Dimension Code");//HEI.01 BPMGAP016

        //HEI.13>>
        //SetLastModifiedDateTime; //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
        //HEI.13<<
    end;

    trigger OnRename();
    begin
        FinancialUtils.MaintainCapexDim("Dimension Code");//HEI.01 BPMGAP016

        //HEI.13>>
        //SetLastModifiedDateTime; //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
        //HEI.13<<
        //HEI.15>>
        //UpdateDimValueCodeZycus(false); //BC Update SAHAL01 (Code Commented due to Zycus Functionality)
        //HEI.15<<
    end;

    var
        CostAccSetup: Record "Cost Accounting Setup";
        GLSetup: Record "General Ledger Setup";
        User: Record User;
        CostAccMgt: Codeunit "Cost Account Mgt";
        FinancialUtils: Codeunit "Financial-Utils";
        Text000: TextConst ENU = '%1\You cannot delete it.', FRA = '%1\Vous ne pouvez pas supprimer l enregistrement.';
        Text002: TextConst ENU = '(CONFLICT)', FRA = '(CONFLIT)';
        Text003: TextConst ENU = '%1 can not be (CONFLICT). This name is used internally by the system.', FRA = '%1 ne peut pas être (CONFLICT). Ce nom est utilisé en interne par le système.';
        Text004: TextConst ENU = '%1\You cannot change the type.', FRA = '%1\Vous ne pouvez pas modifier le type.';
        Text005: TextConst ENU = 'This dimension value has been used in posted or budget entries.', FRA = 'Cette section analytique est utilisée dans les écritures enregistrées ou les écritures budget.';
        Text006: TextConst ENU = 'You cannot change the value of %1.', FRA = 'Vous ne pouvez pas modifier la valeur de %1.';
        Text010: TextConst ENU = '%1 can be modified only for this %2 %3.';
        Text011: TextConst ENU = 'CONCAT';

    procedure GetGlobalDimensionNoDV(): Integer
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.BC.01>>
        GeneralLedgerSetup.Get();
        case "Dimension Code" of
            GeneralLedgerSetup."Global Dimension 1 Code":
                exit(1);
            GeneralLedgerSetup."Global Dimension 2 Code":
                exit(2);
            GeneralLedgerSetup."Shortcut Dimension 3 Code":
                exit(3);
            GeneralLedgerSetup."Shortcut Dimension 4 Code":
                exit(4);
            GeneralLedgerSetup."Shortcut Dimension 5 Code":
                exit(5);
            GeneralLedgerSetup."Shortcut Dimension 6 Code":
                exit(6);
            GeneralLedgerSetup."Shortcut Dimension 7 Code":
                exit(7);
            GeneralLedgerSetup."Shortcut Dimension 8 Code":
                exit(8);
            else
                exit(0);
        end;
        //HEI.BC.01<<
    end;

    procedure SetLastModifiedDateTimeDV()
    begin
        //HEI.BC.01>>
        "Last Modified Date Time" := CurrentDateTime;
        //HEI.BC.01<<
    end;
}

