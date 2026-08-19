xmlport 58006 "Write Vendor Bank"
{
    // Heilite Navision Old Id - 50007
    // version HEI.04

    // HEI.01 IBM HORTOC01 08.06.2018 - add new field "Account Type"
    // HEI.02 CHG2003450 IBM SHANKJ03 30.03.2020
    // HEI.03 CHG2189862 HB3326 IBM SRIVAS07 31.03.2023 - BC Panama - Mendix - Vendor bank account
    //    # Added new elements IntermBankBICSWIFTCode
    //    # Added Code in AddXMLBufferElements()
    // HEI.04 CHG2189862 HB3326 IBM SRIVAS07 04.04.2023 - BC Panama - Mendix - Vendor bank account
    //    # Changed the minOccures and MaxOccurs value for IntermBankBICSWIFTCode element.

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteVendorBank';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webVendorWriteBank)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webVendorWriteBank');
                    TempXMLBuffer.AddElement('ValidateOnly', ValidateOnly);
                end;
            }
            textelement(VendorBank)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Zero;
                textelement(VendorNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable();
                    begin
                        //HEI.02 >>
                        /*
                        IF ValidateOnly = 'NO' THEN BEGIN
                        I += 1;
                        IF I = 1 THEN BEGIN
                          VendorBankAccount.RESET;
                          VendorBankAccount.SETRANGE("Vendor No.",VendorNo);
                          //VendorBankAccount.SETRANGE(Code,Code);
                          IF VendorBankAccount.FINDSET THEN
                            VendorBankAccount.MODIFYALL(Exists,FALSE);
                            COMMIT;
                        END;
                        VendorCode := VendorNo;
                        END;
                        //HEI.02 <<
                        */
                        VendorCode := VendorNo;

                    end;
                }
                textelement(Code)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable();
                    begin
                        //HEI.02 >>
                        /*
                        IF ValidateOnly = 'NO' THEN BEGIN
                        VendorBankAccNo := Code;
                        VendorBankAccount.RESET;
                        VendorBankAccount.SETRANGE("Vendor No.",VendorNo);
                        VendorBankAccount.SETRANGE(Code,VendorBankAccNo);
                        IF VendorBankAccount.FINDSET THEN BEGIN
                          //VendorBankAccount.Exists := TRUE;
                          VendorBankAccount.MODIFY;
                          COMMIT;
                        END;
                        END;
                        //HEI.02 <<
                        */

                    end;
                }
                textelement(BankBranchNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable();
                    begin
                        //HEI.02 >>
                        /*
                        IF ((VendorNo <> '') AND (Code <>''))  THEN
                          IF BankBranchNo ='' THEN BEGIN
                            VendorBankAccount.RESET;
                            VendorBankAccount.SETRANGE("Vendor No.",VendorNo);
                            VendorBankAccount.SETRANGE(Code,Code);
                            IF VendorBankAccount.FINDFIRST THEN BEGIN
                               VendorBankAccount.Exists :=TRUE;
                               VendorBankAccount.MODIFY;
                               //ERROR('%1',VendorBankAccount.Blocked);
                            END;
                        
                        END;
                        IF ValidateOnly = 'NO' THEN BEGIN
                        VendorBankAccount.RESET;
                        VendorBankAccount.SETRANGE("Vendor No.",VendorNo);
                        VendorBankAccount.SETRANGE(Code,VendorBankAccNo);
                        IF VendorBankAccount.FINDSET THEN BEGIN
                          //VendorBankAccount.Exists := TRUE;
                          VendorBankAccount.MODIFY;
                          COMMIT;
                        END;
                        END;
                        //HEI.02 <<
                        */

                    end;
                }
                textelement(BankAccountNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CurrencyCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(IBAN)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable();
                    begin
                        //HEI.02 >>
                        /*
                        IF ValidateOnly = 'NO' THEN BEGIN
                        VendorBankAccount.RESET;
                        VendorBankAccount.SETRANGE("Vendor No.",VendorNo);
                        VendorBankAccount.SETRANGE(Code,VendorBankAccNo);
                        IF VendorBankAccount.FINDFIRST THEN BEGIN
                          IF VendorBankAccount.IBAN = '' THEN BEGIN
                            VendorBankAccount.VALIDATE(IBAN,IBAN);
                            VendorBankAccount.MODIFY;
                            COMMIT;
                          END;
                        END;
                        END;
                        */
                        //HEI.02 <<

                    end;
                }
                textelement(Name)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Address)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(City)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CountryRegionCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SWIFTCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(AccountType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(intermbankbicswiftcode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    XmlName = 'IntermBankBICSWIFTCode';
                }

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('VendorBank');
                    AddXMLBufferElements();
                    TempXMLBuffer.GetParent();
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort();
    begin
        //HEI.02 >>
        I := 0;
        //HEI.02 <<
    end;

    trigger OnPostXmlPort();
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
    begin
        CLEAR(TempBlob);
        InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); //BC Upgrade VAMSIU01 - Added
        // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer);  // BC Upgrade NANDIS03
        //HEI.02 >>

        //IF ValidateOnly = 'NO' THEN BEGIN
        VendorBankAccount.RESET();
        VendorBankAccount.SETRANGE("Vendor No.", VendorCode);
        VendorBankAccount.SETFILTER("Bank Branch No.", '=%1', '');
        if VendorBankAccount.findset() then begin
            repeat
                // IF ((VendorNo <> '') AND (Code <>''))  THEN
                // IF BankBranchNo ='' THEN BEGIN
                //VendorBankAccount.Exists := TRUE;
                //VendorBankAccount.MODIFY;
                VendorBankAccount.DELETE();
            until VendorBankAccount.NEXT() = 0;
            COMMIT();
        end;
        //END;
        //HEI.02 <<
    end;

    var
        TempXMLBuffer: Record "XML Buffer" temporary;
        //TempBlob : Record TempBlob temporary;  // BC Upgrade NANDIS03
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Added
        //CustVendorBankAccWorkflow: Codeunit "Cust/Vendor Bank Acc. Workflow";  // BC Upgrade NANDIS03 - Bloced as nowhere this variable is used
        VendorBankAccount: Record "Vendor Bank Account";
        VendorBankAccount1: Record "Vendor Bank Account";
        VendorCode: Code[20];
        VendorBankAccNo: Code[20];
        I: Integer;
        SessionGlobals: Codeunit "Session Globals";

    local procedure AddXMLBufferElements();
    var
        Vendor: Record Vendor;
        SimulationMode: Boolean;
    begin
        EVALUATE(SimulationMode, ValidateOnly);
        SessionGlobals.SetSimulateModeGlobal(SimulationMode); //HEI.02
        if not SimulationMode then
            TempXMLBuffer.AddElement('VendorNo', VendorNo)
        else
            if VendorNo = '' then begin
                if Vendor.FINDLAST() then
                    TempXMLBuffer.AddElement('VendorNo', Vendor."No.");
            end else
                if Vendor.GET(VendorNo) then
                    TempXMLBuffer.AddElement('VendorNo', VendorNo);
        TempXMLBuffer.AddElement('Code', Code);
        TempXMLBuffer.AddElement('BankBranchNo', BankBranchNo);
        TempXMLBuffer.AddElement('BankAccountNo', BankAccountNo);
        TempXMLBuffer.AddElement('CurrencyCode', CurrencyCode);
        TempXMLBuffer.AddElement('IBAN', IBAN);
        TempXMLBuffer.AddElement('Name', Name);
        TempXMLBuffer.AddElement('Address', Address);
        TempXMLBuffer.AddElement('City', City);
        TempXMLBuffer.AddElement('CountryRegionCode', CountryRegionCode);
        TempXMLBuffer.AddElement('SWIFTCode', SWIFTCode);
        TempXMLBuffer.AddElement('AccountType', AccountType);//HEI.01
        TempXMLBuffer.AddElement('IntermBankBICSWIFTCode', IntermBankBICSWIFTCode); //HEI.03
        VendorNo := '';
        Code := '';
        BankBranchNo := '';
        BankAccountNo := '';
        CurrencyCode := '';
        IBAN := '';
        Name := '';
        Address := '';
        City := '';
        CountryRegionCode := '';
        SWIFTCode := '';
        AccountType := '';//HEI.01
        IntermBankBICSWIFTCode := '';//HEI.03
    end;

    procedure GetSimulateMode() SimulateMode: Boolean;
    begin
        EVALUATE(SimulateMode, ValidateOnly);
    end;

    // BC Upgrade NANDIS03 >> 
    //procedure GetTempBlob(var NewTempBlob: Record TempBlob);
    procedure GetTempBlob(var NewTempBlob: Codeunit "Temp Blob");
    // BC Upgrade NANDIS03 <<
    begin
        NewTempBlob := TempBlob;
    end;
}

