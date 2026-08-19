pageextension 51074 ReturnReasons_ExtCBN extends "Return Reasons"
{
    // DITW19.00.08 AKH 23/09/2016 BL#10763 (DIT-770 #1216) Added new action "Return Reason - Location Relation"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 CHG2200362 IBM COSTES04 30.05.2023 Updating Return reasons Code
    //   # New field Blocked

    layout
    {   //BC Upgrade KAMNAY01>> 
        addafter("Inventory Value Zero")
        {
            field(Blocked; Rec."Blocked FND")
            {
                ApplicationArea = All;
                Caption = 'Blocked';
                ToolTip = 'Specifies the value of the Blocked field.';
            }
            //BC Upgrade KAMNAY01<<
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Code(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Code(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Default Location Code"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Default Location Code"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Inventory Value Zero"(Control 11)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Inventory Value Zero"(Control 11)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

