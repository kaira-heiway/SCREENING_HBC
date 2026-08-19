table 50008 "User Gen. Journal Setup FND"
{
    // version HEI.02

    // HEI.01 HELITEBASE FDD-GAPLOG012 IBM.NAIKH01 14/06/2017
    //   # Created a new Table "User Gen. Journal Setup"
    // HEI.02 CHG2238142 IBM YADAVM09 21.03.2024 #Harmonization of RTR templates plus disabling old templates
    //   #code added for on lookup on "Gen. Journal Template Name"


    fields
    {
        field(1; "Journal Type"; Option)
        {
            OptionCaption = 'General,Item';
            OptionMembers = General,Item;
        }
        field(2; "User ID"; Code[20])
        {

            TableRelation = User."User Name";  // BC Upgrade NANDIS03
            ValidateTableRelation = false; // BC Upgrade NANDIS03
            trigger OnLookup();
            var
                Users: Record User;
                //UserMgt: Codeunit "User Management";  // BC Upgrade NANDIS03
                UserSelection: Codeunit "User Selection";  // BC Upgrade NANDIS03
            begin
                // BC Upgrade NANDIS03 >>
                //UserMgt.LookupUserID("User ID");  
                UserSelection.Open(Users);
                "User ID" := Users."User Name";
                // BC Upgrade NANDIS03 <<
            end;

            trigger OnValidate();
            var
                //UserMgt: Codeunit "User Management";  // BC Upgrade NANDIS03
                UserSelection: Codeunit "User Selection";  // BC Upgrade NANDIS03
            begin
                //UserMgt.ValidateUserID("User ID");  // BC Upgrade NANDIS03
                UserSelection.ValidateUserName("User ID");  // BC Upgrade NANDIS03
            end;
        }
        field(3; "Gen. Journal Template Name"; Code[10])
        {
            CaptionML = ENU = 'Gen. Journal Template Name',
                        FRA = 'Gen. Journal Template Name';
            TableRelation = IF ("Journal Type" = CONST(General)) "Gen. Journal Template"
            else IF ("Journal Type" = CONST(Item)) "Item Journal Template";

            trigger OnLookup();
            begin
                //HEI.02
                if Rec."Journal Type" = Rec."Journal Type"::General then begin
                    if PAGE.RUNMODAL(PAGE::"Gen Temp. for  lookup", GenJournalTemplate) = ACTION::LookupOK then
                        "Gen. Journal Template Name" := GenJournalTemplate.Name;
                end else begin
                    if PAGE.RUNMODAL(PAGE::"Item Journal Templates", ItemJournalTemplate) = ACTION::LookupOK then
                        "Gen. Journal Template Name" := ItemJournalTemplate.Name;
                end;
                //HEI.02
            end;
        }
    }

    keys
    {
        key(Key1; "Journal Type", "User ID", "Gen. Journal Template Name")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GenJournalTemplate: Record "Gen. Journal Template";
        ItemJournalTemplate: Record "Item Journal Template";
        Text001: Label 'You do not have permission to access Gen. Journal Template %1, Contact administrator for assistance.';
        Text002: Label 'You do not have permission to access Item Journal Template %1, Contact administrator for assistance.';

    procedure CheckUserTemplateSetup(JournalType: Option General,Item; TemplateName: Code[10]);
    var
        UserJnlTemplate: Record "User Gen. Journal Setup FND";
    begin
        if not UserJnlTemplate.GET(JournalType, USERID, TemplateName) then begin
            if JournalType = JournalType::General then
                ERROR(Text001, TemplateName);
            if JournalType = JournalType::Item then
                ERROR(Text002, TemplateName);
        end;
    end;
}

