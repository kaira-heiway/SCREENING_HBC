report 58048 "Send Manually B2B Promotions"
{

    //BC Upgrade GUNREM01 Old ID-50494

    // version HEI.02
    // HEI.01 CHG2056939 DEBUSD01 20.10.2022 Promotion Interface b2b
    // HEI.02 CHG2056939 DEBUSD01 23.11.2022 Promotion Interface b2b
    //   # Add "Calculate per" filter default

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis; // BC Upgrade SHUKLP03 <<

    dataset
    {
        //BC Upgrade GUNREM01 -DIT table >>
        // dataitem(SalesPromotionFilters;"Sales Promotion Item Charge")
        // {
        // }
        //BC Upgrade GUNREM01 -DIT table <<
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Filters';
                    field(AsPerDate; AsPerDate)
                    {
                        Caption = 'As per date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            AsPerDate := WORKDATE;
            //HEI.02>>
            //  SetDefaultFilters(SalesPromotionFilters); /BC Upgrade GUNREM01 -Dependecny with DIT
            //HEI.02<<
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    var
        SendB2BPromotion: Codeunit "Send B2B Promotions";
        Executed: Boolean;
    begin
        SendB2BPromotion.SetRunDate(AsPerDate);
        //   SendB2BPromotion.SetRunSalesPromotionFilters(SalesPromotionFilters);  /BC Upgrade GUNREM01 -Dependecny with DIT
        Executed := SendB2BPromotion.CreateAndSendResponseXML();
        if Executed then
            MESSAGE(SendedMessage);
    end;

    var
        AsPerDate: Date;
        SendedMessage: Label 'B2B Promotions are sent.';

    //BC Upgrade GUNREM01 -Dependecny with DIT >>
    // local procedure SetDefaultFilters(var NewSalesPromotionFilters : Record "Sales Promotion Item Charge");
    // begin
    //     //HEI.02>>
    //     NewSalesPromotionFilters.SETFILTER("Calculate per",'%1|%2',
    //       NewSalesPromotionFilters."Calculate per"::Item,NewSalesPromotionFilters."Calculate per"::Order);
    // end;
    //BC Upgrade GUNREM01 -Dependecny with DIT <<
}

