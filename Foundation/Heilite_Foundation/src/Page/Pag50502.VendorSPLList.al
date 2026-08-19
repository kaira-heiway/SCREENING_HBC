page 50502 "Vendor SPL List"
{
    // version HEI.03

    // HEI.01 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # page created
    // HEI.02 CHG2162715 HB3020 NORRIQ KOROLA04 30.11.2022
    //   Default - field removed
    // HEI.03 CHG2162715 HB3020 NORRIQ KOROLA04 14.12.2022
    //   # DUNS Number, Account Group, GLN - fields created

    CardPageID = "Vendor SPL Card";
    Editable = false;
    PageType = List;
    SourceTable = "Vendor SPL Relation FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("SPL Code"; Rec."SPL Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SPL Code field.';
                }
                field("Global Vendor Number"; Rec."Global Vendor Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parent Legal Entity field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name 2 field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Industry Key"; Rec."Industry Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Industry Key field.';
                }
                field("DUNS Number"; Rec."DUNS Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DUNS Number field.';
                }
                field("Account Group"; Rec."Account Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Group field.';
                }
                field(GLN; Rec.GLN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GLN field.';
                }
                field("Marked for Deletion"; Rec."Marked for Deletion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marked for Deletion field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
            }
        }
    }

    actions
    {
    }
}

