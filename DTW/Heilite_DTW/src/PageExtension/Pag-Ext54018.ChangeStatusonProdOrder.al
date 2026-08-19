pageextension 54018 ChangeStatusonProdOrderExt extends "Change Status on Prod. Order"
{
    // version NAVW19.00
    // HEI.01 CHG2037014 - IBM TUDOSG01 06.01.2020
    // #Default value for Update Cost added
    //******************************************************************************
    //BC UPGRADE PATHAA02-05.01.26
    //# HEI.01 As we do not have oninit trigger in page extensions, moved the code to onopenpage trigger
    //******************************************************************************

    layout
    {
        modify(FirmPlannedStatus)
        {
            CaptionML = ENU = 'New Status', FRA = 'Nouveau statut';
        }
        modify(PostingDate)
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify(ReqUpdUnitCost)
        {
            CaptionML = ENU = 'Update Unit Cost', FRA = 'Mise à jour coût unitaire';
        }
    }

    //BC UPGRADE PATHAA02>>
    trigger OnOpenPage()
    begin
        ReqUpdUnitCost := true;//HEI.01
    end;
    //BC UPGRADE PATHAA02<<

    //Unsupported feature: PropertyModification on "Text666(Variable 19003950)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text666 : ENU=%1 is not a valid selection.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text666 : ENU=%1 is not a valid selection.;FRA=%1 n'est pas une sélection valide.;
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FinishedStatusEditable := true;
    ReleasedStatusEditable := true;
    FirmPlannedStatusEditable := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    ReqUpdUnitCost := true; //HEI.01
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

