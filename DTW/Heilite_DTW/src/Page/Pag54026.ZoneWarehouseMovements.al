page 54026 "Zone Warehouse Movements"
{
    // version HEI.02
    //BC Upgrade Kamnay01 Original(Heilite) page id 50002
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #zone transfers
    // HEI.02 Defect #2028 IBM NASTAA02 07.05.2018 # Role Tile Amount incorrect
    //   # Filter on Type "Movement" moved on table
    // HEI.03 FDD-HT623 CHG2022293 IBM GAVANM01 02.07.2019
    //   # New fields added: 'Transfer From Bin', 'Transfer To Bin', 'Posting Date'
    //   # New global variable 'EthiopiaVisible'
    //   # Visible property set to EthiopiaVisible for the following fields: "In-Transit Zone", "In-Transit Bin", "Transfer From Bin", "Transfer To Bin", "Posting Date"
    //   # New Action, 'Update Transfer Information' with code included
    //   # 'Posting date' field moved after the 'No' field
    // HEI.04 FDD-HT623 CHG2022293 IBM GAVANM01 06.08.2019
    //   # visible property set to TRUE for the following fields: "Transfer From Bin", "Transfer To Bin", "Posting Date"
    //   # visible property set to FALSE for the following fields: "In-Transit Zone", "In-Transit Bin"
    //   # visible property set to TRUE for the action 'Update Transfer Information'
    // HEI.05 CHG2069354 IBM.AK 14.10.20
    // # Attached new report-R50449 to Page Action
    // HEI.06 IBM.AK 11.03.21
    //  # Added new fields Shipping Agent, shipping Agent service code, Truck code, Driver Code,
    //  # New Page Action-New Truck Movement added beside New button
    //BC UPGRADE PATHAA02- 23.01.26 #Caption change from 'Warehouse Movements' to 'Zone Warehouse Movements'-FAT

    Caption = 'Zone Warehouse Movements'; //BC UPGRADE PATHAA02- 23.01.26
    CardPageID = "Zone Warehouse Movement";
    Editable = false;
    PageType = List;
    SourceTable = "Warehouse Activity Header";
    ApplicationArea = ALL;    // BC Upgrade SHUKLP03 << 
    UsageCategory = Lists;    // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the warehouse header.';
                    ApplicationArea = ALL;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = ALL;
                }
                field("Transfer Status"; Rec."Transfer Status FND")
                {
                    ApplicationArea = ALL;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the code for the location where the warehouse activity takes place.';
                }
                field("From Zone Code"; Rec."From Zone Code FND")
                {
                    ApplicationArea = ALL;
                }
                field("To Zone Code"; Rec."To Zone Code FND")
                {
                    ApplicationArea = ALL;
                }
                field("In-Transit Zone"; Rec."In-Transit Zone FND")
                {
                    Visible = false;
                    ApplicationArea = ALL;
                }
                field("In-Transit Bin"; Rec."In-Transit Bin FND")
                {
                    Visible = false;
                    ApplicationArea = ALL;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the external document number for the source document to which the warehouse activity is related.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                    Visible = false;
                    ApplicationArea = ALL;
                }
                field("No. of Lines"; Rec."No. of Lines")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the number of lines in the warehouse activity document.';
                }
                field("Assignment Date"; Rec."Assignment Date")
                {
                    ToolTip = 'Specifies the date when the user was assigned the activity.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transfer From Bin"; Rec."Transfer From Bin FND")
                {
                    ApplicationArea = ALL;
                    Visible = true;
                }
                field("Transfer To Bin"; Rec."Transfer To Bin FND")
                {
                    ApplicationArea = ALL;
                    Visible = true;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code FND")
                {
                    ApplicationArea = ALL;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Cod FND")
                {
                    ApplicationArea = ALL;
                }
                field("Truck Code"; Rec."Truck Code FND")
                {
                    ApplicationArea = ALL;
                }
                field("Driver Code"; Rec."Driver Code FND")
                {
                    ApplicationArea = ALL;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Movement")
            {
                Caption = '&Movement';
                Image = CreateMovement;
                action("Co&mments")
                {
                    ApplicationArea = ALL;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Warehouse Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Whse. Activity Header"),
                                  Type = FIELD(Type),
                                  "No." = FIELD("No.");
                }
                action("Registered Movements")
                {
                    ApplicationArea = ALL;
                    Caption = 'Registered Movements';
                    Image = RegisteredDocs;
                    RunObject = Page "Registered Whse. Activity List";
                    RunPageLink = Type = FIELD(Type),
                                  "Whse. Activity No." = FIELD("No.");
                    RunPageView = SORTING("Whse. Activity No.");
                }
                action("Update Transfer Information")
                {
                    ApplicationArea = ALL;
                    Image = UpdateShipment;
                    Visible = true;

                    trigger OnAction();
                    var
                        WhseActivityHeader: Record "Warehouse Activity Header";
                        WhseActivityLines: Record "Warehouse Activity Line";
                        BinCode: Code[20];
                        Text001: Label 'Update completed.';
                    begin
                        //HEI.03>>
                        WhseActivityHeader.RESET();
                        WhseActivityHeader.SETRANGE(Type, WhseActivityHeader.Type::Movement);
                        if WhseActivityHeader.FINDFIRST() then
                            repeat
                                CLEAR(BinCode);
                                WhseActivityLines.RESET();
                                WhseActivityLines.SETRANGE("Activity Type", WhseActivityHeader.Type);
                                WhseActivityLines.SETRANGE("No.", WhseActivityHeader."No.");
                                WhseActivityLines.SETRANGE("Action Type", WhseActivityLines."Action Type"::Take);
                                WhseActivityLines.SETFILTER("Bin Code", '<>%1', '');
                                if WhseActivityLines.FINDFIRST() then begin
                                    BinCode := WhseActivityLines."Bin Code";
                                    repeat
                                        if BinCode <> WhseActivityLines."Bin Code" then
                                            BinCode := 'MULTIPLE';
                                    until (WhseActivityLines.NEXT() = 0) or (BinCode = 'MULTIPLE');
                                end;
                                WhseActivityHeader."Transfer From Bin FND" := BinCode;
                                WhseActivityHeader.MODIFY();

                                CLEAR(BinCode);
                                WhseActivityLines.RESET();
                                WhseActivityLines.SETRANGE("Activity Type", WhseActivityHeader.Type);
                                WhseActivityLines.SETRANGE("No.", WhseActivityHeader."No.");
                                WhseActivityLines.SETRANGE("Action Type", WhseActivityLines."Action Type"::Place);
                                WhseActivityLines.SETFILTER("Bin Code", '<>%1', '');
                                if WhseActivityLines.FINDFIRST() then begin
                                    BinCode := WhseActivityLines."Bin Code";
                                    repeat
                                        if BinCode <> WhseActivityLines."Bin Code" then
                                            BinCode := 'MULTIPLE';
                                    until (WhseActivityLines.NEXT() = 0) or (BinCode = 'MULTIPLE');
                                end;
                                WhseActivityHeader."Transfer To Bin FND" := BinCode;
                                WhseActivityHeader.MODIFY();
                            until WhseActivityHeader.NEXT() = 0;

                        MESSAGE(Text001);
                        //HEI.03<<
                    end;
                }
                action("Zone WH Reconciliation")
                {
                    ApplicationArea = ALL;
                    Image = Zones;
                    RunObject = Report "WH Zone Movements Recon CBN";
                }
                action("New Truck Movement")
                {
                    ApplicationArea = ALL;
                    Caption = 'New Truck Movement';
                    Ellipsis = true;
                    Image = Track;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Zone Warehouse Movement";
                    RunPageMode = Create;
                    ShortCutKey = 'Shift+Ctrl+t';

                    trigger OnAction();
                    var
                        TruckMove: Boolean;
                    begin
                        //HEI.06
                        TruckMove := true;
                        TruckMovementProcess.IsTruckMovTrue(TruckMove);
                        //HEI.06<<
                    end;
                }
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        exit(Rec.FindFirstAllowedRec(Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        exit(Rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage();
    begin
        //  Rec.ErrorIfUserIsNotWhseEmployee();
        CheckUserIsWhseEmployee_DTW();
        Rec."Zone transfer FND" := true;

        //HEI.03>>
        if (TENANTID() = 'ethiopia') /*OR (TENANTID = 'default')*/ then
            EthiopiaVisible := true
        else
            EthiopiaVisible := false;
        //HEI.03<<

    end;
    //BC Upgrade GUNREM01 >> BUG Fix 29.05.26
    procedure CheckUserIsWhseEmployee_DTW()
    var
        WarehouseEmployee: Record "Warehouse Employee_DTW FND";

    begin
        if UserId <> '' then begin
            WarehouseEmployee.SetRange("User ID", UserId);
            if WarehouseEmployee.IsEmpty() then
                ConfirmOpenWarehouseEmployees(WarehouseEmployee, StrSubstNo(UserIsNotWhseEmployeeErr, UserId()));
        end;
    end;

    local procedure ConfirmOpenWarehouseEmployees(var WarehouseEmployee: Record "Warehouse Employee_DTW FND"; ErrorMessage: Text)
    var
        WarehouseEmployeeLocal: Record "Warehouse Employee_DTW FND";
        ConfirmManagement: Codeunit "Confirm Management";
        WarehouseEmployees: Page "Warehouse Employees_DTW CBN";
        ConfirmText: TextBuilder;
        WarehouseEmployeeExists: Boolean;
    begin
        ConfirmText.AppendLine(ErrorMessage);
        ConfirmText.AppendLine();
        ConfirmText.AppendLine(OpenWarehouseEmployeesPageQst);

        WarehouseEmployeeLocal.CopyFilters(WarehouseEmployee);
        WarehouseEmployeeLocal.SetRange(Default);

        if ConfirmManagement.GetResponseOrDefault(ConfirmText.ToText(), false) then begin
            WarehouseEmployees.SetTableView(WarehouseEmployeeLocal);
            WarehouseEmployees.RunModal();
            if not WarehouseEmployee.IsEmpty() then
                WarehouseEmployeeExists := true;
        end;

        if not WarehouseEmployeeExists then
            Error(ErrorMessage);
    end;

    //BC Upgrade GUNREM01 << BUG Fix 29.05.26 

    var
        TransferToBin: Code[20];
        EthiopiaVisible: Boolean;
        TruckMovementProcess: Codeunit "Truck Movement Process";
        //BC Upgrade GUNREM01 >> BUG Fix 29.05.26 
        OpenWarehouseEmployeesPageQst: Label 'Do you want to do that now?';
        UserIsNotWhseEmployeeErr: Label 'You must first set up user %1 as a warehouse employee.';
    //BC Upgrade GUNREM01 << BUG Fix 29.05.26 
}

