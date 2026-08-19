pageextension 51062 WarehouseEmployeesExtCBN extends "Warehouse Employees"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    //     DITW15.00.00.35 DDR 06/10/2009 issue 516 Added field "Physical Location Group Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added Fields Zone Code
    //BC Upgrade GUNREM01 >> - cretaed new page instead of base page to add zone code as part of primary key along with user id and location code to avoid duplicate records for same user and location code combination with different zone code.
    Caption = 'N/A Warehouse Employees';
    AdditionalSearchTerms = '-NOT IN USE';
    //BC Upgrade GUNREM01 << - cretaed new page instead of base page to add zone code as part of primary key along with user id and location code to avoid duplicate records for same user and location code combination with different zone code.

    layout
    {
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the user ID of the warehouse employee.', FRA = 'Spécifie le code utilisateur du magasinier.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location in which the employee works.', FRA = 'Spécifie le code du magasin avec lequel travaille l''employé.';
        }
        modify(Default)
        {
            ToolTipML = ENU = 'Specifies that the location code that is defined as the default location for this employee''s activities.', FRA = 'Spécifie le code magasin qui est défini comme magasin par défaut pour ces activités d''employé.';
        }
        modify("ADCS User")
        {
            CaptionML = ENU = 'ADCS User', FRA = 'Utilisateurs ADCS';
            ToolTipML = ENU = 'Specifies the ADCS user name of a warehouse employee.', FRA = 'Spécifie le nom d''utilisateur ADCS d''un employé de l''entrepôt.';
        }
        addafter("Location Code")
        {
            // field("Physical Location Group Code"; "Physical Location Group Code")
            // {
            // }  // BC Upgrade NANDIS03
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                DrillDownPageID = "Zone List";
                LookupPageID = "Zone List";
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

