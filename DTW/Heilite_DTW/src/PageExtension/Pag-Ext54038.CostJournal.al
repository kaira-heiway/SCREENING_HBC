pageextension 54038 CostJournalExtDTW extends "Cost Journal"
{
    //BC Upgrade KAPOOV01 - Created this page extension to add the action.
    //Main page ext is in RTR extension. this ext created to add the action becuase in that Action we have DTW report-"Allocate by SKU V.2".



    layout
    {

    }
    actions
    {
        addafter(Post)
        {
            group(Allocation)
            {
                //BC Upgrade KAPOOV01 Moved action-"Allocate expenses" to DTW EXT >>
                action("Allocate expenses")
                {
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        AllocatebySKU2: Report "Allocate by SKU V.2";
                    begin
                        //HEI.01>>
                        //AllocatebySKU.SetDocNo(Rec); commented by HEI.03
                        //AllocatebySKU.RUNMODAL; commented by HEI.03
                        //HEI.03>>
                        AllocatebySKU2.SetDocNo(Rec);
                        AllocatebySKU2.RUNMODAL();
                        //HEI.03<<
                        CurrPage.UPDATE(FALSE);
                        //HEI.01<<
                    end;
                }
                //BC Upgrade KAPOOV01 Moved action-"Allocate expenses" to DTW EXT <<

            }

        }
    }

}

