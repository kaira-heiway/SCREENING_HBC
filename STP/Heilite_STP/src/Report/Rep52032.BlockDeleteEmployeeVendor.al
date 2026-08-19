report 52032 "Block Delete Employee Vendor"
{
    // version HEI.02

    // HEI.01 CHG2237281 CC-INC5016654 IBM MAJUMS03 27.02.2024 # Block and Flag for deletion on Baru Panama Vendors Y007
    //   # This report is used for two purpose. First purpose is to Block Employee Vendors(Vendor Type = Y007). Second purpose is to Delete
    //   Employee Vendors(Vendor Type = Y007). Employee Vendors not coming from Mendix.
    //   # OnDelVendCheck Function is copied from OnDelete() Trigger of Vendor Table. In OnDelete() Trigger of Vendor Delete True is called for
    //   for Dimension Value Table (Drink IT Code), taking 40 to 50 sec to Delete one Vendor, OPCO want to Delete 1500 Employee Vendors which do
    //   not have any transaction and Blocked:: All and "Global Flag For Deletion Indicator" = TRUE. As a result system will take a very long
    //   time to Delete a huge no of Vendors. This Deletion only done after proper checking and against a RFF+. It is only applicable for Employee
    //   Vendor(Y007), Blocked: All and "Global Flag For Deletion Indicator" = TRUE.ZycusMasterTimestamp.UpdateZycusMaterTimestamp is excluded as
    //   Zycus Interface Object is not deployed in Production till now.
    // 
    // HEI.02 CHG2237281 CC-INC5016654 IBM MAJUMS03 07.03.2024 # Block and Flag for deletion on Baru Panama Vendors Y007
    //   # Remove Global Variable ZycusMasterTimestamp, as Zycus is not Go Live

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Add layout path and change layout extension rdlc to rdl.
    // 3. "Item Cross Reference" is absolete using "Item Refrence" in Place of  "Item Cross Reference".
    // 4. Table-871 “Social Listening Search Topic” discontinued in BC, commented related code.
    // 5. Commented Drink-IT Tables related code.
    // 6. Added Single quote for vendor filter- Y007 to resolve compilation error 
    // 7. Old Report ID- 50567
    //BC Upgrade KAPOOV01  <<

    ProcessingOnly = true;  //BC Upgrade KAPOOV01
    ApplicationArea = All;  //BC Upgrade KAPOOV01

    DefaultLayout = RDLC;
    //RDLCLayout = './Block Delete Employee Vendor.rdlc'; //BC Upgrade KAPOOV01 Commented.
    RDLCLayout = '.\src\ReportsLayout\Block Delete Employee Vendor.rdl'; //BC Upgrade KAPOOV01 Added.

    Permissions = TableData Vendor = rmd;

    dataset
    {
        dataitem(VendorList; Vendor)
        {
            //BC Upgrade KAPOOV01 added Single quote for vendor filter- Y007 to resolve compilation error >>
            //DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Vendor Type" = FILTER(Y007));  //BC Upgrade KAPOOV01 Commented.
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Vendor Type FND" = FILTER('Y007'));  //BC Upgrade KAPOOV01 Added.
            //BC Upgrade KAPOOV01 added Single quote for vendor filter- Y007 to resolve compilation error <<
            RequestFilterFields = "No.";
            column(No_Vendor; VendorList."No.")
            {
            }
            column(Name_Vendor; VendorList.Name)
            {
            }
            column(Name2_Vendor; VendorList."Name 2")
            {
            }
            column(VendorType_Vendor; VendorList."Vendor Type FND")
            {
            }

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                if Type = Type::"Delete Vendor" then begin
                    if ConfirmProcess then begin
                        OnDelVendCheck();
                        if not (VendorList.Blocked in [VendorList.Blocked::All]) then
                            ERROR(EText003, VendorList."No.");
                        if not (VendorList."Global Delete FND") then
                            ERROR(EText004, VendorList."No.");
                        VendorList.DELETE();
                    end;
                end else if Type = Type::"Block Vendor" then begin
                    if ConfirmProcess then begin
                        VendorList.Blocked := VendorList.Blocked::All;
                        VendorList."Global Delete FND" := true;
                        VendorList.MODIFY(true);
                    end;
                end;
                //HEI.01<<
            end;

            trigger OnPostDataItem();
            begin
                //HEI.01>>
                if GUIALLOWED then
                    MESSAGE(Text001);
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                if Type = Type::" " then
                    ERROR(EText001)
                else begin
                    if VendorList.GETFILTER("No.") = '' then
                        ERROR(EText002)
                end;
                //HEI.01<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Confirm Process"; ConfirmProcess)
                {
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
        Type: Option " ","Block Vendor","Delete Vendor";
        ConfirmProcess: Boolean;
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        MoveEntries: Codeunit MoveEntries;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CommentLine: Record "Comment Line";
        //ItemCrossReference: Record "Item Cross Reference";  //BC Upgrade KAPOOV01 "Item Cross Reference" is absolete using "Item Refrence" in Place of  "Item Cross Reference".
        ItemReference: Record "Item Reference"; // Bc Upgrade KAPOOV01 "Item Cross Reference" is absolete using "Item Refrence" in the Place of "Item Cross Reference".
        ServiceItem: Record "Service Item";
        Text000: TextConst ENU = 'You cannot delete Vendor %1 because there is at least one outstanding Purchase %2 for this vendor.', FRA = 'Vous ne pouvez pas supprimer %1 %2 car il existe encore au moins une %3 achat ouverte pour ce fournisseur.';
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        rDim: Record Dimension;
        rDimValue: Record "Dimension Value";
        Text001: Label 'Process Completed.';
        EText001: Label 'Type cannot be blank in Request Page.';
        EText002: Label 'Please provide the Vendor No. in Request Page.';
        EText003: TextConst ENU = 'Vendor is not Blocked=All for Vendor No. %1';
        EText004: TextConst ENU = 'Vendor is not Global Flag for Deletion = TRUE for Vendor No. %1';
        EText005: Label 'Vendor ledger exists fo Vendor No.  %1';
        VendLedgEntry: Record "Vendor Ledger Entry";

    local procedure OnDelVendCheck();
    var
        ItemVendor: Record "Item Vendor";
        PurchPrice: Record "Purchase Price";
        PurchLineDiscount: Record "Purchase Line Discount";
        PurchPrepmtPct: Record "Purchase Prepayment %";
        //SocialListeningSearchTopic: Record "Social Listening Search Topic";  // BC Upgrade KAPOOV01- Table-871 “Social Listening Search Topic” discontinued in BC, commented related code.
        CustomReportSelection: Record "Custom Report Selection";
        PurchOrderLine: Record "Purchase Line";
        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
    //BC Upgrade KAPOOV01 Drink-IT Tables >>
    //PurchTaxItemCharge: Record "Purchase Tax Item Charge"; 
    //PurchDepositItemCharge: Record "Purchase Deposit Item Charge"; 
    // PurchDiscountItemCharge: Record "Purchase Discount Item Charge";
    // PurchPromotionItemCharge: Record "Purchase Promotion Item Charge";
    // DrinkDiscountRelation: Record "Drink Discount Relation";
    // DrinkPromotionRelaton: Record "Drink Promotion Relation";
    //BC Upgrade KAPOOV01 Drink-IT <<
    begin
        //HEI.01>>
        ApprovalsMgmt.OnCancelVendorApprovalRequest(VendorList);

        MoveEntries.MoveVendorEntries(VendorList);

        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Vendor);
        CommentLine.SETRANGE("No.", VendorList."No.");
        CommentLine.DELETEALL();

        VendBankAcc.SETRANGE("Vendor No.", VendorList."No.");
        VendBankAcc.DELETEALL();

        OrderAddr.SETRANGE("Vendor No.", VendorList."No.");
        OrderAddr.DELETEALL();

        //BC Upgrade KAPOOV01 "Item Cross Reference" is absolete using "Item Refrence" in Place of  "Item Cross Reference". >>
        // ItemCrossReference.SETCURRENTKEY("Cross-Reference Type", "Cross-Reference Type No.");
        // ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::Vendor);
        // ItemCrossReference.SETRANGE("Cross-Reference Type No.", VendorList."No.");
        // ItemCrossReference.DELETEALL;

        ItemReference.SETCURRENTKEY("Reference Type", "Reference Type No.");
        ItemReference.SETRANGE("Reference Type", ItemReference."Reference Type"::Vendor);
        ItemReference.SETRANGE("Reference Type No.", VendorList."No.");
        ItemReference.DELETEALL();
        //BC Upgrade KAPOOV01 "Item Cross Reference" is absolete using "Item Refrence" in Place of  "Item Cross Reference". <<

        PurchOrderLine.SETCURRENTKEY("Document Type", "Pay-to Vendor No.");
        PurchOrderLine.SETFILTER(
          "Document Type", '%1|%2',
          PurchOrderLine."Document Type"::Order,
          PurchOrderLine."Document Type"::"Return Order");
        PurchOrderLine.SETRANGE("Pay-to Vendor No.", VendorList."No.");
        if PurchOrderLine.FINDFIRST() then
            ERROR(
              Text000, VendorList."No.",
              PurchOrderLine."Document Type");
        PurchOrderLine.SETRANGE("Pay-to Vendor No.");
        PurchOrderLine.SETRANGE("Buy-from Vendor No.", VendorList."No.");
        if not PurchOrderLine.ISEMPTY then
            ERROR(
              Text000,
              VendorList."No.", PurchOrderLine."Document Type");

        UpdateContFromVend.OnDelete(VendorList);

        DimMgt.DeleteDefaultDim(DATABASE::Vendor, VendorList."No.");

        ServiceItem.SETRANGE("Vendor No.", VendorList."No.");
        ServiceItem.MODIFYALL("Vendor No.", '');

        ItemVendor.SETRANGE("Vendor No.", VendorList."No.");
        ItemVendor.DELETEALL(true);
        // BC Upgrade KAPOOV01- Table-871 “Social Listening Search Topic” discontinued in BC. >>
        // if not SocialListeningSearchTopic.ISEMPTY then begin
        //     SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Vendor, VendorList."No.");
        //     SocialListeningSearchTopic.DELETEALL;
        // end;
        // BC Upgrade KAPOOV01- Table-871 “Social Listening Search Topic” discontinued in BC. <<

        PurchPrice.SETCURRENTKEY("Vendor No.");
        PurchPrice.SETRANGE("Vendor No.", VendorList."No.");
        PurchPrice.DELETEALL(true);

        PurchLineDiscount.SETCURRENTKEY("Vendor No.");
        PurchLineDiscount.SETRANGE("Vendor No.", VendorList."No.");
        PurchLineDiscount.DELETEALL(true);

        CustomReportSelection.SETRANGE("Source Type", DATABASE::Vendor);
        CustomReportSelection.SETRANGE("Source No.", VendorList."No.");
        CustomReportSelection.DELETEALL();

        PurchPrepmtPct.SETCURRENTKEY("Vendor No.");
        PurchPrepmtPct.SETRANGE("Vendor No.", VendorList."No.");
        PurchPrepmtPct.DELETEALL(true);

        //BC Upgrade KAPOOV01 Drink-IT >>
        // <<DITW15.00.00.23 DDR 01/08/2008
        // PurchTaxItemCharge.SETRANGE("Purchase Type", PurchTaxItemCharge."Purchase Type"::Vendor);
        // PurchTaxItemCharge.SETRANGE("Purchase Code", VendorList."No.");
        // PurchTaxItemCharge.DELETEALL;

        // PurchDepositItemCharge.SETRANGE("Purchase Type", PurchDepositItemCharge."Purchase Type"::Vendor);
        // PurchDepositItemCharge.SETRANGE("Purchase Code", VendorList."No.");
        // PurchDepositItemCharge.DELETEALL;

        // PurchDiscountItemCharge.SETRANGE("Purchase Type", PurchDiscountItemCharge."Purchase Type"::Vendor);
        // PurchDiscountItemCharge.SETRANGE("Purchase Code", VendorList."No.");
        // PurchDiscountItemCharge.DELETEALL;

        // PurchPromotionItemCharge.SETRANGE("Purchase Type", PurchPromotionItemCharge."Purchase Type"::Vendor);
        // PurchPromotionItemCharge.SETRANGE("Purchase Code", VendorList."No.");
        // PurchPromotionItemCharge.DELETEALL;

        // DrinkDiscountRelation.SETRANGE("Source Type", DrinkDiscountRelation."Source Type"::Vendor);
        // DrinkDiscountRelation.SETRANGE("Source No.", VendorList."No.");
        // DrinkDiscountRelation.DELETEALL;

        // DrinkPromotionRelaton.SETRANGE("Source Type", DrinkPromotionRelaton."Source Type"::Vendor);
        // DrinkPromotionRelaton.SETRANGE("Source No.", VendorList."No.");
        // DrinkPromotionRelaton.DELETEALL;
        // >>DITW15.00.00.23 DDR
        //BC Upgrade KAPOOV01 Drink-IT <<

        VATRegistrationLogMgt.DeleteVendorLog(VendorList);

        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089

        PurchSetup.GET();
        //BC Upgrade KAPOOV01 Drink-IT Code block dependent on Drink-IT field-PurchSetup."Vendor Auto Dimension Code" >>
        // if (PurchSetup."Vendor Auto Dimension Code" <> '') then begin
        //     if rDimValue.GET(PurchSetup."Vendor Auto Dimension Code", VendorList."No.") then
        //         rDimValue.DELETE;
        // end;
        //BC Upgrade KAPOOV01 Drink-IT Code block dependent on Drink-IT field-PurchSetup."Vendor Auto Dimension Code" <<

        // VendLedgEntry.RESET();
        // VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date", "Currency Code");
        // VendLedgEntry.SETRANGE(VendLedgEntry."Vendor No.", VendorList."No.");
        // if VendLedgEntry.FINDFIRST() then
        //     ERROR(EText005, VendorList."No.");

        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089

        //HEI.01<<
    end;
}

