report 50271 "Dunning Letter 1"
{
    // version HEI.02

    // HEI.01 CHG2000416 IBM.AB 22.04.2019
    //   #new report created for Dunning Letter functionality
    // HEI.02 INC3980933 - CHG2147800 IBM NASTAA02 21.02.2022 # Bug in code found when running the Test Scripts for dunning letters
    //   # Increased size of variable CustContact from 30 to 50
    // BC Upgrade BHARAD11 >>
    // 1. Add applicationarea and UsageCategory property in report.
    // 2. Change layout extension rdlc to rdl and add layout path
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Dunning Letter 1.rdl'; // Add layout path and change layout extension rdlc to rdl

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
        Text001: Label '"Please be advised that as of today we have not received the payment for the invoices listed above: "';
        Text002: Label 'As per the agreed Payment Terms, the overdue balance needs to be paid immediately. If payment has already been made, please disregard this letter.';
        Text003: Label 'Thank you.';
        Text004: Label 'Kind Regards,';
        Text005: Label 'OTC Collection & Dispute Administrator';
        DunningLevel: Label '1';
        CompInfo: Record "Company Information";
        PageNo: Integer;
        Cust: Record Customer;
        CustContact: Text[50];
}

