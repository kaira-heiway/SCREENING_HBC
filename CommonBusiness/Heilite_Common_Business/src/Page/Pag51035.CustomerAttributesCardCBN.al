page 51035 "Customer Attributes Card CBN"
{
    // version HEI.04

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 28.08.2017 # MDM Customer Card
    //   # Removed field "Account Group"
    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 06.10.2017 # MDM Customer Card
    //   # Removed some fields
    // HEI.04 Bugfixing IBM NASTAA02 17.11.2017 # Local Algeria
    //   # Deleted duplicated fields "Business Register" and "Taxable Item"
    // HEI.05 FDD-HT587 IBM BULIMC01 14.10.2019 #new field displayed in General tab: "Classification"
    // HEI.06 CHG2034524 FDD-HT788 IBM GAVANM01 25.02.2020
    //   # "Search" field added in the General tab
    //BC UPGRADE PATHAA02-18/09/25-Done

    Caption = 'Customer Attributes Card';
    PageType = Card;
    SourceTable = "Customer Attributes FND";
    ApplicationArea = All;  // BC Upgrade PATHAA02

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Name 3"; Rec."Name 3")
                {
                    ToolTip = 'Specifies the value of the Name 3 field.';
                }
                field("Name 4"; Rec."Name 4")
                {
                    ToolTip = 'Specifies the value of the Name 4 field.';
                }
                field(Search; Rec.Search)
                {
                    ToolTip = 'Specifies the value of the Search field.';
                }
                field("Search 2"; Rec."Search 2")
                {
                    ToolTip = 'Specifies the value of the Search 2 field.';
                }
                field("C/O Name"; Rec."C/O Name")
                {
                    ToolTip = 'Specifies the value of the C/O Name field.';
                }
                field("Account Group"; Rec."Account Group")
                {
                    ToolTip = 'Specifies the value of the Account Group field.';
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ToolTip = 'Specifies the value of the Customer Type field.';
                }
                field("Business Segment"; Rec."Business Segment")
                {
                    ToolTip = 'Specifies the value of the Business Segment field.';
                }
                field("Business OrganizationalSegment"; Rec."Business OrganizationalSegment")
                {
                    ToolTip = 'Specifies the value of the Business Organizational Segment field.';
                }
                field("Customer Sub-Type"; Rec."Customer Sub-Type")
                {
                    ToolTip = 'Specifies the value of the Customer Sub-Type field.';
                }
                field("Local Customer Sub-Type"; Rec."Local Customer Sub-Type")
                {
                    ToolTip = 'Specifies the value of the Local Customer Sub-Type field.';
                }
                field("Market Type"; Rec."Market Type")
                {
                    ToolTip = 'Specifies the value of the Market Type field.';
                }
                field("Authorization Group"; Rec."Authorization Group")
                {
                    ToolTip = 'Specifies the value of the Authorization Group field.';
                }
                field("Country License"; Rec."Country License")
                {
                    ToolTip = 'Specifies the value of the Country License field.';
                }
                field("License Type"; Rec."License Type")
                {
                    ToolTip = 'Specifies the value of the License Type field.';
                }
                field("License No."; Rec."License No.")
                {
                    ToolTip = 'Specifies the value of the License No. field.';
                }
                field("License Valid from"; Rec."License Valid from")
                {
                    ToolTip = 'Specifies the value of the License Valid from field.';
                }
                field("License Valid to"; Rec."License Valid to")
                {
                    ToolTip = 'Specifies the value of the License Valid to field.';
                }
                field("Payment valid from"; Rec."Payment valid from")
                {
                    ToolTip = 'Specifies the value of the Payment valid from field.';
                }
                field("Payment valid to"; Rec."Payment valid to")
                {
                    ToolTip = 'Specifies the value of the Payment valid to field.';
                }
                field("Strategic Indicator"; Rec."Strategic Indicator")
                {
                    ToolTip = 'Specifies the value of the Strategic Indicator field.';
                }
                field("Local key Account"; Rec."Local key Account")
                {
                    ToolTip = 'Specifies the value of the Local key Account field.';
                }
                field("Flag for Deletion"; Rec."Flag for Deletion")
                {
                    ToolTip = 'Specifies the value of the Flag for Deletion field.';
                }
                field(Classification; Rec.Classification)
                {
                    ToolTip = 'Specifies the value of the Classification field.';
                }
            }
            group("Address & Contact")
            {
                field("Street 3"; Rec."Street 3")
                {
                    ToolTip = 'Specifies the value of the Street 3 field.';
                }
                field("Street 4"; Rec."Street 4")
                {
                    ToolTip = 'Specifies the value of the Street 4 field.';
                }
                field("Street 5"; Rec."Street 5")
                {
                    ToolTip = 'Specifies the value of the Street 5 field.';
                }
                field("House No. 1"; Rec."House No. 1")
                {
                    ToolTip = 'Specifies the value of the House No. 1 field.';
                }
                field("House Supplement 2"; Rec."House Supplement 2")
                {
                    ToolTip = 'Specifies the value of the House Supplement 2 field.';
                }
                field(District; Rec.District)
                {
                    ToolTip = 'Specifies the value of the District field.';
                }
                field("Different City"; Rec."Different City")
                {
                    ToolTip = 'Specifies the value of the Different City field.';
                }
                field("P.O.Box"; Rec."P.O.Box")
                {
                    ToolTip = 'Specifies the value of the P.O.Box field.';
                }
                field("P.O.Box w/0 No."; Rec."P.O.Box w/0 No.")
                {
                    ToolTip = 'Specifies the value of the P.O.Box w/0 No. field.';
                }
                field("Type of Delivery Service"; Rec."Type of Delivery Service")
                {
                    ToolTip = 'Specifies the value of the Type of Delivery Service field.';
                }
                field("Other City"; Rec."Other City")
                {
                    ToolTip = 'Specifies the value of the Other City field.';
                }
                field("No. of Delivery Service"; Rec."No. of Delivery Service")
                {
                    ToolTip = 'Specifies the value of the No. of Delivery Service field.';
                }
                field("P.O.Box Postal Code"; Rec."P.O.Box Postal Code")
                {
                    ToolTip = 'Specifies the value of the P.O.Box Postal Code field.';
                }
                field("Other Country"; Rec."Other Country")
                {
                    ToolTip = 'Specifies the value of the Other Country field.';
                }
                field("Other Region"; Rec."Other Region")
                {
                    ToolTip = 'Specifies the value of the Other Region field.';
                }
                field("Company Postal Code"; Rec."Company Postal Code")
                {
                    ToolTip = 'Specifies the value of the Company Postal Code field.';
                }
            }
            group(Invoicing)
            {
                field("Tax Number 1"; Rec."Tax Number 1")
                {
                    ToolTip = 'Specifies the value of the Tax Number 1 field.';
                }
                field("Tax Number 2"; Rec."Tax Number 2")
                {
                    ToolTip = 'Specifies the value of the Tax Number 2 field.';
                }
                field("Tax Number 3"; Rec."Tax Number 3")
                {
                    ToolTip = 'Specifies the value of the Tax Number 3 field.';
                }
                field("Tax Number 4"; Rec."Tax Number 4")
                {
                    ToolTip = 'Specifies the value of the Tax Number 4 field.';
                }
                field("Legal Form"; Rec."Legal Form")
                {
                    ToolTip = 'Specifies the value of the Legal Form field.';
                }
                field("Invoice Email Address"; Rec."Invoice Email Address")
                {
                    ToolTip = 'Specifies the value of the Invoice Email Address field.';
                }
                field("Trading Partner"; Rec."Trading Partner")
                {
                    ToolTip = 'Specifies the value of the Trading Partner field.';
                }
                field("Registre de Commerce"; Rec."Registre de Commerce")
                {
                    ToolTip = 'Specifies the value of the Registre de Commerce field.';
                }
                field("Article d'imposition"; Rec."Article d'imposition")
                {
                    ToolTip = 'Specifies the value of the Article d''imposition field.';
                }
                field("N.I.S."; Rec."N.I.S.")
                {
                    ToolTip = 'Specifies the value of the N.I.S. field.';
                }
                field(NIF; Rec.NIF)
                {
                    ToolTip = 'Specifies the value of the NIF field.';
                }
                field("Check Digit -VAT"; Rec."Check Digit -VAT")
                {
                    ToolTip = 'Specifies the value of the Check Digit -VAT field.';
                }
                field("Free Goods"; Rec."Free Goods")
                {
                    ToolTip = 'Specifies the value of the Free Goods field.';
                }
            }
            group(Shipping)
            {
                field("Visit day"; Rec."Visit day")
                {
                    ToolTip = 'Specifies the value of the Visit day field.';
                }
            }
        }
    }

    actions
    {
    }
}

