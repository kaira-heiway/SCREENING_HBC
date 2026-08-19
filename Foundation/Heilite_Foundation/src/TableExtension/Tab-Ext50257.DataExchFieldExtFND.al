tableextension 50257 DataExchFieldExtFND extends "Data Exch. Field"
{
    // version NAVW110.0,HEI.02
    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017
    //   # New fields: XML Node Name, XML Node Path, Big Value
    //   # New function InsertValueIntoBigValue
    // HEI.02 CHG2095189 IBM SAXENA03 27.01.2021
    //   # Code written for optimizaiton
    //   # Created a new Function InsertRec2
    // BC Upgrade NANDIS03 - Code against function - InsertRecXMLFieldWithParentNodeID for Tag HEI.01 moved to subscriber in codeunit 61000

    // BC Upgrade PATELS08 >>
    // # Table Extension moved from Interface to Foundation Layer
    // # Table extension renamed from DataExchField DataExchFieldExtFND
    // # Fields renamed from "XML Node Name", "XML Node Path", "Big Value" to "XML Node Name FND", "XML Node Path FND", "Big Value FND" respectively.
    // BC Upgrade PATELS08 <<
    fields
    {
        modify("Data Exch. No.")
        {
            CaptionML = ENU = 'Data Exch. No.', FRA = 'N° échange données';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Column No.")
        {
            CaptionML = ENU = 'Column No.', FRA = 'N° colonne';
        }
        modify(Value)
        {
            CaptionML = ENU = 'Value', FRA = 'Valeur';
        }
        modify("Node ID")
        {
            CaptionML = ENU = 'Node ID', FRA = 'ID noud';
        }
        modify("Data Exch. Line Def Code")
        {
            CaptionML = ENU = 'Data Exch. Line Def Code', FRA = 'Code déf. ligne échange données';
        }
        modify("Parent Node ID")
        {
            CaptionML = ENU = 'Parent Node ID', FRA = 'ID noud parent';
        }
        modify("Data Exch. Def Code")
        {

            //Unsupported feature: Change CalcFormula on ""Data Exch. Def Code"(Field 11)". Please convert manually.

            CaptionML = ENU = 'Data Exch. Def Code', FRA = 'Code déf. échange données';
        }
        field(50001; "XML Node Name FND"; Text[250])
        {
            Caption = 'XML Node Name';
            Description = 'HEI.01';
        }
        field(50002; "XML Node Path FND"; Text[250])
        {
            Caption = 'XML Node Path';
            Description = 'HEI.01';
        }
        field(50003; "Big Value FND"; BLOB)
        {
            Caption = 'Big Value';
            Description = 'HEI.01';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    // BC Upgrade NANDIS03 >>
    procedure InsertValueIntoBigValue(Value: Text)
    var
        OutputStream: OutStream;
    begin
        //HEI.01>>
        "Big Value FND".CREATEOUTSTREAM(OutputStream);
        OutputStream.WRITETEXT(Value);
        //HEI.01<<
    end;

    procedure InsertRec2(DataExchNo: Integer; LineNo: Integer; ColumnNo: Integer; NewValue: Text[250]; DataExchLineDefCode: Code[20]; XmlName: Text[250]; XmlPath: Text[250])
    var
        myInt: Integer;
    begin
        //<<HEI.02
        INIT();
        VALIDATE("Data Exch. No.", DataExchNo);
        VALIDATE("Line No.", LineNo);
        VALIDATE("Column No.", ColumnNo);
        VALIDATE(Value, NewValue);
        VALIDATE("Data Exch. Line Def Code", DataExchLineDefCode);
        VALIDATE("XML Node Name FND", XmlName);
        VALIDATE("XML Node Path FND", XmlPath);
        INSERT();
        //>>HEI.02
    end;
    // BC Upgrade NANDIS03 <<
}

