page 54041 "Transfer Order IC Log Entries"
{
    // version HEI.01

    // HEI.01 FDD-HT1304 IBM NASTAA02 06.07.2020 # IC Transfer Order Automation
    //   # New Page created for IC Transfer Order Log
    // HEI.02 CHG2090349IBM NASTAA02 09.12.2020 #Bralima opco, difference between the time and date of inter-company transfer
    //   # Added French Translations
    // BC Upgrade BHARAD11 >>
    // 1. OLD Page ID - 50267.
    // 2. Add ApplicationArea Property in Page , fields and actions.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    CaptionML = ENU = 'Transfer Order IC Log Entries',
                FRA = 'Ecritures Ordre de transfert IC Log';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Transfer Ord. IC Log Entry DTW";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("From Company"; Rec."From Company")
                {
                    ApplicationArea = All;
                }
                field("To Company"; Rec."To Company")
                {
                    ApplicationArea = All;
                }
                field("Created Document Type"; Rec."Created Document Type")
                {
                    ApplicationArea = All;
                }
                field("Created Document No."; Rec."Created Document No.")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Creation Time"; Rec."Creation Time")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Last Error"; Rec."Last Error")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            // Caption = 'Options';
            action(ShowRequestXML)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Show Request XML',
                            FRA = 'Montrer la Requête XML';
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Rec.ShowXML();
                end;
            }
            action(OpenRecord)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Open Created Transfer Order',
                            FRA = 'Ordre de Transfert créé ouvert';
                Enabled = CreatedTOVisible;
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Rec.OpenCreatedTO();
                end;
            }
            action(ResendXMLRequest)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Resend XML Request',
                            FRA = 'Renvoyer la Requête XML';
                Enabled = ResendXMLVisible;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Rec.ResendXML();
                end;
            }
            action(Reprocess)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Reprocess Transfer Order Creation',
                            FRA = 'Recréer l''Ordre de Transfert';
                Enabled = ReprocessVisible;
                Image = Reuse;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Rec.Reprocess();
                end;
            }
            action(ReprocessShipment)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Reprocess Transfer Shipment Creation',
                            FRA = 'Recréer l''Expédition Transfert';
                Enabled = ReprocessShipVisible;
                Image = Shipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    TransferHeader: Record "Transfer Header";
                    TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW";
                    ICTransferOrderWS: Codeunit "IC Transfer Order WS";
                    TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
                begin
                    if (Rec."Created Document No." <> '') and (Rec.Status <> Rec.Status::"Posting info. Exported") then begin
                        //Post Transfer Order - Shipment
                        TransferHeader.GET(Rec."Created Document No.");
                        if not TransferPostShipment.RUN(TransferHeader) then begin
                            Rec."Last Error" := GETLASTERRORTEXT;
                            Rec.MODIFY(true);
                        end;

                        ICTransferOrderWS.SendAPIResponse(Rec);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        CreatedTOVisible := (Rec."To Company" = COMPANYNAME) and (Rec."Created Document No." <> '');
        ResendXMLVisible := (Rec."From Company" = COMPANYNAME);
        ReprocessVisible := (Rec."To Company" = COMPANYNAME) and (Rec."Created Document No." = '');
        ReprocessShipVisible := (Rec."To Company" = COMPANYNAME) and (Rec."Created Document No." <> '') and (Rec.Status <> Rec.Status::"Posting info. Exported");
    end;

    var
        CreatedTOVisible: Boolean;
        ResendXMLVisible: Boolean;
        ReprocessVisible: Boolean;
        ReprocessShipVisible: Boolean;
}

