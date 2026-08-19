namespace ALProject.ALProject;

enum 50015 "Plant-Specific Material Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "Local Setup")
    {
        Caption = 'Local Setup';
    }
    value(1; "Local Active")
    {
        Caption = 'Local Active';
    }
    value(2; "Local Inact/ No Procurement")
    {
        Caption = 'Local Inact/ No Procurement';
    }
    value(3; "Local Inactive")
    {
        Caption = 'Local Inactive';
    }
    value(4; "Local to be Archived")
    {
        Caption = 'Local to be Archived';
    }

}