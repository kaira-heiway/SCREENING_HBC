page 58067 "Ibecor Situational File"
{
    // Heilite Navision Old Id - 50464

    // version HEI.05

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 23.07.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface
    // HEI.02 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Field shown in page - "Arrival Date Destination Port"
    // HEI.03 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Page is filtered for Registered Shipment Type
    // HEI.04 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Filter removed on Page level which was added in HEI.03
    // HEI.05 CHG2290079_HB4228_StP_Report CHOUDS08 04.03.2025 for Ibecor- Heilite Integration INT04- shipment update II V
    //   # New field added - Update Date & Time - Data Type - DateTime

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Ibecor Situational File FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Editable = false;
    PageType = List;
    SourceTable = "Ibecor Situational File FND";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Shipment No. field.';
                }
                field("Shipment Type"; Rec."Shipment Type")
                {
                    ToolTip = 'Specifies the value of the Shipment Type field.';
                }
                field("Entry No"; Rec."Entry No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field("Expected Date Departure"; Rec."Expected Date Departure")
                {
                    ToolTip = 'Specifies the value of the Expected Date Departure field.';
                }
                field("Departure Date"; Rec."Departure Date")
                {
                    ToolTip = 'Specifies the value of the Departure Date field.';
                }
                field("Date Orig. Docs Sent"; Rec."Date Orig. Docs Sent")
                {
                    ToolTip = 'Specifies the value of the Date Orig. Docs Sent field.';
                }
                field("Date Copy Docs Sent"; Rec."Date Copy Docs Sent")
                {
                    ToolTip = 'Specifies the value of the Date Copy Docs Sent field.';
                }
                field("Date Orig. CRF Sent"; Rec."Date Orig. CRF Sent")
                {
                    ToolTip = 'Specifies the value of the Date Orig. CRF Sent field.';
                }
                field("Date Copy CRF Sent"; Rec."Date Copy CRF Sent")
                {
                    ToolTip = 'Specifies the value of the Date Copy CRF Sent field.';
                }
                field("Date Orig. B/L Sent"; Rec."Date Orig. B/L Sent")
                {
                    ToolTip = 'Specifies the value of the Date Orig. B/L Sent field.';
                }
                field("Date Copy B/L Sent"; Rec."Date Copy B/L Sent")
                {
                    ToolTip = 'Specifies the value of the Date Copy B/L Sent field.';
                }
                field("Vessel Name"; Rec."Vessel Name")
                {
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                }
                field("Expected Date Arrival"; Rec."Expected Date Arrival")
                {
                    ToolTip = 'Specifies the value of the Expected Date Arrival field.';
                }
                field("B/L-AWB"; Rec."B/L-AWB")
                {
                    ToolTip = 'Specifies the value of the B/L-AWB field.';
                }
                field("Shipment Description"; Rec."Shipment Description")
                {
                    ToolTip = 'Specifies the value of the Shipment Description field.';
                }
                field("Tracking Information"; Rec."Tracking Information")
                {
                    ToolTip = 'Specifies the value of the Tracking Information field.';
                }
                field("Reference SDV"; Rec."Reference SDV")
                {
                    ToolTip = 'Specifies the value of the Reference SDV field.';
                }
                field("Date Receipt Docs Supplier"; Rec."Date Receipt Docs Supplier")
                {
                    ToolTip = 'Specifies the value of the Date Receipt Docs Supplier field.';
                }
                field("Date Receipt Docs Forwarder"; Rec."Date Receipt Docs Forwarder")
                {
                    ToolTip = 'Specifies the value of the Date Receipt Docs Forwarder field.';
                }
                field("Volume in m3"; Rec."Volume in m3")
                {
                    ToolTip = 'Specifies the value of the Volume in m3 field.';
                }
                field("Nbr cont. 20 feet"; Rec."Nbr cont. 20 feet")
                {
                    ToolTip = 'Specifies the value of the Nbr cont. 20 feet field.';
                }
                field("Nbr cont. 40 feet"; Rec."Nbr cont. 40 feet")
                {
                    ToolTip = 'Specifies the value of the Nbr cont. 40 feet field.';
                }
                field("Dossier Number"; Rec."Dossier Number")
                {
                    ToolTip = 'Specifies the value of the Dossier Number field.';
                }
                field("Arrival Date Destination Port"; Rec."Arrival Date Destination Port")
                {
                    ToolTip = 'Specifies the value of the Arrival Date In Port of Destination field.';
                }
                field("Update Date & Time"; Rec."Update Date & Time")
                {
                    ToolTip = 'Specifies the value of the Update Date & Time field.';
                }
            }
        }
    }

    actions
    {
    }
}

