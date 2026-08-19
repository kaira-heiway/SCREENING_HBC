namespace LocalBCHeiliteInterface.LocalBCHeiliteInterface;

using Microsoft.Inventory.Ledger;

pageextension 58069 "ItemLegderEntriesExtINT" extends "Item Ledger Entries"
//HEI.02 FDD-BA-SLSGAP01 IBM NASTAA02 10.12.2018 # Counterpoint Interface
//   # Added Fields "External Document No.", "Vendor No.", "Vendor Name" and "CP Vendor Invoice No."
// HEI.03 CHG2012342 IBM GAVANM01 19/11/2019 # Your Reference added
// HEI.04 CHG2039137 IBM.LS 28.02.2020
//   # New Field added - "Dimension Set ID"
// HEI.05 CHG2065153 IBM KUMARN15 23.06.2020
//   # Added field "Source System Identifier"
// HEI.06 HT1615 BULIMC01 IBM 16.09.2020 #new field created: "Zone Code"
// HEI.07 CHG2077659(SC+) IBM.AK 02.09.20
//   # Changed the caption of "Quantity" field to "Quantity (Base UoM)"
// HEI.08 CHG2131272 IBM.LS      14.12.2021
//   # Added New Field - Reporting Type

//BC upgrade GUNREM01 - added interface fields.
{
    layout
    {
        addafter("Vendor Name")
        {
            //BC Upgrade GUNREM01 added  >>
            field("CP Vendor Invoice No."; Rec."CP Vendor Invoice No. INT")
            {
                Description = 'HEI.02';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CP Vendor Invoice No. field.';
            }
            //BC Upgrade GUNREM01 added <<
        }
    }
}
