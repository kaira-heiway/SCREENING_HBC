page 58070 "HeiFLOW Interface Setup"
{
    // Heilite Navision Old Id - 50469

    // version HEI.03

    // HEI.01 CHG2132748 IBM SAXENA03 09.11.2021
    //   # HeiLite Base integration with HeiFlow  Master Data
    //   # Created a new Pageas HeiFLOW Interface Setup Page
    //   # Created 2 new button to Export Customer and Vendor Data into Excel
    // 
    // HEI.02 CHG2132929 IBM POENAB02 15.04.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Fields added:
    //     # 7 "HeiFlow GL Posting Interface"
    //     # 8 "HeiFlow GL Posting Intf. Resp."
    // 
    // HEI.03 CHG2144425 IBM POENAB02 18.05.2022 HeiLite Vendor Invoice Status| Automation for Caribbean OpCo’s SSC
    //   #Fields added:
    //     # 9 "HeiFlow Vend. Inv. Request"
    //     # 10 "HeiFlow Vend. Inv. Response"

    PageType = Card;
    SourceTable = "HeiFLOW Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Interface Enable/Disable"; Rec."Interface Enable/Disable")
                {
                    ToolTip = 'Specifies the value of the Interface Enable/Disable field.';
                }
                field("HeiFLOW Customer"; Rec."HeiFLOW Customer")
                {
                    ToolTip = 'Specifies the value of the HeiFLOW Customer field.';
                }
                field("HeiFLOW Vendor"; Rec."HeiFLOW Vendor")
                {
                    ToolTip = 'Specifies the value of the HeiFLOW Vendor field.';
                }
                field("Last Modified Vendor"; Rec."Last Modified Vendor")
                {
                    ToolTip = 'Specifies the value of the Last Modified Vendor field.';
                }
                field("Last Modified Customer"; Rec."Last Modified Customer")
                {
                    ToolTip = 'Specifies the value of the Last Modified Customer field.';
                }
                field("HeiFlow GL Posting Interface"; Rec."HeiFlow GL Posting Interface")
                {
                    ToolTip = 'Specifies the value of the HeiFlow GL Posting Interface field.';
                }
                field("HeiFlow GL Posting Intf. Resp."; Rec."HeiFlow GL Posting Intf. Resp.")
                {
                    ToolTip = 'Specifies the value of the HeiFlow GL Posting Interface Response field.';
                }
                field("HeiFlow Vend. Inv. Request"; Rec."HeiFlow Vend. Inv. Request")
                {
                    ToolTip = 'Specifies the value of the HeiFlow Vend. Inv. Request field.';
                }
                field("HeiFlow Vend. Inv. Response"; Rec."HeiFlow Vend. Inv. Response")
                {
                    ToolTip = 'Specifies the value of the HeiFlow Vend. Inv. Response field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            //Caption = 'Options';  // BC Upgrade NANDIS03
            action("Export Customer Data Excel")
            {
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Export Customer Data Excel action.';

                trigger OnAction();
                begin
                    // HeiFLOWExportCustomer.MasterExpotToExcel(MasterType::Customer);  // BC Upgrade NANDIS03 - Need to see if standard BC excel functionality can resolve
                end;
            }
            action("Export Vendor Data Excel")
            {
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Export Vendor Data Excel action.';

                trigger OnAction();
                begin
                    // HeiFLOWExportCustomer.MasterExpotToExcel(MasterType::Vendor);  // BC Upgrade NANDIS03 - Need to see if standard BC excel functionality can resolve
                end;
            }
        }
    }

    var
        // HeiFLOWExportCustomer: Codeunit "HeiFLOW API WS";  // BC Upgrade NANDIS03
        MasterType: Option " ",Customer,Vendor;
}

