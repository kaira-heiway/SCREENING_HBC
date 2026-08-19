namespace STP.STP;
// BC Upgrade BHARDA11 >>
/* 
The purpose of creating this report was that there is a codeunit 52009 "Send Overdue Purchase Orders", 
where the Export to Excel functionality is being used and the file is sent via email at runtime.
Since this cannot be done directly in Business Central, we created this report layout and then converted the report into Excel format and sent it through email using the Job Queue.
 */
// BC Upgrade BHARAD11 <<
report 52050 "Send Overdue Purchase Order"
{
    Caption = 'Send Overdue Purchase Orders1';
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\SendOverDuePurchaseOrders.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purch Order Overdue Entry FND"; "Purch Order Overdue Entry FND")
        {
            column(H1; Text005) { }
            column(H2; Text006) { }
            column(H3; Text007) { }
            column(H4; Text008) { }
            column(H5; Text009) { }
            column(H6; Text010) { }
            column(H7; Text011) { }
            column(H8; Text012) { }
            column(H9; Text013) { }
            column(H10; Text014) { }
            column(H11; Text015) { }
            column(H12; Text016) { }
            column(H13; Text017) { }
            column(R1; "Purch Order Overdue Entry FND"."Document No.") { }
            column(R2; "Purch Order Overdue Entry FND".Status) { }
            column(R3; "Purch Order Overdue Entry FND"."Buy-from Vendor No.") { }
            column(R4; "Purch Order Overdue Entry FND"."Buy-from Vendor Name") { }
            column(R5; "Purch Order Overdue Entry FND"."Line No.") { }
            column(R6; "Purch Order Overdue Entry FND".Type) { }
            column(R7; "Purch Order Overdue Entry FND"."No.") { }
            column(R8; "Purch Order Overdue Entry FND".Description) { }
            column(R9; "Purch Order Overdue Entry FND"."Outstanding Quantity") { }
            column(R10; "Purch Order Overdue Entry FND"."Expected Receipt Date") { }
            column(R11; "Purch Order Overdue Entry FND"."Shopping Card No.") { }
            column(R12; "Purch Order Overdue Entry FND".Overdue) { }
            column(R13; "Purch Order Overdue Entry FND"."Soon To Be Overdue") { }


        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        Text001: Label 'There is no Email Setup to send Email from Sender ID.';
        Text002: Label 'PO';
        Text003: Label 'PO_';
        Text004: Label 'D';
        Text005: Label 'Purchase Order No.';
        Text006: Label 'Status';
        Text007: Label 'Vendor No.';
        Text008: Label 'Vendor Name';
        Text009: Label 'Line No.';
        Text010: Label 'Type';
        Text011: Label 'No.';
        Text012: Label 'Description';
        Text013: Label 'Outstanding Quantiy';
        Text014: Label 'Expected Receipt Date';
        Text015: Label 'Shopping Cart';
        Text016: Label 'Overdue';
        Text017: Label 'Soon To Be Overdue';
}
