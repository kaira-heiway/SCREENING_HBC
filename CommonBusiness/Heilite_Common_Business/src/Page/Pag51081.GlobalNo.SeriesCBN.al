page 51081 "Global No. Series CBN"
{
    // version HEI.01

    // HEI.01 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # Page created
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # Page created

    CaptionML = ENU = 'Global No. Series',
                FRA = 'Souches de n°';
    PageType = List;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Navigate',
                                 FRA = 'Nouveau,Traitement,État,Naviguer';
    RefreshOnActivate = true;
    SourceTable = "Global No. Series FND";
    ApplicationArea = All;  //BC Upgrade KAPOOV01
    UsageCategory = Lists;  //BC Upgrade KAPOOV01

    layout
    {
        area(content)
        {
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors >>
            //repeater() //BC Upgrade KAPOOV01 Commented
            repeater(Group)
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors >>
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a number series code.',
                                FRA = 'Spécifie un code souche de numéros.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a description of the number series.',
                                FRA = 'Spécifie la description de la souche de numéros.';
                }
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Starting Date',
                                FRA = 'Date début';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the date from which this line applies.',
                                FRA = 'Spécifie la date à partir de laquelle cette ligne est valable.';
                    Visible = false;

                    trigger OnDrillDown();
                    begin
                        DrillDownActionOnPage;
                    end;
                }
                field(StartNo; StartNo)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Starting No.',
                                FRA = 'N° début';
                    DrillDown = true;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the first number in the series.',
                                FRA = 'Spécifie le premier numéro de la souche de numéros.';

                    trigger OnDrillDown();
                    begin
                        DrillDownActionOnPage;
                    end;
                }
                field(EndNo; EndNo)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Ending No.',
                                FRA = 'N° fin';
                    DrillDown = true;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the last number in the series.',
                                FRA = 'Spécifie le dernier numéro de la souche de numéros.';

                    trigger OnDrillDown();
                    begin
                        DrillDownActionOnPage;
                    end;
                }
                field(LastDateUsed; LastDateUsed)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Last Date Used',
                                FRA = 'Dernière date utilisée';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the date when a number was most recently assigned from the number series.',
                                FRA = 'Spécifie la dernière date à laquelle un numéro de cette souche de numéros a été affecté.';

                    trigger OnDrillDown();
                    begin
                        DrillDownActionOnPage;
                    end;
                }
                field(LastNoUsed; LastNoUsed)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Last No. Used',
                                FRA = 'Dernier n° utilisé';
                    DrillDown = true;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the last number that was used from the number series.',
                                FRA = 'Spécifie le dernier numéro de la souche de numéros à avoir été utilisé.';

                    trigger OnDrillDown();
                    begin
                        DrillDownActionOnPage;
                    end;
                }
                field(WarningNo; WarningNo)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Warning No.',
                                FRA = 'N° alerte';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the language name of the chart memo.',
                                FRA = 'Spécifie le nom de la langue du mémo graphique.';
                    Visible = false;

                    trigger OnDrillDown();
                    begin
                        DrillDownActionOnPage;
                    end;
                }
                field(IncrementByNo; IncrementByNo)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Increment-by No.',
                                FRA = 'Espace entre n°';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies a number that represents the size of the interval by which the numbers in the series are spaced.',
                                FRA = 'Spécifie un numéro qui représente la taille de l''intervalle entre deux numéros de souche.';
                    Visible = false;

                    trigger OnDrillDown();
                    begin
                        DrillDownActionOnPage;
                    end;
                }
                field("Default Nos."; Rec."Default Nos.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies whether this number series will be used to assign numbers automatically.',
                                FRA = 'Spécifie si la souche de numéros doit être utilisée pour affecter automatiquement des numéros.';
                }
                field("Manual Nos."; Rec."Manual Nos.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies that you can enter numbers manually instead of using this number series.',
                                FRA = 'Spécifie que vous pouvez saisir les numéros manuellement au lieu d''utiliser cette souche de numéros.';
                }
                field("Date Order"; Rec."Date Order")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies to check that numbers are assigned chronologically.',
                                FRA = 'Spécifie de vérifier que les numéros sont affectés dans l''ordre chronologique.';
                }
            }
        }
        area(factboxes)
        {
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors >>
            //systempart(; Links) //BC Upgrade KAPOOV01 Commented
            systempart(Notes; Notes)
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors <<
            {
                ApplicationArea = All;
                Visible = false;
            }
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors >>
            //systempart(; Notes) //BC Upgrade KAPOOV01 Commented
            systempart(Notes1; Notes)
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors <<
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Series")
            {
                CaptionML = ENU = '&Series',
                            FRA = '&Souches';
                Image = SerialNo;
                action(Lines)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Lines',
                                FRA = 'Lignes';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Global No. Series Lines";
                    RunPageLink = "Series Code" = FIELD(Code);
                    ToolTipML = ENU = 'View or edit additional information about the number series lines.',
                                FRA = 'Affichez ou modifiez des informations supplémentaires sur les lignes souches de numéros.';
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        UpdateLineActionOnPage;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        UpdateLineActionOnPage;
    end;

    var
        StartDate: Date;
        StartNo: Code[20];
        EndNo: Code[20];
        LastNoUsed: Code[20];
        WarningNo: Code[20];
        IncrementByNo: Integer;
        LastDateUsed: Date;

    local procedure DrillDownActionOnPage();
    begin
        Rec.DrillDown;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure UpdateLineActionOnPage();
    begin
        Rec.UpdateLine(StartDate, StartNo, EndNo, LastNoUsed, WarningNo, IncrementByNo, LastDateUsed);
    end;
}

