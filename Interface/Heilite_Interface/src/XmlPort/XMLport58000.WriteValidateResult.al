xmlport 58000 "Write/Validate Result"
{
    // Heilite Navision Old Id - 50001 
    // version HEI.01

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/result';
    Encoding = UTF8;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Result)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ErrorOccurred)
            {
                MaxOccurs = Once;
                MinOccurs = Zero;
            }
            textelement(ReturnValue)
            {
                MaxOccurs = Once;
                MinOccurs = Zero;
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

    procedure SetValues(NewErrorOccurred: Boolean; NewReturnValue: Text);
    begin
        ErrorOccurred := FORMAT(NewErrorOccurred);
        ReturnValue := NewReturnValue;
    end;
}

