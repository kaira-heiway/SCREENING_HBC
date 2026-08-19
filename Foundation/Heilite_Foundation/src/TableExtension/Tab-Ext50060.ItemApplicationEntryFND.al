tableextension 50060 ItemApplicationEntryExtFND extends "Item Application Entry"
{
    // version NAVW110.0
    // HEI.01 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Replaced FINDSET with FINDSET(false,false) of function AppliedInbndTransEntryExists() & AppliedOutbndEntryExists()
    //   # Replaced Count=1 with FIND('-') and Next=0
    // HEI.02 CHG2228022 IBM-PATHAA02/VORGIM01 14.11.2023
    //  # Optimization for Adjust Cost-Item Entries, Remove Table Locking
    // BC Upgrade NANDIS03 - No code moved as expecting BC will take care optimization and table locking feature
    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Item Ledger Entry No.")
        {
            CaptionML = ENU = 'Item Ledger Entry No.', FRA = 'N° écriture comptable article';
        }
        modify("Inbound Item Entry No.")
        {
            CaptionML = ENU = 'Inbound Item Entry No.', FRA = 'N° écriture article entrant';
        }
        modify("Outbound Item Entry No.")
        {
            CaptionML = ENU = 'Outbound Item Entry No.', FRA = 'N° écriture article sortant';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Transferred-from Entry No.")
        {
            CaptionML = ENU = 'Transferred-from Entry No.', FRA = 'Transféré à partir de l''écriture n°';
        }
        modify("Creation Date")
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
        }
        modify("Created By User")
        {
            CaptionML = ENU = 'Created By User', FRA = 'Créé par l''utilisateur';
        }
        modify("Last Modified Date")
        {
            CaptionML = ENU = 'Last Modified Date', FRA = 'Date dernière modification';
        }
        modify("Last Modified By User")
        {
            CaptionML = ENU = 'Last Modified By User', FRA = 'Dernière modification par l''utilisateur';
        }
        modify("Cost Application")
        {
            CaptionML = ENU = 'Cost Application', FRA = 'Coût lettré';
        }
        modify("Output Completely Invd. Date")
        {
            CaptionML = ENU = 'Output Completely Invd. Date', FRA = 'Date prod. entièrement fact.';
        }
        modify("Outbound Entry is Updated")
        {

            //Unsupported feature: Change InitValue on ""Outbound Entry is Updated"(Field 5805)". Please convert manually.

            CaptionML = ENU = 'Outbound Entry is Updated', FRA = 'Écriture sortante mise à jour';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyModification on "Text001(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You have to run the %1 batch job, before you can revalue %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You have to run the %1 batch job, before you can revalue %2 %3.;FRA=Vous devez exécuter le traitement par lots %1 avant de pouvoir réévaluer %2 %3.;
    //Variable type has not been exported.
}

