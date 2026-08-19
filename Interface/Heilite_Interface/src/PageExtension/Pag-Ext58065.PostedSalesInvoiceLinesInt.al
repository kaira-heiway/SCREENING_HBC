pageextension 58065 PostedSalesInvoicelinesIntExt extends "Posted Sales Invoice lines"
{

    //     HEI.01 FDD-HT709 IBM NASTAA02 24.07.2019 # Ethiopia Fiscal No in PSIL
    //   # New Field added "Maraki Fiscal No"

    //Bc Upgrade YADAVM09 "Maraki Fiscal No" added in interface page Extension

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

