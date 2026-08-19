pageextension 51119 JobJournalExtCBN extends "Job Journal"
{
    //BC Upgrade KAPOOV01 05.11.2025 # field-Description made non-editable in NAV version it was made non-editable on table level under HEI.01
    //BC Upgrade KAPOOV01 05.11.2025 # Changed values for properties-ShowCaption,Promoted,PromotedIsBig to (TRUE/FALSE), in NAV version values were (Yes/No).
    // version NAVW110.0

    layout
    {
        modify(CurrentJnlBatchName)
        {

            //Unsupported feature: Change Lookup on "CurrentJnlBatchName(Control 78)". Please convert manually.

            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the name of the journal batch.', FRA = 'Spécifie le nom de la comptabilité.';
        }
        modify("Line Type")
        {
            ToolTipML = ENU = 'Specifies the line type of a job planning line in the context of posting of a job ledger entry. The options are described in the following table.', FRA = 'Spécifie le type de ligne d''une ligne planning projet dans le contexte d''une validation d''une écriture comptable. Les options sont décrites dans le tableau suivant.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date you want to assign to each journal line. For more information, see Entering Dates and Times.', FRA = 'Spécifie la date comptabilisation que vous voulez affecter à chaque ligne feuille. Pour plus d''informations, reportez-vous à Entrée des dates et des heures.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provided the basis for this entry.', FRA = 'Spécifie la date du document qui a servi à générer cette écriture.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number that refers to the numbering system of either a customer or vendor associated with the items on this journal line.', FRA = 'Spécifie le numéro de document qui se réfère à la numérotation utilisée par le client ou le fournisseur associé aux articles de cette ligne feuille.';
        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the related job.', FRA = 'Spécifie le projet concerné.';
        }
        modify("Job Task No.")
        {
            ToolTipML = ENU = 'Specifies the related job task number.', FRA = 'Spécifie le numéro de tâche projet concernée.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies an account type for job usage to be posted in the job journal. You can choose from the following options:', FRA = 'Spécifie un type de compte pour l''utilisation de la tâche à valider dans la feuille. Vous avez le choix entre les options suivantes :';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the resource, item, or general ledger account number that this entry applies to. The No. must correspond to your selection in the Type field. Choose the field to see the available accounts.', FRA = 'Spécifie la ressource, l''article ou le numéro de compte général lié à cette écriture. Le numéro doit correspondre à votre sélection dans le champ Type. Pour afficher les comptes disponibles, choisissez le champ.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the name of the resource, item, or general ledger account to which this entry applies. You can change the description.', FRA = 'Spécifie le nom de la ressource, de l''article ou du compte général auquel l''écriture s''applique. Vous pouvez modifier la description.';
            Editable = false;//BC Upgrade KAPOOV01 field made non-editable on table level under HEI.01
        }
        modify("Job Planning Line No.")
        {
            ToolTipML = ENU = 'Specifies the job planning line number to which the usage should be linked when the Job Journal is posted. You can only link to Job Planning Lines that have the Apply Usage Link option enabled.', FRA = 'Spécifie le numéro de la ligne planning projet à laquelle l''utilisation doit être liée lorsque la feuille est validée. Vous pouvez seulement établir une liaison vers des lignes planning projet dont l''option Appliquer le lien d''utilisation est activée.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies an item variant code if the Type field is Item.', FRA = 'Spécifie un code variante article si le champ Type est Article.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }

        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.

        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies a location code for an item.', FRA = 'Spécifie un code magasin pour un article.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies a bin code if you have entered a code in the Location Code field.', FRA = 'Spécifie un code emplacement si vous avez entré un code dans le champ Code magasin.';
        }
        modify("Work Type Code")
        {
            ToolTipML = ENU = 'Specifies which work type the resource applies to. Prices are updated based on this entry.', FRA = 'Spécifie le type travail auquel la ressource s''applique. Les prix sont mis à jour en se basant sur cette valeur.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the job''s currency code that listed in the Currency Code field in the Job Card. You can only create a Job Journal using this currency code.', FRA = 'Spécifie le code devise du projet répertorié dans le champ Code devise de la fiche projet. Vous pouvez uniquement créer une feuille projet à l''aide de ce code devise.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code used to determine the unit price. The code specifies how the quantity is measured. The application retrieves this code from the corresponding item or resource card. To see the units of measure that are available, choose the field.', FRA = 'Spécifie le code unité utilisé pour déterminer le prix unitaire. Le code spécifie la manière dont la quantité est mesurée. L''application copie ce code depuis la fiche article ou ressource correspondante. Pour afficher les unités disponibles, choisissez le champ.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the job journal''s No. field, that is, either the resource, item, or G/L account number, that applies. If you later change the value in the No. field, the quantity does not change on the journal line.', FRA = 'Spécifie le nombre d''unités du champ N° de la feuille projet (numéro de ressource, d''article ou de compte général) qui s''applique. Si vous modifiez la valeur du champ N° ultérieurement, la quantité ne change pas dans la ligne feuille.';
        }
        modify("Remaining Qty.")
        {
            ToolTipML = ENU = 'Specifies the quantity of the resource or item that remains to complete a job. The remaining quantity is calculated as the difference between Quantity and Qty. Posted. You can modify this field to indicate the quantity you want to remain on the job planning line after you post usage.', FRA = 'Spécifie la quantité de la ressource ou de l''article restant pour terminer une tâche. La quantité restante est la différence entre Quantité et Qté validée. Vous pouvez modifier ce champ pour indiquer la quantité restante souhaitée sur la ligne planning projet après validation de l''utilisation.';
        }
        modify("Direct Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the direct unit cost of one unit of the selected Type and No. The amount is in the local currency.', FRA = 'Définit le coût unitaire direct d''une unité du Type et du Nº sélectionnés. Le montant est exprimé en devise société.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost for the selected Type and No. on the journal line. The unit cost is in the job currency, derived from the Currency Code field on the Job Card.', FRA = 'Spécifie le coût unitaire du Type et du N° sélectionnés dans la ligne feuille. Le coût unitaire est exprimé dans la devise projet, issue du champ Code devise de la fiche projet.';
        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit cost for the selected Type and No. on the journal line. The unit cost is in the local currency.', FRA = 'Spécifie le coût unitaire du Type et du N° sélectionnés dans la ligne feuille. Le coût unitaire est exprimé dans la devise société.';
        }
        modify("Total Cost")
        {
            ToolTipML = ENU = 'Specifies the total cost for the journal line. The total cost is calculated based on the job currency, which comes from the Currency Code field on the Job card.', FRA = 'Spécifie le coût total de la ligne feuille. Le coût total est calculé sur la base de la devise projet, issue du champ Code devise de la fiche projet.';
        }
        modify("Total Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the total cost for this journal line. The amount is in the local currency.', FRA = 'Spécifie le coût total de cette ligne feuille. Le montant est exprimé en devise société.';
        }
        modify("Unit Price")
        {
            ToolTipML = ENU = 'Specifies the unit price for the selected Type and No. on the journal line. The unit price is in the job currency, which comes from the Currency Code field on the Job Card.', FRA = 'Spécifie le prix unitaire du Type et du N° sélectionnés dans la ligne feuille. Le prix unitaire est exprimé dans la devise projet, issue du champ Code devise de la fiche projet.';
        }
        modify("Unit Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit price of the selected Type and No. The amount is in the local currency.', FRA = 'Définit le prix unitaire du Type et du Nº sélectionnés. Le montant est exprimé en devise société.';
        }
        modify("Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.', FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';
        }
        modify("Line Amount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the net amount in (LCY) (before subtracting the invoice discount amount) that must be paid for the items on the line.', FRA = 'Spécifie le montant net en DS (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';
        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the discount that applies to the journal line.', FRA = 'Spécifie le montant de la remise qui s''applique à la ligne feuille.';
        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount percentage.', FRA = 'Spécifie le pourcentage remise ligne.';
        }
        modify("Total Price")
        {
            ToolTipML = ENU = 'Specifies the total price in the job currency on the journal line.', FRA = 'Spécifie le prix total dans la devise du projet sur la ligne feuille.';
        }
        modify("Total Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the total price for the journal line. The amount is in the local currency.', FRA = 'Spécifie le prix total de la ligne feuille. Le montant est exprimé en devise société.';
        }
        modify("Applies-to Entry")
        {
            ToolTipML = ENU = 'Specifies if the job journal line has of type Item and the usage of the item will be applied to an already-posted item ledger entry. If this is the case, enter the entry number that the usage will be applied to.', FRA = 'Spécifie si la ligne feuille projet est de type Article et si l''activité de l''article sera lettrée avec une écriture comptable article déjà validée. Si c''est le cas, entrez le numéro de l''écriture avec laquelle l''activité sera lettrée.';
        }
        modify("Applies-from Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry that the journal line costs have been applied from. This should be done when you reverse the usage of an item in a job and you want to return the item to inventory at the same cost as before it was used in the job.', FRA = 'Spécifie le numéro de l''écriture comptable article à partir duquel les coûts ligne feuille ont été appliqués. Cette action doit être menée lors de la contrepassation de l''activité d''un article dans un projet pour que l''article retourne dans le stock au même coût qu''avant son utilisation dans le projet.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code that applies to the journal line.', FRA = 'Spécifie le code pays/région qui s''applique à la ligne feuille.';
        }
        modify("Transaction Type")
        {
            ToolTipML = ENU = 'Specifies the general product posting group. The field is filled automatically when you retrieve a resource, an item, or a G/L account in the current line.', FRA = 'Spécifie le groupe comptabilisation produit. Ce champ est automatiquement renseigné lorsque vous insérez une ressource, un article ou un compte général sur la ligne active.';
        }
        modify("Transport Method")
        {
            ToolTipML = ENU = 'Specifies the code for the transport method.', FRA = 'Spécifie le code du mode de transport.';
        }
        modify("Time Sheet No.")
        {
            ToolTipML = ENU = 'Specifies the number of a time sheet. A number is assigned to each time sheet when it is created. You cannot edit the number.', FRA = 'Spécifie le numéro d''une feuille de temps. Un numéro est attribué à chaque feuille de temps lors de sa création. Vous ne pouvez pas modifier le numéro.';
        }
        modify("Time Sheet Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number for a time sheet.', FRA = 'Spécifie le numéro de ligne d''une feuille de temps.';
        }
        modify("Time Sheet Date")
        {
            ToolTipML = ENU = 'Specifies the date that a time sheet is created.', FRA = 'Spécifie la date de création d''une feuille de temps.';
        }
        modify("Job Description")
        {
            CaptionML = ENU = 'Job Description', FRA = 'Description projet';
        }
        modify(JobDescription)
        {
            //ShowCaption = No;//BC Upgrade KAPOOV01
            ShowCaption = false;//BC Upgrade KAPOOV01
        }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
        }
        modify(AccName)
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
            ToolTipML = ENU = 'Specifies the name of the customer or vendor that the job is related to.', FRA = 'Spécifie le nom du client ou du fournisseur avec lequel le projet est associé.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: CodeModification on "CurrentJnlBatchName(Control 78).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        JobJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        JobJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on "CurrentJnlBatchName(Control 78)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "CurrentJnlBatchName(Control 78)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Type"(Control 88)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Type"(Control 88)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 62)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 62)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job Task No."(Control 86)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job Task No."(Control 86)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job Planning Line No."(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job Planning Line No."(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Bus. Posting Group"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Bus. Posting Group"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Prod. Posting Group"(Control 54)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Prod. Posting Group"(Control 54)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 82)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 82)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 58)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 58)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 60)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 60)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bin Code"(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bin Code"(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Work Type Code"(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Work Type Code"(Control 48)". Please convert manually.



        //Unsupported feature: CodeModification on ""Currency Code"(Control 100).OnAssistEdit". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
        if ChangeExchangeRate.RUNMODAL = ACTION::OK then
          VALIDATE("Currency Factor",ChangeExchangeRate.GetParameter);

        CLEAR(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
        #3..5
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 100)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 100)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Remaining Qty."(Control 99)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Remaining Qty."(Control 99)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Direct Unit Cost (LCY)"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Direct Unit Cost (LCY)"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Cost"(Control 81)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Cost"(Control 81)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Cost (LCY)"(Control 96)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Cost (LCY)"(Control 96)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Total Cost"(Control 85)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Total Cost"(Control 85)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Total Cost (LCY)"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Total Cost (LCY)"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Price"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Price"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Price (LCY)"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Price (LCY)"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Amount"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Amount"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Amount (LCY)"(Control 95)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Amount (LCY)"(Control 95)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Discount Amount"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Discount Amount"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Discount %"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Discount %"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Total Price"(Control 64)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Total Price"(Control 64)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Total Price (LCY)"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Total Price (LCY)"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Entry"(Control 66)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Entry"(Control 66)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-from Entry"(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-from Entry"(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Country/Region Code"(Control 68)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Country/Region Code"(Control 68)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Type"(Control 39)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Type"(Control 39)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 47)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 47)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Time Sheet No."(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Time Sheet No."(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Time Sheet Line No."(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Time Sheet Line No."(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Time Sheet Date"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Time Sheet Date"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control73(Control 73)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1902114901(Control 1902114901)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job Description"(Control 1903098501)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "JobDescription(Control 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "JobDescription(Control 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Account Name"(Control 1901991301)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "AccName(Control 76)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "AccName(Control 76)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 91)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
            //Promoted = Yes;//BC Upgrade KAPOOV01
            Promoted = true;//BC Upgrade KAPOOV01
        }
        modify(ItemTrackingLines)
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
        modify("&Job")
        {
            CaptionML = ENU = '&Job', FRA = 'Proje&t';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View or change detailed information about the record that is being processed on the journal line.', FRA = 'Affichez ou modifiez les informations détaillées sur l''enregistrement qui sont traitées sur la ligne feuille.';

            //Unsupported feature: Change RunObject on "Card(Action 37)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Card(Action 37)". Please convert manually.

        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';

            //Unsupported feature: Change RunObject on ""Ledger E&ntries"(Action 38)". Please convert manually.


            //Unsupported feature: Change RunPageView on ""Ledger E&ntries"(Action 38)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Ledger E&ntries"(Action 38)". Please convert manually.

        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(CalcRemainingUsage)
        {

            //Unsupported feature: Change Ellipsis on "CalcRemainingUsage(Action 93)". Please convert manually.

            CaptionML = ENU = 'Calc. Remaining Usage', FRA = 'Calc. activité restante';
            ToolTipML = ENU = 'Calculate the remaining usage for the job. The batch job calculates, for each job task, the difference between scheduled usage of items, resources, and expenses and actual usage posted in job ledger entries. The remaining usage is then displayed in the job journal from where you can post it.', FRA = 'Calculez l''activité restante pour le projet. Le traitement par lots calcule, pour chaque tâche projet, la différence entre l''activité planifiée des éléments, des ressources et des dépenses générales et l''activité réelle validée dans les écritures comptables projet. L''activité restante est ensuite affichée dans la feuille projet à partir de laquelle vous pouvez la valider.';
            //Promoted = Yes;//BC Upgrade KAPOOV01
            Promoted = true;//BC Upgrade KAPOOV01
        }
        modify(SuggestLinesFromTimeSheets)
        {

            //Unsupported feature: Change Ellipsis on "SuggestLinesFromTimeSheets(Action 11)". Please convert manually.

            CaptionML = ENU = 'Suggest Lines from Time Sheets', FRA = 'Proposer des lignes à partir des feuilles de temps';
            ToolTipML = ENU = 'Fill the journal with lines that exist in the time sheets.', FRA = 'Renseignez la feuille avec les lignes existantes dans les feuilles de temps.';
            //Promoted = Yes;//BC Upgrade KAPOOV01
            Promoted = true;//BC Upgrade KAPOOV01
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify(Reconcile)
        {
            CaptionML = ENU = 'Reconcile', FRA = 'Simuler';
            ToolTipML = ENU = 'View what has been reconciled for the job. The window shows the quantity entered on the job journal lines, totaled by unit of measure and by work type.', FRA = 'Affichez les éléments qui ont fait l''objet du rapprochement pour le projet. La fenêtre affiche la quantité entrée sur les lignes feuille, totalisée par unité de mesure et type de travail.';
        }
        modify("Test Report")
        {

            //Unsupported feature: Change Ellipsis on ""Test Report"(Action 41)". Please convert manually.

            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            //Promoted = Yes;//BC Upgrade KAPOOV01
            Promoted = true;//BC Upgrade KAPOOV01
            //PromotedIsBig = Yes;//BC Upgrade KAPOOV01
            PromotedIsBig = true;//BC Upgrade KAPOOV01
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
            //Promoted = Yes;//BC Upgrade KAPOOV01
            Promoted = true;//BC Upgrade KAPOOV01
            //PromotedIsBig = Yes;//BC Upgrade KAPOOV01
            PromotedIsBig = true;//BC Upgrade KAPOOV01
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Line"(Action 90)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 91)". Please convert manually.



        //Unsupported feature: CodeModification on "ItemTrackingLines(Action 92).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OpenItemTrackingLines(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        OpenItemTrackingLines(FALSE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""&Job"(Action 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Card(Action 37)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ledger E&ntries"(Action 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""F&unctions"(Action 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""P&osting"(Action 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Reconcile(Action 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Test Report"(Action 41)". Please convert manually.



        //Unsupported feature: CodeModification on ""P&ost"(Action 56).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Job Jnl.-Post",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Job Jnl.-Post",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""P&ost"(Action 56)". Please convert manually.



        //Unsupported feature: CodeModification on ""Post and &Print"(Action 57).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Job Jnl.-Post+Print",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Job Jnl.-Post+Print",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Post and &Print"(Action 57)". Please convert manually.

    }


    //Unsupported feature: PropertyModification on "CalcRemainingUsage(Action 93).OnAction.JobCalcRemainingUsage(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CalcRemainingUsage : "Job Calc. Remaining Usage";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalcRemainingUsage : 1090;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SuggestLinesFromTimeSheets(Action 11).OnAction.SuggestJobJnlLines(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SuggestLinesFromTimeSheets : "Suggest Job Jnl. Lines";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SuggestLinesFromTimeSheets : 952;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on ""Currency Code"(Control 100).OnAssistEdit.ChangeExchangeRate(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"Currency Code" : "Change Exchange Rate";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Currency Code" : 511;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnDeleteRecord.ReserveJobJnlLine(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnDeleteRecord.ReserveJobJnlLine : "Job Jnl. Line-Reserve";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnDeleteRecord.ReserveJobJnlLine : 99000844;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "JobJnlManagement(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //JobJnlManagement : JobJnlManagement;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //JobJnlManagement : 1020;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ReportPrint(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReportPrint : "Test Report-Print";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReportPrint : 228;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "JobJnlReconcile(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //JobJnlReconcile : "Job Journal Reconcile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //JobJnlReconcile : 376;
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    COMMIT;
    if not ReserveJobJnlLine.DeleteLineConfirm(Rec) then
      exit(false);
    ReserveJobJnlLine.DeleteLine(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    COMMIT;
    IF NOT ReserveJobJnlLine.DeleteLineConfirm(Rec) THEN
      EXIT(FALSE);
    ReserveJobJnlLine.DeleteLine(Rec);
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsOpenedFromBatch then begin
      CurrentJnlBatchName := "Journal Batch Name";
      JobJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
      exit;
    end;
    JobJnlManagement.TemplateSelection(PAGE::"Job Journal",false,Rec,JnlSelected);
    if not JnlSelected then
      ERROR('');
    JobJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF IsOpenedFromBatch THEN BEGIN
      CurrentJnlBatchName := "Journal Batch Name";
      JobJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
      EXIT;
    end;
    JobJnlManagement.TemplateSelection(PAGE::"Job Journal",FALSE,Rec,JnlSelected);
    IF NOT JnlSelected THEN
      ERROR('');
    JobJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
    */
    //end;


    //Unsupported feature: CodeModification on "CurrentJnlBatchNameOnAfterVali(PROCEDURE 19002411)". Please convert manually.

    //procedure CurrentJnlBatchNameOnAfterVali();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    JobJnlManagement.SetName(CurrentJnlBatchName,Rec);
    CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    JobJnlManagement.SetName(CurrentJnlBatchName,Rec);
    CurrPage.UPDATE(FALSE);
    */
    //end;

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

