table 50363 "Production Version Data FND"
{// 
 // version HEI.03

    // HEI.01 HB2817 - CHG2150741 IBM GOKULS01 15.06.2022 # Production Version data
    // #Created New table for creating active BOM versions
    // HEI.02 HB2817 - CHG2150741 NORRIQ KOROLA04 05.10.2022
    //   #Routing Link Code - field added
    // HEI.03 HB2817 - CHG2150741 NORRIQ KOROLA04 18.10.2022
    //   #Location Code - field added
    //   #BOM Header Code,Routing Link Code,Start Validity Date - key added
    // HEI.04 HB2817 - CHG2189319 NORRIQ ZOGHLE01 19.01.2023
    //   #Fields "Start Validity Date" and "End Validity Date" Caption Changed
    //   #Add code to "Start Validity Date" OnValidate Trigger
    //   #Add COde to "Routing Link Code" OnValidate Trigger

    // BC Upgrade Kamnay01 Original(Heilite) Table id 50244
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Material Code"; Code[20])
        {
            Caption = 'Material Code';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(3; "Production Version"; Code[20])
        {
            Caption = 'Production Version';
            DataClassification = ToBeClassified;
        }
        field(4; "Routing Header Code"; Code[20])
        {
            Caption = 'Routing Header Code';
            DataClassification = ToBeClassified;
            TableRelation = "Routing Header"."No.";
        }
        field(5; "Routing Ver. hdr. Code"; Code[20])
        {
            Caption = 'Routing Version Code';
            DataClassification = ToBeClassified;
            TableRelation = "Routing Version"."Version Code";
        }
        field(6; "BOM Header Code"; Code[20])
        {
            Caption = 'BOM Header Code';
            DataClassification = ToBeClassified;
            TableRelation = "Production BOM Header"."No.";
        }
        field(7; "BOM Ver. Hdr. Code"; Code[20])
        {
            Caption = 'BOM Version Code';
            DataClassification = ToBeClassified;
            TableRelation = "Production BOM Version"."Version Code";
        }
        field(8; "Start Validity Date"; Text[10])
        {
            Caption = 'Starting Validity Week';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ProductionVersionData: Record "Production Version Data FND";
                DateValue: Integer;
            begin

                // BC Upgrade SHUKLP03 >>
                //HEI.04>>
                ProductionVersionData.RESET();
                ProductionVersionData.SETRANGE("Material Code", Rec."Material Code");
                ProductionVersionData.SETRANGE("Routing Link Code", Rec."Routing Link Code");
                ProductionVersionData.SETRANGE("Start Validity Date", Rec."Start Validity Date");
                IF ProductionVersionData.FINDFIRST() THEN
                    ERROR(DateErrorText);
                ProductionVersionData.RESET();
                ProductionVersionData.SETRANGE("Material Code", Rec."Material Code");
                ProductionVersionData.SETRANGE("Routing Link Code", Rec."Routing Link Code");
                ProductionVersionData.SETFILTER("Entry No.", '<%1', Rec."Entry No.");
                IF ProductionVersionData.FINDLAST() THEN BEGIN
                    EVALUATE(DateValue, Rec."Start Validity Date");
                    ProductionVersionData."End Validity Date" := FORMAT(DateValue - 1);
                    ProductionVersionData.MODIFY();
                END;
                Rec."End Validity Date" := DefaultEndingWeek;
                //HEI.04<<
                // BC Upgrade SHUKLP03 <<

            end;
        }
        field(9; "End Validity Date"; Text[10])
        {
            Caption = 'Ending Validity Week';
            DataClassification = ToBeClassified;
        }
        field(11; "Entry Created Date"; DateTime)
        {
            Caption = 'Entry Created Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Entry Update Date"; DateTime)
        {
            Caption = 'Entry Update Date';
            DataClassification = ToBeClassified;
        }
        field(13; "Routing Link Code"; Code[10])
        {
            CaptionML = ENU = 'Routing Link Code',
                        FRA = 'Code lien gamme';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Routing Link";

            // BC Upgrade SHUKLP03 >>
            trigger OnValidate()
            var
                ProductionVersionData: Record "Production Version Data FND";
                DateValue: Integer;
            begin
                //HEI.04>>
                ProductionVersionData.RESET();
                ProductionVersionData.SETRANGE("Material Code", Rec."Material Code");
                ProductionVersionData.SETRANGE("Routing Link Code", Rec."Routing Link Code");
                ProductionVersionData.SETRANGE("Start Validity Date", Rec."Start Validity Date");
                IF ProductionVersionData.FINDFIRST() THEN
                    ERROR(DateErrorText);
                //HEI.04<<
            end;
            // BC Upgrade SHUKLP03 <<

        }
        field(14; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "BOM Header Code", "Routing Link Code", "Start Validity Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        // BC Upgrade SHUKLP03 >>
        DateErrorText: TextConst ENU = 'A record with the same version Code and same starting date exists already';
        DefaultEndingWeek: TextConst ENU = '209953';
    // BC Upgrade SHUKLP03 <<
}

