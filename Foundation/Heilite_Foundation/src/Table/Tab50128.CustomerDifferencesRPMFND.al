table 50128 "Customer Differences RPM FND"
{
    // version HEI.01

    // HEI.01 FDDHT88 IBM BULIMC01 25/10/2019 #code changed


    // HEI.01 already blocked in Nav // BC Upgrade SHUKLP03 <<



    fields
    {
        field(1; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        FRA = 'N° ligne';
            Description = 'HEI.01';
            Editable = false;
        }
        field(2; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.',
                        FRA = 'N° article';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = Item;

            trigger OnValidate();
            begin
                if Item.GET(Rec."Item No.") then begin
                    Rec."Item Description" := Item.Description;
                    Rec."UOM Code" := Item."Sales Unit of Measure";
                end;  //HEI.01
                      //DrinkDepositGroup.SETRANGE("Source Type",DrinkDepositGroup."Source Type"::Item); //HEI.01 commented
                      //DrinkDepositGroup.SETFILTER(Code,Item."Item DDeposit Group Code"); //HEI.01 commented
                      //IF DrinkDepositGroup.FINDFIRST THEN //HEI.01 commented
                      // Rec."Deposit Price"      :=  DrinkDepositGroup."Deposit Reference unit Price"; HEI.01 commented
                      //HEI.01<<
                      //SalesDepositItemCharge.SETRANGE("Source No.", Rec."Item No.");  //commented HEI.01
                      //   IF SalesDepositItemCharge.FINDFIRST THEN  //commented HEI.01
                      //  Rec."Deposit Price" := SalesDepositItemCharge."Unit Price";  //commented HEI.01
                      //HEI.01>>
                      //end;  //commented HEI.01

                Rec."Compensation RPM Diff." := true;
            end;
        }
        field(3; "UOM Code"; Code[10])
        {
            CaptionML = ENU = 'Unit of Measure Code',
                        FRA = 'Code unité';
            Description = 'HEI.01';
            Editable = true;
            TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("Item No."));
        }
        field(4; "Item Description"; Text[50])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
            Description = 'HEI.01';
            Editable = false;
        }
        field(5; "Deposit Price"; Decimal)
        {
            Description = 'HEI.01';
            Editable = false;
        }
        field(6; "RPM Missing Bottle"; Decimal)
        {
            Description = 'HEI.01';
        }
        field(7; "RPM Broken"; Decimal)
        {
            Description = 'HEI.01';
        }
        field(8; "RPM Chipped"; Decimal)
        {
            Description = 'HEI.01';
        }
        field(9; "RPM Missing crate"; Decimal)
        {
            Description = 'HEI.01';
        }
        field(10; "Sell-to customer no."; Code[20])
        {
            Description = 'HEI.01';
        }
        field(11; "Sell-to Customer Name"; Text[50])
        {
            CaptionML = ENU = 'Sell-to Customer Name',
                        FRA = 'Nom du donneur d''ordre';
            Description = 'HEI.01';
            TableRelation = Customer;
            ValidateTableRelation = false;

            trigger OnValidate();
            var
                Customer: Record Customer;
            begin
            end;
        }
        field(12; "Bill-to Customer No."; Code[20])
        {
            CaptionML = ENU = 'Bill-to Customer No.',
                        FRA = 'N° client facturé';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate();
            var
                ShipToAddr: Record "Ship-to Address";
                HasRecreateSalesLines: Boolean;
            begin
            end;
        }
        field(13; "Bill-to Customer name"; Text[50])
        {
            Description = 'HEI.01';
        }
        field(14; "Compensation RPM Diff."; Boolean)
        {
            Description = 'HEI.01';
            Editable = false;
        }
        field(15; "Sales return order no."; Code[20])
        {
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                /*
                salesheader.RESET;
                salesheader.SETRANGE("No.",Rec."Sales return order no.");
                salesheader.SETRANGE("Document Type",salesheader."Document Type"::"Return Order");
                IF salesheader.FINDFIRST THEN
                
                "Sell-to customer no."   :=  salesheader."Sell-to Customer No.";
                "Sell-to Customer Name"  :=  salesheader."Sell-to Customer Name";
                "Bill-to Customer No."   :=  salesheader."Bill-to Customer No.";
                "Bill-to Customer name"  :=  salesheader."Bill-to Name";
                
                IF Cust.GET(salesheader."Sell-to Customer No.") THEN
                  CustomerDifferencesRPM."Compensation RPM Diff." := Cust."Compensate RPM Differences";
                  */

            end;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Item No.", "Sales return order no.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin

        CustomerDifferencesRPM.RESET();
        if CustomerDifferencesRPM.FINDLAST() then begin
            LastLineNo := CustomerDifferencesRPM."Line No.";
            LastLineNo := LastLineNo + 10000;
        end
        else
            LastLineNo := LastLineNo + 10000;

        "Line No." := LastLineNo;
    end;

    var
        Cust: Record Customer;
        CustomerDifferencesRPM: Record "Customer Differences RPM FND";
        Item: Record Item;
        salesheader: Record "Sales Header";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WhseSetup: Record "Warehouse Setup";
        LastLineNo: Integer;
        // NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked as this CU is obsolete
        UpdateDiffValue: Integer;
    // DrinkDepositGroup : Record "Drink Deposit Group";
    // SalesDepositItemCharge : Record "Sales Deposit Item Charge";
}

