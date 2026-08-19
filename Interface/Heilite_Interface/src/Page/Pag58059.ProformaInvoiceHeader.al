page 58059 "Proforma Invoice Header"
{
    // Heilite Navision Old Id - 50455

    // version HEI.21

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface
    // HEI.02 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Code added on Reject button if users want to cancel without selecting any code
    // HEI.03 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Code rectified at time of creation of PO; price refresh at tiem of opening page
    // HEI.04 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Show PO No once "Create Purchase Order" process is completed
    //   # PFI price and contract price should be identical before approving
    //   # Make eneditable for the field - PFI status
    // HEI.05 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Price from Blanket Order in PFI should be updated for Open and Accepted option and will fetch updated price to show in PFI
    //   # Document Shipping Cost line creation logic updated
    // HEI.06 CHG2153153 - IBM NANDIS01 05.04.2022 SQ2220858 can't be transformed to a PO
    //   # PO Date should take the workdate
    //   # Before creating PO system should check contract's validity depending on workdate
    // HEI.07 CHG2167000 - IBM NANDIS01 25.07.2022 # The PO’s created from PFI are not populating 2 fields: “Creation Date/Time” and “Creating By” as example below
    //   # Populate created date time and created by in PO while created from PFI
    // HEI.08 CHG2168025 IBM NANDIS01 10.08.2022 #IBECOR HeiLite PQ-Call-off integration Retrofit for Rwanda
    //   # Price of BO should come from Purchase Price table adding filter on Start Date and End Date with PFI's Doc date
    // HEI.09 CHG2168025 IBM NANDIS01 02.09.2022 #IBECOR HeiLite PQ-Call-off integration Retrofit for Rwanda
    //   # Price of the contract should be validated with respect to currency
    // HEI.10 CHG2156104 IBM NANDIS01 26.10.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Removal of cntract level validation at time of creating PFIs from Ibecor
    // HEI.11 CHG2156104 IBM NANDIS01 03.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # PO should be released
    // HEI.12 CHG2156104 IBM NANDIS01 08.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # PO should take currency from PFI
    // HEI.13 CHG2156104 IBM NANDIS01 17.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Scope changed and PO will be in released status
    //   # Channel A should come from setup
    // HEI.14 CHG2156104 IBM NANDIS01 25.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Fix on comment line
    // HEI.15 CHG2156104 IBM NANDIS01 29.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Fix on document shipping cost lines where curency didnt update
    // HEI.16 CHG2156104 IBM NANDIS01 30.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Block the code of HEI.15 and delete shipping agent lines with 0 cost
    // HEI.17 CHG2156104 IBM NANDIS01 01.12.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Document Shipping cost will be created on the filter of shipping agent service code
    // HEI.18 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields shown - "License Required" and "Credit Info Required"; code added to flow these values
    // HEI.19 CHG2215561 IBM SRIVAS07 28.08.2023 - Message not transferred to Ibecor
    //   # Document Shipping Cost line creation logic updated
    // HEI.20 CHG2215561 IBM SRIVAS07 04.09.2023 - Message not transferred to Ibecor
    //   # Document Shipping Cost line Description should come from PFI Line.
    // HEI.21 CHG2308141 IBM SHARMP16 11.08.2025 Ibecor- HL integration-PFI cancelation - Development
    //   # Code Added on ManagePO() to validate prepayment no. series


    // BC Upgrade MISHRS14 >>
    // Changed table name to "PFI Approval FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<




    // BC Upgrade PATELP08>>
    // Changed name of table from "PFI Comments" to "PFI Comments FND"
    // # Changed name of table from "PFI Lines" to "PFI Lines FND"
    // BC Upgrade PATELP08<<    

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Reject Amend Codes" to "Reject Amend Codes FND".
    // # Table name changed from "Interface Location Matrix" to "Interface Location Matrix FND".
    // BC UPGRADE PATELS08 <<

    //BC UPGRADE ATHKUS01>>
    //1.Mapped Email Receipts from precPFIHdr."Logistics Officer" to precPFIHdr."Logistics Officer Email" email is
    //sent due to Logistics Officer field is code type and email receipt is failing, so added new field "Logistics Officer Email" to capture email address and use it for sending email.
    //BC UPGRADE ATHUKS01<<



    PageType = Document;
    PromotedActionCategories = 'Actions';
    RefreshOnActivate = true;
    SourceTable = "PFI Header INT";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("PFI Document No."; Rec."PFI Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the PFI Document No. field.';
                }
                field("PFI Status"; Rec."PFI Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the PFI Status field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("PQ Number"; Rec."PQ Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the PQ Number field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field("Payment Terms Description"; Rec."Payment Terms Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payment Terms Description field.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("Payment Method Description"; Rec."Payment Method Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payment Method Description field.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shipment Method Code field.';
                }
                field("Shipment Method Description"; Rec."Shipment Method Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shipment Method Description field.';
                }
                field("IBECOR Dossier No."; Rec."IBECOR Dossier No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the IBECOR Dossier No. field.';
                }
                field("Brewery ID"; Rec."Brewery ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Brewery ID field.';
                }
                field("Logistics Officer"; Rec."Logistics Officer")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Logistics Officer field.';
                }
                field("Logistics Officer Email"; Rec."Logistics Officer Email")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Logistics Officer Email field.';
                }
                field("Total Amount(Incl. VAT)"; Rec."Total Amount(Incl. VAT)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Amount(Incl. VAT) field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("PFI Expiration Date"; Rec."PFI Expiration Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the PFI Expiration Date field.';
                }
                field(Amend; Rec.Amend)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amend field.';
                }
                field("PFI Version No"; Rec."PFI Version No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the PFI Version No field.';
                }
                field("PO Created"; Rec."PO Created")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the PO Created field.';
                }
                field("License Required"; Rec."License Required")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the License Required field.';
                }
                field("Credit Info Required"; Rec."Credit Info Required")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Credit Info Required field.';
                }
            }
            part(Control55018; "Proforma Invoice Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "PFI Document No." = FIELD("PFI Document No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("View PFI Approvals")
            {
                ApplicationArea = Basic, Suite;
                Image = View;
                RunObject = Page "PFI Approvals";
                RunPageLink = "PFI document No." = FIELD("PFI Document No.");
                ToolTip = 'Executes the View PFI Approvals action.';
            }
        }
        area(processing)
        {

            // CaptionML = ENU='Action',
            //             FRA='&Commande';
            action(Approve)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Accept';
                Image = Approve;
                ToolTip = 'Executes the Accept action.';

                trigger OnAction();
                begin
                    //HEI.01>>
                    rec.TESTFIELD("PFI Status", rec."PFI Status"::Open);
                    //HEI.04>>
                    //IF NOT ComparePFIPricewithContract(Rec) THEN  //HEI.10
                    //  EXIT; //HEI.10
                    //HEI.04<<
                    ApprovePFI(Rec);
                    //HEI.01<<
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic, Suite;
                Image = Reject;
                ToolTip = 'Executes the Reject action.';

                trigger OnAction();
                begin
                    //HEI.01>>
                    Rec.TESTFIELD("PFI Status", rec."PFI Status"::Open);
                    RejectPFI(Rec);
                    //HEI.01<<
                end;
            }
            action("Create Purchase Order")
            {
                ApplicationArea = Basic, Suite;
                Image = MakeOrder;
                ToolTip = 'Executes the Create Purchase Order action.';

                trigger OnAction();
                var
                    lrecPFILine: Record "PFI Lines FND";
                begin
                    //HEI.01>>
                    rec.TESTFIELD("PFI Status", rec."PFI Status"::Accepted);
                    rec.CALCFIELDS("PO Created");
                    rec.TESTFIELD("PO Created", false);
                    if CONFIRM(Text50005, true) then begin
                        CreatePO(Rec);
                    end else
                        exit;

                    //HEI.04>>
                    //lrecPFILine.RESET;
                    //lrecPFILine.SETRANGE("PFI Document No.",Rec."PFI Document No.");
                    //lrecPFILine.SETRANGE("PO Number",'<>%1','');
                    //IF lrecPFILine.FINDFIRST THEN
                    //  ShowPONumber := lrecPFILine."PO Number";;

                    //MESSAGE(Text50006,ShowPONumber,Rec."PFI Document No.");
                    ////HEI.01<<
                    //DeleteShippingCostLines(GlobalPONo);  //HEI.16//BC Upgrade SHARMP16-- Drink-IT function
                    MESSAGE(Text50006, GlobalPONo, Rec."PFI Document No.");
                    //HEI.04<<
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        //HEI.01>>
        ERROR(Text50012);
        //HEI.01<<
    end;

    trigger OnOpenPage();
    begin
        //HEI.10>>
        // //HEI.01>>
        // //Refresh Price from Contract at time of opening the page
        // CALCFIELDS("PO Created");
        // //HEI.03>>
        // IF "PO Created" THEN
        //  EXIT;
        // //IF ("PFI Status" = "PFI Status"::Accepted) AND (NOT "PO Created") THEN BEGIN
        // //HEI.05>>
        // //IF ("PFI Status" = "PFI Status"::Accepted) THEN BEGIN
        // IF "PFI Status" IN ["PFI Status"::Open,"PFI Status"::Accepted] THEN BEGIN
        // //HEI.05<<
        // //HEI.03<<
        //  grec_PFILines.RESET;
        //  grec_PFILines.SETRANGE("PFI Document No.","PFI Document No.");
        //  grec_PFILines.SETRANGE(Type,grec_PFILines.Type::Item);
        //  grec_PFILines.SETFILTER("Blanket Order No",'<>%1','');
        //  IF grec_PFILines.FINDSET THEN REPEAT
        //    grec_PurchLnPrice.RESET;
        //    grec_PurchLnPrice.SETRANGE("Document Type",grec_PurchLnPrice."Document Type"::"Blanket Order");
        //    grec_PurchLnPrice.SETRANGE("Document No.",grec_PFILines."Blanket Order No");
        //    grec_PurchLnPrice.SETRANGE("Item No.",grec_PFILines."No.");
        //    //HEI.08>>
        //    grec_PurchLnPrice.SETFILTER("Starting Date",'<=%1',"Document Date");
        //    grec_PurchLnPrice.SETFILTER("Ending Date",'>=%1',"Document Date");
        //    //HEI.08<<
        //    grec_PurchLnPrice.SETRANGE("Currency Code","Currency Code");//HEI.09
        //    IF grec_PurchLnPrice.FINDLAST THEN
        //      //HEI.03>>
        //      //IF (grec_PurchLnPrice."Direct Unit Cost" <> grec_PFILines."Price from Blanket Order") THEN BEGIN
        //      //    grec_PFILines."Price from Blanket Order" := grec_PurchLnPrice."Direct Unit Cost";
        //      //    grec_PFILines.MODIFY;
        //      //  END;
        //      //HEI.05>>
        //      //IF (grec_PFILines."Direct Multiplier of BO" <> 0) THEN BEGIN
        //      //  IF (grec_PurchLnPrice."Direct Cost Per Multiplier" <> grec_PFILines."Price from Blanket Order") THEN BEGIN
        //      //    grec_PFILines."Price from Blanket Order" := grec_PurchLnPrice."Direct Cost Per Multiplier";
        //      //    grec_PFILines.MODIFY;
        //      //  END;
        //      //END ELSE BEGIN
        //      //  IF (grec_PurchLnPrice."Direct Unit Cost" <> grec_PFILines."Price from Blanket Order") THEN BEGIN
        //      //    grec_PFILines."Price from Blanket Order" := grec_PurchLnPrice."Direct Unit Cost";
        //      //    grec_PFILines.MODIFY;
        //      //  END;
        //      //END;
        //      IF (grec_PurchLnPrice."Direct Unit Cost Multiplier" <> 0) THEN BEGIN
        //        grec_PFILines."Price from Blanket Order" := grec_PurchLnPrice."Direct Unit Cost" * grec_PurchLnPrice."Direct Unit Cost Multiplier";
        //        grec_PFILines.MODIFY;
        //      END ELSE BEGIN
        //        grec_PFILines."Price from Blanket Order" := grec_PurchLnPrice."Direct Unit Cost";
        //        grec_PFILines.MODIFY;
        //      END;
        //      //HEI.05<<
        //      //HEI.03<<
        //  UNTIL grec_PFILines.NEXT = 0;
        //  CurrPage.UPDATE;
        // END;
        // //HEI.01<<
        //HEI.10<<
    end;

    var
        Text50000: Label 'Do you want to accept the PFI';
        Text50001: Label 'Do you want to amend %1?';
        Text50002: Label 'Do you want to reject the PFI - %1?';
        grec_IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";//BC Upgrade SHARMP16
        Text50003: Label 'Please choose the amend reason in next window';
        Text50004: Label 'Do you want to send more information to Logistics Officer?';
        Text50005: Label 'Do you want to create Order for the PFI?';
        Text50006: Label 'Purchase Order %1 created from PFI document - %2';
        grec_RejectAmendCodes: Record "Reject Amend Codes FND";
        Page_RejectAmendCodes: Page "Reject Amend Codes";
        grec_PFIApproval: Record "PFI Approval FND";
        Page_PFIComments: Page "PFI Comments";
        grec_PFIComments: Record "PFI Comments FND";
        PurchSetup: Record "Purchases & Payables Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade SHUKLP03 << Removed from business central.
        NoSeriesG: Codeunit "No. Series"; // BC Upgrade SHUKLP03 << 
        NoSeries: Record "No. Series";
        store: Code[20];
        PurchHdr: Record "Purchase Header";
        PFICommetsLine: Integer;
        MailBodyTxt: Text;
        Text50007: Label '<br> %1 <br><br>';
        Text50008: Label '<br><br> The document - %1 needs to be amended and reason is %2 <br><br>';
        Text50009: Label '<br><br> The document - %1 does not need be amended <br><br>';
        SenderEmailL: Text[100];
        MailSubjectTxt: Label 'Update from Heilite for PFI - %1 - Dossier No- %2 - Description - %3';
        MailBodyTextLine: Label 'Dear Ibecor, <br><br> We would like to inform you that PFI document - %1 with Dossier No - %2 of Description -%3, was %4ed by Opco. <br><br>';
        Text50010: Label 'There are multiple Blanket Orders except - %1, which will block system to create new PO';
        Text50011: Label 'There is no Blanket Order available for the PFI line No - %1';
        Text50012: Label 'PFI DOcuments are not allowed to be deleted';
        ShowPONumber: Code[20];
        grec_PFILines: Record "PFI Lines FND";
        grec_PurchLnPrice: Record "Purchase Line Price FND";
        GlobalPONo: Code[20];
        PurchaseHeader: Record "Purchase Header";

    local procedure ApprovePFI(prec_PFIHdr: Record "PFI Header INT");
    begin
        //HEI.01>>
        if CONFIRM(Text50000, true) then begin
            prec_PFIHdr."PFI Status" := prec_PFIHdr."PFI Status"::Accepted;
            prec_PFIHdr.MODIFY();
            //Insert Data into PFI Approval
            CLEAR(grec_PFIApproval);
            grec_PFIApproval."PFI document No." := prec_PFIHdr."PFI Document No.";
            grec_PFIApproval."PFI Approval Status" := grec_PFIApproval."PFI Approval Status"::Accepted;
            grec_PFIApproval.Date := WORKDATE();
            grec_PFIApproval.Rejected := false;
            grec_PFIApproval.Accepted := true;
            grec_PFIApproval.INSERT(true);
            //Create Outbound Inter Entries
            CreateOutboundPFIConfirmation(prec_PFIHdr, 'Accept');
            TriggerEmailtoIbecor(prec_PFIHdr, 'Accept');
        end else
            exit;
        //HEI.01<<
    end;

    local procedure RejectPFI(prec_PFIHdr: Record "PFI Header INT");
    begin
        //HEI.01>>
        if CONFIRM(STRSUBSTNO(Text50002, prec_PFIHdr."PFI Document No."), true) then begin
            if CONFIRM(STRSUBSTNO(Text50001, prec_PFIHdr."PFI Document No."), true) then begin
                COMMIT();
                CLEAR(Page_RejectAmendCodes);
                grec_RejectAmendCodes.RESET();
                grec_RejectAmendCodes.FILTERGROUP(2);
                grec_RejectAmendCodes.SETRANGE(Type, grec_RejectAmendCodes.Type::Amend);
                grec_RejectAmendCodes.FILTERGROUP(0);
                Page_RejectAmendCodes.SETTABLEVIEW(grec_RejectAmendCodes);
                Page_RejectAmendCodes.LOOKUPMODE(true);
                if Page_RejectAmendCodes.RUNMODAL() = ACTION::LookupOK then begin
                    Page_RejectAmendCodes.GetSelected(grec_RejectAmendCodes);
                    if grec_RejectAmendCodes.FINDFIRST() then begin
                        ApplyRejectAmendCode(prec_PFIHdr, grec_RejectAmendCodes);
                        if CONFIRM(Text50004, true) then begin
                            COMMIT();
                            CLEAR(Page_PFIComments);
                            grec_PFIComments.RESET();
                            grec_PFIComments.SETRANGE("PFI Document No", prec_PFIHdr."PFI Document No.");
                            if grec_PFIComments.FINDFIRST() then
                                PFICommetsLine := 10000
                            else
                                PFICommetsLine := grec_PFIComments."Line No" + 10000;
                            grec_PFIComments.SETRANGE("Line No", PFICommetsLine);
                            Page_PFIComments.SETTABLEVIEW(grec_PFIComments);
                            Page_PFIComments.GetParameter(prec_PFIHdr."PFI Document No.", PFICommetsLine);
                            Page_PFIComments.RUNMODAL();
                        end;
                    end;
                    prec_PFIHdr.Amend := prec_PFIHdr.Amend::Yes;
                end else //HEI.02
                    exit;  //HEI.02
            end else begin
                COMMIT();
                CLEAR(Page_RejectAmendCodes);
                grec_RejectAmendCodes.FILTERGROUP(2);
                grec_RejectAmendCodes.SETRANGE(Type, grec_RejectAmendCodes.Type::Reject);
                grec_RejectAmendCodes.FILTERGROUP(0);
                Page_RejectAmendCodes.SETTABLEVIEW(grec_RejectAmendCodes);
                Page_RejectAmendCodes.LOOKUPMODE(true);
                if Page_RejectAmendCodes.RUNMODAL() = ACTION::LookupOK then begin
                    Page_RejectAmendCodes.GetSelected(grec_RejectAmendCodes);
                    if grec_RejectAmendCodes.FINDFIRST() then
                        ApplyRejectAmendCode(prec_PFIHdr, grec_RejectAmendCodes);
                end else //HEI.02
                    exit;  //HEI.02
                prec_PFIHdr.Amend := prec_PFIHdr.Amend::No;
                prec_PFIHdr."PFI Status" := prec_PFIHdr."PFI Status"::Rejected;
            end;
            prec_PFIHdr."PFI Status" := prec_PFIHdr."PFI Status"::Rejected;
            prec_PFIHdr.MODIFY();
            CreateOutboundPFIConfirmation(prec_PFIHdr, 'Reject');
            TriggerEmailtoIbecor(prec_PFIHdr, 'Reject');
        end else
            exit;
        //HEI.01<<
    end;

    local procedure CreatePO(prec_PFIHdr: Record "PFI Header INT");
    var
        lrec_PFILn: Record "PFI Lines FND";
        CurrentBONo: Code[20];
    begin
        //HEI.01>>
        grec_IbecorInterfaceSetup.GET();
        //Check all the lines are having BO except CMG9999
        lrec_PFILn.RESET();
        lrec_PFILn.SETRANGE("PFI Document No.", rec."PFI Document No.");
        lrec_PFILn.SETFILTER("No.", '<>%1', grec_IbecorInterfaceSetup."Default CMG");
        lrec_PFILn.SETFILTER("Blanket Order No", '%1', '');
        //lrec_PFILn.SETFILTER(Type,'<>%1',lrec_PFILn.Type::" ");//HEI.10
        lrec_PFILn.SETFILTER(Type, '%1', lrec_PFILn.Type::"Item Charge");//HEI.10
        if lrec_PFILn.findset() then
            repeat
                ERROR(Text50011, lrec_PFILn."Line No");
            until lrec_PFILn.NEXT() = 0;

        //Check whether multiple BO available
        lrec_PFILn.RESET();
        lrec_PFILn.SETCURRENTKEY("PFI Document No.", "Blanket Order No");
        lrec_PFILn.SETRANGE("PFI Document No.", rec."PFI Document No.");
        lrec_PFILn.SETFILTER(Type, '%1', lrec_PFILn.Type::Item);
        lrec_PFILn.SETFILTER("Blanket Order No", '<>%1', '');
        if lrec_PFILn.FINDFIRST() then
            CurrentBONo := lrec_PFILn."Blanket Order No";

        if (CurrentBONo <> '') then begin
            lrec_PFILn.RESET();
            lrec_PFILn.SETCURRENTKEY("PFI Document No.", "Blanket Order No");
            lrec_PFILn.SETRANGE("PFI Document No.", rec."PFI Document No.");
            lrec_PFILn.SETFILTER(Type, '%1', lrec_PFILn.Type::Item);
            lrec_PFILn.SETFILTER("Blanket Order No", '<>%1', CurrentBONo);
            if lrec_PFILn.findset() then
                repeat
                    if (lrec_PFILn."Blanket Order No" <> '') then
                        ERROR(Text50010, CurrentBONo);
                until lrec_PFILn.NEXT() = 0;
        end;

        //Start creating PO
        lrec_PFILn.RESET();
        lrec_PFILn.SETCURRENTKEY("PFI Document No.", "Blanket Order No");
        lrec_PFILn.SETRANGE("PFI Document No.", rec."PFI Document No.");
        if lrec_PFILn.findset() then
            repeat
                ManagePO(lrec_PFILn);
            until lrec_PFILn.NEXT() = 0;
        //HEI.01<<

        //HEI.13>>
        ////HEI.11>>
        //IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,GlobalPONo) THEN
        //  CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchaseHeader);
        ////HEI.11<<
        //HEI.13<<
    end;

    local procedure CreateOutboundPFIConfirmation(prec_PFIHeader: Record "PFI Header INT"; "Action": Code[10]);
    var
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";

        // BC Upgrade MISHRS14 >>
        // Added FND in PFI Approval and other wherever reuired
        lrec_PFIApproval: Record "PFI Approval FND";
        RejectAmendCodes: Record "Reject Amend Codes FND";
    // Blocked below as already defined
    // lrec_PFIApproval: Record "PFI Approval FND";
    // RejectAmendCodes: Record "Reject Amend Codes FND";
    // BC Upgrade MISHRS14 <<

    begin
        //HEI.01>>
        grec_IbecorInterfaceSetup.GET();
        grec_IbecorInterfaceSetup.TESTFIELD("Interface Enable/Disable", true);
        grec_IbecorInterfaceSetup.TESTFIELD("IBECOR PFI Rejection");

        InterfaceSetup.GET(grec_IbecorInterfaceSetup."IBECOR PFI Rejection");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Object Type" := 'PFI';
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Interface Code" := grec_IbecorInterfaceSetup."IBECOR PFI Rejection";
        InterfaceEntryHeaderOut."Source No." := prec_PFIHeader."PFI Document No.";
        InterfaceEntryHeaderOut."Action Code" := FORMAT(prec_PFIHeader."PFI Status");
        InterfaceEntryHeaderOut.City := FORMAT(prec_PFIHeader."PFI Status");
        if (Action = 'ACCEPT') then begin
            InterfaceEntryHeaderOut.Closed := false;
            InterfaceEntryHeaderOut."Log Message" := '';
        end else begin
            if (Action = 'REJECT') then begin
                lrec_PFIApproval.RESET();
                lrec_PFIApproval.SETRANGE("PFI document No.", prec_PFIHeader."PFI Document No.");
                lrec_PFIApproval.SETRANGE("PFI Approval Status", lrec_PFIApproval."PFI Approval Status"::Rejected);
                if lrec_PFIApproval.FINDLAST() then begin
                    if lrec_PFIApproval.Rejected then begin
                        if (lrec_PFIApproval."Rejected Reason" <> '') then
                            if RejectAmendCodes.GET(RejectAmendCodes.Type::Reject, lrec_PFIApproval."Rejected Reason") then begin
                                if not lrec_PFIApproval.Amend then
                                    InterfaceEntryHeaderOut."Address 2" := RejectAmendCodes.Description
                                else
                                    InterfaceEntryHeaderOut."Address 2" := '';
                            end;
                    end;
                    InterfaceEntryHeaderOut.Closed := lrec_PFIApproval.Amend;
                    InterfaceEntryHeaderOut."Log Message" := lrec_PFIApproval."Amend Reason";
                end;
            end;
        end;
        InterfaceEntryHeaderOut."Document Date" := prec_PFIHeader."Document Date";
        InterfaceEntryHeaderOut.Address := prec_PFIHeader."Logistics Officer";
        InterfaceEntryHeaderOut.INSERT(true);
        //HEI.01<<
    end;

    // local procedure TriggerEmailtoIbecor(prec_PFIHdr: Record "PFI Header INT"; "Action": Code[10]);
    // var
    //     lrec_CompInfo: Record "Company Information";
    //     TextL000: Label 'There is no Sender E-mail address available neither in "SMTP Mail Setup", nor "Company Information". Please add it before sending the mail.';
    //     lrec_PFIComments: Record "PFI Comments";
    // begin
    //     //HEI.01>>
    //     MailBodyTxt := '';
    //     lrec_CompInfo.GET;
    //     prec_PFIHdr.TESTFIELD("Logistics Officer Email");
    //     SMTPMailSetup.GET;
    //     CLEAR(SMTPMail);

    //     if SMTPMailSetup."User ID" <> '' then
    //         SenderEmailL := SMTPMailSetup."User ID"
    //     else
    //         SenderEmailL := lrec_CompInfo."E-Mail";
    //     if SenderEmailL = '' then
    //         ERROR(TextL000);

    //     grec_PFIApproval.RESET;
    //     grec_PFIApproval.SETRANGE("PFI document No.", prec_PFIHdr."PFI Document No.");
    //     if grec_PFIApproval.FINDLAST then begin

    //         if (prec_PFIHdr."PFI Status" = prec_PFIHdr."PFI Status"::Accepted) then
    //             MailBodyTxt := STRSUBSTNO(MailBodyTextLine, prec_PFIHdr."PFI Document No.", prec_PFIHdr."IBECOR Dossier No.",
    //                                             prec_PFIHdr.Description, LOWERCASE(Action));
    //         if (prec_PFIHdr."PFI Status" = prec_PFIHdr."PFI Status"::Rejected) then begin
    //             lrec_PFIComments.RESET;
    //             lrec_PFIComments.SETRANGE("PFI Document No", prec_PFIHdr."PFI Document No.");
    //             if lrec_PFIComments.FINDLAST then;
    //             if (prec_PFIHdr.Amend = prec_PFIHdr.Amend::Yes) then begin
    //                 MailBodyTxt := STRSUBSTNO(MailBodyTextLine, prec_PFIHdr."PFI Document No.", prec_PFIHdr."IBECOR Dossier No.",
    //                                 prec_PFIHdr.Description, LOWERCASE(Action)) +
    //                                 STRSUBSTNO(Text50008, prec_PFIHdr."PFI Document No.", grec_PFIApproval."Amend Reason") +
    //                                 STRSUBSTNO(Text50007, lrec_PFIComments.Comments);
    //             end else begin
    //                 MailBodyTxt := STRSUBSTNO(MailBodyTextLine, prec_PFIHdr."PFI Document No.", prec_PFIHdr."IBECOR Dossier No.",
    //                                             prec_PFIHdr.Description, LOWERCASE(Action)) +
    //                                 STRSUBSTNO(Text50009, prec_PFIHdr."PFI Document No.") +
    //                                 STRSUBSTNO(Text50007, lrec_PFIComments.Comments);
    //             end;
    //         end;

    //         SMTPMail.CreateMessage(prec_PFIHdr."Logistics Officer", SenderEmailL, prec_PFIHdr."Logistics Officer Email",
    //                                 STRSUBSTNO(MailSubjectTxt, prec_PFIHdr."PFI Document No.", prec_PFIHdr."IBECOR Dossier No.",
    //                                 prec_PFIHdr.Description), MailBodyTxt, true);
    //         SMTPMail.Send;
    //         grec_PFIApproval."Mail Sent" := true;
    //         grec_PFIApproval.MODIFY;
    //     end;
    //     //HEI.01<<
    // end;
    //BC Upgrade SHARMP16 end<<------------ Email code

    //BC Upgrade SHARMP16 Email code ------ rewrite begin>>
    local procedure TriggerEmailToIbecor(precPFIHdr: Record "PFI Header INT"; Action: Code[10])
    var
        CompanyInfo: Record "Company Information";

        // PFIComments: Record "PFI Comments";
        // PFIApproval: Record "PFI Approval FND";

        // BC Upgrade MISHRS14 >>
        // Added FND in PFI Approval and other wherever reuired
        PFIComments: Record "PFI Comments FND";
        PFIApproval: Record "PFI Approval FND";
        // BC Upgrade MISHRS14 <<

        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        MailBodyTxt: Text;
        SenderEmail: Text;
        Recipients: Text;
        BodyLine: Label 'The PFI document %1 (Dossier No. %2, Description: %3) has been %4.';
        TextAmendReason: Label 'Amend Reason for document %1: %2';
        TextComments: Label 'Comments: %1';
        TextNoSender: Label 'There is no sender email address available in Company Information. Please configure it before sending the mail.';
        MailSubjectTxt: Label 'PFI Document %1 - Dossier No. %2 - %3';
        EmailScenario: Codeunit "Email Scenario";
        EmailAccount: Record "Email Account";

    begin
        // Get company information
        if not CompanyInfo.Get() then
            Error('Company Information record not found.');

        // Get sender email address
        SenderEmail := CompanyInfo."E-Mail";
        if SenderEmail = '' then
            Error(TextNoSender);

        // Validate recipient
        precPFIHdr.TestField("Logistics Officer Email");

        // Initialize email body text
        MailBodyTxt := '';

        // Find the latest approval record
        PFIApproval.Reset();
        PFIApproval.SetRange("PFI Document No.", precPFIHdr."PFI Document No.");
        if PFIApproval.FindLast() then begin

            case precPFIHdr."PFI Status" of
                precPFIHdr."PFI Status"::Accepted:
                    MailBodyTxt := StrSubstNo(BodyLine,
                        precPFIHdr."PFI Document No.",
                        precPFIHdr."IBECOR Dossier No.",
                        precPFIHdr.Description,
                        LowerCase(Action));

                precPFIHdr."PFI Status"::Rejected:
                    begin
                        PFIComments.Reset();
                        PFIComments.SetRange("PFI Document No", precPFIHdr."PFI Document No.");
                        if PFIComments.FindLast() then;

                        if precPFIHdr.Amend = precPFIHdr.Amend::Yes then
                            MailBodyTxt := StrSubstNo(BodyLine,
                                precPFIHdr."PFI Document No.",
                                precPFIHdr."IBECOR Dossier No.",
                                precPFIHdr.Description,
                                LowerCase(Action)) + ' ' +
                                StrSubstNo(TextAmendReason,
                                    precPFIHdr."PFI Document No.",
                                    PFIApproval."Amend Reason") + ' ' +
                                StrSubstNo(TextComments, PFIComments.Comments)
                        else
                            MailBodyTxt := StrSubstNo(BodyLine,
                                precPFIHdr."PFI Document No.",
                                precPFIHdr."IBECOR Dossier No.",
                                precPFIHdr.Description,
                                LowerCase(Action)) + ' ' +
                                StrSubstNo(TextComments, PFIComments.Comments);
                    end;
            end;
            // Add recipients
            Recipients := precPFIHdr."Logistics Officer Email";
            //Recipients.Add(precPFIHdr."Logistics Officer Email");
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", Recipients);
            // Build email message
            // EmailMessage.Create(Recipients,
            //      StrSubstNo(MailSubjectTxt,
            //                 precPFIHdr."PFI Document No.",
            //                 precPFIHdr."IBECOR Dossier No.",
            //                 precPFIHdr.Description),
            // MailBodyTxt);
            //BC UPGRADE ATHKUS01<< 
            EmailMessage.Create(precPFIHdr."Logistics Officer Email", StrSubstNo(MailSubjectTxt,
                                        precPFIHdr."PFI Document No.",
                                        precPFIHdr."IBECOR Dossier No.",
                                        precPFIHdr.Description), MailBodyTxt);
            //BC UPGRADE ATHKUS01>>  
            if EmailScenario.GetEmailAccount(Enum::"Email Scenario"::"Proforma Invoice", EmailAccount) then begin
                if EmailAccount."Email Address" <> '' then
                    Email.Send(EmailMessage, Enum::"Email Scenario"::"Proforma Invoice")
                else
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default)
            end else begin
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

            end;
            PFIApproval."Mail Sent" := true;
            PFIApproval.Modify();
        end;
    end;
    //BC Upgrade SHARMP16 Email code ------ rewrite end<<
    local procedure ApplyRejectAmendCode(p_PFIHdr: Record "PFI Header INT"; p_RejAmendCodes: Record "Reject Amend Codes FND");
    begin
        //HEI.01>>
        CLEAR(grec_PFIApproval);
        grec_PFIApproval."PFI document No." := p_PFIHdr."PFI Document No.";
        grec_PFIApproval."PFI Approval Status" := grec_PFIApproval."PFI Approval Status"::Rejected;
        grec_PFIApproval.Date := WORKDATE();
        grec_PFIApproval.Rejected := true;
        grec_PFIApproval.Accepted := false;
        case p_RejAmendCodes.Type of
            p_RejAmendCodes.Type::Amend:
                begin
                    grec_PFIApproval.Amend := true;
                    grec_PFIApproval."Rejected Reason" := p_RejAmendCodes.Code;
                    grec_PFIApproval."Amend Reason" := p_RejAmendCodes.Description;
                end;
            p_RejAmendCodes.Type::Reject:
                begin
                    grec_PFIApproval.Amend := false;
                    grec_PFIApproval."Rejected Reason" := p_RejAmendCodes.Code;
                end;
        end;
        grec_PFIApproval.INSERT(true);
        //HEI.01<<
    end;

    local procedure ManagePO(prec_PFILine: Record "PFI Lines FND");
    var
        PurchaseHeader: Record "Purchase Header";
        PONumber: Code[20];
        lrec_PFIHeader: Record "PFI Header INT";
        lrec_PurchHdrAdditional: Record "Purchase Header Additional FND";
        lrec_PurchHdrAdditnlUpdate: Record "Purchase Header Additional FND";
        CreatePOHdrandLn: Boolean;
        lrec_PurchHdr: Record "Purchase Header";
        lrec_InterfaceLocationMatrix: Record "Interface Location Matrix FND";
        POAddHdrUpdateCMG: Record "Purchase Header Additional FND";
        POHdrUpdateCMG: Record "Purchase Header";
        lrec_Vendor: Record Vendor;
        POAddHdrUpdateComment: Record "Purchase Header Additional FND";
        // DocumentShippingCost: Record "Document Shipping Cost";// BC Upgrade SHARMP16-- Drink-IT table
        ShippingAgentServices: Record "Shipping Agent Services";
    // ShippingAgentPurchPrice: Record "Shipping Agent Purch. Price";// BC Upgrade SHARMP16-- Drink-IT table
    begin
        //HEI.01>>
        grec_IbecorInterfaceSetup.GET();
        PurchSetup.GET();
        grec_IbecorInterfaceSetup.TESTFIELD("Interface Enable/Disable", true);
        grec_IbecorInterfaceSetup.TESTFIELD("IBECOR Vendor");
        grec_IbecorInterfaceSetup.TESTFIELD("Ibecor PO Channel");//HEI.13

        //HEI.06>>
        //PFIDateValiditywithContract(prec_PFILine);//HEI.10
        //HEI.06<<
        lrec_PurchHdrAdditional.RESET();
        lrec_PurchHdrAdditional.SETRANGE("Document Type", lrec_PurchHdrAdditional."Document Type"::Order);
        lrec_PurchHdrAdditional.SETRANGE("PFI Document No. INT", prec_PFILine."PFI Document No.");
        if lrec_PurchHdrAdditional.FINDLAST() then begin
            lrec_PurchHdr.RESET();
            lrec_PurchHdr.SETRANGE("Document Type", lrec_PurchHdr."Document Type"::Order);
            lrec_PurchHdr.SETRANGE("No.", lrec_PurchHdrAdditional."No.");
            if lrec_PurchHdr.FINDFIRST() then begin
                if (prec_PFILine.Type = prec_PFILine.Type::" ") or (prec_PFILine.Type = prec_PFILine.Type::Item) then begin
                    POAddHdrUpdateComment.RESET();
                    POAddHdrUpdateComment.SETRANGE("Document Type", POAddHdrUpdateComment."Document Type"::Order);
                    POAddHdrUpdateComment.SETRANGE(POAddHdrUpdateComment."PFI Document No. INT", prec_PFILine."PFI Document No.");
                    if POAddHdrUpdateComment.FINDLAST() then
                        if POHdrUpdateCMG.GET(POAddHdrUpdateComment."Document Type"::Order, POAddHdrUpdateComment."No.") then
                            CreteModifyPOLines(POHdrUpdateCMG, prec_PFILine);
                end;
                if (prec_PFILine.Type = prec_PFILine.Type::"Item Charge") then begin
                    if (prec_PFILine."Shipping Agent Code" = grec_IbecorInterfaceSetup."IBECOR Shipping Agent Code") and
                         (prec_PFILine."Shipping Agent Service Code" <> '') then begin
                        //BC Upgrade SHARMP16 begin>>-- Drink-IT table used
                        //Insertion of Doc Shipping Cost
                        // DocumentShippingCost.RESET;
                        // DocumentShippingCost.SETRANGE("Source Type", DATABASE::"Purchase Header");
                        // DocumentShippingCost.SETRANGE("Source No.", lrec_PurchHdr."No.");
                        // //HEI.05>>
                        // //DocumentShippingCost.SETRANGE("Line No.",prec_PFILine."Line No");
                        // DocumentShippingCost.SETRANGE("Line No.", prec_PFILine."Line No"); //HEI.19
                        // DocumentShippingCost.SETRANGE("Charge No.", prec_PFILine."No.");
                        // DocumentShippingCost.SETRANGE("Shipping Agent Service Code", prec_PFILine."Shipping Agent Service Code");  //HEI.17
                        //                                                                                                            //HEI.05<<
                        // DocumentShippingCost.SETRANGE("Sub Type", 1);
                        // if not DocumentShippingCost.FINDFIRST then begin
                        //     ShippingAgentServices.RESET;
                        //     ShippingAgentServices.SETRANGE("Shipping Agent Code", grec_IbecorInterfaceSetup."IBECOR Shipping Agent Code");
                        //     ShippingAgentServices.SETRANGE(Code, prec_PFILine."Shipping Agent Service Code");
                        //     ShippingAgentServices.SETRANGE("Blanket Order No.", prec_PFILine."Blanket Order No");
                        //     ShippingAgentServices.SETRANGE("Shipping Charge No.", prec_PFILine."No.");
                        //     if ShippingAgentServices.FINDFIRST then begin
                        //         ShippingAgentPurchPrice.RESET;
                        //         ShippingAgentPurchPrice.SETRANGE("Shipping Agent Code", grec_IbecorInterfaceSetup."IBECOR Shipping Agent Code");
                        //         ShippingAgentPurchPrice.SETRANGE("Shipping Agent Service Code", ShippingAgentServices.Code);
                        //         if ShippingAgentPurchPrice.FINDFIRST then begin
                        //             DocumentShippingCost.INIT;
                        //             DocumentShippingCost."Source Type" := DATABASE::"Purchase Header";
                        //             DocumentShippingCost."Source No." := lrec_PurchHdr."No.";
                        //             DocumentShippingCost."Line No." := prec_PFILine."Line No";
                        //             DocumentShippingCost."Sub Type" := 1;
                        //             DocumentShippingCost.VALIDATE("Shipping Agent Code", prec_PFILine."Shipping Agent Code");
                        //             DocumentShippingCost.VALIDATE("Shipping Agent Service Code", ShippingAgentServices.Code);
                        //             DocumentShippingCost.VALIDATE("Vendor No.", lrec_PurchHdr."Buy-from Vendor No.");
                        //             DocumentShippingCost."Charge Type" := DocumentShippingCost."Charge Type"::"Charge (Item)";
                        //             DocumentShippingCost."Charge No." := prec_PFILine."No.";
                        //             DocumentShippingCost.Description := prec_PFILine.Description; // HEI.20
                        //             if lrec_PFIHeader.GET(prec_PFILine."PFI Document No.") then;
                        //             DocumentShippingCost."Currency Code" := lrec_PFIHeader."Currency Code";
                        //             DocumentShippingCost."Unit Cost" := prec_PFILine."Unit Price";
                        //             DocumentShippingCost.INSERT;
                        //         end;

                        //end;
                        //HEI.05>>
                        //END;
                        // end else begin
                        //     DocumentShippingCost."Unit Cost" := prec_PFILine."Unit Price";
                        //     //DocumentShippingCost."Currency Code" := lrec_PFIHeader."Currency Code";  //HEI.15   //HEI.16
                        //     DocumentShippingCost.MODIFY;
                        // end;
                        //BC Upgrade SHARMP16 end<<-- Drink-IT table used
                        //HEI.05<<
                    end else begin
                        if (prec_PFILine."No." = grec_IbecorInterfaceSetup."Default CMG") then begin
                            POAddHdrUpdateCMG.RESET();
                            POAddHdrUpdateCMG.SETRANGE("Document Type", POAddHdrUpdateCMG."Document Type"::Order);
                            POAddHdrUpdateCMG.SETRANGE(POAddHdrUpdateCMG."PFI Document No. INT", prec_PFILine."PFI Document No.");
                            if POAddHdrUpdateCMG.FINDLAST() then
                                if POHdrUpdateCMG.GET(POAddHdrUpdateCMG."Document Type"::Order, POAddHdrUpdateCMG."No.") then
                                    CreteModifyPOLines(POHdrUpdateCMG, prec_PFILine);
                        end;
                    end;
                end;
                //end
            end else begin
                //Create a new PO with the line
                if lrec_PFIHeader.GET(prec_PFILine."PFI Document No.") then;
                CLEAR(PurchaseHeader);

                PONumber := '';
                if PONumber = '' then begin
                    PurchSetup.TESTFIELD("Order Nos.");
                    NoSeries.GET(PurchSetup."Order Nos.");
                    //NoSeriesMgt.InitSeries(NoSeries.Code, '', WORKDATE, PONumber, PurchaseHeader."No. Series");  // BC Upgrade SHUKLP03 << Blocked because InitSeries() is removed.
                    // BC Upgrade SHUKLP03 >> Added code to get no series because this is removed InitSeries().
                    PurchaseHeader."No. Series" := NoSeries.Code;
                    NoSeriesG.AreRelated(NoSeries.Code, '');
                    PONumber := NoSeriesG.GetNextNo(PurchaseHeader."No. Series")
                    // BC Upgrade SHUKLP03 << Added code to get no series because this is removed InitSeries().

                end;

                PurchaseHeader.InitRecord();//HEI.07
                if not GUIALLOWED then
                    PurchaseHeader.SetHideValidationDialog(true);
                PurchaseHeader.VALIDATE("Document Type", PurchaseHeader."Document Type"::Order);
                PurchaseHeader.VALIDATE("No.", PONumber);
                lrec_Vendor.RESET();
                lrec_Vendor.SETRANGE("Global Vendor Number FND", grec_IbecorInterfaceSetup."IBECOR Vendor");
                if lrec_Vendor.FINDFIRST() then
                    PurchaseHeader.VALIDATE("Buy-from Vendor No.", lrec_Vendor."No.");
                PurchaseHeader.VALIDATE("Receiving No. Series", PurchSetup."Posted Receipt Nos.");
                //HEI.21>>
                PurchaseHeader.VALIDATE("Prepayment No. Series", PurchSetup."Posted Prepmt. Inv. Nos.");
                //HEI.21<<
                PurchaseHeader.INSERT(true);

                //HEI.06>>
                //PurchaseHeader.VALIDATE("Document Date",lrec_PFIHeader."Document Date");
                //PurchaseHeader.VALIDATE("Posting Date",lrec_PFIHeader."Document Date");
                PurchaseHeader.VALIDATE("Document Date", WORKDATE());
                PurchaseHeader.VALIDATE("Posting Date", WORKDATE());
                //HEI.06<<
                lrec_InterfaceLocationMatrix.RESET();
                lrec_InterfaceLocationMatrix.SETRANGE("IBC Location Code", lrec_PFIHeader."Brewery ID");
                if lrec_InterfaceLocationMatrix.FINDFIRST() then
                    PurchaseHeader."Location Code" := lrec_InterfaceLocationMatrix."Heilite Location Code";
                if (PurchaseHeader."Location Code" <> '') then
                    PurchaseHeader.VALIDATE("Location Code");
                if (lrec_PFIHeader."Payment Terms Code" <> '') then
                    PurchaseHeader.VALIDATE("Payment Terms Code", lrec_PFIHeader."Payment Terms Code");
                if (lrec_PFIHeader."Payment Method Code" <> '') then
                    PurchaseHeader.VALIDATE("Payment Method Code", lrec_PFIHeader."Payment Method Code");
                if (lrec_PFIHeader."Shipment Method Code" <> '') then
                    PurchaseHeader.VALIDATE("Shipment Method Code", lrec_PFIHeader."Shipment Method Code");
                PurchaseHeader.VALIDATE("Document Subtype Code FND", PurchSetup."PO Subtype Code FND");// BC Upgrade VAMSIU01--field Added >>
                PurchaseHeader."Blanket Order No. FND" := prec_PFILine."Blanket Order No";
                //PurchaseHeader.VALIDATE("Shipping Agent Code", prec_PFILine."Shipping Agent Code");// BC Upgrade SHARMP16-- Drink-IT field
                //HEI.13>>
                //PurchaseHeader.Channel := 'A';//HEI.10
                PurchaseHeader."Channel FND" := grec_IbecorInterfaceSetup."Ibecor PO Channel";
                //HEI.13<<
                if (PurchaseHeader."Currency Code" <> lrec_PFIHeader."Currency Code") then  //HEI.12
                    PurchaseHeader.VALIDATE("Currency Code", lrec_PFIHeader."Currency Code");  //HEI.12
                PurchaseHeader.MODIFY(true);
                if lrec_PurchHdrAdditnlUpdate.GET(lrec_PurchHdrAdditional."Document Type"::Order, PurchaseHeader."No.") then begin
                    lrec_PurchHdrAdditnlUpdate."PFI Document No. INT" := prec_PFILine."PFI Document No.";
                    lrec_PurchHdrAdditnlUpdate."Ibecor Dossier No. INT" := lrec_PFIHeader."IBECOR Dossier No.";
                    //HEI.18>>
                    lrec_PurchHdrAdditnlUpdate."License Required INT" := lrec_PFIHeader."License Required";
                    lrec_PurchHdrAdditnlUpdate."Credit Info Required INT" := lrec_PFIHeader."Credit Info Required";
                    //HEI.18<<
                    lrec_PurchHdrAdditnlUpdate.MODIFY();
                end;
                CreteModifyPOLines(PurchaseHeader, prec_PFILine);
            end;
            //HEI.01<<
        end;
    end;

    local procedure CreteModifyPOLines(prec_PurchHdr: Record "Purchase Header"; p_PFI_Line: Record "PFI Lines FND");
    var
        lrec_PurchLn: Record "Purchase Line";
        LineNo: Integer;
        lrec_PFILne: Record "PFI Lines FND";
        lrec_PurchHdrAdditional: Record "Purchase Header Additional FND";
        BOLine: Record "Purchase Line";
    begin
        //HEI.01>>
        PurchSetup.GET();
        LineNo := 0;
        lrec_PurchLn.RESET();
        lrec_PurchLn.SETRANGE("Document Type", prec_PurchHdr."Document Type"::Order);
        lrec_PurchLn.SETRANGE("Document No.", prec_PurchHdr."No.");
        if lrec_PurchLn.FINDLAST() then
            LineNo := lrec_PurchLn."Line No." + 10000
        else
            LineNo := 10000;
        lrec_PurchLn.INIT();
        lrec_PurchLn."Document Type" := prec_PurchHdr."Document Type"::Order;
        lrec_PurchLn."Document No." := prec_PurchHdr."No.";
        lrec_PurchLn."Line No." := LineNo;
        lrec_PurchLn.INSERT(true);

        if (p_PFI_Line.Type = p_PFI_Line.Type::Item) then
            lrec_PurchLn.VALIDATE(Type, lrec_PurchLn.Type::Item)
        else if (p_PFI_Line.Type = p_PFI_Line.Type::"Item Charge") then
            lrec_PurchLn.VALIDATE(Type, lrec_PurchLn.Type::"Charge (Item)")
        else if (p_PFI_Line.Type = p_PFI_Line.Type::" ") then
            lrec_PurchLn.VALIDATE(Type, lrec_PurchLn.Type::" ");

        if (p_PFI_Line."No." <> '') then
            lrec_PurchLn.VALIDATE("No.", p_PFI_Line."No.");
        lrec_PurchLn.Description := p_PFI_Line.Description;
        //HEI.03>>
        if (lrec_PurchLn.Type = lrec_PurchLn.Type::Item) then
            //lrec_PurchLn.VALIDATE("Unit of Measure Code",p_PFI_Line."UOM of BO");//HEI.10
            lrec_PurchLn.VALIDATE("Unit of Measure Code", p_PFI_Line."Unit Of Measure");//HEI.10
        //HEI.03<<
        if (p_PFI_Line.Quantity <> 0) then
            lrec_PurchLn.VALIDATE(Quantity, p_PFI_Line.Quantity);
        //lrec_PurchLn.VALIDATE("Shipping Agent Code", p_PFI_Line."Shipping Agent Code");//BC Upgrade SHARMP16-- Drink-IT field
        //lrec_PurchLn."Blanket Order No." := p_PFI_Line."Blanket Order No";//HEI.10

        //HEI.10>>
        //BOLine.RESET;
        //BOLine.SETRANGE("Document Type",BOLine."Document Type"::"Blanket Order");
        //BOLine.SETRANGE("Document No.",p_PFI_Line."Blanket Order No");
        //BOLine.SETRANGE("No.",p_PFI_Line."No.");
        //IF BOLine.FINDFIRST THEN
        //  lrec_PurchLn.VALIDATE("Blanket Order Line No.",BOLine."Line No.");
        //IF (lrec_PurchLn.Type = lrec_PurchLn.Type::"Charge (Item)") THEN
        //  lrec_PurchLn.VALIDATE("Direct Unit Cost",p_PFI_Line."Unit Price");
        //lrec_PurchLn.MODIFY(TRUE);

        //IF (lrec_PurchLn.Type = lrec_PurchLn.Type::Item) THEN BEGIN
        //  //HEI.02>>
        //  //HEI.03>>
        //  //IF (lrec_PFILne."Direct Multiplier of BO" <> 0) THEN
        //  IF (p_PFI_Line."Direct Multiplier of BO" <> 0) THEN
        //  //HEI.03<<
        //    lrec_PurchLn.VALIDATE(Quantity,p_PFI_Line.Quantity * p_PFI_Line."Direct Multiplier of BO")
        //  ELSE
        //  //HEI.02<<
        //    lrec_PurchLn.VALIDATE(Quantity,p_PFI_Line.Quantity);
        //  //HEI.02>>
        //  //HEI.03>>
        //  //IF (lrec_PFILne."Direct Multiplier of BO" <> 0) THEN BEGIN
        //  IF (p_PFI_Line."Direct Multiplier of BO" <> 0) THEN BEGIN
        //  //HEI.03<<
        //    lrec_PurchLn."Direct Unit Cost" := p_PFI_Line."Unit Price" / p_PFI_Line."Direct Multiplier of BO";
        //    lrec_PurchLn."Item Charge Value" := p_PFI_Line."Unit Price" / p_PFI_Line."Direct Multiplier of BO";
        //    lrec_PurchLn.VALIDATE("Direct Unit Cost");
        //  END ELSE BEGIN
        //  //HEI.02<<
        //    lrec_PurchLn."Direct Unit Cost" := p_PFI_Line."Unit Price";
        //    lrec_PurchLn."Item Charge Value" := p_PFI_Line."Unit Price";
        //    lrec_PurchLn.VALIDATE("Direct Unit Cost");
        //  END;
        //  lrec_PurchLn.MODIFY;
        //END;
        if (lrec_PurchLn.Type <> lrec_PurchLn.Type::" ") then begin
            //lrec_PurchLn.VALIDATE(Quantity,p_PFI_Line.Quantity);
            lrec_PurchLn."Direct Unit Cost" := p_PFI_Line."Unit Price";
            //  lrec_PurchLn."Item Charge Value" := p_PFI_Line."Unit Price";//Bc Upgrade SHARMP16--Drink-It field
            lrec_PurchLn.VALIDATE("Direct Unit Cost");
            lrec_PurchLn.MODIFY();
            //HEI.14>>
            //END;
        end else
            lrec_PurchLn.MODIFY(true);
        //HEI.14<<
        //HEI.10<<

        if lrec_PurchHdrAdditional.GET(lrec_PurchLn."Document Type"::Order, lrec_PurchLn."Document No.") then
            if (lrec_PurchHdrAdditional."Import Identifier") and (lrec_PurchLn.Type = lrec_PurchLn.Type::Item) then begin
                if (PurchSetup."Location Code Imp Proc. FND" <> '') then begin
                    lrec_PurchLn."Location Code" := PurchSetup."Location Code Imp Proc. FND";
                    lrec_PurchLn.MODIFY(true);
                end;
            end else
                lrec_PurchLn."Location Code" := p_PFI_Line."Location Code";

        if lrec_PFILne.GET(p_PFI_Line."PFI Document No.", p_PFI_Line."Line No") then begin
            lrec_PFILne."PO Number" := lrec_PurchLn."Document No.";
            lrec_PFILne.MODIFY();
        end;
        //HEI.01<<
        //HEI.04>>
        GlobalPONo := lrec_PFILne."PO Number";
        //HEI.04<<
    end;

    local procedure ComparePFIPricewithContract(precPFIHeader: Record "PFI Header INT"): Boolean;
    var
        lrecPFILines: Record "PFI Lines FND";
        TxtPFIPriceChk: Label 'There is a price difference between contract and PFI for the Item - %1.';
        NoContractLn: Label 'There is no line with Item Type having contract';
    begin
        //HEI.10>>
        // //HEI.04>>
        // lrecPFILines.RESET;
        // lrecPFILines.SETRANGE("PFI Document No.",precPFIHeader."PFI Document No.");
        // lrecPFILines.SETRANGE(Type,lrecPFILines.Type::Item);
        // lrecPFILines.SETFILTER("Blanket Order No",'<>%1','');
        // IF lrecPFILines.FINDSET THEN BEGIN REPEAT
        //  IF (lrecPFILines."Unit Price" <> lrecPFILines."Price from Blanket Order") THEN
        //    //HEI.05>>
        //    //ERROR(TxtPFIPriceChk);
        //    ERROR(TxtPFIPriceChk,lrecPFILines."No.");
        //    //HEI.05<<
        //  UNTIL lrecPFILines.NEXT = 0;
        //  EXIT(TRUE);
        // END ELSE
        //  ERROR(NoContractLn);
        // //HEI.04<
        //HEI.10<<
    end;

    local procedure PFIDateValiditywithContract(PFILines: Record "PFI Lines FND");
    var
        PurchaseHeaderBO: Record "Purchase Header";
        PFIHeader: Record "PFI Header INT";
        TextError50000: Label 'The to be Document Date - %1 of the Purchase Order does not fall between the range of contract start date - %2 and end date - %3';
    begin
        //HEI.06>>
        if PurchaseHeaderBO.GET(PurchaseHeaderBO."Document Type"::"Blanket Order", PFILines."Blanket Order No") then begin
            if PFILines.Type = PFILines.Type::Item then begin
                if (WORKDATE() < PurchaseHeaderBO."Valid From FND") or (WORKDATE() > PurchaseHeaderBO."Valid To FND") then
                    ERROR(TextError50000, TODAY, PurchaseHeaderBO."Valid From FND", PurchaseHeaderBO."Valid To FND");
            end;
        end;
        //HEI.06<<
    end;
    //BC Upgrade SHARMP16 begin>> -- Drink-IT code
    // local procedure DeleteShippingCostLines(PONumber: Code[20]);
    // var
    //     DocumentShippingCost: Record "Document Shipping Cost";
    // begin
    //     //HEI.16>>
    //     DocumentShippingCost.RESET;
    //     DocumentShippingCost.SETRANGE("Source No.", PONumber);
    //     DocumentShippingCost.SETRANGE("Source Type", 38);
    //     DocumentShippingCost.SETFILTER("Unit Cost", '%1', 0);
    //     if DocumentShippingCost.FINDSET then
    //         repeat
    //             DocumentShippingCost.DELETE;
    //         until DocumentShippingCost.NEXT = 0;
    //HEI.16<<
    // end;//BC Upgrade SHARMP16 end<< -- Drink-IT code
}

