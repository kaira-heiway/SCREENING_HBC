
pageextension 53046 "Ext Gate Entry List MTC" extends "Gate Entry List"
{
    actions
    {
        modify(Card)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                if (Rec."Gate Entry Type" = rec."Gate Entry Type"::Inbound) and (rec.Registered = false) then
                    // PAGE.RUNMODAL(50224, Rec);//BC UPGRADE KUMARR78 -- FDD-MTC-007--
                    PAGE.RUNMODAL(53009, Rec);
                if (rec."Gate Entry Type" = rec."Gate Entry Type"::Inbound) and (rec.Registered = true) then
                    // PAGE.RUNMODAL(50222, Rec);//BC UPGRADE KUMARR78 -- FDD-MTC-007--
                    PAGE.RUNMODAL(53007, Rec);

                if (rec."Gate Entry Type" = rec."Gate Entry Type"::Outbound) and (rec.Registered = false) then
                    // PAGE.RUNMODAL(50225, Rec);//BC UPGRADE KUMARR78 -- FDD-MTC-007--
                    PAGE.RUNMODAL(53010, Rec);

                if (rec."Gate Entry Type" = rec."Gate Entry Type"::Outbound) and (rec.Registered = true) then
                    // PAGE.RUNMODAL(50222, Rec);//BC UPGRADE KUMARR78 -- FDD-MTC-007--
                    PAGE.RUNMODAL(53007, Rec);

                if (rec."Gate Entry Type" = rec."Gate Entry Type"::Service) and (rec.Registered = false) then
                    // PAGE.RUNMODAL(50226, Rec);//BC UPGRADE KUMARR78 -- FDD-MTC-007--
                PAGE.RUNMODAL(53011, Rec);

                if (rec."Gate Entry Type" = rec."Gate Entry Type"::Service) and (rec.Registered = true) then
                    // PAGE.RUNMODAL(50222, Rec);//BC UPGRADE KUMARR78 -- FDD-MTC-007--
                PAGE.RUNMODAL(53007, Rec);

                if (rec."Gate Entry Type" = rec."Gate Entry Type"::Stay) and (rec.Registered = false) then
                    // PAGE.RUNMODAL(50227, Rec);//BC UPGRADE KUMARR78 -- FDD-MTC-007--
                PAGE.RUNMODAL(53012, Rec);

                if (rec."Gate Entry Type" = rec."Gate Entry Type"::Stay) and (rec.Registered = true) then
                    // PAGE.RUNMODAL(50222, Rec);//BC UPGRADE KUMARR78 -- FDD-MTC-007--
                PAGE.RUNMODAL(53007, Rec);
                //HEI.04<<
            end;
        }
    }
}
