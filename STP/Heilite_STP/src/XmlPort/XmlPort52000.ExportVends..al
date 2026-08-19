xmlport 52000 "Export Vends."
{
    //Bc Upgrade YADAVM09 Old id is-50142.
    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;


    schema
    {
        textelement(Root)
        {
            tableelement(Vendor; Vendor)
            {
                XmlName = 'Vendors';
                fieldelement(VendNo; Vendor."No.")
                {
                }
                fieldelement(VendName; Vendor.Name)
                {
                }
                fieldelement(VendGlobalNo; Vendor."Global Vendor Number FND")
                {
                }
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
}

