pageextension 51094 CustomerTemplListExtCBN extends "Customer Templ. List" //  //BC Upgrade Kamnay01 Customer Template List page is replaced by Customer Templ. List"
{
    //     HEI.01 FDD-SLSGAP001 IBM NASTAA02 14.09.2017 # MDM Customer Card
    //   # Replaced Editable - No property with InsertAllowed, ModifyAllowed and DeleteAllowed - No
    // HEI.03 CHG2035637 IBM.LS 14.01.2020
    //   # New Field added: Blocked
    //BC Upgrade Kamnay01>> 
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    //BC Upgrade Kamnay01<<
    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code for the customer template. You can set up as many codes as you want. The code must be unique. You cannot have the same code twice in one table.', FRA = 'Spécifie le code du modèle client. Vous pouvez créer autant de codes que vous le souhaitez. Le code doit être unique, vous ne pouvez pas avoir le même code deux fois dans une table.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the customer template.', FRA = 'Spécifie la description du groupe du modèle client.';
        }
        // BC Upgrade Kamnay01>>This field are not added in the new page Customer Templ. List
        // modify("Country/Region Code")
        // {
        //     ToolTipML = ENU='Specifies the country/region code for the customer template.',FRA='Spécifie le code pays/la région du modèle client.';
        // }
        // modify("Territory Code")
        // {
        //     ToolTipML = ENU='Specifies the territory code for the customer template.',FRA='Spécifie le code de territoire du modèle client.';
        // }
        // modify("Currency Code")
        // {
        //     ToolTipML = ENU='Specifies the currency code for the customer template.',FRA='Spécifie le code devise du modèle client.';
        // }
        // BC Upgrade Kamnay01<<This field are not added in the new page Customer Templ. List
        addafter("Contact Type")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Location Code field.';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Responsibility Center field.';
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping Agent Code field.';
            }
            //BC Upgrade Kamnay01>> DITW fields 
            // field("Tax Office Code";Rec."Tax Office Code")
            // {
            //     Visible = false;
            // }
            // field("DTax Group Code";Rec."DTax Group Code")
            // {
            //     Visible = false;
            // }
            //BC Upgrade Kamnay01>> DITW fields 
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Posting Group field.';
            }
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Price Group field.';
            }
            field("Customer Disc. Group"; Rec."Customer Disc. Group")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Disc. Group field.';
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Blocked field.';
            }
        }
    }
    // BC Upgrade Kamnay01<<This Actions are not added in the new page Customer Templ. List
    // actions
    // {
    //     modify("&Customer Template")
    //     {
    //         CaptionML = ENU = '&Customer Template', FRA = '&Modèle client';
    //     }
    //     modify(Dimensions)
    //     {
    //         CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
    //     }
    //     modify("Dimensions-Single")
    //     {
    //         CaptionML = ENU = 'Dimensions-Single', FRA = 'Affectations - Simples';
    //         ToolTipML = ENU = 'View or edit the single set of dimensions that are set up for the selected record.', FRA = 'Affichez ou modifiez l''ensemble unique de dimensions paramétrées pour l''enregistrement sélectionné.';
    //     }
    //     modify("Dimensions-&Multiple")
    //     {
    //         CaptionML = ENU = 'Dimensions-&Multiple', FRA = 'Affectations - &Multiples';
    //         ToolTipML = ENU = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.', FRA = 'Affichez ou modifiez les axes analytiques pour un groupe d''enregistrements. Vous pouvez affecter des codes axe aux transactions dans le but de répartir les coûts et d''analyser les informations d''historique.';
    //     }
    // }
    // BC Upgrade Kamnay01>>This field are not added in the new page Customer Templ. List

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyDeletion. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

