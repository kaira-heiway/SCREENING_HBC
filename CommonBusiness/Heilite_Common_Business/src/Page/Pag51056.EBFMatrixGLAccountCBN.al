page 51056 "EBF Matrix G/L Account CBN"
{
    // version HEI.04

    // HEI.02 FDD-BPMGAP015 IBM ISYED01 13.11.2017
    //   #added new page with respect to defect 943 EBF matrix button on the chart of account to display the settings filtered by each account
    // HEI.03 CHG2171687 IBM SISUM01 06/03/2023 #add function GetGLAccountRange
    // HEI.04 CHG2171687 IBM SISUM01 19/05/2023 HB3907 EBF Matrix
    //   #test if new EBF version is enable

    PageType = List;
    SourceTable = "Ebf Combination FND";
    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists;  // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("GL Account No."; Rec."GL Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Account Range for SCOA L3 field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the G/L Account Range for SCOA L3 field.';

                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension Code field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Dimension Code field.';

                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension Filter field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Dimension Filter field.';

                }
                field("Combination Restriction"; Rec."Combination Restriction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Combination Restriction field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Combination Restriction field.';

                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        //HEI.03>>
        if (GLAccountRange <> '') then
            Rec."GL Account No." := GLAccountRange;
        //HEI.03<<
    end;

    trigger OnOpenPage();
    begin
        //HEI.03>>
        if (GLAccountRange <> '') then
            Rec.SETFILTER("GL Account No.", '%1', GLAccountRange);
        //HEI.03<<
    end;

    var
        GLAccountRange: Code[10];
        abc: Integer;
        GLAccountOperator: Label '*';

    procedure GetGLAccountRange(GLAccount: Code[10]);
    var
        EBFMatrix: Record "Ebf Combination FND";
    begin
        //HEI.04>>
        if not EBFMatrix.CheckNewEBFMatrixIsActive() then
            GLAccountRange := GLAccount
        else
            //HEI.04<<
            //HEI.03>>
            GLAccountRange := COPYSTR(GLAccount, 1, 5) + GLAccountOperator;
        //HEI.03<<
    end;
}

