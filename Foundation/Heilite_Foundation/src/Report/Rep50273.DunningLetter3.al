report 50273 "Dunning Letter 3"
{
    // version HEI.02

    // HEI.01 CHG2000416 IBM.AB 22.04.2019
    //   #new report created for Dunning Letter functionality
    // HEI.02 INC3980933 - CHG2147800 IBM NASTAA02 21.02.2022 # Bug in code found when running the Test Scripts for dunning letters
    //   # Increased size of variable CustContact from 30 to 50
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea and UsageCategory property in report.
    // 2. Add layout path and change layout extension rdlc to rdl.
    // BC Upgrade BHARDA11 <<
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\src\ReportsLayout\Dunning Letter 3.rdl'; // BC Upgrade BHARDA11 ---Add layout path and change layout extension rdlc to rdl

    Permissions = TableData "Issued Reminder Header" = rimd;

    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            RequestFilterFields = "No.";
            column(PageNo; PageNo)
            {
            }
            column(RemHead_No; "Issued Reminder Header"."No.")
            {
            }
            column(Cust_No; "Issued Reminder Header"."Customer No.")
            {
            }
            column(Cust_Name; "Issued Reminder Header".Name)
            {
            }
            column(Cust_Add; "Issued Reminder Header".Address)
            {
            }
            column(Cust_Add2; "Issued Reminder Header"."Address 2")
            {
            }
            column(Cust_City; "Issued Reminder Header".City)
            {
            }
            column(ToDay; TODAY)
            {
            }
            column(Text001; Text001)
            {
            }
            column(Text002; Text002)
            {
            }
            column(Text003; Text003)
            {
            }
            column(Text004; Text004)
            {
            }
            column(Text005; Text005)
            {
            }
            column(Text006; Text006)
            {
            }
            column(Text007; Text007)
            {
            }
            column(Cust_Contact; CustContact)
            {
            }
            column(Comp_Pic; CompInfo.Picture)
            {
            }
            dataitem("Issued Reminder Line"; "Issued Reminder Line")
            {
                DataItemLink = "Reminder No." = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER("Customer Ledger Entry"));
                column(Doc_No; "Issued Reminder Line"."Document No.")
                {
                }
                column(Doc_Type; "Issued Reminder Line"."Document Type")
                {
                }
                column(Doc_Date; "Issued Reminder Line"."Document Date")
                {
                }
                column(Desc; "Issued Reminder Line".Description)
                {
                }
                column(Disputed; "Issued Reminder Line"."Disputed FND")
                {
                }
                column(Due_Date; "Issued Reminder Line"."Due Date")
                {
                }
                column(DunningLevel; DunningLevel)
                {
                }
                column(Org_Amt; "Issued Reminder Line"."Original Amount")
                {
                }
                column(Rem_Amt; "Issued Reminder Line"."Remaining Amount")
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                if Cust.GET("Issued Reminder Header"."Customer No.") then
                    CustContact := Cust.Contact;
            end;

            trigger OnPostDataItem();
            begin
                /*"Issued Reminder Header"."Mail Sent" := TRUE;
                "Issued Reminder Header".MODIFY;*/

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

    trigger OnPreReport();
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);
        if CurrReport.PAGENO = 1 then PageNo := 1 else PageNo := 0;
    end;

    var
        CompInfo: Record "Company Information";
        PageNo: Integer;
        Text001: Label 'As communicated in our previous letter, we refer to non-payment of the overdue invoices listed below and regret to inform you that no further goods will be supplied to you until your accounts are paid up to date.';
        Text002: Label 'As per the agreed Payment Terms, the overdue balance needs to be paid immediately.';
        Text003: Label 'Please be aware all payments are processed until today. If the funds have been already sent to Heineken please disregard this letter and provide the payment details and date.';
        Text004: Label 'Please be advised that in case the payment is not received within 7 days further collection efforts can be taken, including sending your accounts to the Debt Collection Agency.';
        Text005: Label 'Thank you.';
        Text006: Label 'Kind Regards,';
        Text007: Label 'OTC Collection & Dispute Administrator';
        DunningLevel: Label '3';
        CustContact: Text[50];
        Cust: Record Customer;
}

