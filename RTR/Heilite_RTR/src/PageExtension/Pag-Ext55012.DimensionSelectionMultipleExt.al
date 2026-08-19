pageextension 55012 DimensionSelectionMultipleExt extends "Dimension Selection-Multiple"
{
    // version NAVW110.0
    //HEI.01 CHG2012109 IBM BULIMC01 2.16.2021#new variable created - "SelectAll" in order to select/unselect all the dimensions

    //BC Upgrade KAPOOV01 BCUP0-151>>
    //New variable created - "SelectAll" in order to select/unselect all the dimensions
    //BC Upgrade KAPOOV01 BCUP0-151<<


    layout
    {
        // Inserts the SelectAll field right above the main repeater grid
        addbefore(Control1)
        {
            group(SelectAllGroup)
            {
                ShowCaption = false;

                field(SelectAll; SelectAllVar)
                {
                    ApplicationArea = All;
                    Caption = 'Select All';
                    ToolTip = 'SelectAll';

                    trigger OnValidate()
                    begin
                        //HEI.01>>
                        if Rec.FindSet() then
                            repeat
                                if SelectAllVar then
                                    Rec.Selected := true
                                else
                                    Rec.Selected := false;
                                Rec.Modify();
                            until Rec.Next() = 0;

                        CurrPage.Update(false);
                        //HEI.01<<
                    end;
                }
            }
        }
    }

    var
        SelectAllVar: Boolean;
}
