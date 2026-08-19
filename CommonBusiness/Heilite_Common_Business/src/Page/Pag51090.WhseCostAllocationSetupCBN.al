
page 51090 "Whse.CostAllocSetupCBN"
{
    // version HEI.07

    // HEI.01 CHG2095415 IBM BULIMC01 01.04.2021#new page created
    // HEI.02 CHG2130188 IBM BULIMC01 13/10/2021 #new field added: "Distribution Type","Shipping Charge No. Filter"
    // HEI.03 CHG2132177 BULIMC01 IBM 29/11/2021 # Own Fleet Allocation
    // HEI.04 FDD-HB2761 BULIMC01 IBM 14/02/2022#page name and caption change to 'C2S Mapping SCOA&CC'
    // HEI.05 CHG2132177 BULIMC01 IBM 07/04/2022#change table name back to "Whse. Cost Alloc Setup FND" and keep the caption'C2S Mapping SCOA&CC'
    // HEI.06 IBM CHG2132673 BULIMC01 13/04/2022 new changes on the page
    // HEI.07 CHG2190306 IBM SISUM01 08/02/2023 #Add Export and Import option
    //*****************************************************************************************************************
    //BC UPGRADE PATHAA02- 19/09/25-Done-->Commented Action-Export to Excel (BC UPGRADE PATHAA02-Blocked as Standard BC has Excel Export Functionality)
    //BC UPGRADE PATHAA02-15/12/25-"Import from Excel" on Action is uncommented and ApplicationArea added

    Caption = 'C2S Mapping SCOA & CC';
    PageType = List;
    SourceTable = "Whse. Cost Alloc Setup FND";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = SORTING("C2S Name", "Distribution Type")
                      ORDER(Descending);


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("C2S Name"; Rec."C2S Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the C2S Name field.';
                }
                field("Distribution Type"; Rec."Distribution Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Distribution Type field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("G/L Account Range"; Rec."G/L Account Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Account Range field.';
                }
                field("CCC Dim. Filter"; Rec."CCC Dim. Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CCC Dim. Filter field.';
                }
                field("Allocation Type"; Rec."Allocation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allocation Type field.';
                }
                field("Shipping Charge No. Filter"; Rec."Shipping Charge No. Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Charge No. Filter field.';
                }
                field("Distance Allocation %"; Rec."Distance Allocation %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Distance Allocation % field.';
                }
                field("No. of Drops Allocation %"; Rec."No. of Drops Allocation %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Drops Allocation % field.';
                }
                field("Net Weight Allocation %"; Rec."Net Weight Allocation %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Weight Allocation % field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            //Caption = 'Export/Import';
            action("Import from Excel")
            {
                Caption = 'Import from Excel';
                Image = ImportExcel;
                RunObject = Report "Import C2S Mapping SCOA & CC";
                ToolTip = 'Executes the Import from Excel action.';
            }
            // action("Export to Excel")
            // {
            //     Caption = 'Export to Excel';
            //     Image = ExportToExcel;

            //     trigger OnAction();
            //     var
            //         WhsCostAllocSetup: Record "Whse. Cost Alloc Setup FND";
            //         FileMgt: Codeunit "File Management";
            //         ServerFileName: Text;
            //         WindowTitle: Label 'Save to Path';
            //         FilePath: Text;
            //         FileName: Text;
            //         FileError: Label 'Path must not be empty.';
            //     begin
            //         //HEI.07>>
            //         ServerFileName := FileMgt.ServerTempFileName('xlsx');
            //         FileName := DELCHR(WhsCostAllocSetup.TABLECAPTION(), '=', '&.') + '_' + COMPANYNAME + '_' + FORMAT(TODAY, 0, '<Day,2><Month,2><Year>') + FORMAT(TIME, 0, '<Hours24,2><Filler Character,0><Minutes,2>');
            //         FilePath := FileMgt.SaveFileDialog(WindowTitle, FileName, 'Excel File (*.xlsx)|*.xlsx');
            //         if (FilePath = '') then
            //             ERROR(FileError);
            //         WhsCostAllocSetup.Export2Excel(ServerFileName, FilePath);
            //         //HEI.07<<
            //     end;
            // } BC UPGRADE PATHAA02-Blocked as Standard BC has Excel Export Functionality
        }
    }
}

