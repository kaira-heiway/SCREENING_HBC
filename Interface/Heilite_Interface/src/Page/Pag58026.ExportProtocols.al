page 58026 "Export Protocols"
{
    // Heilite Navision Old Id - 50321

    // version NAVBE10.00

    // HEI.01 V1.05 HT84 IBM POENAB02 10.04.2019 # New page for Bank Connectivity interface

    CaptionML = ENU = 'Export Protocols',
                FRB = 'Protocoles d''exportation',
                NLB = 'Export protocollen';
    PageType = List;
    SourceTable = "Export Protocol FND";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<


    layout
    {
        area(content)
        {
            repeater(Control1010000)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies a code that identifies the export protocol.',
                                FRB = 'Spécifie un code qui identifie le protocole d''exportation.',
                                NLB = 'Hiermee wordt een code aangegeven die het exportprotocol identificeert.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                    ToolTipML = ENU = 'Specifies a description for the export protocol entry.',
                                FRB = 'Spécifie une description pour l''écriture protocole d''exportation.',
                                NLB = 'Hiermee wordt een beschrijving aangegeven voor de exportprotocolpost.';
                }
                field("Code Expenses"; Rec."Code Expenses")
                {
                    ApplicationArea = All;

                    ToolTipML = ENU = 'Specifies the code that describes the type of expenses associated with the export protocol entry.',
                                FRB = 'Spécifie le code qui décrit le type de dépenses associées à l''écriture protocole d''exportation.',
                                NLB = 'Hiermee wordt de code aangegeven die het type kosten beschrijft die zijn gekoppeld aan de exportprotocolpost.';
                }
                field("Check Object ID"; Rec."Check Object ID")
                {
                    ApplicationArea = All;

                    Lookup = true;
                    LookupPageID = Objects;
                    ToolTipML = ENU = 'Specifies the identification number of the verification process, which checks on the object before the payment file is exported.',
                                FRB = 'Spécifie le numéro d''identification du processus de vérification qui vérifie l''objet avant l''exportation du fichier de paiement.',
                                NLB = 'Hiermee wordt het identificatienummer aangegeven van het controleproces, dat het object nagaat voordat het betalingsbestand wordt geëxporteerd.';
                }
                field("Check Object Name"; Rec."Check Object Name")
                {
                    ApplicationArea = All;

                    ToolTipML = ENU = 'Specifies the name of a verification process used to check on the object before the payment file is exported.',
                                FRB = 'Spécifie le nom d''un processus de vérification utilisé pour vérifier l''objet avant l''exportation du fichier de paiement.',
                                NLB = 'Hiermee wordt de naam aangegeven van het controleproces dat het object nagaat voordat het betalingsbestand wordt geëxporteerd.';
                }
                field("Export Object Type"; Rec."Export Object Type")
                {
                    ApplicationArea = All;

                    ToolTipML = ENU = 'Specifies the type of the object that defines the format of the payment file export.',
                                FRB = 'Spécifie le type de l''objet qui définit le format de l''exportation du fichier de paiement.',
                                NLB = 'Hiermee wordt het type object aangegeven dat het formaat van de betalingsbestandexport definieert.';
                }
                field("Export Object ID"; Rec."Export Object ID")
                {
                    ApplicationArea = All;

                    Lookup = true;
                    LookupPageID = Objects;
                    ToolTipML = ENU = 'Specifies the identification number of the object, which defines the report format of the payment file export.',
                                FRB = 'Spécifie le numéro d''identification de l''objet qui définit le format d''état de l''exportation du fichier de paiement.',
                                NLB = 'Hiermee wordt het identificatienummer aangegeven van het object dat het rapportformaat van de betalingsbestandexport definieert.';
                }
                field("Export No. Series"; Rec."Export No. Series")
                {
                    ApplicationArea = All;

                    ToolTipML = ENU = 'Specifies the number series used to assign identification numbers to the payment file export.',
                                FRB = 'Spécifie la souche de numéros qui est utilisée pour affecter des numéros d''identification à l''exportation du fichier de paiement.',
                                NLB = 'Hiermee wordt de nummerreeks aangegeven die wordt gebruikt om identificatienummers aan de betalingsbestandexport toe te wijzen.';
                }
            }
        }
    }

    actions
    {
    }
}

