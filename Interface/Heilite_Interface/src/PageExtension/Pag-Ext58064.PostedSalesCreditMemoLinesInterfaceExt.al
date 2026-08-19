pageextension 58064 PostedSalecredimemolinesIntExt extends "Posted Sales credit memo lines"
{

    //     HEI.01 FDD-HT709 IBM NASTAA02 24.07.2019 # Ethiopia Fiscal No in PSIL
    //   # New Field added "Maraki Fiscal No"

    //Bc Upgrade YADAVM09 "Maraki Fiscal No" added in interface page Extension
    //Bc Upgrade YADAVM09 PostedSalescreditmemolinesIntExt due to length issue page name write like PostedSalescreditmemolinesIntExt.

    layout
    {

        addafter("Document No.")
        {
            field("Maraki Fiscal No."; Rec."Maraki Fiscal No. FND")
            {
                ApplicationArea = ALl;//Bc Upgrade YADAVM09
            }
        }
    }
    actions
    {

    }



}

