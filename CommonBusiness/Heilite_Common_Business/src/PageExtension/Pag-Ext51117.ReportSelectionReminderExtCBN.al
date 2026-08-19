pageextension 51117 ReportSelectionReminderExtCBN extends "Report Selection - Reminder"
{
    // version NAVW110.0,HEI.01
    //     HEI.01 OTCGAP022 IBM ISYED01 23/08/2017
    //   # added code to function SetUsageFilter fo filter Cash.collection
    //   # Added ,Cash.Collection to the option string of Usage on global and in design as well 

    //**********************************************
    //BC UPGRADE PATHAA02-04.11.25
    //1. Created Enum Ext-50012 to add Option -Cash Collection.
    //2. Event Subscribed(OnSetUsageFilterOnAfterSetFiltersByReportUsage) for HEI.01 

    layout
    {
        modify(ReportUsage2)
        {
            CaptionML = ENU = 'Usage', FRA = 'Utilisation';
            //OptionCaptionML = ENU = 'Reminder,Fin. Charge,Reminder Test,Fin. Charge Test,Cash.Collection', FRA = 'Relance,Intérêts de retard,Relance - Test,Intérêts de retard - Test';

        }
        modify(Sequence)
        {
            ToolTipML = ENU = 'Specifies a number that indicates where this report is in the printing order.', FRA = 'Spécifie un numéro qui indique où se trouve l''état dans l''ordre d''impression.';
        }
        modify("Report ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the report that will print.', FRA = 'Spécifie l''ID du rapport qui sera imprimé.';
        }
        modify("Report Caption")
        {
            ToolTipML = ENU = 'Specifies the name of the report.', FRA = 'Spécifie le nom du rapport.';
        }
    }

    //Unsupported feature: PropertyModification on "ReportUsage2(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReportUsage2 : Reminder,"Fin. Charge","Reminder Test","Fin. Charge Test";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReportUsage2 : Reminder,"Fin. Charge","Reminder Test","Fin. Charge Test","Cash.Collection";
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "SetUsageFilter(PROCEDURE 1)". Please convert manually.

    //procedure SetUsageFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ModifyRec then
      if MODIFY then;
    FILTERGROUP(2);
    #4..9
        SETRANGE(Usage,Usage::"Rem.Test");
      ReportUsage2::"Fin. Charge Test":
        SETRANGE(Usage,Usage::"F.C.Test");
    end;
    FILTERGROUP(0);
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
      //HEI.01>>
      ReportUsage2::"Cash.Collection":
       SETRANGE(Usage,Usage::"Cash.Collection");
      //HEI.01<<
    #13..15
    */
    //end;
    //BC UPGRADE PATHAA02>>
    // local procedure SetUsageFilter(ModifyRec: Boolean)

    // var
    //     RecRef: RecordRef;
    //     FieldRef: FieldRef;
    // begin
    //     IF ModifyRec THEN
    //         IF Rec.MODIFY THEN;
    //     Rec.FILTERGROUP(2);
    //     CASE ReportUsage2 OF
    //         ReportUsage2::Reminder:
    //             Rec.SETRANGE(Usage, Rec.Usage::Reminder);
    //         ReportUsage2::"Fin. Charge":
    //             Rec.SETRANGE(Usage, Rec.Usage::"Fin.Charge");
    //         ReportUsage2::"Reminder Test":
    //             Rec.SETRANGE(Usage, Rec.Usage::"Rem.Test");
    //         ReportUsage2::"Fin. Charge Test":
    //             Rec.SETRANGE(Usage, Rec.Usage::"F.C.Test");
    //         //HEI.01>>
    //         ReportUsage2::"Cash.Collection":
    //             Rec.SETRANGE(Usage, Enum::);
    //     //HEI.01<<
    //     end;
    //     Rec.FILTERGROUP(0);
    //     CurrPage.UPDATE;
    // end;
    //BC UPGRADE PATHAA02<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    var
        myInt: Integer;
        ReportUsage2: Option "Reminder","Fin. Charge","Reminder Test","Fin. Charge Test","Cash.Collection";

}

