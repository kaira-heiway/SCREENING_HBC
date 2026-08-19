page 58022 "EBMS Document Status"
{
    // Heilite Navision Old Id - 50263

    // version HEI.03

    // HEI.01 CHG2151260-HB2788 SOICAD02 08.11.2022 Page created
    // HEI.02 CHG2151260 HB2788 BHANDS01 30.12.2022 # Burundi Fiscal Invoice
    //   # New fields added
    //   # Actions Added
    // HEI.03 CHG2151260 HB2788 COSTES04 06.01.2023 # Burundi Fiscal Invoice
    //   # New fields added

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "EBMS Document Status FND";
    ApplicationArea = ALl;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Invoice Details Created"; Rec."Invoice Details Created")
                {
                    ToolTip = 'Specifies the value of the Invoice Details Created field.';
                }
                field("Invoice Details Outbnd Status"; Rec."Invoice Details Outbnd Status")
                {
                    ToolTip = 'Specifies the value of the Invoice Details Outbound Status field.';
                }
                field("Invoice Details Sent to EBMS"; Rec."Invoice Details Sent to EBMS")
                {
                    ToolTip = 'Specifies the value of the Invoice Details Sent to EBMS field.';
                }
                field("Invoice Details Inbound Status"; Rec."Invoice Details Inbound Status")
                {
                    ToolTip = 'Specifies the value of the Invoice Details Inbound Status field.';
                }
                field("Invoice Fields rcvd from EBMS"; Rec."Invoice Fields rcvd from EBMS")
                {
                    ToolTip = 'Specifies the value of the Invoice Response Received from EBMS field.';
                }
                field("Last Updated"; Rec."Last Updated")
                {
                    ToolTip = 'Specifies the value of the Last Updated field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Document)
            {
                Caption = 'Document';
                Image = "Action";
                action("Outbound Interface Entries")
                {
                    Caption = 'Outbound Interface Entries';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Outbound Interface Entries action.';

                    trigger OnAction();
                    var
                        OutInterfaceEntryHeader: Record "Interface Entry Header INT";
                        OutInterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
                    begin
                        //HEI.02>>
                        EBMSInterfaceSetup.GET();
                        OutInterfaceEntryHeaderVIP.SETFILTER("Interface Code", '%1|%2',
                                                           EBMSInterfaceSetup."Send Invoice Interface",
                                                           EBMSInterfaceSetup."Sales Confirmation Interface");
                        OutInterfaceEntryHeaderVIP.SETRANGE("Source No.", Rec."Document No.");
                        if OutInterfaceEntryHeaderVIP.findset() then begin
                            PAGE.RUN(PAGE::"Outbound Interface Entries VIP", OutInterfaceEntryHeaderVIP);
                            exit;
                        end;
                        //HEI.02<<
                    end;
                }
                action("Inbound Interface Entries")
                {
                    Caption = 'Inbound Interface Entries';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Inbound Interface Entries action.';

                    trigger OnAction();
                    var
                        InterfaceEntryHeader: Record "Interface Entry Header INT";
                        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
                    begin
                        //HEI.02>>
                        EBMSInterfaceSetup.GET();
                        InterfaceEntryHeaderVIP.SETFILTER("Interface Code", '%1|%2',
                                                       EBMSInterfaceSetup."Send Invoice Interface",
                                                       EBMSInterfaceSetup."Sales Confirmation Interface");
                        InterfaceEntryHeaderVIP.SETRANGE("Source No.", Rec."Document No.");
                        if InterfaceEntryHeaderVIP.findset() then begin
                            PAGE.RUN(PAGE::"Inbound Interface Entries VIP", InterfaceEntryHeaderVIP);
                            exit;
                        end;
                        //HEI.02<<
                    end;
                }
                action("Interface Log")
                {
                    Caption = 'Interface Log';
                    Image = ImportExport;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Interface Log action.';

                    trigger OnAction();
                    var
                        InterfaceLogHeader: Record "Interface Log Header INT";
                        InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT";
                    begin
                        //HEI.02>>
                        EBMSInterfaceSetup.GET();
                        InterfaceLogHeaderVIP.SETFILTER("Interface Code", '%1|%2',
                                                     EBMSInterfaceSetup."Send Invoice Interface",
                                                     EBMSInterfaceSetup."Sales Confirmation Interface");
                        InterfaceLogHeaderVIP.SETRANGE("Source No.", Rec."Document No.");
                        if InterfaceLogHeaderVIP.findset() then begin
                            PAGE.RUN(PAGE::"Interface Log VIP", InterfaceLogHeaderVIP);
                            exit;
                        end;
                        //HEI.02<<
                    end;
                }
            }
        }
    }

    var
        EBMSInterfaceSetup: Record "EBMS Interface Setup INT";
}

