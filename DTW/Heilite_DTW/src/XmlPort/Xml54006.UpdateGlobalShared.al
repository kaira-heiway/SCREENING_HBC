xmlport 54006 "Update GlobalShared"
{
    //Bc Upgrade YADAVM09 Old id is-50151.

    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'GlobalT';
                UseTemporary = true;
                textelement(SourceType)
                {
                }
                textelement(GlobalID)
                {
                }
                textelement(LocalID)
                {
                }
                textelement(Company)
                {
                }

                trigger OnAfterInsertRecord();
                begin
                    GlobalSharedSource.RESET;
                    GlobalSharedSource.SETRANGE("Source Type", GlobalSharedSource."Source Type"::Vendor);
                    GlobalSharedSource.SETRANGE("Global ID", GlobalID);
                    GlobalSharedSource.SETRANGE("Local ID", LocalID);
                    GlobalSharedSource.SETRANGE("Company ID", Company);
                    if not GlobalSharedSource.FINDFIRST then begin
                        GlobalSharedSource.INIT;
                        GlobalSharedSource."Source Type" := GlobalSharedSource."Source Type"::Vendor;
                        GlobalSharedSource."Global ID" := GlobalID;
                        GlobalSharedSource."Local ID" := LocalID;
                        GlobalSharedSource."Company ID" := Company;
                        GlobalSharedSource.Blocked := false;
                        GlobalSharedSource.INSERT;
                    end;
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

    trigger OnPostXmlPort();
    begin
        MESSAGE('Done');
    end;

    var
        GlobalSharedSource: Record "Global Shared Source FND";
}

