xmlport 54003 "Item Export"
{
    //Bc Upgrade YADAVM09 old id is-50139.

    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Items';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(Desc; Item.Description)
                {
                }
                fieldelement(InvPostGroup; Item."Inventory Posting Group")
                {
                }
                fieldelement(UOM; Item."Base Unit of Measure")
                {
                }
                textelement(DimValue1)
                {
                }
                textelement(DimValue2)
                {
                }
                textelement(DimValue3)
                {
                }
                textelement(DimValue4)
                {
                }
                textelement(DimValue5)
                {
                }
                textelement(DimValue6)
                {
                }
                textelement(DimValue7)
                {
                }
                textelement(DimValue8)
                {
                }
                textelement(DimValue9)
                {
                }
                textelement(DimValue10)
                {
                }
                textelement(DimValue11)
                {
                }
                textelement(DimValue12)
                {
                }
                textelement(DimValue13)
                {
                }
                textelement(DimValue14)
                {
                }
                textelement(DimValue15)
                {
                }
                textelement(DimValue16)
                {
                }
                textelement(DimValue17)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    DefaultDimension.SETRANGE("Table ID", DATABASE::Item);
                    DefaultDimension.SETRANGE("No.", Item."No.");
                    DimCount := 1;
                    if DefaultDimension.FINDSET then
                        repeat
                            DimCode[DimCount] := DefaultDimension."Dimension Code";
                            DimValue[DimCount] := DefaultDimension."Dimension Value Code";
                            DimCount += 1;
                        until DefaultDimension.NEXT = 0;

                    DimValue1 := DimValue[1];
                    DimValue2 := DimValue[2];
                    DimValue3 := DimValue[3];
                    DimValue4 := DimValue[4];
                    DimValue5 := DimValue[5];
                    DimValue6 := DimValue[6];
                    DimValue7 := DimValue[7];
                    DimValue8 := DimValue[8];
                    DimValue9 := DimValue[9];
                    DimValue10 := DimValue[10];
                    DimValue11 := DimValue[11];
                    DimValue12 := DimValue[12];
                    DimValue13 := DimValue[13];
                    DimValue14 := DimValue[14];
                    DimValue15 := DimValue[15];
                    DimValue16 := DimValue[16];
                    DimValue17 := DimValue[17];
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        DefaultDimension: Record "Default Dimension";
        DimCode: array[30] of Text;
        DimValue: array[30] of Text;
        DimCount: Integer;
}

