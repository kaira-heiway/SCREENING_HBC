namespace STP.STP;

using Microsoft.Purchases.Vendor;

pageextension 52031 VendorListSTPExt extends "Vendor List"
{
    // 30April2026
    actions
    {
        addafter("Vendor - Detail Trial Balance")
        {
            action("<Vendor Trial Balance DRC>")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Vendor Trial Balance - DRC',
                            FRA = 'Balance fournisseurs DRC';
                Image = "Report";
                ToolTip = 'Executes the <Vendor Trial Balance DRC> action.';
                RunObject = Report "Vendor Trial Balance - DRC";//BC UPgrade SHARMP16 uncomment this later after the compilation of this report // Bc Upgrade BHARDA11 --30April2026
                // STP
            }
            action("<Vendor Detail Trial Bala DRC>")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Vendor Detail Trial Balance - DRC',
                            FRA = 'Grand livre fournisseurs DRC';
                Image = "Report";
                ToolTip = 'Executes the <Vendor Detail Trial Bala DRC> action.';
                RunObject = Report "Vendor Detail Trial Bal - DRC";//BC UPgrade SHARMP16 uncomment this later after the compilation of this report // Bc Upgrade BHARDA11 --30April2026
                // STP
            }
        }
    }
}
