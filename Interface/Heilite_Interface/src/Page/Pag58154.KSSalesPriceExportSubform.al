page 58154 "KS Sales Price Export Subform"
{
    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Code added to OnOpenPage,
    //                                               MaxPiecePrice,MinPiecePrice,
    //                                               MinUnitPrice,MaxUnitPrice variables added
    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 06.12.2019 # OnOpenPage func. modified
    // BC Upgrade SHUKLP03 >> Added application area.

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Sales Price";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; OrtecKStoreInterfaceSetup."Customer Price Group Code")
                {
                }
                field(Description; CustomerPriceGroup.Description)
                {
                }
                field(Country; CompanyInformation."Country/Region Code")
                {
                }
                field(PriceList; Rec."Sales Code")
                {
                }
                field(ItemCode; Rec."Item No.")
                {
                }
                field(DefaultSalesValue; Rec."Unit Price")
                {
                }
                field(Price1; Price1)
                {
                }
                field(CurrencyCode; CurrencyCode)
                {
                }
                field(UnitCode; Unitcode)
                {
                }
                field(PricelistType; PricelistType)
                {
                }
                field(AccountType; AccountType)
                {
                }
                field(DiscountType; DiscountType)
                {
                }
                field(Quantity1; Quantity1)
                {
                }
                field(LineType; LineType)
                {
                }
                field(ValidFrom; ConvertDate(Rec."Starting Date"))
                {
                }
                field(ValidTo; ConvertDate(Rec."Ending Date"))
                {
                }
                field(Sysmodified; ConvertDate(Rec."Last Date Modified FND"))
                {
                }
                field(ItemAssortment; DefaultDimension."Dimension Value Code")
                {
                }
                field(UnitFactor; UnitFactor)
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified FND")
                {
                }
                field(MinUnitPrice; MinUnitPrice)
                {
                    Caption = 'MinUnitPrice';
                }
                field(MaxUnitPrice; MaxUnitPrice)
                {
                    Caption = 'MaxUnitPrice';
                    DecimalPlaces = 0 : 2;
                }
                field(MinPiecePrice; MinPiecePrice)
                {
                    Caption = 'MinPiecePrice';
                }
                field(MaxPiecePrice; MaxPiecePrice)
                {
                    Caption = 'MaxPiecePrice';
                    DecimalPlaces = 0 : 2;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        if Rec."Currency Code" = '' then
            CurrencyCode := GeneralLedgerSetup."LCY Code"
        else
            CurrencyCode := Rec."Currency Code";

        if DefaultDimension.GET(27, Rec."Item No.", GeneralLedgerSetup."Brand Dimension Code FND") then;
        if Rec."Unit of Measure Code" <> '' then
            Unitcode := Rec."Unit of Measure Code"
        else
            Unitcode := '1';
    end;

    trigger OnInit();
    begin
        OrtecKStoreInterfaceSetup.GET();
    end;

    trigger OnOpenPage();
    begin
        Rec.SETFILTER("Ending Date", '>=%1|%2', TODAY, 0D);
        GeneralLedgerSetup.GET();
        PricelistType := 'S';
        AccountType := 'C';
        DiscountType := 'P';
        LineType := '1';
        Quantity1 := '1';
        UnitFactor := '1';
        Price1 := '0';
        CustomerPriceGroup.GET(OrtecKStoreInterfaceSetup."Customer Price Group Code");
        Rec.SETRANGE("Sales Code", CustomerPriceGroup.Code); //HEI.01
        //>> HEI.01
        MaxUnitPrice := 999.0;
        MinUnitPrice := 1;
        MinPiecePrice := 1;
        MaxPiecePrice := 999.0;
        //<< HEI.01
    end;

    var
        CurrencyCode: Code[20];
        GeneralLedgerSetup: Record "General Ledger Setup";
        Quantity1: Text;
        PricelistType: Text;
        AccountType: Text;
        DiscountType: Text;
        LineType: Text;
        UnitFactor: Text;
        DefaultDimension: Record "Default Dimension";
        Price1: Text;
        Unitcode: Code[20];
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        Description: Text;
        CustomerPriceGroup: Record "Customer Price Group";
        CompanyInformation: Record "Company Information";
        MaxUnitPrice: Decimal;
        MinUnitPrice: Decimal;
        MinPiecePrice: Decimal;
        MaxPiecePrice: Decimal;

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        if SysModified <> 0D then
            ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00'
        else begin
            SysModified := 99991212D;
            ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        end;
        exit(ReturnDate);



        //9999-12-12T01:00:00
    end;
}

