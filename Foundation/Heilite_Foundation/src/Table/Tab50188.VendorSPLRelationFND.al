table 50188 "Vendor SPL Relation FND"
{
    // version HEI.05

    // HEI.01 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # table created
    // HEI.02 CHG2162715 HB3020 NORRIQ KOROLA04 14.11.2022
    //   # LookupPageId - added
    //   # Global Vendor Number - OnValidate changed
    // HEI.03 CHG2162715 HB3020 NORRIQ KOROLA04 21.11.2022
    //   # OnInsert(), OnModify() - triggers changed
    // HEI.04 CHG2162715 HB3020 NORRIQ KOROLA04 08.12.2022
    //   # 'Global Vendor Number' field - new caption added
    // HEI.05 CHG2162715 HB3020 NORRIQ KOROLA04 14.12.2022
    //   # DUNS Number, Account Group, GLN - fields created

    DrillDownPageID = "Vendor SPL List";
    LookupPageID = "Vendor SPL List";

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate();
            begin
                if Vendor.GET("Vendor No.") then
                    "Global Vendor Number" := Vendor."Global Vendor Number FND";
            end;
        }
        field(2; "SPL Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Global Vendor Number"; Code[20])
        {
            Caption = 'Parent Legal Entity';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = Vendor."Global Vendor Number FND";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            var
                Vendor: Record Vendor;
                VendorSPL: Record "Vendor SPL Relation FND";
            begin
                //HEI.02 >>
                Vendor.SETRANGE("Global Vendor Number FND", "Global Vendor Number");
                if not Vendor.FINDFIRST() then exit;
                if not VendorSPL.GET("Vendor No.", "SPL Code") then
                    "Vendor No." := Vendor."No."
                else
                    Rec.RENAME(Vendor."No.", "SPL Code");

                //HEI.02 <<
            end;
        }
        field(4; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Name 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Address; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Industry Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Industry Key FND";
        }
        field(13; Default; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            var
                VendorSPL: Record "Vendor SPL Relation FND";
            begin
                //HEI.03 >>
                TESTFIELD("Marked for Deletion", false);
                TESTFIELD(Blocked, false);
                //HEI.03 <<

                if Default then begin
                    VendorSPL.SETRANGE("Vendor No.", "Vendor No.");
                    VendorSPL.SETRANGE(Default, true);
                    if not VendorSPL.ISEMPTY then
                        VendorSPL.MODIFYALL(Default, false);
                end;
            end;
        }
        field(14; "Marked for Deletion"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if "Marked for Deletion" then
                    VALIDATE(Blocked, true); //HEI.03
            end;
        }
        field(15; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                //HEI.03 >>
                if not Blocked then
                    TESTFIELD("Marked for Deletion", false)
                else
                    Default := false;
                //HEI.03 <<
            end;
        }
        field(16; "DUNS Number"; Code[9])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(17; "Account Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(18; GLN; Code[13])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "SPL Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Vendor No.", "SPL Code", Name, Default)
        {
        }
    }

    trigger OnInsert();
    var
        VendorSPL: Record "Vendor SPL Relation FND";
    begin
        if ("Vendor No." = '') and ("Global Vendor Number" <> '') then begin
            Vendor.SETRANGE("Global Vendor Number FND", "Global Vendor Number");
            Vendor.FINDFIRST();
            "Vendor No." := Vendor."No.";
        end;

        if Default then begin
            VendorSPL.SETRANGE("Vendor No.", "Vendor No.");
            VendorSPL.SETRANGE(Default, true);
            if not VendorSPL.ISEMPTY then
                VendorSPL.MODIFYALL(Default, false);
        end else begin
            //HEI.03 >>
            //VendorSPL.SETRANGE("Vendor No.", "Vendor No.");
            //VendorSPL.SETRANGE(Default, TRUE);
            //IF VendorSPL.ISEMPTY THEN
            //  Default := TRUE;
            //HEI.03 <<
        end;

        if "Marked for Deletion" then
            VALIDATE(Blocked, true); //HEI.03
    end;

    trigger OnModify();
    var
        VendorSPL: Record "Vendor SPL Relation FND";
    begin
        if Default then begin
            VendorSPL.SETRANGE("Vendor No.", "Vendor No.");
            VendorSPL.SETFILTER("SPL Code", '<>%1', "SPL Code");
            VendorSPL.SETRANGE(Default, true);
            if not VendorSPL.ISEMPTY then
                VendorSPL.MODIFYALL(Default, false);
        end;

        if "Marked for Deletion" then
            VALIDATE(Blocked, true); //HEI.03
    end;

    var
        Vendor: Record Vendor;
}

