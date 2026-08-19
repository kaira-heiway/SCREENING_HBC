namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.Document;

using System.Automation;
using System.Utilities;
using System.Security.User;
using Microsoft.Purchases.Setup;

pageextension 52002 PurchaseQuotesExt extends "Purchase Quotes"
{
    //     DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.2
    //                             Added field "Requester ID"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

    // HEI.01 CHG0255725 IBM GAVANM01 18.04.2019
    //   # Added field 'Payment User'
    // HEI.02 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Removed Field "Payment User"
    //   # Added Field “PQ Approver”
    //   # Created new Page Action "Purchase Additional"
    // HEI.03 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // BC Upgrade SHUKLP03 >>

    // Made base action(MakeOrder) visible false and created custom action(MakeOrderCustom).
    // On custom action(MakeOrderCustom) added whole code of codeunit "Purch.-Quote to Order (Yes/No)" because event and REC variable of event was not found on that to add code and also created events OnAfterCreatePurchOrder and OnBeforePurchQuoteToOrder.

    // BC Upgrade SHUKLP03 <<
    layout
    {
        //BC Upgrade SHARMP16>>  -- page formatting changes
        addafter(Status)
        {
            field("PQ Approver"; rec."PQ Approver FND")
            {
                ApplicationArea = all;
            }
            field("Fixed Asset Acquisition"; rec."Fixed Asset Acquisition FND")
            {
                Editable = false;
                ApplicationArea = all;
            }
        }
        //BC Upgrade SHARMP16<<  -- page formatting changes

    }
    actions
    {
        modify(MakeOrder)
        {
            Visible = false; // BC Upgrade SHUKLP03 << // Made base action(MakeOrder) visible false and created custom action(MakeOrderCustom).
        }
        //BC Upgrade SHARMP16>> ---- page formatting changes
        addafter(Approvals)
        {
            action("Purchase Additional")
            {

                ApplicationArea = all;
                Caption = 'Purchase Additional';
                Image = Purchase;
                RunObject = Page "Purchase Additional";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
            }
        }
        addafter(Approvals_Promoted)
        {
            actionref(PurchaseHeader_Additional; "Purchase Additional")
            {

            }
        }
        //BC Upgrade SHARMP16<< -- page formatting changes
        addbefore(Action12)
        {
            action(MakeOrderCustom)
            {
                ApplicationArea = Suite;
                Caption = 'Make &Order';
                Image = MakeOrder;
                ToolTip = 'Convert the purchase quote to a purchase order.';

                trigger OnAction()
                var
                    PurchasesPayablesSetup: Record "Purchases & Payables Setup";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    PurchasesUtils: Codeunit "Purchases-Utils";
                    ConfirmManagement: Codeunit "Confirm Management";
                    IsHandled: Boolean;

                    UserSetup: Record "User Setup";
                    ConvertQuoteToOrderQst: Label 'Do you want to convert the quote to an order?';
                    PurchOrderHeader: Record "Purchase Header";
                    Text001: TextConst ENU = 'Quote number %1 has been converted to order number %2. Location Code in lines is updated to %3', FRA = 'La demande de prix %1 a été transformée en commande %2.';
                    PurchQuoteToOrder: Codeunit "Purch.-Quote to Order";
                    OpenNewOrderQst: Label 'The quote has been converted to order number %1. Do you want to open the new order?', Comment = '%1 - No. of new purchase order.';
                    PQPOError: TextConst ENU = 'You are not allowed to convert Quotation into Order.';
                    Text000: TextConst ENU = 'Shipment method code is relevant for Import process. Do you want to convert the quote to an order?', FRA = 'Souhaitez-vous transformer la demande de prix en commande ?';
                    PQwithNoValue: TextConst ENU = 'There is some line with no value in PQ, its cannot be converted into PO.';
                //Text002: TextConst ENU = 'Do you want to convert the quote to an order?', FRA = 'Souhaitez-vous transformer la demande de prix en commande ?';
                begin
                    if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then begin
                        // BC Upgrade Shuklp03 >> Added below code of codeunit "Purch.-Quote to Order (Yes/No)" because event was not found on that to add below code.

                        PurchasesPayablesSetup.GET(); //HEI.01
                                                      //HEI.04>>
                        IF NOT PurchasesUtils.PQtoPOConditionCheck(Rec) OR NOT (Rec.PurchLinesExist()) THEN
                            ERROR(PQwithNoValue);
                        //HEI.04<<
                        //HEI.02>>
                        IF PurchasesPayablesSetup."Enable PQ to PO check FND" THEN BEGIN
                            UserSetup.GET(USERID);
                            //HEI.03>>
                            IF NOT UserSetup."Make PQ to PO FND" THEN
                                //IF UserSetup."Make PQ to PO" THEN
                                //HEI.03<<
                                ERROR(PQPOError);
                        END;
                        //HEI.02<<
                        Rec.TESTFIELD("Document Type", Rec."Document Type"::Quote);
                        //>>HEI.01
                        IF NOT PurchasesUtils.CheckShippingMethod(PurchasesPayablesSetup, Rec) THEN BEGIN
                            IF NOT CONFIRM(Text000, FALSE) THEN
                                EXIT
                        END ELSE Begin
                            if not ConfirmManagement.GetResponseOrDefault(ConvertQuoteToOrderQst, true) then
                                exit;
                        END;
                        IsHandled := false;
                        OnBeforePurchQuoteToOrder(Rec, IsHandled);
                        if IsHandled then
                            exit;

                        PurchQuoteToOrder.Run(Rec);
                        PurchQuoteToOrder.GetPurchOrderHeader(PurchOrderHeader);

                        IsHandled := false;
                        OnAfterCreatePurchOrder(PurchOrderHeader, IsHandled);
                        if not IsHandled then
                            //>> HEI.01
                            IF NOT PurchasesUtils.CheckShippingMethod(PurchasesPayablesSetup, Rec) THEN BEGIN
                                MESSAGE(
                                    Text001,
                                    Rec."No.", PurchOrderHeader."No.", PurchasesPayablesSetup."Location Code Imp Proc. FND");
                            END ELSE BEGIN
                                if ConfirmManagement.GetResponseOrDefault(StrSubstNo(OpenNewOrderQst, PurchOrderHeader."No."), true) then
                                    PAGE.Run(PAGE::"Purchase Order", PurchOrderHeader);

                                //CODEUNIT.Run(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec)
                                //<<HEI.01
                                // BC Upgrade Shuklp03 >> Added below code of codeunit "Purch.-Quote to Order (Yes/No)" because event was not found on that to add below code.

                            end;
                    end;

                end;
            }
        }

    }
    [IntegrationEvent(false, false)]
    local procedure OnAfterCreatePurchOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePurchQuoteToOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;


}
