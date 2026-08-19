page 58030 "KS Item Export"
{
    // Heilite Navision Old Id - 50328


    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # LoC added to OnOpenPage func.
    //                                               code added to OnAfterGetRecord
    // HEI.02 FDD-LC-HT736 IBM.GUNERE01 21.11.2019 # RemitTo variable datatype modified
    // HEI.03 CHG2182881 IBM SOICAD02 22.11.2022 K store interface bug Fix for wrong VAT calculation

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Item;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ItemCode; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(ItemDescription; Rec."Search Description")
                {
                    ToolTip = 'Specifies the value of the Search Description field.';
                }
                field(IsDivisible; IsDivisible)
                {
                    ToolTip = 'Specifies the value of the IsDivisible field.';
                }
                field(IsBatch; IsBatch)
                {
                    ToolTip = 'Specifies the value of the IsBatch field.';
                }
                field(IsSerial; IsSerial)
                {
                    ToolTip = 'Specifies the value of the IsSerial field.';
                }
                field(DefaultSaleUnit; Rec."Sales Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Sales Unit of Measure field.';
                }
                field(DefaultSalePrice; UnitPrice)
                {
                    ToolTip = 'Specifies the value of the UnitPrice field.';
                }
                field(DefaultVATCode; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                }
                field(DefaultVATPercentage; VATPercDom)
                {
                    ToolTip = 'Specifies the value of the VATPercDom field.';
                }
                field(ForeignVATPerc; VATPercForeign)
                {
                    ToolTip = 'Specifies the value of the VATPercForeign field.';
                }
                field(ItemStatus; Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ItemType; ItemType)
                {
                    ToolTip = 'Specifies the value of the ItemType field.';
                }
                field(ItemValidateStock; ItemValidateStock)
                {
                    ToolTip = 'Specifies the value of the ItemValidateStock field.';
                }
                field(ItemOperationsAllowed; ItemOperationsAllowed)
                {
                    ToolTip = 'Specifies the value of the ItemOperationsAllowed field.';
                }
                field(MainWarehouseCode; OrtecKStoreInterfaceSetup."Inventory Location Code")
                {
                    ToolTip = 'Specifies the value of the Inventory Location Code field.';
                }
                field(ExcludeFromKstore; ExcludeFromKstore)
                {
                    ToolTip = 'Specifies the value of the ExcludeFromKstore field.';
                }
                field(Category1; ' ')
                {
                    ToolTip = 'Specifies the value of the '' '' field.';
                }
                field(Category2; DefaultDimension."Dimension Value Code")
                {
                    ToolTip = 'Specifies the value of the Dimension Value Code field.';
                }
                field(Sysmodified; ConvertDate(Rec."Last Date Modified"))
                {
                    ToolTip = 'Specifies the value of the Last Date Modified) field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Taxable1; Taxable1)
                {
                    ToolTip = 'Specifies the value of the Taxable1 field.';
                }
                field(DaysAvailable; DaysAvailable)
                {
                    ToolTip = 'Specifies the value of the DaysAvailable field.';
                }
                field(RemitFlag; RemitFlag)
                {
                    ToolTip = 'Specifies the value of the RemitFlag field.';
                }
                field(FlexField1; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(RemitTo; RemitTo)
                {
                    ToolTip = 'Specifies the value of the RemitTo field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        if ItemCategory.GET(Rec."Item Category Code") then;
        /*
        IF ItemAttributeValueMapping.GET(27,"No.",OrtecKStoreInterfaceSetup."Primary Pack Type Attribute ID") THEN
          IF ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID") THEN;
        */
        //HEI.03>>
        VATPercDom := 0;
        VATPercForeign := 0;
        //HEI.03<<

        VATPostingSetup.RESET();
        VATPostingSetup.SETRANGE("VAT Prod. Posting Group", Rec."VAT Prod. Posting Group");
        VATPostingSetup.SETRANGE("VAT Bus. Posting Group", OrtecKStoreInterfaceSetup."Def. VAT Bus Pst Group (Dom)");//HEI.03 single line
        if VATPostingSetup.FINDFIRST() then
            VATPercDom := VATPostingSetup."VAT %";//HEI.03 single line

        //HEI.03>>
        VATPostingSetup.RESET();
        VATPostingSetup.SETRANGE("VAT Prod. Posting Group", Rec."VAT Prod. Posting Group");
        VATPostingSetup.SETRANGE("VAT Bus. Posting Group", OrtecKStoreInterfaceSetup."Def. VAT Bus Pst Group (For)");
        if VATPostingSetup.FINDFIRST() then
            VATPercForeign := VATPostingSetup."VAT %";
        //HEI.03<<
        if Rec.Blocked then begin
            Status := 'B';
        end else begin
            Status := 'A';
        end;

        ItemType := 'S';
        IsDivisible := 0;
        IsBatch := 0;
        IsSerial := 0;
        Taxable1 := '';
        //>> HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019
        // BC Upgrade SHUKLP03>> Empty Good is DITW field 
        // CALCFIELDS("Empty Good");
        if REC."Is Empty Good 104FDW" then
            Taxable1 := 'F'
        else
            Taxable1 := 'T';
        // BC Upgrade SHUKLP03<< Empty Good is DITW field 
        DaysAvailable := 'TTTTTTT';
        RemitFlag := 'M';
        RemitTo := 2; //HEI.02
                      //<< HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019

        ItemValidateStock := 1;
        ItemOperationsAllowed := 1;
        ExcludeFromKstore := 0;
        if DefaultDimension.GET(27, Rec."No.", GeneralLedgerSetup."Brand Dimension Code FND") then;

    end;

    trigger OnInit();
    begin
        GeneralLedgerSetup.GET();
        CompanyInformation.GET(); // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019
    end;

    trigger OnOpenPage();
    begin
        OrtecKStoreInterfaceSetup.GET();
        OrtecKStoreInterfaceSetup.TESTFIELD("Item Category Code");
        Rec.SETFILTER("Item Category Code", OrtecKStoreInterfaceSetup."Item Category Code");
    end;

    var
        IsDivisible: Integer;
        IsBatch: Integer;
        IsSerial: Integer;
        ItemCategory: Record "Item Category";
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        ItemAttributeValue: Record "Item Attribute Value";
        VATPostingSetup: Record "VAT Posting Setup";
        UnitPrice: Integer;
        VatPercent: Integer;
        Status: Text;
        ItemType: Text;
        ItemValidateStock: Integer;
        ItemOperationsAllowed: Integer;
        ExcludeFromKstore: Integer;
        DefaultDimension: Record "Default Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Taxable1: Text;
        DaysAvailable: Text;
        RemitFlag: Text;
        CompanyInformation: Record "Company Information";
        RemitTo: Integer;
        VATPercDom: Decimal;
        VATPercForeign: Decimal;

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;
}

