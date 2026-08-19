tableextension 50061 GLRegisterExtFND extends "G/L Register"
{
    // version NAVW17.00,HEI.02
    // HEI.01 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.02 CHG2255472 IBM YADAVM09 06.08.2024 HB3976_Journal Template Name and Batch to be populated on Journal Entry
    //   #New field Added "Journal Template Name"
    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("From Entry No.")
        {
            CaptionML = ENU = 'From Entry No.', FRA = 'N° séquence début';
        }
        modify("To Entry No.")
        {
            CaptionML = ENU = 'To Entry No.', FRA = 'N° séquence fin';
        }
        modify("Creation Date")
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("From VAT Entry No.")
        {
            CaptionML = ENU = 'From VAT Entry No.', FRA = 'N° séquence TVA début';
        }
        modify("To VAT Entry No.")
        {
            CaptionML = ENU = 'To VAT Entry No.', FRA = 'N° séquence TVA fin';
        }
        modify(Reversed)
        {
            CaptionML = ENU = 'Reversed', FRA = 'Contre-passé';
        }
        field(50000; "From WHT Entry No. FND"; Integer)
        {
            Caption = 'From WHT Entry No.';
            Description = 'HEI.01';
        }
        field(50001; "To WHT Entry No. FND"; Integer)
        {
            Caption = 'To WHT Entry No.';
            Description = 'HEI.01';
        }
        field(50002; "Journal Template Name FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Caption = 'Journal Template Name';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

