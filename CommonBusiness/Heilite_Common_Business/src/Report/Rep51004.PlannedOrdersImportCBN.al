report 51004 "Planned Orders Import CBN"
{
    // version HEI.01

    // HEI:EDD068:1:1 19/11/14 TECTURA-HKH
    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Changes:
    // 1. Dependencies: - XMLport "Planned Orders Import" - Required dependency, must be migrated
    // 2. Added UsageCategory = ReportsAndAnalysis for BC compliance
    // 3. Added ApplicationArea to Filename field
    // 4. Added ApplicationArea = All for BC compliance
    // BC Upgrade BHARDA11 
    ApplicationArea = All;  // BC Upgrade BHARDA11
    UsageCategory = ReportsAndAnalysis; // BC Upgrade BHARDA11
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = FILTER(1));
            MaxIteration = 1;

            trigger OnAfterGetRecord();
            begin
                PlannedOrdersImport.RUN();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Filename; Filename)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'File Name',
                                FRA = 'Nom du fichier';
                    ToolTip = 'Specifies the value of the Filename field.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CommonDialogMgt: Codeunit "File Management";
        PlannedOrdersImport: XMLport "Planned Orders Import CBN";
        FiletoImport: File;
        varInputStream: InStream;
        Text001: Label 'No filename specified';
        Text003: Label 'File created succesfully with %1 lines.';
        Filename: Text[1024];
        ServerFileName: Text[1024];
        Text002: TextConst ENU = 'Import from', FRA = 'Importer de';
}

