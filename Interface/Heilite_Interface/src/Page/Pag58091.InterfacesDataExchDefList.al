page 58091 "Interfaces Data Exch Def List"
{
    // version HEI.01

    // HEI.01 GAPID001 IBM LAZARE02 03.08.2017 # New page for interface framework management
    // BC Upgrade SHUKLP03 >> Nav Page Id - 50086

    Caption = 'Interfaces Data Exchange Definitions';
    CardPageID = "Inter Data Exch Def Card CBN";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Import/Export';
    SourceTable = "Data Exch. Def";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code that identifies the data exchange setup.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the data exchange definition.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    ToolTip = 'Specifies what type of exchange the data exchange definition is used for.';
                }
                field("Data Handling Codeunit"; Rec."Data Handling Codeunit")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the codeunit that transfers data in and out of tables in Microsoft Dynamics NAV.';
                }
                field("Reading/Writing Codeunit"; Rec."Reading/Writing Codeunit")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the codeunit that processes imported data prior to mapping and exported data after mapping.';
                }
                field("Ext. Data Handling Codeunit"; Rec."Ext. Data Handling Codeunit")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the codeunit that transfers external data in and out of the Data Exchange Framework.';
                }
                field("Header Lines"; Rec."Header Lines")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how many header lines exist in the file. This ensures that the header data is not imported. This field is only relevant for import.';
                    Visible = false;
                }
                field("Header Tag"; Rec."Header Tag")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the text of the first column on the header line.';
                    Visible = false;
                }
                field("Footer Tag"; Rec."Footer Tag")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the text of the first column on the footer line. If a footer line exists in several places in the file, enter the text of the first column on the footer line to ensure that the footer data is not imported. This field is only relevant for import.';
                    Visible = false;
                }
                field("Column Separator"; Rec."Column Separator")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how columns in the file are separated, if the file is of type Variable Text.';
                    Visible = false;
                }
                field("File Encoding"; Rec."File Encoding")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the encoding of the file to be imported. This field is only relevant for import.';
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    ToolTip = 'Specifies what type of file the data exchange definition is used for. You can select between three file types.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Data Exchange Definition")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import Data Exchange Definition';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Import a data exchange definition from a bank file that is located on your computer or network. The file type must match the value of the File Type field.';

                trigger OnAction();
                begin
                    XMLPORT.RUN(XMLPORT::"Imp / Exp Data Exch Def & Map", false, true);
                end;
            }
            action("Export Data Exchange Definition")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export Data Exchange Definition';
                Image = Export;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Export the data exchange definition to a file on your computer or network. You can then upload the file to your electronic bank to process the related transfers.';

                trigger OnAction();
                var
                    DataExchDef: Record "Data Exch. Def";
                begin
                    CurrPage.SETSELECTIONFILTER(DataExchDef);
                    XMLPORT.RUN(XMLPORT::"Imp / Exp Data Exch Def & Map", false, false, DataExchDef);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec."Interfaces FND" := true;
        Rec.Type := Rec.Type::"Interface Import";
    end;

    trigger OnOpenPage();
    begin
        Rec.FILTERGROUP(6);
        Rec.SETRANGE("Interfaces FND", true);
        Rec.FILTERGROUP(0);
    end;
}

