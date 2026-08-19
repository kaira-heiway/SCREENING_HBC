report 58050 "Maximo TO-WhRcpt Correction"
{
    // version HEI.01

    // HEI.01 CHG2223883 CC-INC4784177 IBM MAJUMS03 13.10.2023 # Not able to ship transfer order
    //   # This report is only used to rectify the TO Lines which are not properly updated due to deadlock issue at the time of MAXIMO-PURCH-RCPT Inbound Interface
    //   for the Type=Transfer.It is sa tool developed to fix the data automatically for the Warehouse Receipt which are stuck due to deadlock issue. As this happened
    //   for multiple OPCOs and for huge no. of data was affected, so this is need to develop to avoid the manual effort, error and time.

    // BC Upgrade KAPOOV01 >>
    // 1. Add layout path and change layout extension rdlc to rdl.
    // 2. Add ApplicationArea AND UsageCategory in Report.
    // 3. Old Report ID- 50430.
    // 4. Changed Variable name from Update to Update1 to resolve compilation 
    // BC Upgrade KAPOOV01 <<

    DefaultLayout = RDLC;
    //RDLCLayout = './Maximo TO-WhRcpt Correction.rdlc';  // BC Upgrade KAPOOV01 Commented
    RDLCLayout = '.\src\ReportsLayout\Maximo TO-WhRcpt Correction.rdl';  // BC Upgrade KAPOOV01 Added
    UsageCategory = ReportsAndAnalysis;  // BC Upgrade KAPOOV01 Added
    ApplicationArea = ALL; // BC Upgrade KAPOOV01 Added

    Permissions = TableData "Transfer Header" = r,
                  TableData "Transfer Line" = rm;

    dataset
    {
        dataitem(TransLine; "Transfer Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE("Derived From Line No." = FILTER(0), "Quantity Shipped" = FILTER(<> 0), "Qty. Shipped (Base)" = FILTER(<> 0));
            RequestFilterFields = "Document No.";
            column(DocumentNo_TransLine; TransLine."Document No.")
            {
            }
            column(LineNo_TransLine; TransLine."Line No.")
            {
            }
            column(ItemNo_TransLine; TransLine."Item No.")
            {
            }
            column(Quantity_TransLine; TransLine.Quantity)
            {
            }
            column(QtytoShip_TransLine; TransLine."Qty. to Ship")
            {
            }
            column(QtytoReceive_TransLine; TransLine."Qty. to Receive")
            {
            }
            column(QuantityShipped_TransLine; TransLine."Quantity Shipped")
            {
            }
            column(QtytoShipBase_TransLine; TransLine."Qty. to Ship (Base)")
            {
            }
            column(TransferToBinCode_TransLine; TransLine."Transfer-To Bin Code")
            {
            }
            column(QtytoReceiveBase_TransLine; TransLine."Qty. to Receive (Base)")
            {
            }

            trigger OnAfterGetRecord();
            begin
                //>>HEI.01
                TOHdr.GET(TransLine."Document No.");
                if TOHdr."PO Reference FND" = '' then
                    ERROR(ErrorText002);

                QtyToShp := 0;
                QtyToShpBase := 0;
                QtyToRcv := 0;
                QtyToRcvBase := 0;
                TransShpToBinCode := '';

                QtyToShp := TransLine."Quantity Shipped";
                QtyToShpBase := TransLine."Qty. Shipped (Base)";
                QtyToRcv := TransLine."Quantity Shipped";
                QtyToRcvBase := TransLine."Qty. Shipped (Base)";
                TransShpToBinCode := TransLine."Transfer-To Bin Code";

                TransLine."Qty. to Ship" := 0;
                TransLine."Qty. to Ship (Base)" := 0;
                TransLine."Qty. to Receive" := 0;
                TransLine."Qty. to Receive (Base)" := 0;

                // BC Upgrade KAPOOV01 Changed Variable name from Update to Update1 to resolve compilation >>
                //if Update then
                if Update1 then
                    // BC Upgrade KAPOOV01 Changed Variable name from Update to Update1 to resolve compilation <<
                    TransLine.MODIFY();

                TOLine.RESET();
                TOLine.SETRANGE("Document No.", TransLine."Document No.");
                TOLine.SETRANGE("Derived From Line No.", TransLine."Line No.");
                TOLine.SETRANGE("Item No.", TransLine."Item No.");
                if TOLine.FINDFIRST() then begin
                    TOLine."Qty. to Ship" := QtyToShp;
                    TOLine."Qty. to Ship (Base)" := QtyToShpBase;
                    TOLine."Qty. to Receive" := QtyToRcv;
                    TOLine."Qty. to Receive (Base)" := QtyToRcvBase;
                    if TOLine."Transfer-To Bin Code" <> '' then
                        TOLine."Transfer-To Bin Code" := TransShpToBinCode;
                    // BC Upgrade KAPOOV01 Changed Variable name from Update to Update1 to resolve compilation >>
                    //if Update then
                    if Update1 then
                        // BC Upgrade KAPOOV01 Changed Variable name from Update to Update1 to resolve compilation <<
                        TOLine.MODIFY();
                end;
                //<<HEI.01
            end;

            trigger OnPreDataItem();
            begin
                //>>HEI.01
                if TransLine.GETFILTER(TransLine."Document No.") = '' then
                    ERROR(ErrorText001);
                //<<HEI.01
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                // BC Upgrade KAPOOV01 Changed Variable name from Update to Update1 to resolve compilation >>
                //field(Update; Update)
                field(Update; Update1)
                // BC Upgrade KAPOOV01 Changed Variable name from Update to Update1 to resolve compilation <<
                {
                    Caption = 'Update';
                    ApplicationArea = All;
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
        ErrorText001: Label 'Document No. of TO Line cannot be blank.';
        TOHdr: Record "Transfer Header";
        TOLine: Record "Transfer Line";
        ErrorText002: Label 'This is not a Maximo related TO. As ehe PO Ref. No. of the TO is blank.';
        QtyToShp: Decimal;
        QtyToShpBase: Decimal;
        QtyToRcv: Decimal;
        QtyToRcvBase: Decimal;
        TransShpToBinCode: Code[10];

        // BC Upgrade KAPOOV01 Changed Variable name from Update to Update1 to resolve compilation >>
        //Update: Boolean;

        Update1: Boolean;

    // BC Upgrade KAPOOV01 Changed Variable name from Update to Update1 to resolve compilation <<
}

