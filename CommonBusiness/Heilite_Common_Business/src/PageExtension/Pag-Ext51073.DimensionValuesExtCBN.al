pageextension 51073 DimensionValuesExtCBN extends "Dimension Values"
{

    // HEI.01 HLSRM04 IBM LAZARE02 10.08.2017 # New fields Approver ID, Approver Name
    // HEI.02 FDD RTRGAP062 NAIH01 30.11.2017
    //   # New Field "Reporting entity" have been added
    // HEI.03 Defect #1328 #1329 IBM NASTAA02 19.12.2017 # Missing fields in file creation
    //   # Added new field "CIL Code"
    // HEI.04 Bugfixing IBM NASTAA02 16.03.2018 # Cannot rename a Dimension
    //   # Commented code from OnValidate trigger of "Code" field
    // HEI.05 RFC-CHG0255777 IBM.LS 17.12.2018
    //   # New Fields added: "Min. Order Value Limit"
    //                       "Min. Order Value Limit Type"
    // HEI.06 FDD-HB2174 CHG2104952 IBM NANDIS01 31.05.2021 Ibecor - PO API
    //   # New fields shown - "Bank who issued the License" and "License Expiration Date"
    // HEI.07 CHG2147859 SAHAL01 22.07.2022
    //   # Added New Field - Send WMS Astro
    // HEI.08 CHG2167376 HB3082 NORRIQ KOROLA04 11.11.2022
    //   # CoD/CoC Number - field created
    // HEI.09 CHG2167376 HB3082 NORRIQ KOROLA04 23.11.2022
    //   # CoD/CoC Number - field editable
    // HEI.10 CHG2210794 SAHAL01 19.12.2023 Zycus - BASE HL Integration Master Dimension
    //   # Added New Fields - Last Date-Time Modified
    //                      - FA Value
    // HEI.11 CHG2210794 SAHAL01 06.02.2024 Zycus - BASE HL Integration Master Dimension
    //   # Modified Fields Name - Last Date-Time Modified Zycus
    //   # Removed Fixed Assets (CONCAT) Interface functionality due to descope
    // HEI.12 CHG2210794 SAHAL01 28.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Added New Field - Updated Special Char Zycus


    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value.', FRA = 'Indique le code de la section analytique.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies a descriptive name for the dimension value.', FRA = 'Spécifie un nom descriptif pour la section analytique.';
        }
        modify("Dimension Value Type")
        {
            ToolTipML = ENU = 'Specifies the purpose of the dimension value.', FRA = 'Indique l''objet de la section analytique.';
        }
        modify(Totaling)
        {
            ToolTipML = ENU = 'Specifies a dimension value interval or a list of dimension values.', FRA = 'Spécifie un intervalle de section analytique ou la liste des sections analytiques.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies that entries with this dimension value cannot be posted.', FRA = 'Spécifie que les écritures ayant cette section analytique ne peuvent pas être validées.';
        }
        modify("Map-to IC Dimension Value Code")
        {
            ToolTipML = ENU = 'Specifies which intercompany dimension value corresponds to the dimension value on the line.', FRA = 'Spécifie quelle valeur de dimension intersociété correspond à la section analytique sur la ligne.';
        }
        modify("Consolidation Code")
        {
            ToolTipML = ENU = 'Specifies the code that is used for consolidation.', FRA = 'Spécifie le code utilisé pour la consolidation.';
        }

        //Unsupported feature: CodeInsertion on "Code(Control 4)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.04>>
        //CurrPage.SAVERECORD;
        //CurrPage.UPDATE(TRUE);
        //HEI.04<<
        */
        //end;


        //Unsupported feature: CodeInsertion on "Name(Control 6)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        {CurrPage.SAVERECORD;
        CurrPage.UPDATE(TRUE);
        }//commented by PATHAA02-100617
        */
        //end;


        //Unsupported feature: CodeModification on "Totaling(Control 10).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DimVal := Rec;
        DimVal.SETRANGE("Dimension Code","Dimension Code");
        DimValList.SETTABLEVIEW(DimVal);
        DimValList.LOOKUPMODE := TRUE;
        IF DimValList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          DimValList.GETRECORD(DimVal);
          Text := DimVal.Code;
          EXIT(TRUE);
        end;
        EXIT(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        DimValList.LOOKUPMODE := true;
        if DimValList.RUNMODAL = ACTION::LookupOK then begin
          DimValList.GETRECORD(DimVal);
          Text := DimVal.Code;
          exit(true);
        end;
        exit(false);
        */
        //end;
        addafter("Consolidation Code")
        {
            field("Approver ID"; Rec."Approver ID FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approver ID field.';
            }
            field("Approver Name"; Rec."Approver Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approver Name field.';
            }
            field("Reporting Entity"; Rec."Reporting Entity FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reporting Entity field.';
            }
            field("CIL Code"; Rec."CIL Code FND")
            {
                Description = 'HEI1.0,EDD072';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIL Code field.';
            }
            field("Linked Dimension Code"; Rec."Linked Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Linked Dimension Code field.';
            }
            field("Linked Dimension Value Code"; Rec."Linked Dime. Value Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Linked Dimension Value Code field.';
            }
            field("Min. Order Value Limit"; Rec."Min. Order Value Limit FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Min. Order Value Limit field.';
            }
            field("Min. Order Value Limit Type"; Rec."Min. Ord. Value Limit Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Min. Order Value Limit Type field.';
            }
            field("Bank who issued the License"; Rec."Bank issued the License FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank who issued the License field.';
            }
            field("License Expiration Date"; Rec."License Expiration Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the License Expiration Date field.';
            }
            field("Send WMS Astro"; Rec."Send WMS Astro FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Send WMS Astro field.';
            }
            field("CoD/CoC Number"; Rec."CoD/CoC Number FND")
            {
                Editable = true;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CoD/CoC Number field.';
                //---BC Upgrade KAMNAY01                ApplicationArea = All;

            }
            field("Last Date-Time Modified Zycus"; Rec."Last DateTime Modif. Zycus FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last Date-Time Modified Zycus field.';
            }
            field("Updated Special Char Zycus"; Rec."Updated Special Char Zycus FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Updated Special Char Zycus field.';
            }

        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Indent Dimension Values")
        {
            CaptionML = ENU = 'Indent Dimension Values', FRA = 'Indenter sections analytiques';
            ToolTipML = ENU = 'Indent dimension values between a Begin-Total and the matching End-Total one level to make the list easier to read.', FRA = 'Indentez des sections analytiques entre un Début total et le Fin total correspondant d''un niveau pour que la liste soit plus simple à lire.';
        }
    }


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Dimension Code") <> '' THEN
      DimensionCode := GETRANGEMIN("Dimension Code");
    IF DimensionCode <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Dimension Code",DimensionCode);
      FILTERGROUP(0);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if GETFILTER("Dimension Code") <> '' then
      DimensionCode := GETRANGEMIN("Dimension Code");
    if DimensionCode <> '' then begin
    #4..6
    end;
    */
    //end;

    procedure GetSelectionFilter(): Text;
    var
        Loc: Record Location;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        exit(SelectionFilterManagement.GetSelectionFilterForDimensionValue(Rec));
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

