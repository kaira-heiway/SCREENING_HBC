page 58050 "SRM Interface Setup"
{
    // Heilite Navision Old Id - 50412

    // version HEI.05

    // HEI.01 CHG2041871 PANDES01 24-01-2020
    //  # New Page SRM Interface Setup created.
    //  HEI.02 CHG2021732 FDD-HB755 IBM.GUNERE01 10.02.2020 # "SRM G/L Account Position", "SRM G/L Account Position Val." fields added
    // HEI.03 CHG2095081 IBM.PANDES01 14-04-2021
    //  #Added one field Default Unit of Measure
    // HEI.04 CHG2148350 FDD-HB2777 IBM NANDIS01 16.02.2023 # develop confirmation check interface for HL
    //   # Fields shown "GR Validation Req Interface" and "GR Validation Res Interface"
    // HEI.05 CHG2190299 FDD-HB3316 IBM NANDIS01 24.05.2023 # POSM eshop SRM- HL interface
    //   # Fields shown "POSM-GR-Creation" and "POSM GR Confirmation"

    PageType = Card;
    SourceTable = "SRM Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group("SRM Interface Setup INT")
            {
                field("SRM Vendor Request Interface"; Rec."SRM Vendor Request Interface")
                {
                    ToolTip = 'Specifies the value of the SRM Vendor Request Interface field.';
                }
                field("SRM Vendor Response Interface"; Rec."SRM Vendor Response Interface")
                {
                    ToolTip = 'Specifies the value of the SRM Vendor Response Interface field.';
                }
                field("SRM Material Request Interface"; Rec."SRM Material Request Interface")
                {
                    ToolTip = 'Specifies the value of the SRM Material Request Interface field.';
                }
                field("SRM Material Response Interf."; Rec."SRM Material Response Interf.")
                {
                    ToolTip = 'Specifies the value of the SRM Material Response Interface field.';
                }
                field("Contract Creation Interface"; Rec."Contract Creation Interface")
                {
                    ToolTip = 'Specifies the value of the Contract Creation Interface field.';
                }
                field("Contract Confirm. Interface"; Rec."Contract Confirm. Interface")
                {
                    ToolTip = 'Specifies the value of the Contract Confirmation Interface field.';
                }
                field("Contract Call-Off Interface"; Rec."Contract Call-Off Interface")
                {
                    ToolTip = 'Specifies the value of the Contract Call-Off Interface field.';
                }
                field("PO Validation Req. Interface"; Rec."PO Validation Req. Interface")
                {
                    ToolTip = 'Specifies the value of the PO Validation Request Interface field.';
                }
                field("PO Validation Resp. Interface"; Rec."PO Validation Resp. Interface")
                {
                    ToolTip = 'Specifies the value of the PO Validation Response Interface field.';
                }
                field("PO Creation Interface"; Rec."PO Creation Interface")
                {
                    ToolTip = 'Specifies the value of the PO Creation Interface field.';
                }
                field("PO Confirmation Interface"; Rec."PO Confirmation Interface")
                {
                    ToolTip = 'Specifies the value of the PO Confirmation Interface field.';
                }
                field("GR Validation Req Interface"; Rec."GR Validation Req Interface")
                {
                    ToolTip = 'Specifies the value of the GR Validation Request Interface field.';
                }
                field("GR Validation Res Interface"; Rec."GR Validation Res Interface")
                {
                    ToolTip = 'Specifies the value of the GR Validation Response Interface field.';
                }
                field("GR Creation Interface"; Rec."GR Creation Interface")
                {
                    ToolTip = 'Specifies the value of the GR Creation Interface field.';
                }
                field("GR Confirmation Interface"; Rec."GR Confirmation Interface")
                {
                    ToolTip = 'Specifies the value of the GR Confirmation Interface field.';
                }
                field("Account Assignment Interface"; Rec."Account Assignment Interface")
                {
                    ToolTip = 'Specifies the value of the Account Assignment Interface field.';
                }
                field("G/L Account Interface"; Rec."G/L Account Interface")
                {
                    ToolTip = 'Specifies the value of the G/L Account Interface field.';
                }
                field("POSM GR Creation"; Rec."POSM GR Creation")
                {
                    ToolTip = 'Specifies the value of the POSM GR Creation Interface field.';
                }
                field("POSM GR Confirmation"; Rec."POSM GR Confirmation")
                {
                    ToolTip = 'Specifies the value of the POSM GR Confirmation field.';
                }
                field("Account Assgn. Dim. Filter"; Rec."Account Assgn. Dim. Filter")
                {
                    ToolTip = 'Specifies the value of the Account Assignment Dimension Filter field.';
                }
                field("SRM Cost Center Object Type"; Rec."SRM Cost Center Object Type")
                {
                    ToolTip = 'Specifies the value of the SRM Cost Center Object Type field.';
                }
                field("SRM Project Object Type"; Rec."SRM Project Object Type")
                {
                    ToolTip = 'Specifies the value of the SRM Project Object Type field.';
                }
                field("SRM G/L Account Object Type"; Rec."SRM G/L Account Object Type")
                {
                    ToolTip = 'Specifies the value of the SRM G/L Account Object Type field.';
                }
                field("SRM Exch. Rate Rndg. Precision"; Rec."SRM Exch. Rate Rndg. Precision")
                {
                    ToolTip = 'Specifies the value of the SRM Exchange Rate Rounding Precision field.';
                }
                field("GR Creation Movement Type"; Rec."GR Creation Movement Type")
                {
                    ToolTip = 'Specifies the value of the GR Creation Movement Type field.';
                }
                field("GR Cancellation Movement Type"; Rec."GR Cancellation Movement Type")
                {
                    ToolTip = 'Specifies the value of the GR Cancellation Movement Type field.';
                }
                field("Contract Default G/L Acc. No."; Rec."Contract Default G/L Acc. No.")
                {
                    ToolTip = 'Specifies the value of the Contract Default G/L Acc. No. field.';
                }
                field("SRM Create Action Code"; Rec."SRM Create Action Code")
                {
                    ToolTip = 'Specifies the value of the SRM Create Action Code field.';
                }
                field("SRM Change Action Code"; Rec."SRM Change Action Code")
                {
                    ToolTip = 'Specifies the value of the SRM Change Action Code field.';
                }
                field("SRM Close Action Code"; Rec."SRM Close Action Code")
                {
                    ToolTip = 'Specifies the value of the SRM Close Action Code field.';
                }
                field("SRM Default Vendor"; Rec."SRM Default Vendor")
                {
                    ToolTip = 'Specifies the value of the SRM Default Vendor field.';
                }
                field("SRM G/L Account Position"; Rec."SRM G/L Account Position")
                {
                    ToolTip = 'Specifies the value of the SRM G/L Account Position field.';
                }
                field("SRM G/L Account Position Val."; Rec."SRM G/L Account Position Val.")
                {
                    ToolTip = 'Specifies the value of the SRM G/L Account Position Val. field.';
                }
                field("RD Movement Type"; Rec."RD Movement Type")
                {
                    ToolTip = 'Specifies the value of the Return Delivery Movement Type field.';
                }
                field("RD Cancellation Movement Type"; Rec."RD Cancellation Movement Type")
                {
                    ToolTip = 'Specifies the value of the Return Delivery Cancellation Movement Type field.';
                }
                field("Default Unit of Measure"; Rec."Default Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Default Unit of Measure field.';

                    // trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        UnitofMeasure: Record "Unit of Measure";
                    begin
                        //UnitofMeasure.GET;
                        //HEI.03
                        if PAGE.RUNMODAL(PAGE::"Units of Measure", UnitofMeasure) = ACTION::LookupOK then
                            Rec."Default Unit of Measure" := UnitofMeasure."International Standard Code";
                        //HEI.03
                    end;
                }
            }
        }
    }

    actions
    {
    }
}

