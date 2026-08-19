page 58046 "LSR Master Included/Excluded"
{
    // Heilite Navision Old Id - 50389

    // HEI.01 FDD-HB899 - CHG2044703 IBM GAVANM01 13.12.2020 # New POS System Required for OPCO
    //   # New Page created for LSR Interfaces

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "LSR Master Included/Excluded" to "LSR Master Inc/Exc FND"
    // BC UPGRADE PATELS08 <<

    PageType = List;
    SourceTable = "LSR Master Inc/Exc FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Included; Rec.Included)
                {
                    ToolTip = 'Specifies the value of the Included field.';
                }
                field(Excluded; Rec.Excluded)
                {
                    ToolTip = 'Specifies the value of the Excluded field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.FILTERGROUP(2);
        Rec.SETRANGE(Type, Type_Var);
        Rec.FILTERGROUP(0);
        CurrPage.CAPTION := FORMAT(Type_Var) + ' ' + Text001;
    end;

    var
        Type_Var: Option Item,Customer,Vendor;
        Text001: Label 'Included/Excluded';

    procedure SetType(pType: Option Item,Customer,Vendor);
    begin
        Type_Var := pType;
    end;
}

