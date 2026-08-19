report 58041 "Ibecor Situation File"
{
    // version HEI.02

    // HEI.01 CHG2278142 CHOUDS08 16.01.2025 Report for Ibecor- Heilite integration shipment update
    //   # Used Excelbuffer to create an excel report from Ibecor Situational File using Purchase Header for
    //     filtering and Purchase Header Additional for extracting Ibecor Dosier No. and PFI Document No.
    // HEI.02 CHG2290079_HB4228_StP_Report CHOUDS08 12.03.2025 for Ibecor- Heilite Integration INT04- shipment update II V
    //   # Added "Item Description" and “Shipment Status Update” Fields in the Excel Report and set up
    //     filterring based on Shipment Status Update.
    //   # Changed column ordering in excel report.

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Function- CreateBookAndOpenExcel cannot be used here as its scope is OnPrem, replaced with new logic.
    // 3. Replaced ReqFilterHeading with RequestFilterHeadingML.
    // 4. Old Report ID- 50616
    // 5. Modified Dataitem-> "<Purchase Order>" name ->Old Name: "<Purchase Order>", New Name: "Purchase Header".
    //BC Upgrade KAPOOV01  <<

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Ibecor Situational File FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    ProcessingOnly = true;
    UseRequestPage = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        //dataitem("<Purchase Order>"; "Purchase Header") //BC Upgrade KAPOOV01 Commented.
        dataitem("Purchase Header"; "Purchase Header") //BC Upgrade KAPOOV01 Added.
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending);
            RequestFilterFields = "No.", "Order Date";
            //ReqFilterHeading = 'Purchase Order';  //BC Upgrade KAPOOV01 Replaced ReqFilterHeading with RequestFilterHeadingML
            RequestFilterHeadingML = ENU = 'Purchase Order'; //BC Upgrade KAPOOV01 Replaced ReqFilterHeading with RequestFilterHeadingML
            dataitem("Ibecor Situational File FND"; "Ibecor Situational File FND")
            {
                DataItemLink = "Order No." = FIELD("No.");
                DataItemTableView = SORTING("Order No.", "Shipment No.", "Shipment Type") ORDER(Ascending);
                RequestFilterFields = "Update Date & Time";
                //ReqFilterHeading = 'Shipment Status Update Date'; //BC Upgrade KAPOOV01 Replaced ReqFilterHeading with RequestFilterHeadingML
                RequestFilterHeadingML = ENU = 'Shipment Status Update Date'; //BC Upgrade KAPOOV01 Replaced ReqFilterHeading with RequestFilterHeadingML

                trigger OnAfterGetRecord();
                var
                    MakeExcelHeader: Integer;
                begin
                    //HEI.01>>
                    CLEAR(PFI);
                    CLEAR(Dosier);
                    PurchHeader.RESET();
                    PurchHeader.SETRANGE("No.", "Ibecor Situational File FND"."Order No.");
                    if PurchHeader.FINDFIRST() then begin
                        PFI := PurchHeader."PFI Document No. INT";
                        Dosier := PurchHeader."Ibecor Dossier No. INT";
                    end;
                    //HEI.02>>
                    //MakeExcelBody(PFI,Dosier,"Ibecor Situational File");
                    PFIHeader.RESET();
                    PFIHeader.SETRANGE("PFI Document No.", PFI);
                    if PFIHeader.FINDFIRST() then begin
                        ItemDesc := PFIHeader.Description;
                    end;
                    MakeExcelBody(PFI, Dosier, ItemDesc, "Ibecor Situational File FND");
                    //HEI.02<<
                    //HEI.01<<
                end;
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

    trigger OnPostReport();
    begin
        //HEI.01>>
        CreateBookAndOpenExcel();
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        ExcelBuffer.DELETEALL();
        MakeExcelHeader();
        //HEI.01<<
    end;

    var
        PFI: Code[20];
        Dosier: Code[20];
        PurchHeader: Record "Purchase Header Additional FND";
        ExcelBuffer: Record "Excel Buffer" temporary;
        PFIHeader: Record "PFI Header INT";
        ItemDesc: Text[250];

        //BC Upgrade KAPOOV01  >>
        ServerFileName: Text;
        ExcelFileExtensionTok: Label '.xlsx';
    //BC Upgrade KAPOOV01  <<

    local procedure MakeExcelHeader();
    begin
        //HEI.01>>
        ExcelBuffer.AddColumn('Order No.', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PFI Document No.', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Ibecor Dossier No.', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.02>>
        ExcelBuffer.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.02<<
        ExcelBuffer.AddColumn('Shipment No.', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Shipment Type', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Expected Date Departure', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Departure Date', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.02>>
        ExcelBuffer.AddColumn('Shipment Status Update Date', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.02<<
        ExcelBuffer.AddColumn('Date Orig. Docs. Sent', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date Copy Docs Sent', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date Org. CRF Sent', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date Orig. B/L Sent', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date Copy B/L Sent', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vessel Name', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Expected Date Arrival', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('B/L-AWB', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Shipment Description', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Tracking Information', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Reference SDV', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date Receipt Docs Supplier', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date Receipt Docs Forwarder', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Volume in m3', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Nbr cont. 20 feet', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Nbr cont. 40 feet', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Dossier Number', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Arrival Date In Port of Destination', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.01<<
    end;

    local procedure CreateBookAndOpenExcel();
    begin
        //HEI.01>>
        //BC Upgrade KAPOOV01 function- CreateBookAndOpenExcel cannot be used here as its scope is OnPrem, replaced with new logic >>
        //ExcelBuffer.CreateBookAndOpenExcel('', 'Ibecor Situational File', '', COMPANYNAME, USERID);
        ExcelBuffer.CreateNewBook('Ibecor Situational File');
        ExcelBuffer.WriteSheet('Ibecor Situational File', COMPANYNAME, USERID);
        ServerFileName := 'Ibecor Situational File' + COMPANYNAME + USERID;
        ExcelBuffer.SetFriendlyFilename(ServerFileName + ExcelFileExtensionTok);
        ExcelBuffer.CloseBook();
        ExcelBuffer.OpenExcel();
        //BC Upgrade KAPOOV01 function- CreateBookAndOpenExcel cannot be used here as its scope is OnPrem, replaced with new logic <<

        //HEI.01<<
    end;

    local procedure MakeExcelBody(PFINumber: Code[20]; DosierNumber: Code[20]; ItemDesc: Text[250]; "Ibecor Situational File FND": Record "Ibecor Situational File FND");
    begin
        //HEI.01>>
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Order No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PFINumber, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(DosierNumber, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.02>>
        ExcelBuffer.AddColumn(ItemDesc, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.02<<
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Shipment No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Shipment Type", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Expected Date Departure", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Departure Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.02>>
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Update Date & Time", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.02<<
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Date Orig. Docs Sent", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Date Copy Docs Sent", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Date Orig. CRF Sent", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Date Copy B/L Sent", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Date Copy B/L Sent", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Vessel Name", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Expected Date Arrival", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Expected Date Arrival", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Shipment Description", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Tracking Information", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Reference SDV", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Date Receipt Docs Supplier", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Date Receipt Docs Forwarder", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Volume in m3", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Nbr cont. 20 feet", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Nbr cont. 40 feet", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Dossier Number", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Ibecor Situational File FND"."Arrival Date Destination Port", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
        //HEI.01<<
    end;
}

