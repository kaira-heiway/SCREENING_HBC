namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Manufacturing.Document;

pageextension 58024 FirmPlannedProdOrderInterfExt extends "Firm Planned Prod. Order"
{
    // BC Upgrade SHUKLP03 >>
    // HEI.06 CHG2129985 SAHAL01      14.04.2022
    //   # Added New Tab - LogoPak
    //   # Added New Fields - Prod. Order Interface
    //                      - Parked for LogoPak
    //   # Added Code to visible LogoPak Tab
    // BC Upgrade SHUKLP03 <<

    layout
    {
        addafter(Posting)
        {
            group(LogoPak)
            {
                Caption = 'LogoPak';
                Visible = VisibleLogoPak;
                field("Prod. Order Interface"; Rec."Prod. Order Interface INT")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Order Interface field.';
                }
                field("Parked for LogoPak"; Rec."Parked for LogoPak INT")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parked for LogoPak field.';
                }
            }

        }
    }

    trigger OnOpenPage()
    var
        WMSInterfaceSetupL: Record "WMS Interface Setup INT";
        InterfaceSetupL: Record "Interface Setup INT";
    begin
        //HEI.06>>
        CLEAR(VisibleLogoPak);
        IF WMSInterfaceSetupL.GET() AND WMSInterfaceSetupL."WMS Integration" THEN BEGIN
            IF WMSInterfaceSetupL."Activate LogoPak Interface" AND (WMSInterfaceSetupL."Prod. Order Interface" <> '') THEN
                IF InterfaceSetupL.GET(WMSInterfaceSetupL."Prod. Order Interface") THEN
                    VisibleLogoPak := TRUE;
        END;
        //HEI.06<<
    end;

    var
        VisibleLogoPak: Boolean;

}
