pageextension 51089 AccountScheduleExtCBN extends "Account Schedule"
{
    //     HEI.01 CHG2200302 IBM POENAB02 31.05.2023 P&L by Nature in Heilite Base
    //   # New field added - 50001 CIL account
    //   # Code added in OnOpenPage
    // HEI.02 CHG2215009 IBM POENAB02 04.10.2023 HB3349 Enhancement of HB3349 To add column for L3 in main view
    //   # New field added - 50002 L3 Account

    // POENAB02 25.02.2026 gap/fit fixes for P&L by Nature

    layout
    {
        modify(CurrentSchedName)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the account schedule.', FRA = 'Spécifie le nom du tableau d''analyse.';
        }
        modify("Row No.")
        {
            ToolTipML = ENU = 'Specifies a number for the account schedule line.', FRA = 'Spécifie un numéro pour la ligne tableau d''analyse.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies text that will appear on the account schedule line.', FRA = 'Spécifie le texte qui figure sur la ligne du tableau d''analyse.';
        }
        modify("Totaling Type")
        {
            ToolTipML = ENU = 'Specifies the totaling type for the account schedule line. The type determines which accounts within the totaling interval you specify in the Totaling field will be totaled.', FRA = 'Spécifie le type de totalisation de la ligne du tableau d''analyse. Ce type détermine les comptes de l''intervalle de totalisation spécifié dans le champ Totalisation qui sont totalisés.';
        }
        modify(Totaling)
        {
            ToolTipML = ENU = 'Specifies which accounts will be totaled on this line.', FRA = 'Spécifie les comptes totalisés sur cette ligne.';
        }
        modify("Row Type")
        {
            ToolTipML = ENU = 'Specifies the row type for the account schedule row. The type determines how the amounts in the row are calculated.', FRA = 'Spécifie le type de la ligne du tableau d''analyse. Le type détermine la méthode de calcul des montants des lignes.';
        }
        modify("Amount Type")
        {
            ToolTipML = ENU = 'Specifies the type of entries that will be included in the amounts in the account schedule row.', FRA = 'Spécifie le type des écritures à inclure dans les montants de la ligne du tableau d''analyse.';
        }
        modify("Show Opposite Sign")
        {
            ToolTipML = ENU = 'Specifies whether to show debits in reports as negative amounts with a minus sign and credits as positive amounts.', FRA = 'Spécifie si les débits doivent être affichés comme des montants négatifs avec un signe moins et les crédits comme des montants positifs.';
        }
        modify("Dimension 1 Totaling")
        {
            ToolTipML = ENU = 'Specifies which dimension value amounts will be totaled on this line.', FRA = 'Spécifie les montants de section analytique totalisés sur la ligne.';
        }
        modify("Dimension 2 Totaling")
        {
            ToolTipML = ENU = 'Specifies which dimension value amounts will be totaled on this line.', FRA = 'Spécifie les montants de section analytique totalisés sur la ligne.';
        }
        modify("Dimension 3 Totaling")
        {
            ToolTipML = ENU = 'Specifies which dimension value amounts will be totaled on this line.', FRA = 'Spécifie les montants de section analytique totalisés sur la ligne.';
        }
        modify("Dimension 4 Totaling")
        {
            ToolTipML = ENU = 'Specifies which dimension value amounts will be totaled on this line.', FRA = 'Spécifie les montants de section analytique totalisés sur la ligne.';
        }
        modify(Show)
        {
            ToolTipML = ENU = 'Specifies whether the account schedule line will be printed on the report.', FRA = 'Spécifie si la ligne de tableau d''analyse est imprimée dans l''état.';
        }
        modify(Bold)
        {
            ToolTipML = ENU = 'Specifies whether to print the amounts in this row in bold.', FRA = 'Spécifie s''il faut imprimer les montants de cette ligne en gras.';
        }
        modify(Italic)
        {
            ToolTipML = ENU = 'Specifies whether to print the amounts in this row in italics.', FRA = 'Spécifie s''il faut imprimer les montants de cette ligne en italique.';
        }
        modify(Underline)
        {
            ToolTipML = ENU = 'Specifies whether to underline the amounts in this row.', FRA = 'Spécifie s''il faut souligner les montants de cette ligne.';
        }
        modify("Double Underline")
        {
            ToolTipML = ENU = 'Specifies whether to double underline the amounts in this row.', FRA = 'Spécifie s''il faut souligner deux fois les montants de cette ligne.';
        }
        modify("New Page")
        {
            ToolTipML = ENU = 'Specifies whether there will be a page break after the current account when the account schedule is printed.', FRA = 'Spécifie si, lorsque le tableau d''analyse est imprimé, il doit y avoir un saut de page après le compte en cours.';
        }
        // addafter("Row No.")
        addbefore(Description)
        {
            field("CIL account"; Rec."CIL account FND")
            {
                Visible = ShowCILAcc;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIL account field.';
            }
            field("L3 Account"; Rec."L3 Account FND")
            {
                Visible = ShowCILAcc;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the L3 Account field.';
            }
        }
    }
    actions
    {
        //BC Upgrade Kamnay01>> The action 'Overview' is not found in the target 'Account Schedule'
        // modify(Overview)
        // {
        //     CaptionML = ENU = 'Overview', FRA = 'Aperçu';
        //     ToolTipML = ENU = 'View an overview of the current account schedule.', FRA = 'Affichez une présentation du tableau du compte en cours.';
        // }
        //BC Upgrade Kamnay01<< The action 'Overview' is not found in the target 'Account Schedule'
        modify(Indent)
        {
            CaptionML = ENU = 'Indent', FRA = 'Indenter';
            ToolTipML = ENU = 'Make this row part of a group of rows. For example, indent rows that itemize a range of accounts, such as types of revenue.', FRA = 'Insérez cette ligne dans un groupe de lignes. Par exemple, indentez des lignes qui donnent le détail d''un ensemble de comptes, tels que des types de revenus.';
        }
        modify(Outdent)
        {
            CaptionML = ENU = 'Outdent', FRA = 'Retrait négatif';
            ToolTipML = ENU = 'Move this row out one level.', FRA = 'Déplacez cette ligne d''un niveau.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(InsertGLAccounts)
        {
            CaptionML = ENU = 'Insert G/L Accounts', FRA = 'Insérer des comptes généraux';
            ToolTipML = ENU = 'Open the list of general ledger accounts so you can add accounts to the account schedule.', FRA = 'Ouvrez la liste des comptes généraux afin que vous puissiez ajouter des comptes au tableau d''analyse.';
        }
        modify(InsertCFAccounts)
        {
            CaptionML = ENU = 'Insert CF Accounts', FRA = 'Insérer des comptes de trésorerie';
        }
        modify(InsertCostTypes)
        {
            CaptionML = ENU = 'Insert Cost Types', FRA = 'Insérer des types de coûts';
        }
        //BC Upgrade Kamnay01>> The action 'EditColumnLayoutSetup','Reports','Print' is not found in the target 'Account Schedule'
        // modify(EditColumnLayoutSetup)
        // {
        //     CaptionML = ENU = 'Edit Column Layout Setup', FRA = 'Modifier paramètres présentation colonne';
        //     ToolTipML = ENU = 'Create or change the column layout for the current account schedule name.', FRA = 'Créez ou modifiez la présentation de colonne pour le nom du tableau d''analyse en cours.';
        // }
        // modify(Reports)
        // {
        //     CaptionML = ENU = 'Reports', FRA = 'États';
        // }
        // modify(Print)
        // {
        //     CaptionML = ENU = '&Print', FRA = '&Imprimer';
        //     ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        // }
        //BC Upgrade Kamnay01<< The action 'EditColumnLayoutSetup','Reports','Print' is not found in the target 'Account Schedule'
    }
    //BC Upgrade Kamnay01>> 
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.01>>
        GLSetup.GET();
        ShowCILAcc := FALSE;
        if GLSetup."P&L by Nature code FND" <> '' then //BC Upgrade POENAB02, 25.02.2026
            IF GLSetup."P&L by Nature code FND" = rec."Schedule Name" THEN
                ShowCILAcc := true;
        //HEI.01<<
    end;
    //BC Upgrade Kamnay01<<
    // BC Upgrade SHUKLP03 >>
    trigger OnAfterGetRecord()
    begin
        //HEI.01>>
        GLSetup.GET();
        ShowCILAcc := FALSE;
        IF GLSetup."P&L by Nature code FND" = rec."Schedule Name" THEN
            ShowCILAcc := true;
        //HEI.01<<

    end;
    // BC Upgrade SHUKLP03 <<


    var
        GLSetup: Record "General Ledger Setup";
        ShowCILAcc: Boolean;
        CurrentSchedName: Code[10]; //BC Upgrade Kamnay01 


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AccSchedManagement.OpenAndCheckSchedule(CurrentSchedName,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    AccSchedManagement.OpenAndCheckSchedule(CurrentSchedName,Rec);

    //HEI.01>>
    GLSetup.GET;
    ShowCILAcc := false;
    if GLSetup."P&L by Nature code" = CurrentSchedName then
      ShowCILAcc := true;
    //HEI.01<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

