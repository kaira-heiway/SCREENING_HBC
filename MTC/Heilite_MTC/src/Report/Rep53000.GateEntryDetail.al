report 53000 "Gate Entry Detail"
{
    // version HEI.01
    //BC Upgrade GUNREM01 -Old report ID-50188
    // HEI:219422:1:1 28/01/15 IBM.ND
    //   # New report created
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Report from HEI2.0
    // HEI.02 FDD-CHG2024489 Gate Control IBM SAXENS01  17.09.2019
    //   Sequence of datacolumn in reports is changed as per FDD and page setup In report has been changed to A4


    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Gate Entry Detail.rdl';

    Caption = 'Gate Entry Detail';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Gate Entry Header FND"; "Gate Entry Header FND")
        {
            DataItemTableView = SORTING("Gate Entry Document No.");
            RequestFilterFields = "Gate Entry Document No.", "Document Date", "Document Type", "Reference Document";
            column(CompName; CompanyInfo.Name)
            {
            }
            column(GEH_GEDocNo; "Gate Entry Document No.")
            {
                IncludeCaption = true;
            }
            column(GEH_DocDate; "Document Date")
            {
                IncludeCaption = true;
            }
            column(GEL_GateKeep; "Gate Keeper ID")
            {
                IncludeCaption = true;
            }
            column(GEH_VehNo; "Vehicle No.")
            {
                IncludeCaption = true;
            }
            column(GEH_DrivCode; "Driver Code")
            {
                IncludeCaption = true;
            }
            column(GEH_DocType; "Document Type")
            {
                IncludeCaption = true;
            }
            column(GEH_DateIn; "Date In")
            {
                IncludeCaption = true;
            }
            column(GEH_TimeIn; "Time In")
            {
                IncludeCaption = true;
            }
            column(GEH_DateOut; "Date Out")
            {
                IncludeCaption = true;
            }
            column(GEH_TimeOut; "Time Out")
            {
                IncludeCaption = true;
            }
            column(GEH_Location; "Location Code")
            {
                IncludeCaption = true;
            }
            dataitem("Gate Entry Line FND"; "Gate Entry Line FND")
            {
                DataItemLink = "Gate Entry Document No." = FIELD("Gate Entry Document No.");
                DataItemTableView = SORTING("Gate Entry Document No.", "Line No.") WHERE("No." = FILTER(<> ''));
                column(GEL_No; "No.")
                {
                    IncludeCaption = true;
                }
                column(GEL_Desc; Description)
                {
                    IncludeCaption = true;
                }
                column(GEL_QtyOnArr; "Quantity on Arrival")
                {
                    IncludeCaption = true;
                }
                column(GEL_QtyOnDep; "Quantity on Departure")
                {
                    IncludeCaption = true;
                }
                column(TodayFormatted; FORMAT(TODAY, 0, 4))
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CompanyInfo.GET;
    end;

    var
        CompanyInfo: Record "Company Information";
        RepName: Label 'Gate Entry Detail';
}

