table 50153 "Job Queue Log Entry Detail FND"
{
    // version HEI.02,SB

    // HEI.01 FDD-HD-545 IBM POSTOI01 11.10.2019 # Self-Billing
    //   # New Table
    // HEI.02 FDD-HD-545 IBM POSTOI01 27.11.2019 # Self-Billing
    //   # add code to Document No - OnLookup
    //   # delete TableRelation property on "Document No." field

    // BC Upgrade SHUKLP03 >> Added document subtype code added.


    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "User ID"; Text[65])
        {
        }
        field(3; "Execution Date/Time"; DateTime)
        {
        }
        field(4; "Entry Type"; Option)
        {
            OptionMembers = " ",Sale,Purchase;
        }
        field(5; "Document No"; Code[20])
        {

            trigger OnLookup();
            var
                POPurchInv: Page "PO Purchase Invoices";
                PurchInvHeader: Record "Purch. Inv. Header";
                PurchHeader: Record "Purchase Header";
                PurchPaySetup: Record "Purchases & Payables Setup";
                PurchInvList: Page "Posted Purchase Invoices";
                PurchInv: Page "Purchase List";
            begin
                //HEI.02>>
                if PurchPaySetup.GET() then;
                if "Document Type" = "Document Type"::Invoice then begin
                    PurchHeader.RESET();
                    PurchHeader.SETRANGE(PurchHeader."Document Type", PurchHeader."Document Type"::Invoice);
                    PurchHeader.SETRANGE(PurchHeader."No.", Rec."Document No");
                    if PurchHeader.FINDFIRST() then
                        if PurchHeader."Document Subtype Code FND" = PurchPaySetup."PO Subtype Code FND" then begin
                            POPurchInv.SETTABLEVIEW(PurchHeader);
                            POPurchInv.LOOKUPMODE := true;
                            if POPurchInv.RUNMODAL = ACTION::LookupOK then;
                        end else begin
                            PurchInv.SETTABLEVIEW(PurchHeader);
                            PurchInv.LOOKUPMODE := true;
                            if PurchInv.RUNMODAL() = ACTION::LookupOK then;
                        end;
                end else
                    if "Document Type" = "Document Type"::"Posted Invoice" then begin
                        PurchInvHeader.RESET();
                        PurchInvHeader.SETRANGE(PurchInvHeader."No.", Rec."Document No");
                        PurchInvList.SETTABLEVIEW(PurchInvHeader);
                        PurchInvList.LOOKUPMODE := true;
                        if PurchInvList.RUNMODAL() = ACTION::LookupOK then;
                    end;
            end;
            //HEI.02<<
        }
        field(6; "Document Status"; Option)
        {
            OptionMembers = "Not Created",Created,Posted,Printed,Email;
        }
        field(7; Message; Text[250])
        {
        }
        field(8; "Message 1"; Text[250])
        {
        }
        field(9; "Message 2"; Text[250])
        {
        }
        field(10; "Message 3"; Text[250])
        {
        }
        field(11; "Document Type"; Option)
        {
            OptionMembers = Invoice,Receipt,Shipment,"Cr.Memo","Posted Invoice","Posted Receipt","Posted Shipment","Posted Cr.Memo";
        }
        field(12; Description; Text[250])
        {
        }
        field(13; "Job Queue ID"; Guid)
        {
            CaptionML = ENU = 'ID',
                        FRA = 'ID';
            TableRelation = "Job Queue Entry".ID;
        }
        field(14; "JQ Object Type to Run"; Option)
        {
            CaptionML = ENU = 'Object Type to Run',
                        FRA = 'Type objet à exécuter';
            InitValue = "Report";
            OptionCaptionML = ENU = ',,,Report,,Codeunit',
                              FRA = ',,,Report,,Codeunit';
            OptionMembers = ,,,"Report",,"Codeunit";
        }
        field(15; "JQ Object ID to Run"; Integer)
        {
            CaptionML = ENU = 'Object ID to Run',
                        FRA = 'ID objet à exécuter';

            trigger OnLookup();
            var
                NewObjectID: Integer;
            begin
            end;

            trigger OnValidate();
            var
            //"Object": Record "Object";
            begin
            end;
        }
        field(16; "JQ Object Caption to Run"; Text[250])
        {
            CaptionML = ENU = 'Object Caption to Run',
                        FRA = 'Légende de l''objet à exécuter';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

