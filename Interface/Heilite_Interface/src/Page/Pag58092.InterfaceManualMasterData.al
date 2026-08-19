page 58092 "Interface Manual Master Data"
{
    // version HEI.01

    // HEI.01 GAPID043 IBM LAZARE02 08.08.2017 # New page for manual data entry
    // BC Upgrade SHUKLP03 >> Nav Page Id - 50088

    Caption = 'Interface Manual Master Data';
    PageType = List;
    SourceTable = "Interface Entry Comp.DetailINT";
    SourceTableTemporary = true;
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(InterfaceCode; InterfaceCode)
                {
                    Caption = 'Interface Code';
                    TableRelation = "Interface Setup INT";
                }
                field(TableIDCtrl; TableID)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Table ID';

                    trigger OnLookup(var Text: Text): Boolean;
                    var
                        TempAllObjWithCaption: Record AllObjWithCaption temporary;
                    begin
                        if InterfaceCode = '' then
                            ERROR(InterfaceNotSpecifiedErr);

                        CLEAR(TempAllObjWithCaption);
                        SetupObjectNoList(TempAllObjWithCaption);
                        if PAGE.RUNMODAL(PAGE::Objects, TempAllObjWithCaption) = ACTION::LookupOK then begin
                            TableID := TempAllObjWithCaption."Object ID";
                            //TableCaption := TempAllObjWithCaption."Object Caption";
                        end;
                    end;

                    trigger OnValidate();
                    var
                        TempAllObjWithCaption: Record AllObjWithCaption temporary;
                    begin
                        if InterfaceCode = '' then
                            ERROR(InterfaceNotSpecifiedErr);

                        SetupObjectNoList(TempAllObjWithCaption);
                        TempAllObjWithCaption."Object Type" := TempAllObjWithCaption."Object Type"::Table;
                        TempAllObjWithCaption."Object ID" := TableID;
                        if not TempAllObjWithCaption.FIND then
                            Rec.FIELDERROR("Table ID");
                    end;
                }
            }
            repeater(Control50005)
            {
                field("Field ID"; Rec."Field ID")
                {

                    trigger OnLookup(var Text: Text): Boolean;
                    var
                        "Field": Record "Field";
                    begin
                        Field.SETRANGE(TableNo, Rec."Table ID");
                        if PAGE.RUNMODAL(PAGE::"Fields Lookup", Field) = ACTION::LookupOK then
                            Rec."Field ID" := Field."No.";
                    end;

                    trigger OnValidate();
                    begin
                        Rec.TESTFIELD("Table ID");
                    end;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    Enabled = false;
                }
                field(Value; Rec.Value)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Create Interface Entries")
                {
                    Caption = 'Create Interface Entries';
                    Image = CreateDocuments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Create inbound interface entries for the specified data';

                    trigger OnAction();
                    var
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
                    begin
                        InterfaceFrameworkMgt.CreateManualInterfaceEntries(Rec, InterfaceCode);
                        if Rec.ISTEMPORARY then begin
                            Rec.RESET;
                            Rec.DELETEALL;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Table ID" := TableID;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        Rec.RESET;
        if not Rec.ISEMPTY then
            if not CONFIRM(DataNotSavedErr) then
                exit(false);
    end;

    var
        InterfaceCode: Code[20];
        TableID: Integer;
        TableCaption: Text;
        InterfaceNotSpecifiedErr: Label 'You must specify an interface code.';
        DataNotSavedErr: Label 'The data has not been processed. If you close the page, it will be lost. Do you want to close the page?';

    procedure SetupObjectNoList(var TempAllObjWithCaption: Record AllObjWithCaption temporary);
    begin
        InsertObject(TempAllObjWithCaption, DATABASE::Vendor);
        InsertObject(TempAllObjWithCaption, DATABASE::"Vendor Bank Account");
        InsertObject(TempAllObjWithCaption, DATABASE::Item);
        InsertObject(TempAllObjWithCaption, DATABASE::"Item Translation");
        InsertObject(TempAllObjWithCaption, DATABASE::"Item Unit of Measure");
        //InsertObject(TempAllObjWithCaption, DATABASE::"Item Cross Reference");
        InsertObject(TempAllObjWithCaption, DATABASE::"Item Reference"); // BC Upgrade SHUKLP03 << "Item Cross Reference" replaced by "Item Reference"
        InsertObject(TempAllObjWithCaption, DATABASE::"Stockkeeping Unit");
        InsertObject(TempAllObjWithCaption, DATABASE::Customer);
    end;

    procedure InsertObject(var TempAllObjWithCaption: Record AllObjWithCaption temporary; TableID: Integer);
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        AllObjWithCaption.SETRANGE("Object Type", AllObjWithCaption."Object Type"::Table);
        AllObjWithCaption.SETRANGE("Object ID", TableID);
        if AllObjWithCaption.FINDFIRST then begin
            TempAllObjWithCaption := AllObjWithCaption;
            TempAllObjWithCaption.INSERT;
        end;
    end;
}

