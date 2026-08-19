table 58072 "Zycus Interface Setup INT"
{
    // Heilite Navision Old Id - 50275
    // version HEI.10,HEI.11

    // HEI.01 CHG2210794 SAHAL01 07.12.2023 Zycus - BASE HL Integration Master Dimension
    //   # Created New Table: 50275 - Zycus Interface Setup
    //   # Added Code
    // HEI.02 CHG2210794 SAHAL01 06.02.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 43 - Starting Date-Time for CCC
    //                         47 - Last Zycus CCC Error Date-Time
    //                         53 - Starting Date-Time for WBN
    //                         57 - Last Zycus WBN Error Date-Time
    //   # Removed Fixed Assets (CONCAT) Interface functionality due to descope
    // HEI.03 CHG2210794 MAJUMS03 22.01.2024 Zycus - BASE HL Integration Master Vendor and GL Account. (*RLPPD)
    //   # New Fields added
    // HEI.04 CHG2210794 SAHAL01 27.02.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 201 - Activate PO Interface
    //                         202 - Zycus PO Creation Interface
    //                         203 - Zycus PO Confirmatio Interface
    //                         207 - Zycus Create Action Code
    //                         208 - Zycus Update Action Code
    //                         209 - Zycus Cancellation Action Code
    // HEI.05 CHG2210794 MAJUMS03 21.03.2024 Zycus - BASE HL Integration Master Vendor and GL Account.
    //   # New Fields added
    // HEI.06 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Fields: 212 - Zycus PO CCC Dimention Code
    //                         213 - Zycus PO CONCAT Dimention Code
    //                         215 - Zycus Normal PO Code
    //                         216 - Zycus Limit PO Code
    // HEI.07 CHG2210794 SAHAL01 22.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Field: 214 - Zycus PO CMG Dimention Code
    // HEI.08 CHG2210794 SAHAL01 26.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Fields: 11 - HeiLite Business System ID
    //                         12 - Zycus Business System ID
    // HEI.09 CHG2210794 SAHAL01 30.04.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Fields: 231 - Activate GR Interface
    //                         232 - Zycus GR Creation Interface
    //                         233 - Zycus GR Confirmatio Interface
    //                         234 - Zycus GR Cancel Interface
    //                         235 - Zycus GR Cancel Conf Interface
    //                         242 - Zycus LPO GR CreationInterface
    //                         243 - Zycus LPO GR Conf Interface
    //                         244 - Zycus LPO GR Cancel Interface
    //                         245 - Zycus LPO GR CanlConfInterface
    //                         251 - Zycus GR CreationMovement Type
    //                         252 - Zycus GR Cancel Movement Type
    //                         253 - Zycus RD CreationMovement Type
    //                         254 - Zycus RD Cancel Movement Type
    // HEI.10 CHG2210794 VERMAA03 14.06.2024 Zycus - BASE Integration with POSM GR
    //   # Created New Fields: 400 - Activate POSM GR Interface
    //                         401 - POSM GR Creation Interface
    //                         402 - POSM GR Confirmation Interface
    //                         403 - POSM GR Creation Movement Type
    //                         404 - POSM GR Cancel Movement Type
    // HEI.11 CHG2210794 MAJUMS03 06.06.2024 Zycus - BASE HL Integration - CMG Rule Map
    //   # New Fields added.
    // HEI.15 CHG2313281 SAHAL01 23.07.2025 Zycus - CMG Dimension Check
    //   # Created New Field: 217 - Exclude Dimension Matching

    // BC Upgrade PATELS08 >>
    //   # Added HEI.15 Tag in Documentation
    //   # Added Field: 405 - 'Exclude Dimension Matching ' as part of HEI.15
    // BC Upgrade PATELS08 <<

    Caption = 'Zycus Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            Description = 'HEI.01';
        }
        field(2; "Enabled Zycus Integration"; Boolean)
        {
            Caption = 'Enabled Zycus Integration';
            Description = 'HEI.01';
        }
        field(3; "Last Date Modified"; Date)
        {
            CaptionML = ENU = 'Last Date Modified',
                        FRA = 'Date dern. modification';
            Description = 'HEI.01';
            Editable = false;
        }
        field(4; "Last Time Modified"; Time)
        {
            CaptionML = ENU = 'Last Time Modified',
                        FRA = 'Heure dern. modification';
            Description = 'HEI.01';
            Editable = false;
        }
        field(5; "Last Modified By User"; Code[50])
        {
            CaptionML = ENU = 'Last Modified By User',
                        FRA = 'Dernière modification par l''utilisateur';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserRec: Record User;
                UserID: Code[50];
            begin
                //BCUpgrade sharmp16
                //HEI.01>>
                if UserRec.Get(Rec."Last Modified By User") then
                    UserID := UserRec."User Security ID"
                //HEI.01<<
            end;
            //BCUpgrade sharmp16
        }
        field(11; "HeiLite Business System ID"; Code[20])
        {
            Caption = 'HeiLite Business System ID';
            Description = 'HEI.08';
        }
        field(12; "Zycus Business System ID"; Code[20])
        {
            Caption = 'Zycus Business System ID';
            Description = 'HEI.08';
        }
        field(39; "Activate CCC Interface"; Boolean)
        {
            Caption = 'Activate CCC Interface';
            Description = 'HEI.01';
        }
        field(40; "Zycus CCC Object Type"; Code[20])
        {
            Caption = 'Zycus CCC Object Type';
            Description = 'HEI.01';
            TableRelation = Dimension;
        }
        field(41; "Zycus CCC Interface"; Code[20])
        {
            Caption = 'Zycus CCC Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(43; "Starting Date-Time for CCC"; DateTime)
        {
            Caption = 'Starting Date-Time for CCC';
            Description = 'HEI.02';
        }
        field(45; "Max No. of Records for CCC"; Integer)
        {
            Caption = 'Max No. of Records for CCC';
            Description = 'HEI.01';
        }
        field(46; "Last Zycus CCC Park Date-Time"; DateTime)
        {
            Caption = 'Last Zycus CCC Park Date-Time';
            Description = 'HEI.01';
        }
        field(47; "Last Zycus CCC Error Date-Time"; DateTime)
        {
            Caption = 'Last Zycus CCC Error Date-Time';
            Description = 'HEI.02';
            Editable = false;
        }
        field(48; "Last Zycus CCC in Error"; Boolean)
        {
            Caption = 'Last Zycus CCC in Error';
            Description = 'HEI.01';
            Editable = false;
        }
        field(49; "Activate Project Interface"; Boolean)
        {
            Caption = 'Activate Project Interface';
            Description = 'HEI.01';
        }
        field(50; "Zycus Project Object Type"; Code[20])
        {
            Caption = 'Zycus Project Object Type';
            Description = 'HEI.01';
            TableRelation = Dimension;
        }
        field(51; "Zycus WBN Interface"; Code[20])
        {
            Caption = 'Zycus WBN Interface';
            Description = 'HEI.01,HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(53; "Starting Date-Time for WBN"; DateTime)
        {
            Caption = 'Starting Date-Time for WBN';
            Description = 'HEI.02';
        }
        field(55; "Max No. of Records for WBN"; Integer)
        {
            Caption = 'Max No. of Records for WBN';
            Description = 'HEI.01';
        }
        field(56; "Last Zycus WBN Park Date-Time"; DateTime)
        {
            Caption = 'Last Zycus WBN Park Date-Time';
            Description = 'HEI.01';
        }
        field(57; "Last Zycus WBN Error Date-Time"; DateTime)
        {
            Caption = 'Last Zycus WBN Error Date-Time';
            Description = 'HEI.02';
            Editable = false;
        }
        field(58; "Last Zycus WBN in Error"; Boolean)
        {
            Caption = 'Last Zycus WBN in Error';
            Description = 'HEI.01';
            Editable = false;
        }
        field(101; "Activate Vendor Interface"; Boolean)
        {
            Caption = 'Activate Vendor Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(102; "Zycus Vendor Interface Code"; Code[20])
        {
            Caption = 'Zycus Vendor Interface Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(103; "Vendor Account Group Filter"; Code[50])
        {
            Caption = 'Vendor Account Group Filter';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Vendor Type FND";
            ValidateTableRelation = false;
        }
        field(105; "Last Zycus Vendor Sync Time"; DateTime)
        {
            Caption = 'Last Zycus Vendor Sync Time';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = true;
        }
        field(107; "Max. Vendor Per Interface"; Integer)
        {
            Caption = 'Max. Vendor Per Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(108; "Last Interface Run Time Vendor"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(121; "Activate Account Interface"; Boolean)
        {
            Caption = 'Activate Account Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(122; "Zycus Account Interface Code"; Code[20])
        {
            Caption = 'Zycus Account Interface Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(123; "Last Zycus Account Sync Time"; DateTime)
        {
            Caption = 'Last Zycus Account Sync Time';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(124; "Max. Account Per Interface"; Integer)
        {
            Caption = 'Max.Account Per Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(125; "G/L Account Position"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(126; "G/L Account Position Value"; Code[1])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(127; "Last Interface Run Time GL Acc"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(201; "Activate PO Interface"; Boolean)
        {
            Caption = 'Activate PO Interface';
            Description = 'HEI.04';
        }
        field(202; "Zycus PO Creation Interface"; Code[20])
        {
            Caption = 'Zycus PO Creation Interface';
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(203; "Zycus PO Confirmatio Interface"; Code[20])
        {
            Caption = 'Zycus PO Confirmation Interface';
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(207; "Zycus Create Action Code"; Code[2])
        {
            Caption = 'Zycus Create Action Code';
            Description = 'HEI.04';
        }
        field(208; "Zycus Update Action Code"; Code[2])
        {
            Caption = 'Zycus Update Action Code';
            Description = 'HEI.04';
        }
        field(209; "Zycus Cancellation Action Code"; Code[2])
        {
            Caption = 'Zycus Cancellation Action Code';
            Description = 'HEI.04';
        }
        field(212; "Zycus PO CCC Dimention Code"; Code[20])
        {
            Caption = 'Zycus PO CCC Dimention Code';
            Description = 'HEI.06';
            TableRelation = Dimension;
        }
        field(213; "Zycus PO CONCAT Dimention Code"; Code[20])
        {
            Caption = 'Zycus PO CONCAT Dimention Code';
            Description = 'HEI.06';
            TableRelation = Dimension;
        }
        field(214; "Zycus PO CMG Dimention Code"; Code[20])
        {
            Caption = 'Zycus PO CMG Dimention Code';
            Description = 'HEI.07';
            TableRelation = Dimension;
        }
        field(215; "Zycus Normal PO Code"; Code[3])
        {
            Caption = 'Zycus Normal PO Code';
            Description = 'HEI.06';
        }
        field(216; "Zycus Limit PO Code"; Code[3])
        {
            Caption = 'Zycus Limit PO Code';
            Description = 'HEI.06';
        }
        field(231; "Activate GR Interface"; Boolean)
        {
            Caption = 'Activate GR Interface';
            Description = 'HEI.09';
        }
        field(232; "Zycus GR Creation Interface"; Code[20])
        {
            Caption = 'Zycus GR Creation Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(233; "Zycus GR Confirmatio Interface"; Code[20])
        {
            Caption = 'Zycus GR Confirmation Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(234; "Zycus GR Cancel Interface"; Code[20])
        {
            Caption = 'Zycus GR Cancellation Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(235; "Zycus GR Cancel Conf Interface"; Code[20])
        {
            Caption = 'Zycus GR Cancel Confirmation Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(242; "Zycus LPO GR CreationInterface"; Code[20])
        {
            Caption = 'Zycus Limit PO GR Creation Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(243; "Zycus LPO GR Conf Interface"; Code[20])
        {
            Caption = 'Zycus Limit PO GR Confirmation Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(244; "Zycus LPO GR Cancel Interface"; Code[20])
        {
            Caption = 'Zycus Limit PO GR Cancellation Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(245; "Zycus LPO GR CanlConfInterface"; Code[20])
        {
            Caption = 'Zycus Limit PO GR Cancel Confirmation Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(251; "Zycus GR CreationMovement Type"; Integer)
        {
            Caption = 'Zycus GR Creation Movement Type';
            Description = 'HEI.09';
        }
        field(252; "Zycus GR Cancel Movement Type"; Integer)
        {
            Caption = 'Zycus GR Cancel Movement Type';
            Description = 'HEI.09';
        }
        field(253; "Zycus RD CreationMovement Type"; Integer)
        {
            Caption = 'Zycus Return Delivery Creation Movement Type';
            Description = 'HEI.09';
        }
        field(254; "Zycus RD Cancel Movement Type"; Integer)
        {
            Caption = 'Zycus Return Delivery Cancel Movement Type';
            Description = 'HEI.09';
        }
        field(301; "Activate GL Rule Map Interface"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(302; "Zycus GL Rule Map Object Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            TableRelation = Dimension.Code;
        }
        field(303; "Zycus GL Rule Map Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            TableRelation = "Interface Setup INT".Code;
        }
        field(304; "Starting DateTime  GL Rule Map"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(305; "Max. GL Rule Per Interface"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(306; "Last Zycus GL Rule Sync Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(307; "Last Zycus GL Rule Error Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(308; "Last Zycus GL Rule in Error"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(309; "Last Interface Run Time GLRule"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(400; "Activate POSM GR Interface"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
        }
        field(401; "POSM GR Creation Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            TableRelation = "Interface Setup INT" WHERE("VIP Interface" = FILTER(true));
        }
        field(402; "POSM GR Confirmation Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            TableRelation = "Interface Setup INT" WHERE("VIP Interface" = FILTER(true));
        }
        field(403; "POSM GR Creation Movement Type"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
        }
        field(404; "POSM GR Cancel Movement Type"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
        }
        // BC Upgrade PATELS08 >> # Added new field "Exclude Dimension Matching" as part of HEI.15
        field(405; "Exclude Dimension Matching"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Exclude Dimension Matching';
            TableRelation = Dimension.Code;
            Description = 'HEI.15';
        }
        // BC Upgrade PATELS08 <<
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //HEI.01>>
        SetLastModifiedDateTime();
        //HEI.01<<
    end;

    trigger OnModify();
    begin
        //HEI.01>>
        SetLastModifiedDateTime();
        //HEI.01<<
    end;

    local procedure SetLastModifiedDateTime();
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
        NowL: DateTime;
    begin
        //HEI.01>>
        NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        "Last Date Modified" := DT2DATE(NowL);
        "Last Time Modified" := DT2TIME(NowL);
        "Last Modified By User" := USERID;
        //HEI.01<<
    end;
}

