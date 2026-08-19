page 58089 "Maraki Details"
{
    // version HEI.01

    // HEI.01 FDD-ET-MARAKI POS Interface IBM NASTAA02 06.08.2019 # Maraki POS Interface
    //   # New Page created
    // HEI.02 HT1010 IBM NASTAA02 02.12.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # Changed code on Page Actions to use the new VIP table created
    // BC Upgrade BHARAD11 >>
    // 1. Change Page ID. Old Page ID is 50341
    // BC Upgrade BHARDA11 <<

    // BC Upgrade PATELP08>>
    // Changed name of table from "EBM Log" to "EBM Log FND"
    // BC Upgrade PATELP08<<

    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Maraki Details';
    PageType = Card;
    SourceTable = "EBM Log FND";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maraki Fiscal No."; Rec."Maraki Fiscal No.")
                {
                    ApplicationArea = All;
                    Editable = Rec."Maraki Supress Value";
                }
                field("Maraki Posted Date"; Rec."Maraki Posted Date")
                {
                    ApplicationArea = All;
                    Editable = Rec."Maraki Supress Value";
                }
                field("Maraki Machine No."; Rec."Maraki Machine No.")
                {
                    ApplicationArea = All;
                    Editable = Rec."Maraki Supress Value";
                }
                field("Maraki Supress Value"; Rec."Maraki Supress Value")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    ApplicationArea = All;
                    Caption = 'Outbound Interface Entries';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        OutInterfaceEntryHeader: Record "Interface Entry Header VIP INT";
                    begin
                        IF MarakiInterfaceSetup.GET THEN BEGIN
                            OutInterfaceEntryHeader.SETRANGE("Interface Code", MarakiInterfaceSetup."Sales Posting Interface");
                            OutInterfaceEntryHeader.SETRANGE("Source No.", Rec."Document No.");
                            PAGE.RUN(PAGE::"Outbound Interface Entries VIP", OutInterfaceEntryHeader); //HEI.02
                        END;
                    end;
                }
                action("Inbound Interface Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Inbound Interface Entries';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
                    begin
                        IF MarakiInterfaceSetup.GET THEN BEGIN
                            InterfaceEntryHeaderVIP.SETFILTER("Interface Code", '%1|%2',
                                                           MarakiInterfaceSetup."Status Update Interface",
                                                           MarakiInterfaceSetup."Sales Confirmation Response");
                            InterfaceEntryHeaderVIP.SETRANGE("Source No.", Rec."Document No.");
                            PAGE.RUN(PAGE::"Inbound Interface Entries VIP", InterfaceEntryHeaderVIP); //HEI.02
                        END;
                    end;
                }
                action("Interface Log")
                {
                    ApplicationArea = All;
                    Caption = 'Interface Log';
                    Image = ImportExport;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT";
                    begin
                        IF MarakiInterfaceSetup.GET THEN BEGIN
                            InterfaceLogHeaderVIP.SETFILTER("Interface Code", '%1|%2|%3',
                                                         MarakiInterfaceSetup."Sales Posting Interface",
                                                         MarakiInterfaceSetup."Status Update Interface",
                                                         MarakiInterfaceSetup."Sales Confirmation Response");
                            InterfaceLogHeaderVIP.SETRANGE("Source No.", Rec."Document No.");
                            PAGE.RUN(PAGE::"Interface Log VIP", InterfaceLogHeaderVIP); //HEI.02
                        END;
                    end;
                }
            }
        }
    }

    var
        MarakiInterfaceSetup: Record "Maraki Interface Setup INT";
}

