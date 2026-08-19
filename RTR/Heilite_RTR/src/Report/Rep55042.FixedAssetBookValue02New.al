report 55042 "Fixed Asset - Book Value 02New"
{
    // version NAVW110.0,HEI.05

    // HEI.01 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Code added
    //   # New functions created "GetDeprBookInfo" and "GetDerogDeprBookInfo"
    // HEI.02  YADAVM05 09.03.2023 CHG2187935_HB3211 code added to skip CMG Mandatory check on report
    // HEI.03  YADAVM05 20.03.2023 CHG2187935_HB3211 code added to skip CMG Mandatory check on report
    // HEI.04  YADAVM05 29.03.2023 CHG2198032_HB3211 cChanging Documentation part from CHG2187935_HB3211 to CHG2198032_HB3211
    // HEI.05  YADAVM05 17.05.2023 CHG2198032_HB3211 CMG Code Mandatory Additional Ticket
    //  #Blocking code as this Part handled using Mandatory setup
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID- 5606.
    // 2. "In NAV, the 'Fixed Asset - Book Value 02' report was modified. However, it contained custom code tagged with 'HEI' that didn't correspond to any events also there are many changes in layout, and this is not possible by report extension. To address this, I created a copy of the report and replaced the original report with a substitute event."
    // 3. Add layout path and change layout extension rdlc to rdl.
    // 4. Remove French Localization Fields and related code(Derogatory,"Derogatory Calculation")
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Fixed Asset - Book Value 02.rdl';

    Caption = 'Fixed Asset - Book Value 02';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
            column(MainHeadLineText; MainHeadLineText)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(DeprBookText; DeprBookText)
            {
            }
            column(GroupCodeName; GroupCodeName)
            {
            }
            column(FixedAssetCaptionFilter; TABLECAPTION + ': ' + FAFilter)
            {
            }
            column(FAFilter; FAFilter)
            {
            }
            column(No_FixedAsset; "No.")
            {
            }
            column(Description_FixedAsset; Description)
            {
            }
            column(HeadLineText1; HeadLineText[1])
            {
            }
            column(HeadLineText6; HeadLineText[6])
            {
            }
            column(HeadLineText7; HeadLineText[7])
            {
            }
            column(HeadLineText_1__Control7; HeadLineText[1])
            {
            }
            column(StartText; StartText)
            {
            }
            column(EndText; EndText)
            {
            }
            column(StartAmt1; StartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmt1; NetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmt1; DisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmt1; TotalEndingAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassStartAmt1; ReclassStartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassNetChangeAmt1; ReclassNetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassDisposalAmt1; ReclassDisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmt1; ReclassTotalEndingAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(HeadLineText5; HeadLineText[5])
            {
            }
            column(StartText_Control23; StartText)
            {
            }
            column(BookValueAtStartingDate; BookValueAtStartingDate)
            {
                AutoFormatType = 1;
            }
            column(ReclassificationText; ReclassificationText)
            {
            }
            column(BudgetReport; BudgetReport)
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(Reclassify; Reclassify)
            {
            }
            column(HeadLineText2; HeadLineText[2])
            {
            }
            column(HeadLineText_6__Control9; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control10; HeadLineText[7])
            {
            }
            column(HeadLineText_2__Control11; HeadLineText[2])
            {
            }
            column(StartText_Control25; StartText)
            {
            }
            column(EndText_Control31; EndText)
            {
            }
            column(StartAmt2; StartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmt2; NetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmt2; DisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmt2; TotalEndingAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassStartAmt2; ReclassStartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassNetChangeAmt2; ReclassNetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassDisposalAmt2; ReclassDisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmt2; ReclassTotalEndingAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ShowSection02; ShowSection(0, 2))
            {
            }
            column(HeadLineText3; HeadLineText[3])
            {
            }
            column(HeadLineText_6__Control47; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control50; HeadLineText[7])
            {
            }
            column(HeadLineText_3__Control53; HeadLineText[3])
            {
            }
            column(StartText_Control45; StartText)
            {
            }
            column(EndText_Control56; EndText)
            {
            }
            column(StartAmt3; StartAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmt3; NetChangeAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmt3; DisposalAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmt3; TotalEndingAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassStartAmt3; ReclassStartAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassNetChangeAmt3; ReclassNetChangeAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassDisposalAmt3; ReclassDisposalAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmt3; ReclassTotalEndingAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ShowSection03; ShowSection(0, 3))
            {
            }
            column(HeadLineText4; HeadLineText[4])
            {
            }
            column(HeadLineText_6__Control70; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control71; HeadLineText[7])
            {
            }
            column(HeadLineText_4__Control72; HeadLineText[4])
            {
            }
            column(StartText_Control73; StartText)
            {
            }
            column(EndText_Control74; EndText)
            {
            }
            column(StartAmt4; StartAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmt4; NetChangeAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmt4; DisposalAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmt4; TotalEndingAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassStartAmt4; ReclassStartAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassNetChangeAmt4; ReclassNetChangeAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassDisposalAmt4; ReclassDisposalAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmt4; ReclassTotalEndingAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ShowSection04; ShowSection(0, 4))
            {
            }
            column(HeadLineText8; HeadLineText[8])
            {
            }
            column(HeadLineText_6__Control49; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control51; HeadLineText[7])
            {
            }
            column(HeadLineText_8__Control52; HeadLineText[8])
            {
            }
            column(StartText_Control54; StartText)
            {
            }
            column(EndText_Control55; EndText)
            {
            }
            column(StartAmt5; StartAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmt5; NetChangeAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmt5; DisposalAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmt5; TotalEndingAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassStartAmt5; ReclassStartAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassNetChangeAmt5; ReclassNetChangeAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassDisposalAmt5; ReclassDisposalAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmt5; ReclassTotalEndingAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ShowSection05; ShowSection(0, 5))
            {
            }
            column(HeadLineText9; HeadLineText[9])
            {
            }
            column(HeadLineText_6__Control218; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control219; HeadLineText[7])
            {
            }
            column(HeadLineText_9__Control220; HeadLineText[9])
            {
            }
            column(StartText_Control221; StartText)
            {
            }
            column(EndText_Control222; EndText)
            {
            }
            column(StartAmt6; StartAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmt6; NetChangeAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmt6; DisposalAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmt6; TotalEndingAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassStartAmt6; ReclassStartAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassNetChangeAmt6; ReclassNetChangeAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassDisposalAmt6; ReclassDisposalAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmt6; ReclassTotalEndingAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ShowSection06; ShowSection(0, 6))
            {
            }
            column(HeadLineText_5__Control79; HeadLineText[5])
            {
            }
            column(EndText_Control80; EndText)
            {
            }
            column(BookValueAtEndingDate; BookValueAtEndingDate)
            {
                AutoFormatType = 1;
            }
            column(GroupHeadLineText; GroupHeadLineText)
            {
            }
            column(HeadLineText_1__Control83; HeadLineText[1])
            {
            }
            column(HeadLineText_6__Control84; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control85; HeadLineText[7])
            {
            }
            column(HeadLineText_1__Control86; HeadLineText[1])
            {
            }
            column(StartText_Control87; StartText)
            {
            }
            column(EndText_Control88; EndText)
            {
            }
            column(GroupStartAmt1; GroupStartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmt1; GroupNetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmt1; GroupDisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_1__Control92; TotalEndingAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupStartAmt1; ReclassGroupStartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupNetChangeAmt1; ReclassGroupNetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupDisposalAmt1; ReclassGroupDisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_1__Control189; ReclassTotalEndingAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(HeadLineText_5__Control14; HeadLineText[5])
            {
            }
            column(StartText_Control16; StartText)
            {
            }
            column(BookValueAtStartingDate_Control26; BookValueAtStartingDate)
            {
                AutoFormatType = 1;
            }
            column(ReclassificationText_Control42; ReclassificationText)
            {
            }
            column(GroupTotals; GroupTotals)
            {
            }
            column(ShowSection12; ShowSection(1, 2))
            {
            }
            column(HeadLineText_2__Control93; HeadLineText[2])
            {
            }
            column(HeadLineText_6__Control94; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control95; HeadLineText[7])
            {
            }
            column(HeadLineText_2__Control96; HeadLineText[2])
            {
            }
            column(StartText_Control97; StartText)
            {
            }
            column(EndText_Control98; EndText)
            {
            }
            column(GroupStartAmt2; GroupStartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmt2; GroupNetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmt2; GroupDisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_2__Control102; TotalEndingAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupStartAmt2; ReclassGroupStartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupNetChangeAmt2; ReclassGroupNetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupDisposalAmt2; ReclassGroupDisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_2__Control193; ReclassTotalEndingAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ShowSection_1_2__Control369; ShowSection(1, 2))
            {
            }
            column(GroupTotals_Control370; GroupTotals)
            {
            }
            column(HeadLineText_3__Control103; HeadLineText[3])
            {
            }
            column(HeadLineText_6__Control104; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control105; HeadLineText[7])
            {
            }
            column(HeadLineText_3__Control106; HeadLineText[3])
            {
            }
            column(StartText_Control107; StartText)
            {
            }
            column(EndText_Control108; EndText)
            {
            }
            column(GroupStartAmt3; GroupStartAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmt3; GroupNetChangeAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmt3; GroupDisposalAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_3__Control112; TotalEndingAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupStartAmt3; ReclassGroupStartAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupNetChangeAmt3; ReclassGroupNetChangeAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupDisposalAmt3; ReclassGroupDisposalAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_3__Control197; ReclassTotalEndingAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(GroupTotals_Control381; GroupTotals)
            {
            }
            column(ShowSection13; ShowSection(1, 3))
            {
            }
            column(HeadLineText_4__Control113; HeadLineText[4])
            {
            }
            column(HeadLineText_6__Control114; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control115; HeadLineText[7])
            {
            }
            column(HeadLineText_4__Control116; HeadLineText[4])
            {
            }
            column(StartText_Control117; StartText)
            {
            }
            column(EndText_Control118; EndText)
            {
            }
            column(GroupStartAmt4; GroupStartAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmt4; GroupNetChangeAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmt4; GroupDisposalAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_4__Control122; TotalEndingAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupStartAmt4; ReclassGroupStartAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupNetChangeAmt4; ReclassGroupNetChangeAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupDisposalAmt4; ReclassGroupDisposalAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_4__Control201; ReclassTotalEndingAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(GroupTotals_Control391; GroupTotals)
            {
            }
            column(ShowSection14; ShowSection(1, 4))
            {
            }
            column(HeadLineText_8__Control232; HeadLineText[8])
            {
            }
            column(HeadLineText_6__Control233; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control234; HeadLineText[7])
            {
            }
            column(HeadLineText_8__Control235; HeadLineText[8])
            {
            }
            column(StartText_Control236; StartText)
            {
            }
            column(EndText_Control237; EndText)
            {
            }
            column(GroupStartAmt5; GroupStartAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmt5; GroupNetChangeAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmt5; GroupDisposalAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_5__Control241; TotalEndingAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupStartAmt5; ReclassGroupStartAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupNetChangeAmt5; ReclassGroupNetChangeAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupDisposalAmt5; ReclassGroupDisposalAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_5__Control245; ReclassTotalEndingAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(GroupTotals_Control401; GroupTotals)
            {
            }
            column(ShowSection15; ShowSection(1, 5))
            {
            }
            column(HeadLineText_9__Control246; HeadLineText[9])
            {
            }
            column(HeadLineText_6__Control247; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control248; HeadLineText[7])
            {
            }
            column(HeadLineText_9__Control249; HeadLineText[9])
            {
            }
            column(StartText_Control250; StartText)
            {
            }
            column(EndText_Control251; EndText)
            {
            }
            column(GroupStartAmt6; GroupStartAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmt6; GroupNetChangeAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmt6; GroupDisposalAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_6__Control255; TotalEndingAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupStartAmt6; ReclassGroupStartAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupNetChangeAmt6; ReclassGroupNetChangeAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassGroupDisposalAmt6; ReclassGroupDisposalAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_6__Control259; ReclassTotalEndingAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(GroupTotals_Control414; GroupTotals)
            {
            }
            column(ShowSection16; ShowSection(1, 6))
            {
            }
            column(HeadLineText_5__Control123; HeadLineText[5])
            {
            }
            column(EndText_Control124; EndText)
            {
            }
            column(BookValueAtEndingDate_Control125; BookValueAtEndingDate)
            {
                AutoFormatType = 1;
            }
            column(HeadLineText_1__Control127; HeadLineText[1])
            {
            }
            column(HeadLineText_6__Control128; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control129; HeadLineText[7])
            {
            }
            column(HeadLineText_1__Control130; HeadLineText[1])
            {
            }
            column(StartText_Control131; StartText)
            {
            }
            column(EndText_Control132; EndText)
            {
            }
            column(TotalStartAmt1; TotalStartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmt1; TotalNetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmt1; TotalDisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_1__Control136; TotalEndingAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalStartAmt1; ReclassTotalStartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalNetChangeAmt1; ReclassTotalNetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalDisposalAmt1; ReclassTotalDisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_1__Control205; ReclassTotalEndingAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(HeadLineText_5__Control27; HeadLineText[5])
            {
            }
            column(StartText_Control29; StartText)
            {
            }
            column(BookValueAtStartingDate_Control30; BookValueAtStartingDate)
            {
                AutoFormatType = 1;
            }
            column(ReclassificationText_Control46; ReclassificationText)
            {
            }
            column(ShowSection22; ShowSection(2, 2))
            {
            }
            column(HeadLineText_2__Control137; HeadLineText[2])
            {
            }
            column(HeadLineText_6__Control138; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control139; HeadLineText[7])
            {
            }
            column(HeadLineText_2__Control140; HeadLineText[2])
            {
            }
            column(StartText_Control141; StartText)
            {
            }
            column(EndText_Control142; EndText)
            {
            }
            column(TotalStartAmt2; TotalStartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmt2; TotalNetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmt2; TotalDisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_2__Control146; TotalEndingAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalStartAmt2; ReclassTotalStartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalNetChangeAmt2; ReclassTotalNetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalDisposalAmt2; ReclassTotalDisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_2__Control209; ReclassTotalEndingAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(ShowSection_2_2__Control433; ShowSection(2, 2))
            {
            }
            column(HeadLineText_3__Control147; HeadLineText[3])
            {
            }
            column(HeadLineText_6__Control148; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control149; HeadLineText[7])
            {
            }
            column(HeadLineText_3__Control150; HeadLineText[3])
            {
            }
            column(StartText_Control151; StartText)
            {
            }
            column(EndText_Control152; EndText)
            {
            }
            column(TotalStartAmt3; TotalStartAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmt3; TotalNetChangeAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmt3; TotalDisposalAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_3__Control156; TotalEndingAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalStartAmt3; ReclassTotalStartAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalNetChangeAmt3; ReclassTotalNetChangeAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalDisposalAmt3; ReclassTotalDisposalAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_3__Control213; ReclassTotalEndingAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(ShowSection23; ShowSection(2, 3))
            {
            }
            column(HeadLineText_4__Control157; HeadLineText[4])
            {
            }
            column(HeadLineText_6__Control158; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control159; HeadLineText[7])
            {
            }
            column(HeadLineText_4__Control160; HeadLineText[4])
            {
            }
            column(StartText_Control161; StartText)
            {
            }
            column(EndText_Control162; EndText)
            {
            }
            column(TotalStartAmt4; TotalStartAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmt4; TotalNetChangeAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmt4; TotalDisposalAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_4__Control166; TotalEndingAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalStartAmt4; ReclassTotalStartAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalNetChangeAmt4; ReclassTotalNetChangeAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalDisposalAmt4; ReclassTotalDisposalAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_4__Control217; ReclassTotalEndingAmounts[4])
            {
                AutoFormatType = 1;
            }
            column(ShowSection24; ShowSection(2, 4))
            {
            }
            column(HeadLineText_8__Control272; HeadLineText[8])
            {
            }
            column(HeadLineText_6__Control273; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control274; HeadLineText[7])
            {
            }
            column(HeadLineText_8__Control275; HeadLineText[8])
            {
            }
            column(StartText_Control276; StartText)
            {
            }
            column(EndText_Control277; EndText)
            {
            }
            column(TotalStartAmt5; TotalStartAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmt5; TotalNetChangeAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_5__Control280; TotalEndingAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalStartAmt5; ReclassTotalStartAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalNetChangeAmt5; ReclassTotalNetChangeAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalDisposalAmt5; ReclassTotalDisposalAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_5__Control284; ReclassTotalEndingAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmt5; TotalDisposalAmounts[5])
            {
                AutoFormatType = 1;
            }
            column(ShowSection25; ShowSection(2, 5))
            {
            }
            column(HeadLineText_9__Control3; HeadLineText[9])
            {
            }
            column(HeadLineText_6__Control15; HeadLineText[6])
            {
            }
            column(HeadLineText_7__Control261; HeadLineText[7])
            {
            }
            column(HeadLineText_9__Control262; HeadLineText[9])
            {
            }
            column(StartText_Control263; StartText)
            {
            }
            column(EndText_Control264; EndText)
            {
            }
            column(TotalStartAmt6; TotalStartAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmt6; TotalNetChangeAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts_6__Control267; TotalEndingAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalStartAmt6; ReclassTotalStartAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalNetChangeAmt6; ReclassTotalNetChangeAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalDisposalAmt6; ReclassTotalDisposalAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ReclassTotalEndingAmounts_6__Control271; ReclassTotalEndingAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmt6; TotalDisposalAmounts[6])
            {
                AutoFormatType = 1;
            }
            column(ShowSection26; ShowSection(2, 6))
            {
            }
            column(HeadLineText_5__Control167; HeadLineText[5])
            {
            }
            column(EndText_Control168; EndText)
            {
            }
            column(BookValueAtEndingDate_Control169; BookValueAtEndingDate)
            {
                AutoFormatType = 1;
            }
            column(FAClassCode_FixedAsset; "FA Class Code")
            {
            }
            column(FASubclassCode_FixedAsset; "FA Subclass Code")
            {
            }
            column(FALocationCode_FixedAsset; "FA Location Code")
            {
            }
            column(CompofMainAsset_FixedAsset; "Component of Main Asset")
            {
            }
            column(GlobalDim1Code_FixedAsset; "Global Dimension 1 Code")
            {
            }
            column(GlobalDim2Code_FixedAsset; "Global Dimension 2 Code")
            {
            }
            column(FAPostingGroup_FixedAsset; "FA Posting Group")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT FADeprBook.GET("No.", DeprBookCode) THEN
                    CurrReport.SKIP();
                IF SkipRecord() THEN
                    CurrReport.SKIP();

                //HEI.01>>
                HasDerogatorySetup := FALSE;
                FADeprBook2.SETRANGE("FA No.", "No.");
                FADeprBook2.SETRANGE("Depreciation Book Code", DerogDeprBook.Code);
                IF FADeprBook2.FIND('-') THEN
                    HasDerogatorySetup := TRUE;
                //HEI.01<<

                IF GroupTotals = GroupTotals::"FA Posting Group" THEN
                    IF "FA Posting Group" <> FADeprBook."FA Posting Group" THEN
                        ERROR(Text007, FIELDCAPTION("FA Posting Group"), "No.");

                BeforeAmount := 0;
                EndingAmount := 0;
                IF BudgetReport THEN
                    BudgetDepreciation.Calculate(
                      "No.", GetStartingDate(StartingDate), EndingDate, DeprBookCode, BeforeAmount, EndingAmount);

                i := 0;
                WHILE i < NumberOfTypes DO BEGIN
                    i := i + 1;
                    CASE i OF
                        1:
                            PostingType := FADeprBook.FIELDNO("Acquisition Cost");
                        2:
                            PostingType := FADeprBook.FIELDNO(Depreciation);
                        3:
                            PostingType := FADeprBook.FIELDNO("Write-Down");
                        4:
                            PostingType := FADeprBook.FIELDNO(Appreciation);
                        5:
                            PostingType := FADeprBook.FIELDNO("Custom 1");
                        6:
                            PostingType := FADeprBook.FIELDNO("Custom 2");
                    //HEI.01>>
                    // 7:
                    //     PostingType := FADeprBook.FIELDNO(Derogatory); // BC Upgrade BHARDA11 ----French Localization Field(Derogatory)
                    //HEI.01<<
                    END;
                    IF StartingDate <= 00000101D THEN BEGIN
                        StartAmounts[i] := 0;
                        ReclassStartAmounts[i] := 0;
                    END ELSE BEGIN
                        StartAmounts[i] :=
                          FAGenReport.CalcFAPostedAmount(
                            "No.", PostingType, Period1, StartingDate, EndingDate,
                            DeprBookCode, BeforeAmount, EndingAmount, FALSE, TRUE);
                        IF Reclassify THEN
                            ReclassStartAmounts[i] :=
                              FAGenReport.CalcFAPostedAmount(
                                "No.", PostingType, Period1, StartingDate, EndingDate,
                                DeprBookCode, 0, 0, TRUE, TRUE);
                    END;
                    NetChangeAmounts[i] := FAGenReport.CalcFAPostedAmount("No.", PostingType, Period2, StartingDate, EndingDate,
                        DeprBookCode, BeforeAmount, EndingAmount, FALSE, TRUE);

                    //HEI.01>>
                    IF i = 7 THEN BEGIN
                        // FAGenReport.SetSign(TRUE);
                        SetSign(TRUE);
                        NetChangeAmounts[i] := -(FAGenReport.CalcFAPostedAmount("No.", PostingType, Period2, StartingDate, EndingDate,
                                                 DeprBookCode, BeforeAmount, EndingAmount, FALSE, TRUE));
                        // FAGenReport.SetSign(FALSE);
                        SetSign(FALSE);
                        DisposalAmounts[i] := FAGenReport.CalcFAPostedAmount("No.", PostingType, Period2, StartingDate, EndingDate,
                                                DeprBookCode, BeforeAmount, EndingAmount, FALSE, TRUE);
                    END;
                    //HEI.01<<

                    IF Reclassify THEN
                        ReclassNetChangeAmounts[i] :=
                          FAGenReport.CalcFAPostedAmount(
                            "No.", PostingType, Period2, StartingDate, EndingDate,
                            DeprBookCode, 0, 0, TRUE, TRUE);

                    IF GetPeriodDisposal() THEN BEGIN
                        DisposalAmounts[i] := -(StartAmounts[i] + NetChangeAmounts[i]);
                        ReclassDisposalAmounts[i] := -(ReclassStartAmounts[i] + ReclassNetChangeAmounts[i]);
                    END ELSE BEGIN
                        IF i <> 7 THEN //HEI.01
                            DisposalAmounts[i] := 0;
                        ReclassDisposalAmounts[i] := 0;
                    END;
                END;

                FOR J := 1 TO NumberOfTypes DO BEGIN
                    TotalEndingAmounts[J] := StartAmounts[J] + NetChangeAmounts[J] + DisposalAmounts[J];
                    IF Reclassify THEN
                        ReclassTotalEndingAmounts[J] :=
                          ReclassStartAmounts[J] + ReclassNetChangeAmounts[J] + ReclassDisposalAmounts[J];
                END;
                BookValueAtEndingDate := 0;
                BookValueAtStartingDate := 0;
                FOR J := 1 TO NumberOfTypes DO BEGIN
                    BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[J];
                    BookValueAtStartingDate := BookValueAtStartingDate + StartAmounts[J];
                END;

                MakeGroupHeadLine();
                UpdateTotals();
                CreateGroupTotals();

                //HEI.01>>
                GetDeprBookInfo();
                GetDerogDeprBookInfo();
                //HEI.01<<
            end;

            trigger OnPostDataItem()
            begin
                CreateTotals();
            end;

            trigger OnPreDataItem()
            begin
                CASE GroupTotals OF
                    GroupTotals::"FA Class":
                        SETCURRENTKEY("FA Class Code");
                    GroupTotals::"FA Subclass":
                        SETCURRENTKEY("FA Subclass Code");
                    GroupTotals::"Main Asset":
                        SETCURRENTKEY("Component of Main Asset");
                    GroupTotals::"FA Location":
                        SETCURRENTKEY("FA Location Code");
                    GroupTotals::"Global Dimension 1":
                        SETCURRENTKEY("Global Dimension 1 Code");
                    GroupTotals::"Global Dimension 2":
                        SETCURRENTKEY("Global Dimension 2 Code");
                    GroupTotals::"FA Posting Group":
                        SETCURRENTKEY("FA Posting Group");
                END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DeprBookCode; DeprBookCode)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Book';
                        TableRelation = "Depreciation Book";
                        ToolTip = 'Specifies the code for the depreciation book to be included in the report or batch job.';
                    }
                    field(StartingDate; StartingDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date when you want the report to start.';
                    }
                    field(EndingDate; EndingDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the date when you want the report to end.';
                    }
                    field(GroupTotals; GroupTotals)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Group Totals';
                        OptionCaption = ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group';
                        ToolTip = 'Specifies if you want the report to group fixed assets and print totals using the category defined in this field. For example, maintenance expenses for fixed assets can be shown for each fixed asset class.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Print per Fixed Asset';
                        ToolTip = 'Specifies if you want the report to print information separately for each fixed asset.';
                    }
                    field(BudgetReport; BudgetReport)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Budget Report';
                        ToolTip = 'Specifies if you want the report to calculate future depreciation and book value. This is valid only if you have selected Depreciation and Book Value for Amount Field 1, 2 or 3.';
                    }
                    field(IncludeReclassification; Reclassify)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Include Reclassification';
                        ToolTip = 'Specifies if you want to include reclassification entries in the report.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            GetDepreciationBookCode();
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //HEI.04
        //FABool := FALSE;//HEI.05
        //FAMandatorySingleInstance.InitalizeFA(FABool);//HEI.05
        //HEI.04
    end;

    trigger OnPreReport()
    begin
        CLEAR(DerogDeprBook); //HEI.01
        FAGenReport.ValidateDates(StartingDate, EndingDate);
        DeprBook.GET(DeprBookCode);
        //HEI.01>>
        // DerogDeprBook.SETRANGE("Derogatory Calculation", DeprBookCode); // BC Upgrade BHARDA11 ----French Localization Field("Derogatory Calculation")
        IF DerogDeprBook.FIND('-') THEN;
        //HEI.01<<
        //FABool := TRUE;//HEI.05
        //FAMandatorySingleInstance.InitalizeFA(FABool);//HEI.05
        IF GroupTotals = GroupTotals::"FA Posting Group" THEN
            FAGenReport.SetFAPostingGroup("Fixed Asset", DeprBook.Code);
        FAGenReport.AppendFAPostingFilter("Fixed Asset", StartingDate, EndingDate);
        FAFilter := "Fixed Asset".GETFILTERS;
        MainHeadLineText := Text000;
        IF BudgetReport THEN
            MainHeadLineText := STRSUBSTNO('%1 %2', MainHeadLineText, Text001);
        DeprBookText :=
          STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCode);
        //HEI.01>>
        //NumberOfTypes := 6;
        NumberOfTypes := 7;
        //HEI.01<<
        MakeHeadLineText();
        MakeGroupTotalText();
        Period1 := Period1::"Before Starting Date";
        Period2 := Period2::"Net Change";
    end;

    var
        Text000: Label 'Fixed Asset - Book Value 02';
        Text001: Label '(Budget Report)';
        Text002: Label 'Group Totals';
        Text003: Label 'Reclassification';
        Text004: Label 'Addition in Period';
        Text005: Label 'Disposal in Period';
        Text006: Label 'Group Total';
        Text007: Label '%1 has been modified in fixed asset %2.';
        FASetup: Record "FA Setup";
        DeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FA: Record "Fixed Asset";
        FAGenReport: Codeunit "FA General Report";
        BudgetDepreciation: Codeunit "Budget Depreciation";
        DeprBookCode: Code[10];
        NumberOfTypes: Integer;
        FAFilter: Text;
        MainHeadLineText: Text;
        GroupHeadLineText: Text;
        DeprBookText: Text;
        GroupCodeName: Text;
        GroupHeadLine: Text;
        GroupTotals: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
        HeadLineText: array[10] of Text;
        StartText: Text;
        EndText: Text;
        StartAmounts: array[10] of Decimal;
        NetChangeAmounts: array[10] of Decimal;
        DisposalAmounts: array[10] of Decimal;
        GroupStartAmounts: array[10] of Decimal;
        GroupNetChangeAmounts: array[10] of Decimal;
        GroupDisposalAmounts: array[10] of Decimal;
        TotalStartAmounts: array[10] of Decimal;
        TotalNetChangeAmounts: array[10] of Decimal;
        TotalDisposalAmounts: array[10] of Decimal;
        ReclassStartAmounts: array[10] of Decimal;
        ReclassNetChangeAmounts: array[10] of Decimal;
        ReclassDisposalAmounts: array[10] of Decimal;
        ReclassGroupStartAmounts: array[10] of Decimal;
        ReclassGroupNetChangeAmounts: array[10] of Decimal;
        ReclassGroupDisposalAmounts: array[10] of Decimal;
        ReclassTotalStartAmounts: array[10] of Decimal;
        ReclassTotalNetChangeAmounts: array[10] of Decimal;
        ReclassTotalDisposalAmounts: array[10] of Decimal;
        TotalEndingAmounts: array[10] of Decimal;
        ReclassTotalEndingAmounts: array[10] of Decimal;
        BookValueAtStartingDate: Decimal;
        BookValueAtEndingDate: Decimal;
        i: Integer;
        J: Integer;
        PostingType: Integer;
        Period1: Option "Before Starting Date","Net Change","at Ending Date";
        Period2: Option "Before Starting Date","Net Change","at Ending Date";
#pragma warning disable AA0204
        StartingDate: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        EndingDate: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        PrintDetails: Boolean;
#pragma warning restore AA0204
#pragma warning disable AA0204
        BudgetReport: Boolean;
#pragma warning restore AA0204
        Reclassify: Boolean;
        ReclassificationText: Text;
        BeforeAmount: Decimal;
        EndingAmount: Decimal;
        AcquisitionDate: Date;
        DisposalDate: Date;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
        DeprBookInfo: array[5] of Text[30];
        DerogDeprBookInfo: array[5] of Text[30];
        PrintFASetup: Boolean;
        HasDerogatorySetup: Boolean;
        DerogDeprBookInfo5: Decimal;
        DeprBookInfo5: Decimal;
        DerogDeprBook: Record "Depreciation Book";
        FADeprBook2: Record "FA Depreciation Book";
        Type: Integer;
        FABool: Boolean;
        FAMandatorySingleInstance: Codeunit "FA Mandatory Single Inst. CBN";

    local procedure SkipRecord(): Boolean
    begin
        AcquisitionDate := FADeprBook."Acquisition Date";
        DisposalDate := FADeprBook."Disposal Date";
        EXIT(
          "Fixed Asset".Inactive OR
          (AcquisitionDate = 0D) OR
          (AcquisitionDate > EndingDate) AND (EndingDate > 0D) OR
          (DisposalDate > 0D) AND (DisposalDate < StartingDate))
    end;

    local procedure GetPeriodDisposal(): Boolean
    begin
        IF DisposalDate > 0D THEN
            IF (EndingDate = 0D) OR (DisposalDate <= EndingDate) THEN
                EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure MakeGroupTotalText()
    begin
        CASE GroupTotals OF
            GroupTotals::"FA Class":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Class Code");
            GroupTotals::"FA Subclass":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Subclass Code");
            GroupTotals::"FA Location":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Location Code");
            GroupTotals::"Main Asset":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Main Asset/Component");
            GroupTotals::"Global Dimension 1":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Global Dimension 1 Code");
            GroupTotals::"Global Dimension 2":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Global Dimension 2 Code");
            GroupTotals::"FA Posting Group":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Posting Group");
        END;
        IF GroupCodeName <> '' THEN
            GroupCodeName := STRSUBSTNO('%1%2 %3', Text002, ':', GroupCodeName);
    end;

    local procedure MakeHeadLineText()
    begin
        EndText := STRSUBSTNO('%1', EndingDate);
        StartText := STRSUBSTNO('%1', StartingDate - 1);
        IF Reclassify THEN
            ReclassificationText := Text003;

        HeadLineText[1] := FADeprBook.FIELDCAPTION("Acquisition Cost");
        HeadLineText[2] := FADeprBook.FIELDCAPTION(Depreciation);
        HeadLineText[3] := FADeprBook.FIELDCAPTION("Write-Down");
        HeadLineText[4] := FADeprBook.FIELDCAPTION(Appreciation);
        HeadLineText[5] := FADeprBook.FIELDCAPTION("Book Value");
        HeadLineText[6] := STRSUBSTNO('%1  %2', '', Text004);
        HeadLineText[7] := STRSUBSTNO('%1  %2', '', Text005);
        HeadLineText[8] := FADeprBook.FIELDCAPTION("Custom 1");
        HeadLineText[9] := FADeprBook.FIELDCAPTION("Custom 2");
    end;

    local procedure MakeGroupHeadLine()
    begin
        FOR J := 1 TO NumberOfTypes DO BEGIN
            GroupStartAmounts[J] := 0;
            GroupNetChangeAmounts[J] := 0;
            GroupDisposalAmounts[J] := 0;
            ReclassGroupStartAmounts[J] := 0;
            ReclassGroupNetChangeAmounts[J] := 0;
            ReclassGroupDisposalAmounts[J] := 0;
        END;
        CASE GroupTotals OF
            GroupTotals::"FA Class":
                GroupHeadLine := "Fixed Asset"."FA Class Code";
            GroupTotals::"FA Subclass":
                GroupHeadLine := "Fixed Asset"."FA Subclass Code";
            GroupTotals::"FA Location":
                GroupHeadLine := "Fixed Asset"."FA Location Code";
            GroupTotals::"Main Asset":
                BEGIN
                    FA."Main Asset/Component" := FA."Main Asset/Component"::"Main Asset";
                    GroupHeadLine :=
                      STRSUBSTNO('%1 %2', FORMAT(FA."Main Asset/Component"), "Fixed Asset"."Component of Main Asset");
                    IF "Fixed Asset"."Component of Main Asset" = '' THEN
                        GroupHeadLine := STRSUBSTNO('%1 %2', GroupHeadLine, '*****');
                END;
            GroupTotals::"Global Dimension 1":
                GroupHeadLine := "Fixed Asset"."Global Dimension 1 Code";
            GroupTotals::"Global Dimension 2":
                GroupHeadLine := "Fixed Asset"."Global Dimension 2 Code";
            GroupTotals::"FA Posting Group":
                GroupHeadLine := "Fixed Asset"."FA Posting Group";
        END;
        IF GroupHeadLine = '' THEN
            GroupHeadLine := '*****';

        GroupHeadLineText := STRSUBSTNO('%1%2 %3', Text006, ':', GroupHeadLine);
    end;

    local procedure UpdateTotals()
    begin
        FOR J := 1 TO NumberOfTypes DO BEGIN
            GroupStartAmounts[J] := GroupStartAmounts[J] + StartAmounts[J];
            GroupNetChangeAmounts[J] := GroupNetChangeAmounts[J] + NetChangeAmounts[J];
            GroupDisposalAmounts[J] := GroupDisposalAmounts[J] + DisposalAmounts[J];
            TotalStartAmounts[J] := TotalStartAmounts[J] + StartAmounts[J];
            TotalNetChangeAmounts[J] := TotalNetChangeAmounts[J] + NetChangeAmounts[J];
            TotalDisposalAmounts[J] := TotalDisposalAmounts[J] + DisposalAmounts[J];
            IF Reclassify THEN BEGIN
                ReclassGroupStartAmounts[J] := ReclassGroupStartAmounts[J] + ReclassStartAmounts[J];
                ReclassGroupNetChangeAmounts[J] := ReclassGroupNetChangeAmounts[J] + ReclassNetChangeAmounts[J];
                ReclassGroupDisposalAmounts[J] := ReclassGroupDisposalAmounts[J] + ReclassDisposalAmounts[J];
                ReclassTotalStartAmounts[J] := ReclassTotalStartAmounts[J] + ReclassStartAmounts[J];
                ReclassTotalNetChangeAmounts[J] := ReclassTotalNetChangeAmounts[J] + ReclassNetChangeAmounts[J];
                ReclassTotalDisposalAmounts[J] := ReclassTotalDisposalAmounts[J] + ReclassDisposalAmounts[J];
            END;
        END;
    end;

    local procedure CreateGroupTotals()
    begin
        FOR J := 1 TO NumberOfTypes DO BEGIN
            TotalEndingAmounts[J] := GroupStartAmounts[J] + GroupNetChangeAmounts[J] + GroupDisposalAmounts[J];
            IF Reclassify THEN
                ReclassTotalEndingAmounts[J] :=
                  ReclassGroupStartAmounts[J] + ReclassGroupNetChangeAmounts[J] + ReclassGroupDisposalAmounts[J];
        END;
        BookValueAtEndingDate := 0;
        BookValueAtStartingDate := 0;
        FOR J := 1 TO NumberOfTypes DO BEGIN
            BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[J];
            BookValueAtStartingDate := BookValueAtStartingDate + GroupStartAmounts[J];
        END;
    end;

    local procedure CreateTotals()
    begin
        FOR J := 1 TO NumberOfTypes DO BEGIN
            TotalEndingAmounts[J] := TotalStartAmounts[J] + TotalNetChangeAmounts[J] + TotalDisposalAmounts[J];
            IF Reclassify THEN
                ReclassTotalEndingAmounts[J] :=
                  ReclassTotalStartAmounts[J] + ReclassTotalNetChangeAmounts[J] + ReclassTotalDisposalAmounts[J];
        END;
        BookValueAtEndingDate := 0;
        BookValueAtStartingDate := 0;
        FOR J := 1 TO NumberOfTypes DO BEGIN
            BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[J];
            BookValueAtStartingDate := BookValueAtStartingDate + TotalStartAmounts[J];
        END;
    end;

    local procedure GetStartingDate(StartingDate: Date): Date
    begin
        IF StartingDate <= 00000101D THEN
            EXIT(0D);

        EXIT(StartingDate - 1);
    end;

    local procedure ShowSection(Section: Option Body,GroupFooter,Footer; Type: Integer): Boolean
    begin
        CASE Section OF
            Section::Body:
                EXIT(
                  PrintDetails AND
                  ((StartAmounts[Type] <> 0) OR
                   (NetChangeAmounts[Type] <> 0) OR
                   (DisposalAmounts[Type] <> 0) OR
                   (TotalEndingAmounts[Type] <> 0) OR
                   (ReclassStartAmounts[Type] <> 0) OR
                   (ReclassNetChangeAmounts[Type] <> 0) OR
                   (ReclassDisposalAmounts[Type] <> 0) OR
                   (ReclassTotalEndingAmounts[Type] <> 0)));
            Section::GroupFooter:
                EXIT(
                  (GroupTotals <> GroupTotals::" ") AND
                  ((GroupStartAmounts[Type] <> 0) OR
                   (GroupNetChangeAmounts[Type] <> 0) OR
                   (GroupDisposalAmounts[Type] <> 0) OR
                   (TotalEndingAmounts[Type] <> 0) OR
                   (ReclassGroupStartAmounts[Type] <> 0) OR
                   (ReclassGroupNetChangeAmounts[Type] <> 0) OR
                   (ReclassGroupDisposalAmounts[Type] <> 0) OR
                   (ReclassTotalEndingAmounts[Type] <> 0)));
            Section::Footer:
                EXIT(
                  (TotalStartAmounts[Type] <> 0) OR
                  (TotalNetChangeAmounts[Type] <> 0) OR
                  (TotalDisposalAmounts[Type] <> 0) OR
                  (TotalEndingAmounts[Type] <> 0) OR
                  (ReclassTotalStartAmounts[Type] <> 0) OR
                  (ReclassTotalNetChangeAmounts[Type] <> 0) OR
                  (ReclassTotalDisposalAmounts[Type] <> 0) OR
                  (ReclassTotalEndingAmounts[Type] <> 0));
        END;
    end;

    procedure SetMandatoryFields(DepreciationBookCodeFrom: Code[10]; StartingDateFrom: Date; EndingDateFrom: Date)
    begin
        DeprBookCode := DepreciationBookCodeFrom;
        StartingDate := StartingDateFrom;
        EndingDate := EndingDateFrom;
    end;

    procedure SetTotalFields(GroupTotalsFrom: Option; PrintDetailsFrom: Boolean; BudgetReportFrom: Boolean; ReclassifyFrom: Boolean)
    begin
        GroupTotals := GroupTotalsFrom;
        PrintDetails := PrintDetailsFrom;
        BudgetReport := BudgetReportFrom;
        Reclassify := ReclassifyFrom;
    end;

    procedure GetDepreciationBookCode()
    begin
        IF DeprBookCode = '' THEN BEGIN
            FASetup.GET();
            DeprBookCode := FASetup."Default Depr. Book";
        END;
    end;

    procedure GetDeprBookInfo()
    begin
        //HEI.01>>
        DeprBookInfo[1] := DeprBookCode;
        DeprBookInfo[2] := FORMAT(FADeprBook."Depreciation Method");
        DeprBookInfo[3] := FORMAT(FADeprBook."Depreciation Starting Date");
        DeprBookInfo[4] := FORMAT(FADeprBook."Depreciation Ending Date");
        DeprBookInfo[5] := FORMAT(FADeprBook."Declining-Balance %");
        DeprBookInfo5 := FADeprBook."Declining-Balance %";
        //HEI.01<<
    end;

    procedure GetDerogDeprBookInfo()
    begin
        //HEI.01>>
        DerogDeprBookInfo[1] := FADeprBook2."Depreciation Book Code";
        DerogDeprBookInfo[2] := FORMAT(FADeprBook2."Depreciation Method");
        DerogDeprBookInfo[3] := FORMAT(FADeprBook2."Depreciation Starting Date");
        DerogDeprBookInfo[4] := FORMAT(FADeprBook2."Depreciation Ending Date");
        DerogDeprBookInfo[5] := FORMAT(FADeprBook2."Declining-Balance %");
        DerogDeprBookInfo5 := FADeprBook2."Declining-Balance %";
        //HEI.01<<
    end;

    procedure SetSign(Sign: Boolean)
    var
        UseCreditAmounts: Boolean;
        UseDebitAmounts: Boolean;
    begin
        //HEI.02>>
        IF Sign = TRUE THEN BEGIN
            UseCreditAmounts := TRUE;
            UseDebitAmounts := FALSE
        END ELSE BEGIN
            UseCreditAmounts := FALSE;
            UseDebitAmounts := TRUE;
        END;
        //HEI.02<<
    end;
}

