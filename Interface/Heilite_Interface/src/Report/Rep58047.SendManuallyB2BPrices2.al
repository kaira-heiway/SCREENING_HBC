report 58047 "Send Manually B2B Prices2"
{
    //BC Upgrade GUNREM01 Old ID-50493
    // version HEI.02

    // HEI.01 FDD-HB1281 - CHG2056937 IBM NASTAA02 12.04.2021 # B2B Pricing Interface
    //   # New Report created for B2B Pricing Interface
    // HEI.02 CHG2199256 IBM COSTES04 19.04.2023 B2B-Pricing Interface sending zero pricing
    //   # Enable posibility to send prices for a specific date when running manually

    Caption = 'Send Manually B2B Prices';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis; // BC Upgrade SHUKLP03 <<

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord();
            begin
                SendB2BPrices.SetRunDate(AsPerDate);//HEI.02
                SendB2BPrices.CreateAndSendResponseXML;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsPerDate; AsPerDate)
                {
                    Caption = 'As per Date';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            AsPerDate := WORKDATE;//HEI.02
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        MESSAGE(B2BPricesSentMsg);
    end;

    var
        SendB2BPrices: Codeunit "Send B2B Prices";
        B2BPricesSentMsg: Label 'B2B Prices are sent.';
        AsPerDate: Date;
}

