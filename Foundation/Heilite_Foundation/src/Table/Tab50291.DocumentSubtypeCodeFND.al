table 50291 "Document Subtype Code FND"
{
    // BC Upgrade BHANDS01 >> 2 Mar 2026 => Created table

    DataClassification = ToBeClassified;
    Caption = 'Document Subtype Code';
    LookupPageID = "Document Subtype Codes";

    fields
    {
        field(1; "Report Selection Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Sales,Purchase,,,,Inventory,Service,,,,,,,,,,,,Fin.Contract';
            OptionMembers = Sales,Purchase,BankAcc,Reminder,CashFlow,Inventory,Service,"P.Service","Prod.Order",,,,,,,,,,"Fin.Contract";
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Posted Invoice Nos."; Code[20])
        {
            Caption = 'Posted Invoice Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(5; "Posted CM. Nos."; Code[20])
        {
            Caption = 'Posted Credit Memo Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }

    procedure InitRecord();
    begin
        "Report Selection Type" := xRec."Report Selection Type"
    end;

    procedure GetPostedSerialNoforDocumentSubtype(Documenttype: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; SubtypeCode: Code[20]): Code[20];
    var
        DocSubtypeCode: Record "Document Subtype Code FND";
    begin
        IF DocSubtypeCode.GET(SubtypeCode) THEN BEGIN
            CASE Documenttype OF
                Documenttype::Quote, Documenttype::Order,
              Documenttype::Invoice:
                    IF DocSubtypeCode."Posted Invoice Nos." <> '' THEN
                        EXIT(DocSubtypeCode."Posted Invoice Nos.");
                Documenttype::"Return Order",
              Documenttype::"Credit Memo":
                    IF DocSubtypeCode."Posted CM. Nos." <> '' THEN
                        EXIT(DocSubtypeCode."Posted CM. Nos.");
            END;
        END;
    end;
}