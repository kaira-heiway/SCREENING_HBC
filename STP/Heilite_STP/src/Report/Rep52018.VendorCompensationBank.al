report 52018 "Vendor Compensation Bank"
{
    // version HEI.01

    // HEI.01 FDD-HT1103 IBM SURYAS01  13-04-2020
    //   #Created New Report "Vendor Compensation Bank"
    // HEI.02 CHG2083510 IBM POENAB02 15.10.2020
    //   # VendorName should be taken from Vendor.Name instead of "Vendor Bank Account".Name. Modified "Data Source" for VendorName
    // BC Upgrade BHARAD11 >>
    // 1. Add layout path and Change extension RDLC to RDL.
    // 2. Add ApplicationArea and UsageCategory property in Report.
    // 3. Old Report ID- 50412.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Vendor Compensation Bank.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.


    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            dataitem("Vendor Bank Account"; "Vendor Bank Account")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Vendor No.", Code)
                                    ORDER(Ascending);
                RequestFilterFields = "Vendor No.";
                column(VendorBankCode; "Vendor Bank Account".Code)
                {
                }
                column(vendorbankAccount; "Vendor Bank Account"."Bank Account No.")
                {
                }
                column(VendorIBAN; "Vendor Bank Account".IBAN)
                {
                }
                column(VendorSwiftCode; "Vendor Bank Account"."SWIFT Code")
                {
                }
                column(vendorCompensationBank; "Vendor Bank Account"."Compensation Bank FND")
                {
                }
                column(VendorNo; "Vendor Bank Account"."Vendor No.")
                {
                }
                column(VendorName; Vendor.Name)
                {
                }
                column("count"; Var_Count)
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                Var_Count := 0;
                Rec_VendorBankAccount.RESET;
                Rec_VendorBankAccount.SETRANGE("Vendor No.", Vendor."No.");
                IF Rec_VendorBankAccount.FINDSET THEN
                    REPEAT
                        Var_Count += 1;
                    UNTIL Rec_VendorBankAccount.NEXT = 0;
                IF Var_Count <= 1 THEN
                    CurrReport.SKIP;
            end;
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

    var
        Var_Count: Integer;
        Rec_VendorBankAccount: Record "Vendor Bank Account";
}

