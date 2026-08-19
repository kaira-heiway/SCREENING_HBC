namespace BC_DTWLocal.BC_DTWLocal;
using Microsoft.Inventory.Costing;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Inventory.Posting;
using ALProject.ALProject;
using Microsoft.Inventory.Setup;
using Microsoft.Inventory.Ledger;

codeunit 54012  "Inventory Posting To G/L_DTW"
{
    //BC Upgrade Kamnay01 Created this new Cu for Revaluation Journal error log. FDD- FDD-DTW-031 
    // DITW15.00.00.01 DDR 29/01/2008 Added function GetGLReg(),SetGLReg()

    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules

    // DITW15.00.00.19 DDR 04/04/2008 Certification rules

    // DITW15.00.00.35 DDR 07/08/2009 issue 757 remove call function SetGLReg()

    // DITW16.00.00.40 - PRODW16.00.00.08.19 DDR 17/01/2012 DIT-715 #189

    //                                  Modified function to Allow WIP Acc. from components (or other)

    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 19.12.2018 # Counterpoint Interface

    //   # When Counterpoint Purchases and RTV's are posted "Purchase Account" needs to be used instead of "Direct Cost Applied Account"

    //   # "Interface Code" and "CP Vendor Invoice No." should flow to GL Entry

    // HEI.02 RFC-CHG0270789 IBM.LS 19.02.2019

    //   # Code added to calculate the Output for correct Account.

    // HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # VAT Centime - part 2 - Purchases

    //   # Code added

    // HEI.04 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite

    //   # Code change to skip dimension combination validation if the entry is created from Sales document and if the setup is true

    // HEI.05 CHG2187702 SAHAL01 18.09.2023 Revaluation journal items in error

    //   # Added Code

    var

        ItemJnlLineError: Record "Item Journal Line";
        CreateLog: Boolean;
        GCalledFromItemPosting: Boolean;
        GCalledFromTestReport: Boolean;// BC Upgrade YADAVM09 - Declared global variable << codeunit 5802

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Inventory Posting To G/L", 'OnBeforeBufferInvtPosting', '', true, true)]
    local procedure OnBeforeBufferInvtPosting(var ValueEntry: Record "Value Entry"; var Result: Boolean; var IsHandled: Boolean; RunOnlyCheck: Boolean; CalledFromTestReport: Boolean)
    var
        ItemJnlLineL: Record "Item Journal Line";
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
    begin
        //HEI.05>>
        //HEI.20>>
        //HEI.05>>
        if InventorySetupL.Get then
            if ValueEntry."Rev. Jnl. Error Log FND" then
                IF ItemJnlLineL.GET('REVAL', ValueEntry."Journal Batch Name", ValueEntry."Line No. FND") THEN
                    GetItemJnlLine(ItemJnlLineL);
    END;
    //HEI.05<<

    //HEI.05<<


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Inventory Posting To G/L", 'OnBeforeGetInvtPostSetup', '', true, true)]
    local procedure OnBeforeGetInvtPostSetup(var InventoryPostingSetup: Record "Inventory Posting Setup"; var LocationCode: Code[10]; InventoryPostingGroup: Code[20]; var GenPostingSetup: Record "General Posting Setup"; var IsHandled: Boolean; var InvtPostingBuffer: Record "Invt. Posting Buffer")
    var
        ErrorTextL: Text[250];
        HBCUpgrade: Codeunit "Item Jnl.-Post Batch _DTW";
        Text011: Label 'The %1 does not exist. Identification fields and values: %2 - %3 and %4 - %5.';
    BEGIN
        if InvtPostingBuffer.UseInvtPostSetup() then begin
            if GCalledFromItemPosting then
                InventoryPostingSetup.Get(InvtPostingBuffer."Location Code", InvtPostingBuffer."Inventory Posting Group")
            else
                if not InventoryPostingSetup.Get(InvtPostingBuffer."Location Code", InvtPostingBuffer."Inventory Posting Group") then begin
                    IsHandled := true;//Bc Upgrade YADAVM09 condtion added to handle exit.
                    exit;
                end;
        end else begin
            if GCalledFromItemPosting then
                //HEI.05>>
                IF CreateLog AND (NOT GenPostingSetup.GET(InvtPostingBuffer."Gen. Bus. Posting Group", InvtPostingBuffer."Gen. Prod. Posting Group")) THEN BEGIN
                    ErrorTextL := COPYSTR(STRSUBSTNO(Text011, GenPostingSetup.TABLECAPTION,
                      InvtPostingBuffer.FIELDCAPTION("Gen. Bus. Posting Group"), InvtPostingBuffer."Gen. Bus. Posting Group",
                        InvtPostingBuffer.FIELDCAPTION("Gen. Prod. Posting Group"), InvtPostingBuffer."Gen. Prod. Posting Group"), 1, 250);
                    HBcUpgrade.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                    CLEAR(ErrorTextL);
                END ELSE
                    //HEI.05<<
                    GenPostingSetup.Get(InvtPostingBuffer."Gen. Bus. Posting Group", InvtPostingBuffer."Gen. Prod. Posting Group")
            else
                if not GenPostingSetup.Get(InvtPostingBuffer."Gen. Bus. Posting Group", InvtPostingBuffer."Gen. Prod. Posting Group") then begin
                    IsHandled := true;//Bc Upgrade YADAVM09 condtion added to handle exit.
                    exit;
                end;

            if not GCalledFromItemPosting then
                GenPostingSetup.TestField(Blocked, false);
        END;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Inventory Posting To G/L", 'OnAfterSetRunOnlyCheck', '', true, true)]
    local procedure OnAfterSetRunOnlyCheck(CalledFromItemPosting: Boolean; RunOnlyCheck: Boolean; CalledFromTestReport: Boolean)
    var
    begin
        GCalledFromItemPosting := CalledFromItemPosting;
        GCalledFromTestReport := CalledFromTestReport;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Inventory Posting To G/L", 'OnBeforeSetAccNo', '', true, true)]
    local procedure OnBeforeSetAccNo(var InvtPostBuf: Record "Invt. Posting Buffer"; ValueEntry: Record "Value Entry"; AccType: Option; BalAccType: Option; CalledFromItemPosting: Boolean; var IsHandled: Boolean)
    var
        ErrorTextL: Text[250];
        ItemJnlLineL: Record "Item Journal Line";
        HBCUpgrade: Codeunit "Item Jnl.-Post Batch _DTW";
        ItemJnlPostBatchL: Codeunit "Item Jnl.-Post Batch";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        GenPostingSetup: Record "General Posting Setup";
        ItemL: Record Item;
        Text011: Label 'The %1 does not exist. Identification fields and values: %2 - %3 and %4 - %5.';
        Text012: Label '%1 must have a value in %2: %3 - %4 and %5 - %6. It cannot be zero or empty.';
    begin

        InventoryPostingSetup.Get(InvtPostBuf."Location Code", InvtPostBuf."Inventory Posting Group");//BCUpgrade sharmp16--PurchaseProcesstestchanges

        IF ItemJnlLineL.GET('REVAL', ValueEntry."Journal Batch Name", ValueEntry."Line No. FND") THEN
            GetItemJnlLine(ItemJnlLineL);
        //HEI.05>>
        IF CreateLog AND (NOT GenPostingSetup.GET(InvtPostBuf."Gen. Bus. Posting Group", InvtPostBuf."Gen. Prod. Posting Group")) THEN BEGIN
            ErrorTextL := COPYSTR(STRSUBSTNO(Text011, GenPostingSetup.TABLECAPTION,
              InvtPostBuf.FIELDCAPTION("Gen. Bus. Posting Group"), InvtPostBuf."Gen. Bus. Posting Group",
                InvtPostBuf.FIELDCAPTION("Gen. Prod. Posting Group"), InvtPostBuf."Gen. Prod. Posting Group"), 1, 250);
            HBCUpgrade.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
            CLEAR(ErrorTextL);
        END ELSE
            //HEI.05<<
            GenPostingSetup.Get(InvtPostBuf."Gen. Bus. Posting Group", InvtPostBuf."Gen. Prod. Posting Group");//BCUpgrade sharmp16--PurchaseProcesstestchanges
        case InvtPostBuf."Account Type" of
            InvtPostBuf."Account Type"::Inventory:
                if CalledFromItemPosting then Begin
                    InventoryPostingSetup.Get(InvtPostBuf."Location Code", InvtPostBuf."Inventory Posting Group");  // BC Upgrade SHUKLP03 <<
                    InvtPostBuf."Account No." := InventoryPostingSetup.GetInventoryAccount()
                end else
                    InvtPostBuf."Account No." := InventoryPostingSetup."Inventory Account";
            InvtPostBuf."Account Type"::"Inventory (Interim)":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := InventoryPostingSetup.GetInventoryAccountInterim()
                else
                    InvtPostBuf."Account No." := InventoryPostingSetup."Inventory Account (Interim)";
            InvtPostBuf."Account Type"::"WIP Inventory":
                begin //Bc Upgrade YADAVM09 
                    if CalledFromItemPosting then
                        InvtPostBuf."Account No." := InventoryPostingSetup.GetWIPAccount()
                    else
                        InvtPostBuf."Account No." := InventoryPostingSetup."WIP Account";
                    //HEI.02>>
                    IF (ValueEntry."Item No." <> '') AND
                      (ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Output)
                    THEN BEGIN
                        ItemL.GET(ValueEntry."Item No.");
                        IF ItemL."Costing Method" = ItemL."Costing Method"::Standard THEN BEGIN
                            IF InventoryPostingSetup."Apply WIP Consumption FND" THEN
                                InvtPostBuf."Account No." := InventoryPostingSetup."WIP Consumption FND";
                        END;
                    END;
                    //HEI.02<<

                end;//Bc Upgrade YADAVM09
            InvtPostBuf."Account Type"::"Material Variance":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := InventoryPostingSetup.GetMaterialVarianceAccount()
                else
                    InvtPostBuf."Account No." := InventoryPostingSetup."Material Variance Account";
            InvtPostBuf."Account Type"::"Material - Non Inventory Variance":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := InventoryPostingSetup.GetMaterialNonInventoryVarianceAccount()
                else
                    InvtPostBuf."Account No." := InventoryPostingSetup."Mat. Non-Inv. Variance Acc.";
            InvtPostBuf."Account Type"::"Capacity Variance":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := InventoryPostingSetup.GetCapacityVarianceAccount()
                else
                    InvtPostBuf."Account No." := InventoryPostingSetup."Capacity Variance Account";
            InvtPostBuf."Account Type"::"Subcontracted Variance":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := InventoryPostingSetup.GetSubcontractedVarianceAccount()
                else
                    InvtPostBuf."Account No." := InventoryPostingSetup."Subcontracted Variance Account";
            InvtPostBuf."Account Type"::"Cap. Overhead Variance":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := InventoryPostingSetup.GetCapOverheadVarianceAccount()
                else
                    InvtPostBuf."Account No." := InventoryPostingSetup."Cap. Overhead Variance Account";
            InvtPostBuf."Account Type"::"Mfg. Overhead Variance":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := InventoryPostingSetup.GetMfgOverheadVarianceAccount()
                else
                    InvtPostBuf."Account No." := InventoryPostingSetup."Mfg. Overhead Variance Account";
            InvtPostBuf."Account Type"::"Inventory Adjmt.":
                begin//Bc Upgrade YADAVM09
                    GetItemJnlLine(ItemJnlLineL);
                    if CalledFromItemPosting then
                        //HEI.05>>

                        IF CreateLog AND (GenPostingSetup."Inventory Adjmt. Account" = '') THEN BEGIN
                            ErrorTextL := COPYSTR(STRSUBSTNO(Text012, GenPostingSetup.FIELDCAPTION("Inventory Adjmt. Account"),
                              GenPostingSetup.TABLECAPTION, InvtPostBuf.FIELDCAPTION("Gen. Bus. Posting Group"), InvtPostBuf."Gen. Bus. Posting Group",
                                InvtPostBuf.FIELDCAPTION("Gen. Prod. Posting Group"), InvtPostBuf."Gen. Prod. Posting Group"), 1, 250);
                            HBcUpgrade.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                            CLEAR(ErrorTextL);
                        END ELSE Begin
                            //HEI.05<<
                            GenPostingSetup.Get(InvtPostBuf."Gen. Bus. Posting Group", InvtPostBuf."Gen. Prod. Posting Group"); // BC Upgrace SHUKLP03 <<
                            InvtPostBuf."Account No." := GenPostingSetup.GetInventoryAdjmtAccount()
                        end
                    else
                        InvtPostBuf."Account No." := GenPostingSetup."Inventory Adjmt. Account";
                end;//Bc Upgrade YADAVM09
            InvtPostBuf."Account Type"::"Direct Cost Applied":
                begin//Bc Upgrade YADAVM09
                    if CalledFromItemPosting then
                        InvtPostBuf."Account No." := GenPostingSetup.GetDirectCostAppliedAccount();
                    //BC Upgrade YADAVM09 Event craeted for Interface code>>
                    OnBeforeSetAccNoInterfaceCode(InvtPostBuf, ValueEntry, CalledFromItemPosting, GenPostingSetup);
                    //BC Upgrade YADAVM09 Event craeted for Interface code<<
                end;//Bc Upgrade YADAVM09
            InvtPostBuf."Account Type"::"Direct Cost Non-Inventory Applied":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := GenPostingSetup.GetDirectCostNonInvtAppliedAccount()
                else
                    InvtPostBuf."Account No." := GenPostingSetup."Direct Cost Non-Inv. App. Acc.";
            InvtPostBuf."Account Type"::"Overhead Applied":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := GenPostingSetup.GetOverheadAppliedAccount()
                else
                    InvtPostBuf."Account No." := GenPostingSetup."Overhead Applied Account";
            InvtPostBuf."Account Type"::"Purchase Variance":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := GenPostingSetup.GetPurchaseVarianceAccount()
                else
                    InvtPostBuf."Account No." := GenPostingSetup."Purchase Variance Account";
            InvtPostBuf."Account Type"::COGS:
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := GenPostingSetup.GetCOGSAccount()
                else
                    InvtPostBuf."Account No." := GenPostingSetup."COGS Account";
            InvtPostBuf."Account Type"::"COGS (Interim)":
                if CalledFromItemPosting then begin
                    GetItemJnlLine(ItemJnlLineL);
                    //HEI.05>>
                    IF CreateLog AND (GenPostingSetup."COGS Account (Interim)" = '') THEN BEGIN
                        ErrorTextL := COPYSTR(STRSUBSTNO(Text012, GenPostingSetup.FIELDCAPTION(GenPostingSetup."COGS Account (Interim)"),
                          GenPostingSetup.TABLECAPTION, InvtPostBuf.FIELDCAPTION("Gen. Bus. Posting Group"), InvtPostBuf."Gen. Bus. Posting Group",
                            InvtPostBuf.FIELDCAPTION("Gen. Prod. Posting Group"), InvtPostBuf."Gen. Prod. Posting Group"), 1, 250);
                        HBCUpgrade.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                        CLEAR(ErrorTextL);
                    END ELSE
                        //HEI.05<<
                        if CalledFromItemPosting then
                            InvtPostBuf."Account No." := GenPostingSetup.GetCOGSInterimAccount()
                        else
                            InvtPostBuf."Account No." := GenPostingSetup."COGS Account (Interim)";
                end;
            InvtPostBuf."Account Type"::"Invt. Accrual (Interim)":
                if CalledFromItemPosting then
                    InvtPostBuf."Account No." := GenPostingSetup.GetInventoryAccrualAccount()
                else
                    InvtPostBuf."Account No." := GenPostingSetup."Invt. Accrual Acc. (Interim)";
        end;


        OnSetAccNoOnBeforeCheckAccNo(InvtPostBuf, InventoryPostingSetup, GenPostingSetup, CalledFromItemPosting, ValueEntry);
        CheckAccNo(InvtPostBuf."Account No.", CalledFromItemPosting);

        OnAfterSetAccNo(InvtPostBuf, ValueEntry, CalledFromItemPosting);

        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Inventory Posting To G/L", 'OnPostInvtPostBufOnBeforeSetAmt', '', true, true)]
    local procedure OnPostInvtPostBufOnBeforeSetAmt(var GenJournalLine: Record "Gen. Journal Line"; var ValueEntry: Record "Value Entry"; var GlobalInvtPostingBuffer: Record "Invt. Posting Buffer")
    var
    begin
        //HEI.05>>
        IF ValueEntry."Rev. Jnl. Error Log FND" THEN BEGIN
            GenJournalLine."Rev. Jnl. Error Log FND" := TRUE;
            GenJournalLine."Item Journal Template Name FND" := ValueEntry."Journal Template Name FND";
            GenJournalLine."Item Journal Batch Name FND" := ValueEntry."Journal Batch Name";
            GenJournalLine."Item Journal Line No. FND" := ValueEntry."Line No. FND";
        END;
        //HEI.05<<
    end;

    local procedure CheckAccNo(var AccountNo: Code[20]; CalledFromItemPosting: Boolean)
    var
        GLAccount: Record "G/L Account";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckGLAcc(AccountNo, CalledFromItemPosting, IsHandled);
        if IsHandled then
            exit;

        if AccountNo = '' then
            exit;

        GLAccount.Get(AccountNo);
        if GLAccount.Blocked then begin
            if CalledFromItemPosting then
                GLAccount.TestField(Blocked, false);
            if not gCalledFromTestReport then
                AccountNo := '';
        end;
    end;


    procedure GetItemJnlLine(VAR ItemJournalLine: Record "Item Journal Line")
    Var
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
    begin
        //HEI.05>>
        CLEAR(ItemJnlLineError);
        CLEAR(CreateLog);
        IF InventorySetupL.GET THEN BEGIN
            IF InventorySetupL."Activate Rev.Jnl.Error Log FND" THEN BEGIN
                IF ItemJnlTemplateL.GET(ItemJournalLine."Journal Template Name") THEN BEGIN
                    IF ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation THEN BEGIN
                        ItemJnlLineError.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                        ItemJnlLineError.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        ItemJnlLineError.SETRANGE("Line No.", ItemJournalLine."Line No.");
                        IF ItemJnlLineError.FINDFIRST THEN;
                        CreateLog := TRUE;
                    END;
                END;
            END;
        END;
    End;
    //HEI.05<<

    [IntegrationEvent(false, false)]
    local procedure OnSetAccNoOnBeforeCheckAccNo(var InvtPostBuf: Record "Invt. Posting Buffer"; InvtPostingSetup: Record "Inventory Posting Setup"; GenPostingSetup: Record "General Posting Setup"; CalledFromItemPosting: Boolean; var ValueEntry: Record "Value Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetAccNo(var InvtPostingBuffer: Record "Invt. Posting Buffer"; ValueEntry: Record "Value Entry"; CalledFromItemPosting: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetAccNoInterfaceCode(var InvtPostingBuffer: Record "Invt. Posting Buffer"; ValueEntry: Record "Value Entry"; CalledFromItemPosting: Boolean; GenPostingSetup: Record "General Posting Setup")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckGLAcc(var AccountNo: Code[20]; CalledFromItemPosting: Boolean; var IsHandled: Boolean)
    begin
    end;
    // BC Upgrade YADAVM09 << codeunit "Inventory Posting to G/L - id - 5802 <<
}
