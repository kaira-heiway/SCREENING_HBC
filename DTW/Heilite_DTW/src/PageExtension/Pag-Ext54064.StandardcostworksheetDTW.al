namespace DTWMain_Ext.DTWMain_Ext;

using Microsoft.Manufacturing.StandardCost;

pageextension 54064 StandardcostworksheetDTW extends "Standard Cost Worksheet"
{
    //BC Upgrade GUNREM01 >> Created this page extension to add the action for "Implement Standard Cost Based On Components DTW" in standard cost worksheet page  FDD DTW 16
    layout
    {

    }
    actions
    {
        addafter("&Implement Standard Cost Changes")
        {
            action(ImpementStandardCostBasedOnCompDTW)
            {
                ApplicationArea = all;
                Caption = 'Implement Standard Cost Based On Components DTW';
                Image = ImplementCostChanges;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report ImplementStandardCostItem;
                ToolTip = 'Implement Standard Cost Based On Components';
            }
        }
    }
}
