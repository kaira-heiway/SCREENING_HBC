pageextension 51176 ItemChargeAssignPurchExtCBN extends "Item Charge Assignment (Purch)"
{
    // version NAVW110.0

    // HEI.01 FDD-HT1075 CHG2039144 IBM.GUNERE01 14.01.2020 # GetTransferShipmentLines PageAction added
    //                                                    UpdateQty func. modified
    //Bc Upgrade YADAVM09 Event OnAfterUpdateQty is Subscribed for function UpdateQty to handle in Subcriber codeunit.//HEI.01

    layout
    {
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = All;
            ToolTipML = ENU = 'Specifies the type of document that the item charge is assigned to.', FRA = 'Indique le type du document auquel les frais annexes sont affectés.';
        }
        modify("Applies-to Doc. No.")
        {
            ApplicationArea = All;
            ToolTipML = ENU = 'Specifies the number of the document that the item charge is assigned to.', FRA = 'Indique le numéro du document auquel les frais annexes sont affectés.';
        }
        modify("Applies-to Doc. Line No.")
        {
            ApplicationArea = All;
            ToolTipML = ENU = 'Specifies the line number of the line that the item charge is assigned to.', FRA = 'Indique le numéro de la ligne à laquelle les frais annexes sont affectés.';
        }
        modify("Item No.")
        {
            ApplicationArea = All;
            ToolTipML = ENU = 'Specifies the item number of the document line assigned to the item charge.', FRA = 'Spécifie le numéro de l''article de la ligne document à laquelle les frais annexes sont affectés.';
        }
        modify(Description)
        {
            ApplicationArea = All;
            ToolTipML = ENU = 'Specifies a description of the item that the item charge will be assigned to.', FRA = 'Spécifie une description de l''article auquel les frais annexes vont être affectés.';
        }
        modify("Qty. to Assign")
        {
            ApplicationArea = All;
            ToolTipML = ENU = 'Specifies the number of units of the item charge that will be assigned to this line.', FRA = 'Spécifie le nombre d''unités des frais annexes qui seront affectés à cette ligne.';
        }
        modify("Qty. Assigned")
        {
            ApplicationArea = All;
            ToolTipML = ENU = 'Specifies the number of units of the item charge that has been assigned to this line.', FRA = 'Spécifie le nombre d''unités des frais annexes qui ont été affectés à cette ligne.';
        }
        modify("Amount to Assign")
        {
            ApplicationArea = All;
            ToolTipML = ENU = 'Specifies the amount that will be assigned to this assignment line.', FRA = 'Indique le montant affecté à cette ligne d''affectation.';
        }
        modify(QtyToReceiveBase)
        {
            ApplicationArea = All;
            CaptionML = ENU = 'Qty. to Receive (Base)', FRA = 'Qté à recevoir (base)';
            ToolTipML = ENU = 'Specifies a value if the purchase line entered into this assignment line Specifies units that have not yet been posted as received.', FRA = 'Spécifie une valeur si la ligne achat entrée dans cette ligne affectation indique des unités n''ayant pas encore été validées comme étant réceptionnées.';
        }
        modify(QtyReceivedBase)
        {
            ApplicationArea = All;
            CaptionML = ENU = 'Qty. Received (Base)', FRA = 'Quantité reçue (base)';
            ToolTipML = ENU = 'Specifies the number of units that have been posted as received from the purchase line on this assignment line.', FRA = 'Spécifie le nombre d''unités ayant été validées comme étant reçue à partir de la ligne achat sur cette ligne affectation.';
        }
        modify(QtyToShipBase)
        {
            ApplicationArea = All;
            CaptionML = ENU = 'Qty. to Ship (Base)', FRA = 'Qté à expédier (base)';
            ToolTipML = ENU = 'Specifies a value if the purchase line entered into this assignment line Specifies units that have not yet been posted as shipped.', FRA = 'Spécifie une valeur si la ligne achat entrée dans cette ligne affectation indique des unités n''ayant pas encore été validées comme étant expédiées.';
        }
        modify(QtyShippedBase)
        {
            ApplicationArea = All;
            CaptionML = ENU = 'Qty. Shipped (Base)', FRA = 'Qté expédiée (base)';
            ToolTipML = ENU = 'Specifies the number of units that have been posted as shipped from the purchase line on this assignment line.', FRA = 'Spécifie le nombre d''unités ayant été validées comme étant expédiées à partir de la ligne achat sur cette ligne affectation.';
        }
        modify(Assignable)
        {
            CaptionML = ENU = 'Assignable', FRA = 'Affectable';
        }
        modify(AssignableQty)
        {
            CaptionML = ENU = 'Total (Qty.)', FRA = 'Total (qté)';
            ToolTipML = ENU = 'Specifies the total quantity of the item charge that you can assign in this window.', FRA = 'Indique la quantité totale des frais annexes que vous pouvez attribuer dans cette fenêtre.';
        }
        modify(AssgntAmount)
        {
            CaptionML = ENU = 'Total (Amount)', FRA = 'Total (montant)';
            ToolTipML = ENU = 'Specifies the total item charge amount that you can assign in this window.', FRA = 'Indique le montant total des frais annexes que vous pouvez attribuer dans cette fenêtre.';
        }
        modify("To Assign")
        {
            CaptionML = ENU = 'To Assign', FRA = 'A affecter';
        }
        modify(TotalQtyToAssign)
        {
            CaptionML = ENU = 'Qty. to Assign', FRA = 'Qté à affecter';
            ToolTipML = ENU = 'Specifies the quantity of the item charge that is assigned.', FRA = 'Spécifie la quantité de frais annexes affectée.';
        }
        modify(TotalAmountToAssign)
        {
            CaptionML = ENU = 'Amount to Assign', FRA = 'Montant à affecter';
            ToolTipML = ENU = 'Specifies the amount of the item charge that will be assigned on the assignment lines in this window.', FRA = 'Indique le montant des frais annexes affecté aux lignes affectation dans cette fenêtre.';
        }
        modify("Rem. to Assign")
        {
            CaptionML = ENU = 'Rem. to Assign', FRA = 'Restant à affecter';
        }
        modify(RemQtyToAssign)
        {
            CaptionML = ENU = 'Rem. Qty. to Assign', FRA = 'Qté à affecter restante';
            ToolTipML = ENU = 'Specifies the quantity of the item charge that has not yet been assigned.', FRA = 'Indique la quantité des frais annexes qui n''a pas encore été affectée.';
        }
        modify(RemAmountToAssign)
        {
            CaptionML = ENU = 'Rem. Amount to Assign', FRA = 'Montant à affecter restant';
            ToolTipML = ENU = 'Specifies the amount of the item charge that has not yet been assigned.', FRA = 'Indique le montant des frais annexes qui n''a pas encore été affecté.';
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(GetReceiptLines)
        {
            CaptionML = ENU = 'Get &Receipt Lines', FRA = '&Extraire lignes réception';
        }
        modify(GetTransferReceiptLines)
        {
            CaptionML = ENU = 'Get &Transfer Receipt Lines', FRA = 'Extraire lignes &réception transfert';
        }
        modify(GetReturnShipmentLines)
        {
            CaptionML = ENU = 'Get Return &Shipment Lines', FRA = 'Extraire lignes e&xpédition retour';
        }
        modify(GetSalesShipmentLines)
        {
            CaptionML = ENU = 'Get S&ales Shipment Lines', FRA = 'Ex&traire lignes expéd. vente';
        }
        modify(GetReturnReceiptLines)
        {
            CaptionML = ENU = 'Get Ret&urn Receipt Lines', FRA = 'Extr&aire lignes récept. retour';
        }
        modify(SuggestItemChargeAssignment)
        {
            CaptionML = ENU = 'Suggest &Item Charge Assignment', FRA = '&Suggérer affectation frais annexes';
        }
        addafter(GetTransferReceiptLines)
        {
            action(GetTransferShipmentLines)
            {
                AccessByPermission = TableData "Transfer Header" = R;
                Caption = 'Get &Transfer Shipment Lines';
                Image = TransferReceipt;
                ApplicationArea = All;
                ToolTip = 'Executes the Get &Transfer Shipment Lines action.';

                trigger OnAction();
                var
                    ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
                    PostedTransferShipmentLines: Page "Posted Transfer Shipment Lines";
                begin
                    //>> HEI.01
                    ItemChargeAssgntPurch.SETRANGE("Document Type", Rec."Document Type");
                    ItemChargeAssgntPurch.SETRANGE("Document No.", Rec."Document No.");
                    ItemChargeAssgntPurch.SETRANGE("Document Line No.", Rec."Document Line No.");
                    TransferShptLine.SETCURRENTKEY("Document No.");
                    TransferShptLine.SETASCendING("Document No.", true);
                    PostedTransferShipmentLines.SETTABLEVIEW(TransferShptLine);
                    if ItemChargeAssgntPurch.FINDLAST() then
                        PostedTransferShipmentLines.Initialize(ItemChargeAssgntPurch, PurchLine2."Unit Cost")
                    else
                        PostedTransferShipmentLines.Initialize(Rec, PurchLine2."Unit Cost");
                    PostedTransferShipmentLines.LOOKUPMODE(true);
                    PostedTransferShipmentLines.RUNMODAL();
                    //<< HEI.01
                end;
            }
        }
    }


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=The sign of %1 must be the same as the sign of %2 of the item charge.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=The sign of %1 must be the same as the sign of %2 of the item charge.;FRA=Le signe de %1 doit être le même que celui de %2 des frais annexes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : @@@="%2 = Document Type, %3 = Document No.";ENU=The remaining amount to assign is %1. It must be zero before you can post %2 %3.\ \Are you sure that you want to close the window?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : @@@="%2 = Document Type, %3 = Document No.";ENU=The remaining amount to assign is %1. It must be zero before you can post %2 %3.\ \Are you sure that you want to close the window?;FRA=Le montant ouvert à affecter est %1. Il doit être égal à zéro avant de valider %2 %3.\ \Voulez-vous vraiment fermer la fenêtre ?;
    //Variable type has not been exported.

    var
        TransferShptLine: Record "Transfer Shipment Line";


    //Unsupported feature: CodeModification on "UpdateQty(PROCEDURE 1)". Please convert manually.

    //procedure UpdateQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    case "Applies-to Doc. Type" of
      "Applies-to Doc. Type"::Order,"Applies-to Doc. Type"::Invoice:
        begin
    #4..54
          QtyToShipBase := 0;
          QtyShippedBase := 0;
        end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..57
        //>> HEI.01
        "Applies-to Doc. Type"::"Transfer Shipment":
        begin
          TransferShptLine.GET("Applies-to Doc. No.","Applies-to Doc. Line No.");
          QtyToReceiveBase := 0;
          QtyReceivedBase := TransferShptLine.Quantity;
          QtyToShipBase := 0;
          QtyShippedBase := 0;
        end;
        //<< HEI.01
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

