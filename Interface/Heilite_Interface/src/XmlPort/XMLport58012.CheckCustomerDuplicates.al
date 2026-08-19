xmlport 58012 "Check Customer Duplicates"
{
    // Heilite Navision Old Id - 50047
    // HEI.01 FDD-SLSGAP020 IBM HORTOC01 #new xmlport - customer mendix interface

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/CheckCustomerDuplicates';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webCheckCustomer)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(Customer)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Once;
                textelement(Name1)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Address)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Address2)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(City)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VatRegistrationNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CustomerAttributes)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    textelement(Street3)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Street4)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Street5)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(HouseNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(TaxNumber1)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(TaxNumber2)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(POBox)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                }

                trigger OnAfterAssignVariable();
                begin
                    /*
                    TempCust.INIT;
                    TempCust.Name := Name1;
                    TempCust.Address := Address;
                    TempCust."Address 2" := Address2;
                    TempCust.City := City;
                    TempCust."VAT Registration No." := VatRegistrationNo;
                    TempCust.INSERT;
                    */

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

    var
        TempCust: Record Customer temporary;

    procedure GetCustomerDescription() Name: Text;
    begin
        //Name := TempCust.Name;
        Name := POBox + HouseNo + Street3 + Street4 + Street5 + Name1 + Address + Address2 + City;
        Name := DELCHR(Name, '=', ' ');
    end;

    procedure GetVatRegNo(): Text;
    begin
        exit(VatRegistrationNo);
    end;

    procedure GetTaxNumber1(): Text;
    begin
        exit(TaxNumber1)
    end;

    procedure GetTaxNumber2(): Text;
    begin
        exit(TaxNumber2)
    end;
}

