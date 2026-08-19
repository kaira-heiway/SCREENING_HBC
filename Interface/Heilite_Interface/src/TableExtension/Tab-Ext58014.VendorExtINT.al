namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.Vendor;

tableextension 58014 "VendorExt_INT" extends Vendor
{

    // HEI.22 HEI.02 CHG2210794 MAJUMS03 22.01.2024 Zycus - BASE HL Integration Master Vendor and GL Account. (*RLPPD)
    //   # New Function "UpdateLocaltimestamp" is added.
    //   # Code added.
    // HEI.23 CHG2210794 MAJUMS03 13.05.2024 Zycus - BASE HL Integration - Vendor GL Account Development Rework.
    //   # Code added.
    // HEI.24 CHG2210794 MAJUMS03 04.09.2024 Zycus - BASE HL Integration - Vendor GL Account Development Finetuning.
    //   # Code added.
    //   # New Function "CheckZycusEnable" is added

    // BC Upgrade SHUKLP03 >>
    // Procedure UpdateLocaltimestamp() and CheckZycusEnable() added Here.
    // OnInsert, OnModify, OnDelete, OnRename code is added Here.
    // BC Upgrade SHUKLP03 <<


    //BCUpgrade sharmp16 begin>>
    local procedure UpdateLocaltimestamp()
    var
        myInt: Integer;
    begin
        //HEI.22>>
        IF (xRec."Vendor Type FND" <> Rec."Vendor Type FND") OR (xRec.Blocked <> Rec.Blocked) OR (xRec."Currency Code" <> Rec."Currency Code")
          OR (xRec."Payment Terms Code" <> Rec."Payment Terms Code") OR (xRec."Shipment Method Code" <> Rec."Shipment Method Code")
          OR (xRec."Global Delete FND" <> Rec."Global Delete FND") THEN
            //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor,"No.",FALSE); //HEI.23
            ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor, "No.", FALSE, "Global Delete FND"); //HEI.23
                                                                                                             //HEI.22<<

    end;

    local procedure CheckZycusEnable(): Boolean
    var

    begin
        // HEI.24 >>
        if ZycusInterfaceSetupLV.ReadPermission then begin
            if ZycusInterfaceSetupLV.Get() then
                if (ZycusInterfaceSetupLV."Enabled Zycus Integration" and ZycusInterfaceSetupLV."Activate Vendor Interface") then
                    exit(true);
        end;
        exit(false);
    end;  // BC Upgrade NANDIS03

    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        IF CheckZycusEnable() THEN//HEI.24
            ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor, "No.", FALSE, "Global Delete FND"); //HEI.2    // BC Upgrade NANDIS03
    end;

    trigger OnAfterModify()
    var
        myInt: Integer;
    begin
        IF CheckZycusEnable() THEN //HEI.24
            UpdateLocaltimestamp(); //HEI.22  // BC Upgrade NANDIS03

    end;

    trigger OnAfterDelete()
    var
        myInt: Integer;
    begin
        IF CheckZycusEnable() THEN //HEI.24
            ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor, "No.", TRUE, "Global Delete FND"); //HEI.23  // BC Upgrade NANDIS03

    end;

    trigger OnAfterRename()
    var
        myInt: Integer;
    begin
        IF CheckZycusEnable() THEN //HEI.24
            ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor, "No.", FALSE, "Global Delete FND"); //HEI.23  // BC Upgrade NANDIS03

    end;
    //BCUpgrade sharmp16 end<<



    var
        ZycusMasterTimestamp: Record "Zycus Master Timestamp FND";
        ZycusInterfaceSetupLV: Record "Zycus Interface Setup INT";


}
