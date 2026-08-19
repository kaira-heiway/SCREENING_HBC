page 50127 "WHT Entry"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # Object created
    // 
    // HEI.02 FDD-RTRGAP BRD HT422 IBM BULIMC01 09.04.2019 # 4 fields displayed
    // HEI.03 CHG2057437 IBM POENAB02 28.04.2020 # FDD_HT1104_DRC_WHT functionality enhancement
    //   # New field: 50004 "WHT Bearer"
    // BC Upgrade RD03 - adding code to show the records which have WHT Prod Posting Group -- >>

    Caption = 'WHT Entry';
    Editable = false;
    PageType = List;
    SourceTable = "WHT Entry FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1500000)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies an auto-generated unique key for every transaction in this table.',
                                ENA = 'Specifies an auto-generated unique key for every transaction in this table.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies that the value is assigned from Gen. Bus. Posting Group in the Sales/Purchase/Journal transaction.',
                                ENA = 'Specifies that the value is assigned from Gen. Bus. Posting Group in the Sales/Purchase/Journal transaction.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the value is assigned from Gen. Prod. Posting Group in the Sales/Purchase/Journal transaction.',
                                ENA = 'Specifies the value is assigned from Gen. Prod. Posting Group in the Sales/Purchase/Journal transaction.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Vendor Address"; Rec."Vendor Address")
                {
                    ToolTip = 'Specifies the value of the Vendor Address field.';
                }
                field("Vendor Phone Number"; Rec."Vendor Phone Number")
                {
                    ToolTip = 'Specifies the value of the Vendor Phone Number field.';
                }
                field("Invoice Payment Date"; Rec."Invoice Payment Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Payment Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the value is assigned from the Posting Date in the Sales/Purchase/Journal transaction.',
                                ENA = 'Specifies the value is assigned from the Posting Date in the Sales/Purchase/Journal transaction.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the value is assigned from the Document No. in the Sales/Purchase/Journal transaction.',
                                ENA = 'Specifies the value is assigned from the Document No. in the Sales/Purchase/Journal transaction.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the value is assigned from Document Type in the Sales/Purchase/Journal transaction.',
                                ENA = 'Specifies the value is assigned from Document Type in the Sales/Purchase/Journal transaction.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the source of the transaction.',
                                ENA = 'Specifies the source of the transaction.';
                }
                field(Base; Rec.Base)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the calculated WHT Base Amount is assigned here during the posting process.',
                                ENA = 'Specifies the calculated WHT Base Amount is assigned here during the posting process.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the Calculated WHT Amount is assigned here during the posting process.',
                                ENA = 'Specifies the Calculated WHT Amount is assigned here during the posting process.';
                }
                field("WHT Calculation Type"; Rec."WHT Calculation Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the withholding tax (WHT) calculation type.',
                                ENA = 'Specifies the withholding tax (WHT) calculation type.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies that the value of Specifies that this field is assigned from Currency Code in the Sales/Purchase/Journal transaction.',
                                ENA = 'Specifies that the value of Specifies that this field is assigned from Currency Code in the Sales/Purchase/Journal transaction.';
                }
                field("Bill-to/Pay-to No."; Rec."Bill-to/Pay-to No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the number of the Bill-to Customer or Pay-to Vendor that the entry is linked to.',
                                ENA = 'Shows the number of the Bill-to Customer or Pay-to Vendor that the entry is linked to.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Contains the ID of the user that is associated with the entry.',
                                ENA = 'Contains the ID of the user that is associated with the entry.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the source code that is linked to the WHT entry.',
                                ENA = 'Shows the source code that is linked to the WHT entry.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the reason code on the entry.',
                                ENA = 'Shows the reason code on the entry.';
                }
                field("Closed by Entry No."; Rec."Closed by Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the entry number of the WHT entry that has been applied to (that has closed) the entry.',
                                ENA = 'Shows the entry number of the WHT entry that has been applied to (that has closed) the entry.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies that the entry has been closed for transactions.',
                                ENA = 'Specifies that the entry has been closed for transactions.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the country code for the customer or vendor to which the WHT entry is linked.',
                                ENA = 'Shows the country code for the customer or vendor to which the WHT entry is linked.';
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the transaction number assigned to the entry.',
                                ENA = 'Shows the transaction number assigned to the entry.';
                }
                field("Unrealized Amount"; Rec."Unrealized Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the WHT Amount calculated during the posting of Invoice or Credit Memo, which will be realized during payment.',
                                ENA = 'Shows the WHT Amount calculated during the posting of Invoice or CR/Adj Note, which will be realised during payment.';
                }
                field("Unrealized Base"; Rec."Unrealized Base")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the Base Amount on which WHT Amount was calculated.',
                                ENA = 'Shows the Base Amount on which WHT Amount was calculated.';
                }
                field("Remaining Unrealized Amount"; Rec."Remaining Unrealized Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the Remaining WHT Amount calculated.',
                                ENA = 'Shows the Remaining WHT Amount calculated.';
                }
                field("Remaining Unrealized Base"; Rec."Remaining Unrealized Base")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the Remaining Base Amount calculated.',
                                ENA = 'Shows the Remaining Base Amount calculated.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the external document number for this entry.',
                                ENA = 'Shows the external document number for this entry.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Contains the code for the no. series to which the document number on this entry belongs.',
                                ENA = 'Contains the code for the no. series to which the document number on this entry belongs.';
                }
                field("Unrealized WHT Entry No."; Rec."Unrealized WHT Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Contains the number of the original WHT entry (with the unrealized WHT amount).',
                                ENA = 'Contains the number of the original WHT entry (with the unrealised WHT amount).';
                }
                field("WHT Bus. Posting Group"; Rec."WHT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the WHT Business Posting group code that was used when the entry was posted.',
                                ENA = 'Shows the WHT Business Posting group code that was used when the entry was posted.';
                }
                field("WHT Prod. Posting Group"; Rec."WHT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the WHT Product Posting group code that was used when the entry was posted.',
                                ENA = 'Shows the WHT Product Posting group code that was used when the entry was posted.';
                }
                field("Base (LCY)"; Rec."Base (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Contains the Base Amount in LCY of the WHT, which is realized during this transaction.',
                                ENA = 'Contains the Base Amount in LCY of the WHT, which is realised during this transaction.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Contains the WHT Amount in LCY of the WHT, which is realized during this transaction.',
                                ENA = 'Contains the WHT Amount in LCY of the WHT, which is realised during this transaction.';
                }
                field("Unrealized Amount (LCY)"; Rec."Unrealized Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the WHT Amount in LCY calculated during the posting of the invoice or credit memo, which will be realized during payment.',
                                ENA = 'Shows the WHT Amount in LCY calculated during the posting of the invoice or CR/Adj Note, which will be realised during payment.';
                }
                field("Unrealized Base (LCY)"; Rec."Unrealized Base (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the Base Amount in LCY on which the WHT Amount was calculated.',
                                ENA = 'Shows the Base Amount in LCY on which the WHT Amount was calculated.';
                }
                field("WHT %"; Rec."WHT %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Shows the WHT % used for calculations during this transaction.',
                                ENA = 'Shows the WHT % used for calculations during this transaction.';
                }
                field("Rem Unrealized Amount (LCY)"; Rec."Rem Unrealized Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the Remaining Unrealized Amount in LCY left for a particular transaction is stored.',
                                ENA = 'Specifies the Remaining Unrealised Amount in LCY left for a particular transaction is stored.';
                }
                field("Rem Unrealized Base (LCY)"; Rec."Rem Unrealized Base (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the Remaining Unrealized Base in LCY left for a particular transaction is stored.',
                                ENA = 'Specifies the Remaining Unrealised Base in LCY left for a particular transaction is stored.';
                }
                field("WHT Difference"; Rec."WHT Difference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the difference between the Unrealized and Realized WHT.',
                                ENA = 'Specifies the difference between the Unrealised and Realised WHT.';
                }
                field("Ship-to/Order Address Code"; Rec."Ship-to/Order Address Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the Ship-to/Order Address Code is filled in during the posting of an invoice / credit memo.',
                                ENA = 'Specifies the Ship-to/Order Address Code is filled in during the posting of an invoice / CR/Adj Note.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the Document Date from the applied WHT Entry is stored for applying the WHT Entry table.',
                                ENA = 'Specifies the Document Date from the applied WHT Entry is stored for applying the WHT Entry table.';
                }
                field("Actual Vendor No."; Rec."Actual Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the Actual Vendor No. from which Invoices or Journals is copied.',
                                ENA = 'Specifies the Actual Vendor No. from which Invoices or Journals is copied.';
                }
                field("WHT Certificate No."; Rec."WHT Certificate No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies an auto-generated no. based on the no. series.',
                                ENA = 'Specifies an auto-generated no. based on the no. series.';
                }
                field("Void Check"; Rec."Void Check")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies that this field is marked internally if the transactions have been reversed due to voiding of checks.',
                                ENA = 'Specifies that this field is marked internally if the transactions have been reversed due to voiding of cheques.';
                }
                field("Original Document No."; Rec."Original Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the original document no. from the Invoice or Journal is assigned to this field.',
                                ENA = 'Specifies the original document no. from the Invoice or Journal is assigned to this field.';
                }
                field("Void Payment Entry No."; Rec."Void Payment Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the entry no. of the WHT Entry, which has been voided, with this transaction.',
                                ENA = 'Specifies the entry no. of the WHT Entry, which has been voided, with this transaction.';
                }
                field("WHT Report Line No"; Rec."WHT Report Line No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies an auto-generated field based on the no. series defined in the WHT Posting Setup for a particular WHT Report Type.',
                                ENA = 'Specifies an auto-generated field based on the no. series defined in the WHT Posting Setup for a particular WHT Report Type.';
                }
                field(Settled; Rec.Settled)
                {
                    ToolTip = 'Specifies the value of the Settled field.';
                }
                field("WHT Report"; Rec."WHT Report")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies that this field is assigned from WHT Posting Setup based on WHT Business and WHT Product Posting Group.',
                                ENA = 'Specifies that this field is assigned from WHT Posting Setup based on WHT Business and WHT Product Posting Group.';
                }
                field("WHT Bearer"; Rec."WHT Bearer")
                {
                    ToolTip = 'Specifies the value of the WHT Bearer field.';
                }
            }
        }
    }

    actions
    {
    }
    // BC Upgrade RD03 - adding code to show the records which have WHT Prod Posting Group -- >>
    trigger OnOpenPage()
    begin
        Rec.SetFilter("WHT Prod. Posting Group", '<>%1', '');
    end;
    // BC Upgrade RD03 - adding code to show the records which have WHT Prod Posting Group -- <<
}

