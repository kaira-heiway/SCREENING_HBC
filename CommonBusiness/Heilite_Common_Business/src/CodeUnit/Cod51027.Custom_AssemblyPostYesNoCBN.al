namespace Heiniken.Heiniken;
using Microsoft.Assembly.Document;
using Microsoft.Assembly.Posting;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Setup;
using Microsoft.Finance.GeneralLedger.Preview;
codeunit 51027 "Custom_Assembly-Post(Y/N)CBN"

{
    //BC Upgrade KAPOOV01 25.11.2025 # Created new Codeunit for CD-901-Assembly-Post (Yes/No) to add HEI Customizations. 
    //Created new Codeunit for standard Codeunit-901-Assembly-Post (Yes/No) for HEI.01 related customization done in function- "Code()" , unable to take this customization in BC as no event found in standard BC CU to add this HEI.01 related code, this HEI.01 code is calling custom function-AllowedEmptyUnitCostOnAssemblyOrder() before running the codeunit-CODEUNIT::"Assembly-Post",AssemblyHeader.
    TableNo = "Assembly Header";

    trigger OnRun()
    begin
        AssemblyHeader.COPY(Rec);
        Code();
        Rec := AssemblyHeader;
    end;

    //HEI.01-CD-901>>
    local procedure Code()
    var

    begin

        //WITH AssemblyHeader DO BEGIN //BC Upgrade KAPOOV01 Commented.

        //HEI.01>>
        IF GUIALLOWED THEN BEGIN
            //HEI.01<<
            IF NOT CONFIRM(Text000, FALSE, AssemblyHeader."Document Type") THEN
                EXIT;

            //HEI.01>>
            IF NOT AllowedEmptyUnitCostOnAssemblyOrder(AssemblyHeader) THEN
                EXIT;
        END;
        //HEI.01<<

        CODEUNIT.RUN(CODEUNIT::"Assembly-Post", AssemblyHeader);
        COMMIT();
        //END;//BC Upgrade KAPOOV01 Commented.
    end;
    //HEI.01-CD-901<<


    //HEI.01,HEI.02-CD-901>>
    local procedure AllowedEmptyUnitCostOnAssemblyOrder(VAR AssemblyHeader: Record "Assembly Header") Post: Boolean
    var
        AssemblyLineL: Record "Assembly Line";
        InventorySetupL: Record "Inventory Setup";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        SKUNotExistL: Boolean;
        DimensionFiltersL: Query "Dimension Filters";
        Text000L: TextConst ENU = 'Unit Cost of an Item %1 is 0.00. Please contact Controlling Team immediately, in order to set correct Unit Cost in the system. In case you proceed with this transaction as is, accounting transactions posted will be wrong. Would you like to proceed?';
    begin
        //HEI.01>>
        Post := TRUE;
        InventorySetupL.GET();
        IF NOT InventorySetupL."Activate UnitCost Warn.Msg FND" THEN
            EXIT;
        IF NOT StockkeepingUnitL.GET(AssemblyHeader."Location Code", AssemblyHeader."Item No.", AssemblyHeader."Variant Code") THEN
            SKUNotExistL := TRUE;
        IF (StockkeepingUnitL."Unit Cost" = 0) OR SKUNotExistL THEN BEGIN
            DimensionFiltersL.SETRANGE(No, AssemblyHeader."Item No.");
            IF InventorySetupL."Exclude CMG Dime. Value FND" <> '' THEN
                DimensionFiltersL.SETFILTER(Dimension_Value_Code, '<>%1', InventorySetupL."Exclude CMG Dime. Value FND");
            DimensionFiltersL.OPEN();
            IF DimensionFiltersL.READ() THEN BEGIN
                IF NOT CONFIRM(Text000L, FALSE, AssemblyHeader."Item No.") THEN BEGIN
                    //HEI.02>>
                    DimensionFiltersL.CLOSE();
                    //HEI.02<<
                    EXIT(FALSE);
                    //HEI.02>>
                END;
                //HEI.02<<
            END;
            //HEI.02>>
            DimensionFiltersL.CLOSE();
            //HEI.02<<
        END;

        AssemblyLineL.SETCURRENTKEY("Document Type", "Document No.", Type);
        AssemblyLineL.SETRANGE("Document Type", AssemblyHeader."Document Type");
        AssemblyLineL.SETRANGE("Document No.", AssemblyHeader."No.");
        AssemblyLineL.SETRANGE(Type, AssemblyLineL.Type::Item);
        //IF AssemblyLineL.FINDSET(FALSE, FALSE) THEN   //BC Upgrade KAPOOV01 Commented as FindSet(ForUpdate, UpdateKey) is deprecated.
        IF AssemblyLineL.FINDSET() THEN
            REPEAT
                CLEAR(SKUNotExistL);
                IF NOT StockkeepingUnitL.GET(AssemblyLineL."Location Code", AssemblyLineL."No.", AssemblyLineL."Variant Code") THEN
                    SKUNotExistL := TRUE;
                IF (StockkeepingUnitL."Unit Cost" = 0) OR SKUNotExistL THEN BEGIN
                    DimensionFiltersL.SETRANGE(No, AssemblyLineL."No.");
                    IF InventorySetupL."Exclude CMG Dime. Value FND" <> '' THEN
                        DimensionFiltersL.SETFILTER(Dimension_Value_Code, '<>%1', InventorySetupL."Exclude CMG Dime. Value FND");
                    DimensionFiltersL.OPEN();
                    IF DimensionFiltersL.READ() THEN BEGIN
                        IF NOT CONFIRM(Text000L, FALSE, AssemblyLineL."No.") THEN BEGIN
                            //HEI.02>>
                            DimensionFiltersL.CLOSE();
                            //HEI.02<<
                            EXIT(FALSE);
                            //HEI.02>>
                        END;
                        //HEI.02<<
                    END;
                    //HEI.02>>
                    DimensionFiltersL.CLOSE();
                    //HEI.02<<
                END;
            UNTIL AssemblyLineL.NEXT() = 0;
        //HEI.01<<

    end;
    //HEI.01,HEI.02-CD-901<<

    var
        AssemblyHeader: Record "Assembly Header";
        Text000: TextConst ENU = 'Do you want to post the %1?', FRA = 'Souhaitez-vous valider le document %1 ?';

}
