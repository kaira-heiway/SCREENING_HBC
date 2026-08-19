page 51017 "Source Code Dim Matrix CBN"
{
    // version HEI.01

    // HEI.01 BPMGAP015 IBM SOICAD01 11.07.2017 EBF Matrix & Movement Type
    //   #new page created

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "G/L Account";
    SourceTableView = WHERE("Account Type" = FILTER(Posting));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = Name;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the name of the general ledger account.';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    LookupPageID = "Dimension Value List";
                    Visible = Field1Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[1] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(1);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(1);
                        ShowSelectedDimValue();
                    end;


                }
                field(Field2; MATRIX_CellData[2])
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field2Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[2] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(2);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(2);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 BlankNumbers
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field3Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[3] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(3);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(3);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field4Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[4] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(4);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(4);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field5Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[5] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(5);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(5);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field6Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[6] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(6);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(6);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field7Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[7] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(7);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(7);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field8Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[8] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(8);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(8);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field9Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[9] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(9);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(9);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field10Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[10] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(10);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(10);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field11Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[11] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(11);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(11);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field12Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[12] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(12);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(12);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field13Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[13] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(13);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(13);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field14Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[14] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(14);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(14);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field15Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[15] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(15);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(15);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field16Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[16] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(16);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(16);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field17Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[17] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(17);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(17);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field18Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[18] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(18);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(18);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field19Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[19] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(19);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(19);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field20Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[20] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(20);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(20);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field21Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[21] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(21);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(21);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field22Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[22] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(22);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(22);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field23Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[23] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(23);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(23);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field24Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[24] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(24);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(24);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field25Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[25] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(25);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(25);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field26Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[26] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(26);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(26);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field27Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[27] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(27);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(27);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field28Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[28] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(28);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(28);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field29Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[29] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(29);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(29);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[30];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field30Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[30] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(30);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(30);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'."
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field31Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[31] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(31);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(31);
                        ShowSelectedDimValue();
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    //BlankNumbers = BlankZero; //BC Upgrade Kamnay01 "The property 'BlankNumbers' can only be used if the field's type is one of these values: 'BigInteger,Boolean,Date,DateTime,Decimal,Duration,Enum,Integer,Option,Time'." 
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Lookup = true;
                    Visible = Field32Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[32] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupDimensionValue(32);
                    end;

                    trigger OnValidate();
                    begin
                        ChangeSelectedDimValue(32);
                        ShowSelectedDimValue();
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        MATRIX_Steps: Integer;
    begin
        MATRIX_CurrentColumnOrdinal := 0;
        if MATRIX_OnFindRecord('=><') then begin
            MATRIX_CurrentColumnOrdinal := 1;
            repeat
                MATRIX_ColumnOrdinal := MATRIX_CurrentColumnOrdinal;
                MATRIX_OnAfterGetRecord();
                MATRIX_Steps := MATRIX_OnNextRecord(1);
                MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + MATRIX_Steps;
            until (MATRIX_CurrentColumnOrdinal - MATRIX_Steps = MATRIX_NoOfMatrixColumns) or (MATRIX_Steps = 0);
            if MATRIX_CurrentColumnOrdinal <> 1 then
                MATRIX_OnNextRecord(1 - MATRIX_CurrentColumnOrdinal);
        end
    end;

    trigger OnInit();
    begin
        MATRIX_NoOfMatrixColumns := ARRAYLEN(MATRIX_CellData);
    end;

    trigger OnOpenPage();
    begin
        Field32Visible := true;
        Field31Visible := true;
        Field30Visible := true;
        Field29Visible := true;
        Field28Visible := true;
        Field27Visible := true;
        Field26Visible := true;
        Field25Visible := true;
        Field24Visible := true;
        Field23Visible := true;
        Field22Visible := true;
        Field21Visible := true;
        Field20Visible := true;
        Field19Visible := true;
        Field18Visible := true;
        Field17Visible := true;
        Field16Visible := true;
        Field15Visible := true;
        Field14Visible := true;
        Field13Visible := true;
        Field12Visible := true;
        Field11Visible := true;
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;
    end;

    var
        MatrixRecord: Record "Source Code";
        MatrixRecords: array[32] of Record "Source Code";
        SelectedDimValue: Code[20];
        ShowColumnName: Boolean;
        MATRIX_ColumnOrdinal: Integer;
        MATRIX_NoOfMatrixColumns: Integer;
        MATRIX_CellData: array[32] of Code[20];
        MATRIX_ColumnCaption: array[32] of Text[100];
        DimCode: Code[20];

        Field1Visible: Boolean;

        Field2Visible: Boolean;

        Field3Visible: Boolean;

        Field4Visible: Boolean;

        Field5Visible: Boolean;

        Field6Visible: Boolean;

        Field7Visible: Boolean;

        Field8Visible: Boolean;

        Field9Visible: Boolean;

        Field10Visible: Boolean;

        Field11Visible: Boolean;

        Field12Visible: Boolean;

        Field13Visible: Boolean;

        Field14Visible: Boolean;

        Field15Visible: Boolean;

        Field16Visible: Boolean;

        Field17Visible: Boolean;

        Field18Visible: Boolean;

        Field19Visible: Boolean;

        Field20Visible: Boolean;

        Field21Visible: Boolean;

        Field22Visible: Boolean;

        Field23Visible: Boolean;

        Field24Visible: Boolean;

        Field25Visible: Boolean;

        Field26Visible: Boolean;

        Field27Visible: Boolean;

        Field28Visible: Boolean;

        Field29Visible: Boolean;

        Field30Visible: Boolean;

        Field31Visible: Boolean;

        Field32Visible: Boolean;

    procedure Load(MatrixColumns1: array[32] of Text[1024]; var MatrixRecords1: array[32] of Record "Source Code"; _ShowColumnName: Boolean; _DimCode: Code[20]);
    begin
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);
        COPYARRAY(MatrixRecords, MatrixRecords1, 1);
        ShowColumnName := _ShowColumnName;
        DimCode := _DimCode;
    end;

    local procedure MATRIX_OnAfterGetRecord();
    begin
        ShowSelectedDimValue();
        SetVisible();
    end;

    local procedure MATRIX_OnFindRecord(Which: Text[1024]): Boolean;
    begin
        exit(MatrixRecord.FIND(Which));
    end;

    local procedure MATRIX_OnNextRecord(Steps: Integer): Integer;
    begin
        exit(MatrixRecord.NEXT(Steps));
    end;

    procedure SetVisible();
    begin
        Field1Visible := MATRIX_ColumnCaption[1] <> '';
        Field2Visible := MATRIX_ColumnCaption[2] <> '';
        Field3Visible := MATRIX_ColumnCaption[3] <> '';
        Field4Visible := MATRIX_ColumnCaption[4] <> '';
        Field5Visible := MATRIX_ColumnCaption[5] <> '';
        Field6Visible := MATRIX_ColumnCaption[6] <> '';
        Field7Visible := MATRIX_ColumnCaption[7] <> '';
        Field8Visible := MATRIX_ColumnCaption[8] <> '';
        Field9Visible := MATRIX_ColumnCaption[9] <> '';
        Field10Visible := MATRIX_ColumnCaption[10] <> '';
        Field11Visible := MATRIX_ColumnCaption[11] <> '';
        Field12Visible := MATRIX_ColumnCaption[12] <> '';
        Field13Visible := MATRIX_ColumnCaption[13] <> '';
        Field14Visible := MATRIX_ColumnCaption[14] <> '';
        Field15Visible := MATRIX_ColumnCaption[15] <> '';
        Field16Visible := MATRIX_ColumnCaption[16] <> '';
        Field17Visible := MATRIX_ColumnCaption[17] <> '';
        Field18Visible := MATRIX_ColumnCaption[18] <> '';
        Field19Visible := MATRIX_ColumnCaption[19] <> '';
        Field20Visible := MATRIX_ColumnCaption[20] <> '';
        Field21Visible := MATRIX_ColumnCaption[21] <> '';
        Field22Visible := MATRIX_ColumnCaption[22] <> '';
        Field23Visible := MATRIX_ColumnCaption[23] <> '';
        Field24Visible := MATRIX_ColumnCaption[24] <> '';
        Field25Visible := MATRIX_ColumnCaption[25] <> '';
        Field26Visible := MATRIX_ColumnCaption[26] <> '';
        Field27Visible := MATRIX_ColumnCaption[27] <> '';
        Field28Visible := MATRIX_ColumnCaption[28] <> '';
        Field29Visible := MATRIX_ColumnCaption[29] <> '';
        Field30Visible := MATRIX_ColumnCaption[30] <> '';
        Field31Visible := MATRIX_ColumnCaption[31] <> '';
        Field32Visible := MATRIX_ColumnCaption[32] <> '';
    end;

    procedure ChangeSelectedDimValue(ColumnID: Integer);
    var
        AccountNo: Code[20];
        DimValueCode: Code[20];
        SourceCodeDim: Record "Source Code Dimension FND";
        SourceCode: Code[10];
    begin
        AccountNo := Rec."No.";
        SourceCode := MatrixRecords[ColumnID].Code;
        if not SourceCodeDim.GET(Rec."No.", SourceCode, DimCode) then
            if MATRIX_CellData[ColumnID] <> '' then begin
                SourceCodeDim.VALIDATE("GL Account No.", Rec."No.");
                SourceCodeDim.VALIDATE("Source Code", SourceCode);
                SourceCodeDim.VALIDATE("Dimension Code", DimCode);
                SourceCodeDim.VALIDATE("Dimension Value Code", MATRIX_CellData[ColumnID]);
                SourceCodeDim.INSERT(true);
                CurrPage.UPDATE();
                exit;
            end;

        if MATRIX_CellData[ColumnID] = '' then
            SourceCodeDim.DELETE(true)
        else begin
            SourceCodeDim.VALIDATE("Dimension Value Code", MATRIX_CellData[ColumnID]);
            SourceCodeDim.MODIFY(true);
        end;
        CurrPage.UPDATE()
    end;

    procedure ShowSelectedDimValue();
    var
        AccountNo: Code[20];
        DimValueCode: Code[20];
        SourceCodeDim: Record "Source Code Dimension FND";
        SourceCode: Code[10];
    begin
        AccountNo := Rec."No.";
        SourceCode := MatrixRecords[MATRIX_ColumnOrdinal].Code;
        if not SourceCodeDim.GET(Rec."No.", SourceCode, DimCode) then begin
            SourceCodeDim.INIT();
            SourceCodeDim."GL Account No." := Rec."No.";
            SourceCodeDim."Source Code" := SourceCode;
            SourceCodeDim."Dimension Code" := DimCode;
            MATRIX_CellData[MATRIX_ColumnOrdinal] := '';
            exit
        end;
        MATRIX_CellData[MATRIX_ColumnOrdinal] := SourceCodeDim."Dimension Value Code";
    end;

    local procedure LookupDimensionValue(ColumnId: Integer);
    var
        DimensionValueList: Page "Dimension Value List";
        DimensionValue: Record "Dimension Value";
    begin
        DimensionValue.FILTERGROUP(2);
        DimensionValue.SETRANGE("Dimension Code", DimCode);
        DimensionValue.FILTERGROUP(0);
        DimensionValueList.SETTABLEVIEW(DimensionValue);
        DimensionValueList.SETRECORD(DimensionValue);
        DimensionValueList.LOOKUPMODE(true);
        if DimensionValueList.RUNMODAL() = ACTION::LookupOK then begin
            DimensionValueList.GETRECORD(DimensionValue);
            MATRIX_CellData[ColumnId] := DimensionValue.Code;
            ChangeSelectedDimValue(ColumnId);
            ShowSelectedDimValue();
        end;
    end;
}

