pageextension 53051 "Ext Vehicle" extends Vehicle101FDW
{
    layout
    {
        addafter(Type)
        {
            field("Status FND"; Rec."Status FND")
            {
                ApplicationArea = All;
            }
        }

    }
}
