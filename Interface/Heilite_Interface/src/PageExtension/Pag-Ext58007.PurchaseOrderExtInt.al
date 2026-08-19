pageextension 58007 PurchaseOrderExtInt extends "Purchase Order"
{

    //     HEI.02 HLSRM02-05 IBM LAZARE02 31.07.2017
    //   #New fields for SRM integration added to SRM tab

    // HEI.03 FDD-PTPGAP007 IBM PATHAA02 28.08.2017
    // # Made property "Show mandatory" to True for the field "Vendor Bank Account"

    // HEI.04 FDD-PURGAPINT005 IBM NASTAA02 28.09.2017 # Purchase Order Layout Template Procurement
    //   # Print button should be enabled just when "SRM Order No." is empty

    // HEI.05 FDD-PTPGAP067 IBM Isyed01
    //   # added code to update document sub type for PO if we are printing prepayment invoice and prepayment redit memo.

    // HEI.06 HLSRM03 IBM LAZARE02 11.12.2017
    //   # New action Get Blanket Order Price
    // HEI.07  FDD-AL-PTPGAP02 IBM HORTOC01 16.05.2018 - new subpage

    // HEI.08 defect #2234 IBM POSTOI01 05.06.2018
    //   #new code OnOpenPage, new variable DocSubtypeEditable, change property Editable on Document Subtype Code field
    // HEI.09 SoicaD Filtering by doc subtype
    // HEI.10 RFC-CHG0249183 IBM.LS 04.10.2018
    //   # Added code to call SendEmailPurchaseOrder function. Code commented here and added in Codeunit-415.
    //   # Added field - "BRC Purchase Order".

    // HEI.11 RFC-CHG0246348 IBM.AB 08.10.2018
    //   # Field Purchase Reason Code added
    //   # Code added to make under Reopen action to archive and make Purchase Reason Code blank
    // HEI.12 RFC-CHG0246348 IBM.SS 16.01.2019
    //   Code added for Item category
    // HEI.13 FDD-PURGAP027 - Maximo POs approval flow, IBM.POENAB02 , 28.02.2019
    //   # New field added in "General" group - 50002 Payment User. Set EDITABLE property for this field to FALSE.
    // HEI.14 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Removed Field "Payment User"
    //   # Added Field “PQ Approver”
    //   # Created new Page Action "Purchase Additional"
    // HEI.15 FDD-Ethiopia_Prepayment HT628 IBM POSTOI01 04.07.2019
    //   # modify OnAfterGetCurrentRecord
    //   # add new glovbal variable ActivePrepayment : IncludeInDataset= True
    //   # change the Editable property for the following fields : "Prepayment%, "Compress Prepayment", "Prepmt.Payment Terms Code", "Prepmt.Payment Discount %"
    // HEI.16 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    //   # Made Field "Vendor Posting Group" non-editable
    // FINXL11.00 HBA 03/05/2018 NRQ#69018: Added Action "Auto. Send IC Order"
    // DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018
    // HEI.18 FDD-HB858 - CHG2027215 SHANKJ03 IBM 23.01.2020
    //   # Added field House Number
    // HEI.19 CHG2038388 FDD-HB1005 IBM GUNERE01 17.02.2020 # "Shopping Card No." field added to SRM tab
    // HEI.20 FDD-HT657 IBM NASTAA02 27.02.2020 # Ethiopia Intercompany Automation
    //   # New Field added: "IC Document"
    //   # Code added on OnAfterGetRecord trigger
    // FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    // Hei.21 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //  # New Field Added License Code
    //  # Code added in triggers
    // HEI.22 CHG2062340 HB1378 IBM GAVANM01 29.07.2020 #Retrofitting the Brewco – Sellco
    //   # for the action "Auto Send IC Order": delete Visible property, add Enabled property
    // HEI.23 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //   # new field added: IC Order No.
    //   # hide action "Send IC Purchase Order"
    //   # Properties changed for action Auto. Send IC Order: Promoted=yes, PromotedCategory=Process, PromotedIsBig=yes
    // HEI.24 CHG2081091 IBM SHANKJ03  01.10.2020
    //   # new field added Mail sent & Mail sent date time
    // HEI.26 CHG2083064 IBM.GUNERE01  21.10.2020 # Mail Sent, Mail sent date time fields set to editable false
    // HEI.27 HT1136 CHG2084917 IBM.GUNERE01 11.03.2020 # Added Code in License Code Onvalidate trigger
    // HEI.28 CHG2088873 IBM.GUNERE01 11.26.2020 # License Code onDrillDown, Post and Release funcs. modified
    // HEI.29 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //   # New field added: PurchaseHeaderAdditional."Special Order No."
    // HEI.30 CHG2081323 HB1619 IBM.GUNERE01 20.01.2021 # Limit PO field added in SRM Tab
    // HEI.31 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added in General tab: LSR Order No
    // Hei.32  CHG2096764 IBM. PANDES01  12.03.2021
    //  # Added code for Requesters ID.
    // HEI.33 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # Import Identifier field added to Receiving tab
    // HEI.34 CHG2105495- Defect - 6206 IBM NANDIS01 07.04.2021 - Haiti fix for defect 6206 Location error when approving PO/PQ
    //   # Defect raised from Haiti opco - location code should be mandatory while sending the doc to approver
    // HEI.35 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # Called a new function and added in ReOpen and Release button
    //   # Shown field - "Exp Physical Del Date(Imp)" and "TO Reference" from Purchase Header Additional table
    // HEI.36 FDD-HB2174 CHG2104952 IBM NANDIS01 27.07.2021 Ibecor - PO API
    //   # New Tab - Ibecor created and PFI Doc No. and other fields shown
    //   # New button - Ibecor Situational FIle created
    //   # Visibility of Ibecor tab controlled - code added in OnInit trigger
    // HEI.37 CHG2121745 IBM BHATTA09 23.08.2021
    //   # New Field added - Shopping Card Creation Date
    // HEI.38 CHG2103752 IBM BHATTA09 07.09.2021
    //   # Maximo Status field editability property Changed and code added
    //   # Maximo Status field added in Maximo tab
    // HEI.39 CHG2123487 IBM BHATTA  20.10.2021
    //   # Code added for CMG Dimension mandatory for Shipping Cost type Item Charges
    // HEI.40 FDD-HB2155 CHG2128694 IBM NANDIS01 28.10.2021 WMS PO
    //   # field shown - "WMS Export"
    // HEI.41 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New fields added in Ibecor TAB
    //   # Caption changed to "Shipment No." for field PurchaseHeaderAdditional."Order No." from Order No., and made the field uneditable
    // HEI.42 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Removed filter from properties of button "Ibecor Situational File"
    //   # Code added in button - Ibecor Situational FIle
    // HEI.43 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Field - "Astro Unique ID" shown in new tab - Astro WMS
    // HEI.44 CHG2155847 HB2821 IBM NANDIS01 26.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Field name changed to "Astro WMS PO" from "Astro Unique ID"  and added new button "Process PO for Astro WMS"
    // HEI.45 CHG2167376 HB3082 NORRIQ KOROLA 11.11.2022
    //   # Location Code, Bank who issued the License,License Expiration Date,CoD/CoC Number - fields added
    // HEI.46 CHG2167376 HB3082 NORRIQ KOROLA 22.11.2022


    //   # Ibecor FastTab changed
    // HEI.47 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields shown - "License Required" and "Credit Info Required"
    // HEI.48 CHG2198834 CC IBM NANDIS01 13.04.2023 #Issue with STP report that collects eligible PO’s to be sent to ASTRO
    //   # Astro WMS Tab will be visible as per User setup, new wizard to remove unique id created
    // HEI.49 CHG2198834 CC IBM NANDIS01 19.04.2023 #Issue with STP report that collects eligible PO’s to be sent to ASTRO
    //   # Message box made clear for users
    // HEI.50 CHG2170300 HB3129 IBM SRIVAS07 26-04-23 # Block editing of dimensions during PO Invoice Processing
    //   # Added EBF Combination restrictions in Release and Send for Approval Actions.
    // HEI.51 CHG2214459 IBM SRIVAS07 01.08.2023 - to amend the logic to get the license Number from the dimension license code
    //   # Added Code for Update the License Name in "Purchase Header Additional FND" Table, in License Code - OnDrillDown()
    // HEI.52 CHG2215561 IBM SRIVAS07 21.08.2023 - Message not transferred to Ibecor
    //   # Added code in "License Code" - OnValidate()
    // HEI.53 CHG2215561 IBM SRIVAS07 23.08.2023 - Message not transferred to Ibecor
    //   # Added code in "License Code" - OnValidate()
    // HEI.54 CHG2215561 IBM SRIVAS07 28.08.2023 - Message not transferred to Ibecor
    //   # Added code in "License Code" - OnValidate() - Auto Refresh Page and Reset locTempDimensionSetEntry.
    // HEI.55 CHG2218301 HB3550 IBM SRIVAS07 18.10.2023 - Reduce the manual Purchase Order deletion Development
    //   # Adde code in OnOpen Action
    // HEI.56 CHG2210794 SAHAL01 23.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.57 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus
    // HEI.58 CHG2251877 MAJUMS03 05.07.2024 Warehouse Receipt Lines creation issue
    //   # Code added under OnValidate() Trigger of "Delivery Finalized" field to proper update of "Warehouse Rcpt/Shpt No." of Warehouse Request to fix
    //   the bug related to "Delivery Finalized" field in Purchase Line table and "Warehouse Rcpt/Shpt No." of Warehouse Request table. Code written on
    //   Page level to update "Warehouse Rcpt/Shpt No." of Warehouse Request table before triggering the function under Codeunit and to avoid COMMIT.
    //   # TableData Warehouse Request=rm Permission added.
    // HEI.59 CHG2251877 MAJUMS03 05.07.2024 Warehouse Receipt Lines creation issue
    //   # Code modified.
    //   # TableData Warehouse Request=rm Permission is modified as Warehouse Request=rimd.

    //HEI.08 Code skipped because --- Drink-It fields used.
    //HEI.09 Code skipped because --- Drink-It fields used.

    // BC Upgrade SHUKLP03 >> Added field "LSR Order No." and "WMS Export".

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Ibecor Situational File FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    //BC UPGRADE ATHUKS01>>
    //1.Uncomment code in onaftergetrecordtrigger.
    //BC UPGRADE ATHUKS01<<

    layout
    {
        // addafter("Expctd Physical Delvry Date(Imp)")
        // {
        //     field("WMS Export"; PurchaseHeaderAdditional."WMS Export")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'WMS Export';
        //         Editable = false;
        //     }
        // }

        addafter("Mail Sent Date Time")//BC Upgrade SHARMP16-- Page formatting changes
        {
            // BC Upgrade SHUKLP03 >>
            field("LSR Order No. INT"; PurchaseHeaderAdditional."LSR Order No INT")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the LSR Order No field.';
            }
            field("WMS Export"; PurchaseHeaderAdditional."WMS Export INT")
            {
                ApplicationArea = All;
                Caption = 'WMS Export';
                Editable = false;
                ToolTip = 'Specifies the value of the WMS Export field.';
            }
            // BC Upgrade SHUKLP03 <<
        }
        addafter(Receiving)
        {//BC Upgarde SHARMP16-- PO page related changes
            group(Maximo)
            {
                Caption = 'Maximo';
                field("Maximo Requisition No."; Rec."Maximo Requisition No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximo Requisition No. field.';
                }
                field("Maximo Status"; Rec."Maximo Status INT")
                {
                    ApplicationArea = All;
                    Editable = MaximoStatusIsEditable;
                    ToolTip = 'Specifies the value of the Maximo Status field.';
                }
            }

            group(SRM)
            {
                Caption = 'SRM';
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Name"; Rec."SRM Contract Name FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SRM Contract Name field.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field("Shopping Card No."; Rec."Shopping Card No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shopping Card No. field.';
                }
                field("Shopping Card Creation Date"; PurchaseHeaderAdditional."Shopping Card Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shopping Card Creation Date field.';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field(Channel; Rec."Channel FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Channel field.';
                }
                field(Closed; Rec."Closed FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("Target Value Currency"; Rec."Target Value Currency FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Value Currency field.';
                }
                field("Target Value Amount"; Rec."Target Value Amount FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Value Amount field.';
                }
                field("Limit PO"; PurchaseHeaderAdditional."Limit PO")
                {
                    ApplicationArea = All;
                    Caption = 'Limit PO';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Limit PO field.';
                }
            }
            group(Ibecor)
            {
                Caption = 'Ibecor';
                Visible = EnableIbecorInterface;
                field("PFI Document No."; PurchaseHeaderAdditional."PFI Document No. INT")
                {
                    ApplicationArea = All;
                    Caption = 'PFI Document No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the PFI Document No. field.';
                }
                field("Ibecor Dossier No."; PurchaseHeaderAdditional."Ibecor Dossier No. INT")
                {
                    ApplicationArea = All;
                    Caption = 'Ibecor Dossier No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Ibecor Dossier No. field.';
                }
                group("Letter of Credit Information")
                {
                    Caption = 'Letter of Credit Information';
                    field("Credit Info Required"; PurchaseHeaderAdditional."Credit Info Required INT")
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Information Required';
                        Enabled = false;
                        ToolTip = 'Specifies the value of the Credit Information Required field.';
                    }
                    field("Credit Number"; PurchaseHeaderAdditional."Credit Number INT")
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Number';
                        ToolTip = 'Specifies the value of the Credit Number field.';

                        trigger OnValidate();
                        var
                            lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
                        begin
                            //HEI.36>>
                            //Free Text anytime can be modified
                            if (PurchaseHeaderAdditional."Credit Number INT" <> '') then begin
                                if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                    lrecPurchAddtnlHdr."Credit Number INT" := PurchaseHeaderAdditional."Credit Number INT";
                                    lrecPurchAddtnlHdr.MODIFY();
                                end
                            end else begin
                                if (PurchaseHeaderAdditional."Credit Number INT" = '') then begin
                                    if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                        lrecPurchAddtnlHdr."Credit Number INT" := '';
                                        lrecPurchAddtnlHdr.MODIFY();
                                    end;
                                end;
                            end;
                            //HEI.36<<
                        end;
                    }
                    field("Credit Amount Of supplier"; PurchaseHeaderAdditional."Credit Amount Of supplier INT")
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Amount Of Supplier';
                        ToolTip = 'Specifies the value of the Credit Amount Of Supplier field.';

                        trigger OnValidate();
                        var
                            lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
                        begin
                            //HEI.36>>
                            //Free Text anytime can be modified
                            if (PurchaseHeaderAdditional."Credit Amount Of supplier INT" <> 0) then begin
                                if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                    lrecPurchAddtnlHdr."Credit Amount Of supplier INT" := PurchaseHeaderAdditional."Credit Amount Of supplier INT";
                                    lrecPurchAddtnlHdr.MODIFY();
                                end
                            end else begin
                                if (PurchaseHeaderAdditional."Credit Amount Of supplier INT" = 0) then begin
                                    if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                        lrecPurchAddtnlHdr."Credit Amount Of supplier INT" := 0;
                                        lrecPurchAddtnlHdr.MODIFY();
                                    end;
                                end;
                            end;
                            //HEI.36<<
                        end;
                    }
                    field("Bank Who Issued Credit"; PurchaseHeaderAdditional."Bank Who Issued Credit INT")
                    {
                        ApplicationArea = All;
                        Caption = 'Bank Who Issued Credit';
                        ToolTip = 'Specifies the value of the Bank Who Issued Credit field.';

                        trigger OnValidate();
                        var
                            lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
                        begin
                            //HEI.36>>
                            //Free Text anytime can be modified
                            if (PurchaseHeaderAdditional."Bank Who Issued Credit INT" <> '') then begin
                                if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                    lrecPurchAddtnlHdr."Bank Who Issued Credit INT" := PurchaseHeaderAdditional."Bank Who Issued Credit INT";
                                    lrecPurchAddtnlHdr.MODIFY();
                                end
                            end else begin
                                if (PurchaseHeaderAdditional."Bank Who Issued Credit INT" = '') then begin
                                    if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                        lrecPurchAddtnlHdr."Bank Who Issued Credit INT" := '';
                                        lrecPurchAddtnlHdr.MODIFY();
                                    end;
                                end;
                            end;
                            //HEI.36<<
                        end;
                    }
                    field("Last Date Of Shipment"; PurchaseHeaderAdditional."Last Date Of Shipment INT")
                    {
                        ApplicationArea = All;
                        Caption = 'Last Date Of Shipment';
                        ToolTip = 'Specifies the value of the Last Date Of Shipment field.';

                        trigger OnValidate();
                        var
                            lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
                        begin
                            //HEI.36>>
                            //Free Text anytime can be modified
                            if (PurchaseHeaderAdditional."Last Date Of Shipment INT" <> 0D) then begin
                                if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                    lrecPurchAddtnlHdr."Last Date Of Shipment INT" := PurchaseHeaderAdditional."Last Date Of Shipment INT";
                                    lrecPurchAddtnlHdr.MODIFY();
                                end
                            end else begin
                                if (PurchaseHeaderAdditional."Last Date Of Shipment INT" = 0D) then begin
                                    if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                        lrecPurchAddtnlHdr."Last Date Of Shipment INT" := 0D;
                                        lrecPurchAddtnlHdr.MODIFY();
                                    end;
                                end;
                            end;
                            //HEI.36<<
                        end;
                    }
                    field("Credit Validity Date"; PurchaseHeaderAdditional."Credit Validity Date INT")
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Validity Date';
                        ToolTip = 'Specifies the value of the Credit Validity Date field.';

                        trigger OnValidate();
                        var
                            lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
                        begin
                            //HEI.36>>
                            //Free Text anytime can be modified
                            if (PurchaseHeaderAdditional."Credit Validity Date INT" <> 0D) then begin
                                if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                    lrecPurchAddtnlHdr."Credit Validity Date INT" := PurchaseHeaderAdditional."Credit Validity Date INT";
                                    lrecPurchAddtnlHdr.MODIFY();
                                end
                            end else begin
                                if (PurchaseHeaderAdditional."Credit Validity Date INT" = 0D) then begin
                                    if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                        lrecPurchAddtnlHdr."Credit Validity Date INT" := 0D;
                                        lrecPurchAddtnlHdr.MODIFY();
                                    end;
                                end;
                            end;
                            //HEI.36<<
                        end;
                    }
                    field(BankReferenceNumber; PurchaseHeaderAdditional."Bank Reference Number")
                    {
                        ApplicationArea = All;
                        Caption = 'Bank Reference Number';
                        ToolTip = 'Specifies the value of the Bank Reference Number field.';

                        trigger OnValidate();
                        var
                            lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
                        begin
                            //HEI.46 >>
                            if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
                                lrecPurchAddtnlHdr."Bank Reference Number" := PurchaseHeaderAdditional."Bank Reference Number";
                                lrecPurchAddtnlHdr.MODIFY();
                                CurrPage.UPDATE(false);
                            end;
                            //HEI.46 <<
                        end;
                    }

                    group("License Information")
                    {

                        Caption = 'License Information';
                        field("License Required"; PurchaseHeaderAdditional."License Required INT")
                        {
                            ApplicationArea = All;
                            Caption = 'License Required';
                            Enabled = false;
                            ToolTip = 'Specifies the value of the License Required field.';
                        }
                        field("License Name"; PurchaseHeaderAdditional."License Name")
                        {
                            ApplicationArea = All;
                            Caption = 'License Code';
                            Editable = false;
                            ToolTip = 'Specifies the value of the License Code field.';
                        }
                        field("Bank who issued the License"; PurchaseHeaderAdditional."Bank who issued the License")
                        {
                            ApplicationArea = All;
                            Caption = 'Bank Name';
                            Editable = false;
                            ToolTip = 'Specifies the value of the Bank Name field.';
                        }
                        field("License Expiration Date"; PurchaseHeaderAdditional."License Expiration Date")
                        {
                            ApplicationArea = All;
                            Caption = 'Date Validity License';
                            Editable = false;
                            ToolTip = 'Specifies the value of the Date Validity License field.';
                        }
                        field("CoD/CoC Number"; PurchaseHeaderAdditional."CoD/CoC Number")
                        {
                            ApplicationArea = All;
                            Caption = 'CoD/CoC Number';
                            Editable = false;
                            ToolTip = 'Specifies the value of the CoD/CoC Number field.';
                        }
                    }
                    group("Other Information")
                    {
                        Caption = 'Other Information';
                        field("Expected Date Departure"; PurchaseHeaderAdditional."Expected Date Departure INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Expected Date Departure';
                            ToolTip = 'Specifies the value of the Expected Date Departure field.';
                        }
                        field("Departure Date"; PurchaseHeaderAdditional."Departure Date INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Departure Date';
                            ToolTip = 'Specifies the value of the Departure Date field.';
                        }
                        field("Date Orig. Docs Sent INT"; PurchaseHeaderAdditional."Date Orig. Docs Sent INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Date Orig. Docs Sent';
                            ToolTip = 'Specifies the value of the Date Orig. Docs Sent field.';
                        }
                        field("Date Copy Docs Sent"; PurchaseHeaderAdditional."Date Copy Docs Sent INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Date Copy Docs Sent';
                            ToolTip = 'Specifies the value of the Date Copy Docs Sent field.';
                        }
                        field("Order Form To Supplier Date"; PurchaseHeaderAdditional."Order FormTo Supplier Date INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Order Form To Supplier Date';
                            ToolTip = 'Specifies the value of the Order Form To Supplier Date field.';
                        }
                        field("Expected Date to Ex Works"; PurchaseHeaderAdditional."Expected Date to Ex Works INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Expected Date to Ex Works';
                            ToolTip = 'Specifies the value of the Expected Date to Ex Works field.';
                        }
                        field("Vessel Name"; PurchaseHeaderAdditional."Vessel Name INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Vessel Name';
                            ToolTip = 'Specifies the value of the Vessel Name field.';
                        }
                        field("Expected Date Arrival"; PurchaseHeaderAdditional."Expected Date Arrival INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Expected Date Arrival';
                            ToolTip = 'Specifies the value of the Expected Date Arrival field.';
                        }
                        field("B/L-AWB"; PurchaseHeaderAdditional."B/L-AWB INT")
                        {
                            ApplicationArea = All;
                            Caption = 'B/L-AWB';
                            ToolTip = 'Specifies the value of the B/L-AWB field.';
                        }
                        field("Shipment Description"; PurchaseHeaderAdditional."Shipment Description INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Shipment Description';
                            ToolTip = 'Specifies the value of the Shipment Description field.';
                        }
                        field("Order No."; PurchaseHeaderAdditional."Order No. INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Shipment No.';
                            Editable = false;
                            ToolTip = 'Specifies the value of the Shipment No. field.';
                        }
                        field("Tracking Information"; PurchaseHeaderAdditional."Tracking Information INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Tracking Information';
                            ToolTip = 'Specifies the value of the Tracking Information field.';
                        }
                        field("Reference SDV"; PurchaseHeaderAdditional."Reference SDV INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Reference SDV';
                            ToolTip = 'Specifies the value of the Reference SDV field.';
                        }
                        field("Date Receipt Docs Supplier"; PurchaseHeaderAdditional."Date Receipt Docs Supplier INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Date Receipt Docs Supplier';
                            Importance = Additional;
                            ToolTip = 'Specifies the value of the Date Receipt Docs Supplier field.';
                        }
                        field("Date Receipt Docs Forwarder"; PurchaseHeaderAdditional."Date ReceiptDocs Forwarder INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Date Receipt Docs Forwarder';
                            Importance = Additional;
                            ToolTip = 'Specifies the value of the Date Receipt Docs Forwarder field.';
                        }
                        field("Volume in m3"; PurchaseHeaderAdditional."Volume in m3 INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Volume in m3';
                            Importance = Additional;
                            ToolTip = 'Specifies the value of the Volume in m3 field.';
                        }
                        field("Nbr cont. 20 feet"; PurchaseHeaderAdditional."Nbr cont. 20 feet INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Nbr cont. 20 feet';
                            Importance = Additional;
                            ToolTip = 'Specifies the value of the Nbr cont. 20 feet field.';
                        }
                        field("Nbr cont. 40 feet"; PurchaseHeaderAdditional."Nbr cont. 40 feet INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Nbr cont. 40 feet';
                            Importance = Additional;
                            ToolTip = 'Specifies the value of the Nbr cont. 40 feet field.';
                        }
                        field("Arrival Date Destination Port"; PurchaseHeaderAdditional."Arrival Date Dest. Port INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Date Of Arrival in Port of Destination';
                            Importance = Additional;
                            ToolTip = 'Specifies the value of the Date Of Arrival in Port of Destination field.';
                        }
                    }
                }

                group("Zycus Interface")
                {
                    Caption = 'Zycus Interface';
                    Visible = VisibleZycusInterface;
                    field("Zycus Order No."; PurchaseHeaderAdditional."Zycus Order No. INT")
                    {
                        ApplicationArea = All;
                        Caption = 'Zycus Order No.';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Zycus Order No. field.';
                    }
                    group("Zycus PO Interface")
                    {
                        Caption = 'Zycus PO Interface';
                        field("PO Transaction Interface Zycus"; PurchaseHeaderAdditional."PO Transaction Intf. Zycus INT")
                        {
                            ApplicationArea = All;
                            Caption = 'PO Transaction Interface Zycus';
                            Editable = false;
                            ToolTip = 'Specifies the value of the PO Transaction Interface Zycus field.';
                        }
                        field("Processed PO Transaction Zycus"; PurchaseHeaderAdditional."Processed PO Trans. Zycus INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Processed PO Transaction Zycus';
                            Editable = false;
                            ToolTip = 'Specifies the value of the Processed PO Transaction Zycus field.';
                        }
                    }

                    group("Zycus GR Interface")
                    {
                        Caption = 'Zycus GR Interface';
                        field("Zycus GR UUID"; PurchaseHeaderAdditional."Zycus GR UUID INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Zycus GR UUID';
                            Editable = false;
                            ToolTip = 'Specifies the value of the Zycus GR UUID field.';
                        }
                        field("GR Transaction Interface Zycus"; PurchaseHeaderAdditional."GR Transaction Intf Zycus INT")
                        {
                            ApplicationArea = All;
                            Caption = 'GR Transaction Interface Zycus';
                            Editable = false;
                            ToolTip = 'Specifies the value of the GR Transaction Interface Zycus field.';
                        }
                        field("Processed GR Transaction Zycus"; PurchaseHeaderAdditional."Processed GR Trans. Zycus INT")
                        {
                            ApplicationArea = All;
                            Caption = 'Processed GR Transaction Zycus';
                            Editable = false;
                            ToolTip = 'Specifies the value of the Processed GR Transaction Zycus field.';
                        }
                    }
                }
            }
        }
    }


    actions
    {
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //Hei.32
                PurchasesPSetup.GET();
                IF PurchasesPSetup."Requester ID Mandatory FND" THEN BEGIN
                    IF rec."SRM Order No. FND" = '' THEN;
                    //    Rec.TESTFIELD("Requester ID");//BC Upgrade SHARMP16-- Drink-IT field
                END;
                //Hei.32//BC Upgrade SHARMP16--- Interface code. 
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                PurchaseLine: Record "Purchase Line";
                ItemCategoryBool: Boolean;
                ArchiveManagement: Codeunit ArchiveManagement;
                CustomHeinekenCU: Codeunit "Heineken BC Custom Functions";
            begin
                //HEI.12>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document No.", rec."No.");
                    PurchaseLine.SETFILTER("Document Type", '%1', PurchaseLine."Document Type"::Order);
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    ELSE
                        ItemCategoryBool := TRUE;
                    IF ItemCategoryBool THEN BEGIN
                        //HEI.12<<
                        //HEI.11>>
                        IF rec."SRM Order No. FND" = '' THEN BEGIN
                            CustomHeinekenCU.ArchivePurchDocumentOnReopen(Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                        //HEI.11<<
                        //HEI.12>>
                    END;
                END;
                //HEI.12<<
            end;
        }
        modify(Email)
        {
            Visible = false;
        }
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //Hei.32
                PurchasesPSetup.GET();
                IF PurchasesPSetup."Requester ID Mandatory FND" THEN BEGIN
                    IF rec."SRM Order No. FND" = '' THEN;
                    // Rec.TESTFIELD("Requester ID");//BC Upgrade SHARMP16-- DRink-IT field
                END;
                //Hei.32
            end;
        }
        modify("&Print")
        {
            Visible = false;//BC Upgrade SHARMP16 06072026
        }
        addafter(Email)
        {
            action("OrderCustom")
            {
                ApplicationArea = all;
                Caption = 'Order';
                Image = Print;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                Promoted = true;
                PromotedCategory = Category10;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin

                    PurchaseHeader := Rec;
                    CurrPage.SetSelectionFilter(PurchaseHeader);
                    PurchaseHeader.PrintRecords(true);
                end;

            }
        }//BC Upgrade SHARMP16 06072026
        addafter("Purchase Additional")
        {
            action("Ibecor Situational File")
            {
                Promoted = true;//BC Upgarde SHARMP16-- PO page related changes
                PromotedCategory = Category8;//BC Upgarde SHARMP16-- PO page related changes
                ApplicationArea = All;
                ToolTip = 'Executes the Ibecor Situational File action.';
                trigger OnAction()
                var
                    StoreLastShipmentNo: Code[10];
                begin
                    //HEI.42>>

                    IbecorSituationalFile.RESET();
                    IbecorSituationalFile.SETRANGE("Order No.", rec."No.");
                    IbecorSituationalFile.SETRANGE("Shipment Type", IbecorSituationalFile."Shipment Type"::Registered);
                    IF IbecorSituationalFile.FINDFIRST() THEN
                        PAGE.RUNMODAL(PAGE::"Ibecor Situational File", IbecorSituationalFile)
                    ELSE BEGIN
                        IbecorSituationalFile.SETRANGE("Shipment Type", IbecorSituationalFile."Shipment Type"::Current);
                        IF IbecorSituationalFile.FINDLAST() THEN
                            StoreLastShipmentNo := IbecorSituationalFile."Shipment No.";
                        IbecorSituationalFile.SETRANGE("Shipment No.", StoreLastShipmentNo);
                        PAGE.RUNMODAL(PAGE::"Ibecor Situational File", IbecorSituationalFile)
                    END;
                    //HEI.42<<

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        //>>HEI.01
        PrintEnabled := rec."SRM Order No. FND" = '';
        //<<HEI.01
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.07>>
        PurchSetup.GET();
        ShowSRMSubpage := (rec."SRM Order No. FND" <> '') AND PurchSetup."Allow VATChange C&TP Ord. FND";
        //HEI.07<<
        LicensiEdit := TRUE;//HEI.21
                            //HEI.36>>
        IF grec_IbecorInterfaceSetup.GET() THEN BEGIN
            IF grec_IbecorInterfaceSetup."Interface Enable/Disable" THEN
                EnableIbecorInterface := TRUE
            ELSE
                EnableIbecorInterface := FALSE;
        END;
        //HEI.36<<
        //>>HEI.38
        MaximoStatusIsEditable := TRUE;
        //<<HEI.38
        //HEI.56>>
        IF ZycusInterfaceSetupL.GET() AND ZycusInterfaceSetupL."Enabled Zycus Integration" THEN
            VisibleZycusInterface := TRUE;
        //HEI.56<<

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //>>HEI.15
        IF (rec."Blanket Order No. FND" <> '') OR (rec."SRM Contract No. FND" <> '') THEN
            ActivePrepayment := FALSE
        ELSE
            ActivePrepayment := TRUE;
        //<<HEI.15
        //HEI.35>>
        //IF PurchaseHeaderAdditional.GET("Document Type","No.") THEN; //HEI.20
        // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<AUTO GENERATED BY CONFLICT EXTENSION<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< development
        // IF PurchaseHeaderAdditional.GET(rec."Document Type", rec."No.") THEN //HEI.20//BC Upgrade SHARMP16-- Purchprocesschanges shifted to Gen extension
        //     PurchaseHeaderAdditional.CALCFIELDS("TO Reference");//BC Upgrade SHARMP16-- Purchprocesschanges shifted to Gen extension
        //BC UPGRADE ATHUKS01>>
        IF PurchaseHeaderAdditional.GET(rec."Document Type", rec."No.") THEN //HEI.20//BC Upgrade SHARMP16-- Purchprocesschanges shifted to Gen extension
            PurchaseHeaderAdditional.CALCFIELDS("TO Reference");//BC Upgrade SHARMP16-- Purchprocesschanges shifted to Gen extension
                                                                //BC UPGRADE ATHUKS01<<
                                                                // ====================================AUTO GENERATED BY CONFLICT EXTENSION ====================================
        IF PurchaseHeaderAdditional.GET(rec."Document Type", rec."No.") THEN //HEI.20//BC Upgrade SHARMP16-- Purchprocesschanges shifted to Gen extension
            PurchaseHeaderAdditional.CALCFIELDS("TO Reference");//BC Upgrade SHARMP16-- Purchprocesschanges shifted to Gen extension
                                                                // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>AUTO GENERATED BY CONFLICT EXTENSION >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SRM_Interface_PR01
                                                                //HEI.35<<
                                                                // HEI.21 >>
                                                                // PurchRcptHdrRec.RESET;
                                                                // PurchRcptHdrRec.SETRANGE("Order No.",Rec."No.");
                                                                // IF PurchRcptHdrRec.FINDFIRST THEN
        PurchLine2.SETRANGE("Document Type", Rec."Document Type");
        PurchLine2.SETRANGE("Document No.", Rec."No.");
        PurchLine2.SETFILTER("Quantity Received", '>%1', 0);
        IF PurchLine2.FINDFIRST() THEN
            LicensiEdit := FALSE;
        // HEI.21 <<

        //>>HEI.38
        IF rec."Maximo Requisition No. FND" <> '' THEN
            MaximoStatusIsEditable := FALSE;
        //<<HEI.38

    end;

    var
        IbecorSituationalFile: Record "Ibecor Situational File FND";
        ActivePrepayment: Boolean;
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        MaximoStatusIsEditable: Boolean;
        EnableIbecorInterface: Boolean;
        VisibleZycusInterface: Boolean;
        PrintEnabled: Boolean;
        PurchSetup: Record "Purchases & Payables Setup";
        ShowSRMSubpage: Boolean;
        PurchLine2: Record "Purchase Line";
        LicensiEdit: Boolean;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        grec_IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";
        PurchasesPSetup: Record "Purchases & Payables Setup";
}