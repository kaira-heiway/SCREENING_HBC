pageextension 51175 AssemblyOrderSubformExtCBN extends "Assembly Order Subform"
{
    //    FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."

    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    // DITW17.10.05 DDR 03/09/2014 DIT-770 #675 Added Tax Assembly Orders functionality
    // DITW17.10.05 DDR 05/09/2014 DIT-770 #675 Modified Caption 'Insert Tax Charges'
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Cost"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #new fields Zone Code
    // HEI.02 FDD-PRDGAP031 IBM PATHAA02 09.11.2017
    // #Code on OnAfterGetRecord

    layout
    {
        addbefore("Bin Code")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
        }
        modify(Description)
        {
            Editable = EditableDesc;
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //HEI.02 PATHAA02 07.11.2017>>
        IF Rec.Type <> Rec.Type::Item THEN
            EditableDesc := TRUE
        else
            EditableDesc := FALSE;
        //PATHAA02 07.11.2017<<
    end;

    var
        EditableDesc: Boolean;
        myInt: Integer;
}