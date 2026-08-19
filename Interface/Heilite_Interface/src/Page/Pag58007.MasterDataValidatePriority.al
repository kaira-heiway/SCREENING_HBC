page 58007 "Master Data Validate Priority"
{
    // Heilite Navision Old Id - 50130
    // version HEI.01

    // HEI.01 GAPID043 IBM LAZARE02 08.08.2017 # New page for manual data entry
    // HEI.02 FDD-SLSGAP020 IBM HORTOC01 25.10.2018 # customer mendix interface

    // BC Upgrade MISHRS14 >>
    // Changed Table name from "Master Data Validate Priority" to "Master Data Val Priority FND" as its moved from Interface to Foundation Layer
    // BC Upgrade MISHRS14 <<

    Caption = 'Master Data Validate Priority';
    PageType = List;
    SourceTable = "Master Data Val Priority FND";
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    ApplicationArea = All;  // BC Upgrade NANDIS03
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(TableIDCtrl; TableID)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Table ID';
                    ToolTip = 'Specifies the value of the Table ID field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        TempAllObjWithCaption: Record AllObjWithCaption temporary;
                    begin
                        CLEAR(TempAllObjWithCaption);
                        SetupObjectNoList(TempAllObjWithCaption);
                        if PAGE.RUNMODAL(PAGE::Objects, TempAllObjWithCaption) = ACTION::LookupOK then begin
                            TableID := TempAllObjWithCaption."Object ID";
                            //TableCaption := TempAllObjWithCaption."Object Caption";
                            OnValidateTableID();
                        end;
                    end;

                    trigger OnValidate();
                    var
                        TempAllObjWithCaption: Record AllObjWithCaption temporary;
                    begin
                        SetupObjectNoList(TempAllObjWithCaption);
                        TempAllObjWithCaption."Object Type" := TempAllObjWithCaption."Object Type"::Table;
                        TempAllObjWithCaption."Object ID" := TableID;
                        if not TempAllObjWithCaption.FIND() then
                            Rec.FIELDERROR("Table ID");
                        OnValidateTableID();
                    end;
                }
            }
            repeater(Control50005)
            {
                field("Field ID"; Rec."Field ID")
                {
                    ToolTip = 'Specifies the value of the Field ID field.';
                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean  // BC Upgrade NANDIS03
                    var
                        "Field": Record "Field";
                    begin
                        Field.SETRANGE(TableNo, Rec."Table ID");
                        //if PAGE.RUNMODAL(PAGE::Fields, Field) = ACTION::LookupOK then  // BC Upgrade NANDIS03
                        if PAGE.RUNMODAL(PAGE::"Page Fields", Field) = ACTION::LookupOK then  // BC Upgrade NANDIS03 - Need to revalidate the page once its piublished
                            Rec."Field ID" := Field."No.";
                    end;

                    trigger OnValidate();
                    begin
                        Rec.TESTFIELD("Table ID");
                    end;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the value of the Field Caption field.';
                }
                field("Validate Priority"; Rec."Validate Priority")
                {
                    ToolTip = 'Specifies the value of the Validate Priority field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Table ID" := TableID;
    end;

    trigger OnOpenPage();
    begin
        TableID := DATABASE::Item;
        OnValidateTableID();
    end;

    var
        TableID: Integer;
        TableCaption: Text;

    procedure SetupObjectNoList(var TempAllObjWithCaption: Record AllObjWithCaption temporary);
    begin
        InsertObject(TempAllObjWithCaption, DATABASE::Vendor);
        InsertObject(TempAllObjWithCaption, DATABASE::"Vendor Bank Account");
        InsertObject(TempAllObjWithCaption, DATABASE::Item);
        InsertObject(TempAllObjWithCaption, DATABASE::"Item Translation");
        InsertObject(TempAllObjWithCaption, DATABASE::"Item Unit of Measure");
        //InsertObject(TempAllObjWithCaption, DATABASE::"Item Cross Reference");  // BC Upgrade NANDIS03
        InsertObject(TempAllObjWithCaption, DATABASE::"Stockkeeping Unit");
        //HEI.02>>
        InsertObject(TempAllObjWithCaption, DATABASE::Customer);
        InsertObject(TempAllObjWithCaption, DATABASE::"Customer Attributes FND");
        InsertObject(TempAllObjWithCaption, DATABASE::"Customer Bank Account");
        InsertObject(TempAllObjWithCaption, DATABASE::MultiDeliveryTimes107FDW);//BC UPGRADE KUMARR78 18-06-2026++

        //HEI.02<<
    end;

    procedure InsertObject(var TempAllObjWithCaption: Record AllObjWithCaption temporary; TableID: Integer);
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        AllObjWithCaption.SETRANGE("Object Type", AllObjWithCaption."Object Type"::Table);
        AllObjWithCaption.SETRANGE("Object ID", TableID);
        if AllObjWithCaption.FINDFIRST() then begin
            TempAllObjWithCaption := AllObjWithCaption;
            TempAllObjWithCaption.INSERT();
        end;
    end;

    local procedure OnValidateTableID();
    begin
        Rec.FILTERGROUP(6);
        Rec.SETRANGE("Table ID", TableID);
        Rec.FILTERGROUP(0);
        CurrPage.UPDATE(false);
    end;
}

