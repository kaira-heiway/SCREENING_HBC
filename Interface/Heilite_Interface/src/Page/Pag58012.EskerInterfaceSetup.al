page 58012 "Esker Interface Setup"
{
    // Heilite Navision Old Id - 50213
    // version ESKER

    // HEI.01 Esker Interfaces  Solution IBM POSTOI01 - new Codeunit for Esker Interface
    // HEI.02 CHG2022396_Ethiopia _Esker_ Interface_V0.3_HT75 IBM POSTOI01, 09.07.2019
    //   # oshow 4 new fields 28,29,30,31 :"Esker WHT Req Interf", "Esker WHT Resp Interf","Esker LC Req Interf","Esker LC Resp Interf"
    // HEI.03 CHG2028862 Mozambique _Esker_ Interface IBM POSTOI01,  28.07.2019
    //   # show the new Esker POLines Interf field ID = 32
    // HEI.04 FDD HB1348 CHG2061857 IBM SHANKJ03 25.06.2020
    //   # New Field Added

    SourceTable = "Esker Interface Setup INT";
    ApplicationArea = All; // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group("Esker Interfaces")
            {
                Caption = 'Esker Interfaces';
                field("Esker Vendor Req Interf"; Rec."Esker Vendor Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker Vendor Req Interf field.';
                }
                field("Esker Vendor Resp Interf"; Rec."Esker Vendor Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker Vendor Resp Interf field.';
                }
                field("Esker Company Req Interf"; Rec."Esker Company Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker Company Req Interf field.';
                }
                field("Esker Company Resp Interf"; Rec."Esker Company Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker Company Resp Interf field.';
                }
                field("Esker CostCenters Req Interf"; Rec."Esker CostCenters Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker CostCenters Req Interf field.';
                }
                field("Esker CostCenters Resp Interf"; Rec."Esker CostCenters Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker CostCenters Resp Interf field.';
                }
                field("Esker GLAccount Req Interf"; Rec."Esker GLAccount Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker GLAccount Req Interf field.';
                }
                field("Esker GLAccount Resp Interf"; Rec."Esker GLAccount Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker GLAccount Resp Interf field.';
                }
                field("Esker Brand Req Interf"; Rec."Esker Brand Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker Brand Req Interf field.';
                }
                field("Esker Brand Resp Interf"; Rec."Esker Brand Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker Brand Resp Interf field.';
                }
                field("Esker Currency Req Interf"; Rec."Esker Currency Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker Currency Req Interf field.';
                }
                field("Esker Currency Resp Interf"; Rec."Esker Currency Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker Currency Resp Interf field.';
                }
                field("Esker TaxCode Req Interf"; Rec."Esker TaxCode Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker TaxCode Req Interf field.';
                }
                field("Esker TaxCode Resp Interf"; Rec."Esker TaxCode Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker TaxCode Resp Interf field.';
                }
                field("Esker PaymTerm Req Interf"; Rec."Esker PaymTerm Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker PaymTerm Req Interf field.';
                }
                field("Esker PaymTerm Resp Interf"; Rec."Esker PaymTerm Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker PaymTerm Resp Interf field.';
                }
                field("Esker BankDetail Req Interf"; Rec."Esker BankDetail Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker BankDetail Req Interf field.';
                }
                field("Esker BankDetail Resp Interf"; Rec."Esker BankDetail Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker BankDetail Resp Interf field.';
                }
                field("Esker WHT Req Interf"; Rec."Esker WHT Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker WHT Req Interf field.';
                }
                field("Esker WHT  Resp Interf"; Rec."Esker WHT  Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker WHT  Resp Interf field.';
                }
                field("Esker LC Req Interf"; Rec."Esker LC Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker LC Req Interf field.';
                }
                field("Esker LC  Resp Interf"; Rec."Esker LC  Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker LC  Resp Interf field.';
                }
                field("Esker POHeader Req Interf"; Rec."Esker POHeader Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker POHeader Req Interf field.';
                }
                field("Esker POHeader Resp Interf"; Rec."Esker POHeader Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker POHeader Resp Interf field.';
                }
                field("Esker POLine Req Interf"; Rec."Esker POLine Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker POLine Req Interf field.';
                }
                field("Esker POLine Resp Interf"; Rec."Esker POLine Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker POLine Resp Interf field.';
                }
                field("Esker POLines Interf"; Rec."Esker POLines Interf")
                {
                    ToolTip = 'Specifies the value of the Esker POLines Interf field.';
                }
                field("Esker PaymStatus Req Interf"; Rec."Esker PaymStatus Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker PaymStatus Req Interf field.';
                }
                field("Esker PaymStatus Resp Interf"; Rec."Esker PaymStatus Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker PaymStatus Resp Interf field.';
                }
                field("Esker InvPosting Interf"; Rec."Esker InvPosting Interf")
                {
                    ToolTip = 'Specifies the value of the Esker InvPosting Interf field.';
                }
                field("Esker InvConfirm Interf"; Rec."Esker InvConfirm Interf")
                {
                    ToolTip = 'Specifies the value of the Esker InvConfirm Interf field.';
                }
                field("Esker VendorPostGrp Req Interf"; Rec."Esker VendorPostGrp Req Interf")
                {
                    ToolTip = 'Specifies the value of the Esker VendorPostGrp Req Interf field.';
                }
                field("Esker VendorPostGr Resp Interf"; Rec."Esker VendorPostGr Resp Interf")
                {
                    ToolTip = 'Specifies the value of the Esker VendorPostGr Resp Interf field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.GET() then begin
            Rec.INIT();
            Rec.INSERT();  // BC Upgrade NANDIS03 - Added Rec.
        end;
    end;

    var
        ItemCategories: Page "Item Categories";
}

