namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Sales.Document;
using System.Security.User;

pageextension 58039 SalesOrderInterfaceExt extends "Sales Order"
{
    // HEI.12 INC2109750 IBM NASTAA02 16.04.2019 # Promotion Group Dimensions
    //   # New function created "UHT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.17 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field added: "Suppress POS Interface"
    //   # Code added to enable editing of Field "Supress POS Interface"
    // HEI.27 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    //   # New field added : 50042 - WMS Export

    layout
    {
        addafter(Status)
        {
            field("Load No."; Rec."Load No. FND")
            {
                Visible = true;
                ApplicationArea = All;
            }
            field("Sequence No."; Rec."Sequence No. FND")
            {
                Visible = true;
                ApplicationArea = All;
            }
            // BC Upgrade MISHRS14 >>
            // Added FND in field Rec.
            field("Suppress POS Interface"; Rec."Suppress POS Interface FND")
            {
                Editable = SuppressPOSInterfaceEditable;
                ApplicationArea = All;
            }
            // BC Upgrade MISHRS14 <<
            field("WMS Export"; Rec."WMS Export FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord();
    var
    begin
        //HEI.17>>
        UserSetup2.GET(USERID);
        SuppressPOSInterfaceEditable := UserSetup2."Allow Change Inter Flag FND";
        //HEI.17<<

        //HEI.21<<
        MakeFieldEditable;
        //HEI.21>>
    end;

    trigger OnOpenPage();
    begin
        //HEI.21<<
        MakeFieldEditable;
        //HEI.21>>
    end;

    procedure MakeFieldEditable();
    begin
        //HEI.21<<
        InterfaceEntryheader.RESET;
        InterfaceEntryheader.SETRANGE(Status, InterfaceEntryheader.Status::Pending);
        InterfaceEntryheader.SETRANGE(Direction, InterfaceEntryheader.Direction::Inbound);
        InterfaceEntryheader.SETFILTER("Interface Code", '=%1', 'PEPERRI-IMP');
        if InterfaceEntryheader.FINDSET then begin
            if Rec."No." = 'O' + InterfaceEntryheader."Salespers./Purch. Code" + '-' + InterfaceEntryheader."Source No." then begin
                if InterfaceEntryheader.Closed = true then begin
                    //"Disable DIT Disc. Prom." := "Disable DIT Disc. Prom."::Promotion;  // BC Upgrade SHUKLP03 << Blocked DIT field.
                    FieldEditable := false;
                end else begin
                    FieldEditable := true;
                    //"Disable DIT Disc. Prom." := "Disable DIT Disc. Prom."::" "; // BC Upgrade SHUKLP03 << Blocked DIT field.
                end;
            end;
        end;
        //HEI.21>>
    end;

    var
        InterfaceEntryheader: Record "Interface Entry Header INT";
        SuppressPOSInterfaceEditable: Boolean;
        FieldEditable: Boolean;
        UserSetup2: Record "User Setup";

}
