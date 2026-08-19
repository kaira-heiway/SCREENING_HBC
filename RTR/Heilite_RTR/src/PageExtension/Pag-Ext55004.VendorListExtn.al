pageextension 55004 VendorListExtn extends "Vendor List"
{
    actions
    {
        addafter("Vendor - Detail Trial Balance")
        {
            action("Vendor Detail Trial Balance FR")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Vendor Detail Trial Balance FR',
                            FRA = 'Grand livre fournisseurs FR';
                Image = "Report";
                ToolTip = 'Executes the Vendor Detail Trial Balance FR action.';
                RunObject = Report "Vendor Detail Trial Balance LR";//BC UPgrade SHARMP16 uncomment this later after the compilation of this report // Bc Upgrade BHARDA11 --30April2026
                                                                    // RTR
            }
        }
    }
}
