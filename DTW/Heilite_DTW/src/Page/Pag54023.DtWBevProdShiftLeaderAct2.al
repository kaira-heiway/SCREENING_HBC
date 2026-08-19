page 54023 "DtW Bev Prod Shift Leader Act2"
{
    // version Role,HEI.05
    //BC Upgrade Kamnay01 Original(Heilite) page id 50425
    // HEI.01 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //  # New object created
    // HEI.02 CHG2089898 IBM POENAB02 15.12.2020 Role Centre Production Bottling Role Centre
    //  # Modified function CueDrillDown
    // HEI.03 CHG2118467 IBM.LS      22.09.2021
    //   # Added New Field - Bulk Transfer
    // HEI.04 CHG2138109 IBM.LS      22.02.2022
    //   # Removed the Page - Item Reclass. Journal from DrillDownPageID property
    //   # Added Code to open the Page - Item Reclass. Journal besed on current filters
    // HEI.05 HB1487 - CHG2070737 IBM NASTAA02 31.03.2022 # Mass Upload of Production Orders
    //   # Added Field 'Imported Production Orders'

    //Bc Upgrade YADAVM09 Drink it field and code commented.
    //Bc Upgrade YADAVM09 Field is blocked from page "Imported Production Orders".

    Caption = 'Activities';
    PageType = CardPart;
    ApplicationArea = All;
    RefreshOnActivate = true;
    SourceTable = "Manufacturing Cue";

    layout
    {
        area(content)
        {

            cuegroup("Firm Planned")
            {
                Caption = 'Firm Planned';
                field("Count_PO(2,1)"; Count_PO(2, 1))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 1);
                    Visible = ShowCue1;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 1);
                    end;
                }
                field("Count_PO(2,2)"; Count_PO(2, 2))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 2);
                    Visible = ShowCue2;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 2);
                    end;
                }
                field("Count_PO(2,3)"; Count_PO(2, 3))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 3);
                    Visible = ShowCue3;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 3);
                    end;
                }
                field("Count_PO(2,4)"; Count_PO(2, 4))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 4);
                    Visible = ShowCue4;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 4);
                    end;
                }
                field("Count_PO(2,5)"; Count_PO(2, 5))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 5);
                    Visible = ShowCue5;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 5);
                    end;
                }
                field("Count_PO(2,6)"; Count_PO(2, 6))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 6);
                    Visible = ShowCue6;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 6);
                    end;
                }
                field("Count_PO(2,7)"; Count_PO(2, 7))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 7);
                    Visible = ShowCue7;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 7);
                    end;
                }
                field("Count_PO(2,8)"; Count_PO(2, 8))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 8);
                    Visible = ShowCue8;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 8);
                    end;
                }
                field("Count_PO(2,9)"; Count_PO(2, 9))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 9);
                    Visible = ShowCue9;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 9);
                    end;
                }
                field("Count_PO(2,10)"; Count_PO(2, 10))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 10);
                    Visible = ShowCue10;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 10);
                    end;
                }
                field("Count_PO(2,11)"; Count_PO(2, 11))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 11);
                    Visible = ShowCue11;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 11);
                    end;
                }
                field("Count_PO(2,12)"; Count_PO(2, 12))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 12);
                    Visible = ShowCue12;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 12);
                    end;
                }
                field("Count_PO(2,13)"; Count_PO(2, 13))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 13);
                    Visible = ShowCue13;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 13);
                    end;
                }
                field("Count_PO(2,14)"; Count_PO(2, 14))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 14);
                    Visible = ShowCue14;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 14);
                    end;
                }
                field("Count_PO(2,15)"; Count_PO(2, 15))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 15);
                    Visible = ShowCue15;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::"Firm Planned", 15);
                    end;
                }
            }
            cuegroup("Released Orders")
            {
                Caption = 'Released Orders';
                field("Count_PO(3,1)"; Count_PO(3, 1))
                {
                    CaptionClass = GetCaptionClassPO(1, 1);
                    Visible = ShowCue1;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 1);
                    end;
                }
                field("Count_PO(3,2)"; Count_PO(3, 2))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 2);
                    Visible = ShowCue2;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 2);
                    end;
                }
                field("Count_PO(3,3)"; Count_PO(3, 3))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 3);
                    Visible = ShowCue3;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 3);
                    end;
                }
                field("Count_PO(3,4)"; Count_PO(3, 4))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 4);
                    Visible = ShowCue4;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 4);
                    end;
                }
                field("Count_PO(3,5)"; Count_PO(3, 5))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 5);
                    Visible = ShowCue5;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 5);
                    end;
                }
                field("Count_PO(3,6)"; Count_PO(3, 6))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 6);
                    Visible = ShowCue6;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 6);
                    end;
                }
                field("Count_PO(3,7)"; Count_PO(3, 7))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 7);
                    Visible = ShowCue7;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 7);
                    end;
                }
                field("Count_PO(3,8)"; Count_PO(3, 8))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 8);
                    Visible = ShowCue8;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 8);
                    end;
                }
                field("Count_PO(3,9)"; Count_PO(3, 9))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 9);
                    Visible = ShowCue9;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 9);
                    end;
                }
                field("Count_PO(3,10)"; Count_PO(3, 10))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 10);
                    Visible = ShowCue10;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 10);
                    end;
                }
                field("Count_PO(3,11)"; Count_PO(3, 11))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 11);
                    Visible = ShowCue11;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 11);
                    end;
                }
                field("Count_PO(3,12)"; Count_PO(3, 12))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 12);
                    Visible = ShowCue12;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 12);
                    end;
                }
                field("Count_PO(3,13)"; Count_PO(3, 13))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 13);
                    Visible = ShowCue13;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 13);
                    end;
                }
                field("Count_PO(3,14)"; Count_PO(3, 14))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 14);
                    Visible = ShowCue14;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 14);
                    end;
                }
                field("Count_PO(3,15)"; Count_PO(3, 15))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 15);
                    Visible = ShowCue15;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Released, 15);
                    end;
                }
                /* //Bc Upgrade YADAVM09 No Opco is using this functionality>>
                field("Imported Production Orders"; "Imported Production Orders")
                {
                }
                */ //Bc Upgrade YADAVM09 No Opco is using this functionality<<
            }
            cuegroup("Finished Orders")
            {
                Caption = 'Finished Orders';
                field("Count_PO(4,1)"; Count_PO(4, 1))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 1);
                    Visible = ShowCue1;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 1);
                    end;
                }
                field("Count_PO(4,2)"; Count_PO(4, 2))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 2);
                    Visible = ShowCue2;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 2);
                    end;
                }
                field("Count_PO(4,3)"; Count_PO(4, 3))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 3);
                    Visible = ShowCue3;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 3);
                    end;
                }
                field("Count_PO(4,4)"; Count_PO(4, 4))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 4);
                    Visible = ShowCue4;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 4);
                    end;
                }
                field("Count_PO(4,5)"; Count_PO(4, 5))
                {
                    CaptionClass = GetCaptionClassPO(1, 5);
                    Visible = ShowCue5;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 5);
                    end;
                }
                field("Count_PO(4,6)"; Count_PO(4, 6))
                {
                    CaptionClass = GetCaptionClassPO(1, 6);
                    Visible = ShowCue6;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 6);
                    end;
                }
                field("Count_PO(4,7)"; Count_PO(4, 7))
                {
                    CaptionClass = GetCaptionClassPO(1, 7);
                    Visible = ShowCue7;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 7);
                    end;
                }
                field("Count_PO(4,8)"; Count_PO(4, 8))
                {
                    CaptionClass = GetCaptionClassPO(1, 8);
                    Visible = ShowCue8;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 8);
                    end;
                }
                field("Count_PO(4,9)"; Count_PO(4, 9))
                {
                    CaptionClass = GetCaptionClassPO(1, 9);
                    Visible = ShowCue9;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 9);
                    end;
                }
                field("Count_PO(4,10)"; Count_PO(4, 10))
                {
                    CaptionClass = GetCaptionClassPO(1, 10);
                    Visible = ShowCue10;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        UserPersonalization: Record "User Personalization";
                        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
                        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
                        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
                        i: Integer;
                        TileNo: Integer;
                        lRoleCentreGrouping: Text;
                        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 10);
                    end;
                }
                field("Count_PO(4,11)"; Count_PO(4, 11))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 11);
                    Visible = ShowCue11;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 11);
                    end;
                }
                field("Count_PO(4,12)"; Count_PO(4, 12))
                {
                    CaptionClass = GetCaptionClassPO(1, 12);
                    Visible = ShowCue12;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 12);
                    end;
                }
                field("Count_PO(4,13)"; Count_PO(4, 13))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 13);
                    Visible = ShowCue13;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 13);
                    end;
                }
                field("Count_PO(4,14)"; Count_PO(4, 14))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 14);
                    Visible = ShowCue14;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 14);
                    end;
                }
                field("Count_PO(4,15)"; Count_PO(4, 15))
                {
                    ApplicationArea = All;
                    CaptionClass = GetCaptionClassPO(1, 15);
                    Visible = ShowCue15;

                    trigger OnDrillDown();
                    begin
                        CueDrillDown(PurchOrderStatus::Finished, 15);
                    end;
                }
            }
            //BC Upgrade GUNREM01 >> FDD-DTW-029 
            //     cuegroup(Masterdata)
            //     {
            //        
            //         Caption = 'Wort/Must Production';

            //         field("FPPO – Wort & Must"; Rec."Firm Plan. PO - Brewing")
            //         {
            //             ApplicationArea = all;
            //             Caption = 'FPPO - Wort & Must';
            //             DrillDownPageId = "Firm Planned Prod. Orders - CU";

            //         }
            //         field("RPO – Wort & Must"; Rec."Released PO - Brewing")
            //         {
            //             ApplicationArea = all;
            //             Caption = 'RPO - Wort & Must';
            //             DrillDownPageId = "Released Production Orders C";

            //         }
            //         field("FPO – Wort & Must"; Rec."Finished PO - Brewing")
            //         {
            //             ApplicationArea = all;
            //             Caption = 'FPO - Wort & Must';
            //             DrillDownPageId = "Finished Production Orders- CU";

            //         }
            //         // field("Import Production Orders"; Rec.prod)
            //         // {
            //         //     ApplicationArea = all;
            //         // }  Import Production Orders not found 
            //     }



            // cuegroup("Master Data")
            // {
            //     Caption = 'Master Data';
            //     field(Items; Rec.Items)
            //     {
            //         ApplicationArea = all;
            //     }
            //     field(SKU; Rec.SKU)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'SKUs';
            //     }
            //     field(WorkCenter; Rec.WorkCenter)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Work Centers';
            //     }
            //     field(Routings; Rec.Routings)
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Routing Links"; Rec."Routing Links")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Routing Link Codes';
            //     }
            //     field(BOM; Rec.BOM)
            //     {
            //         Caption = 'BOMs';
            //         ApplicationArea = All;
            //     }
            // }

            // cuegroup("Inventory Management")
            // {
            //     Caption = 'Inventory Management';
            //     field("Goods Movement"; Rec."Goods Movement")
            //     {
            //         Caption = 'Zone Warehouse Movements';
            //         DrillDownPageID = "Zone Warehouse Movements";
            //         ApplicationArea = All;
            //     }
            //     field("Registered Goods Movements"; Rec."Registered Goods Movements")
            //     {

            //         DrillDownPageID = "Registered Whse. Activity List";
            //         ApplicationArea = All;
            //     }
            //     field("Goods Receipts"; Rec."Goods Receipts")
            //     {
            //         DrillDownPageID = "Warehouse Receipts";
            //         ApplicationArea = All;
            //     }
            //     field("Registered Goods Receipts"; Rec."Registered Goods Receipts")
            //     {
            //         DrillDownPageID = "Posted Whse. Receipt List";
            //         ApplicationArea = ALL;
            //     }
            //     field("Posted Whse. Receipt List- Bre"; Rec."Posted Whse. Receipt List- Bre")
            //     {
            //         DrillDownPageID = "Posted Whse. Receipt List- BRe";
            //         Visible = false;
            //     }
            //     field("Item Reclass"; Rec."Item Reclass")
            //     {
            //         DrillDownPageID = "Item Reclass. Journal";
            //         ApplicationArea = ALL;
            //         Visible = false;
            //     }
            //     field("Lot No. Information"; Rec."Lot No. Information")
            //     {
            //         DrillDownPageID = "Lot No. Information List";
            //     }
            //     field("Lot Tests in Progress"; Rec."Lot Tests in Progress")
            //     {
            //         // DrillDownPageID = "Quality Processing List";//Bc Upgrade YADAVM09 Drink it object
            //     }
            //     field("Bulk Transfer"; Rec."Bulk Transfer")
            //     {

            //         trigger OnDrillDown();
            //         var
            //             ItemJournalTemplateL: Record "Item Journal Template";
            //             ItemJournalBatchL: Record "Item Journal Batch";
            //             iL: Integer;
            //             TemplateNameL: Code[10];
            //             BatchNameL: Code[10];
            //             ItemReclassJournalL: Page "Item Reclass. Journal";
            //         begin
            //             //HEI.04>>
            //             CurrPage.UPDATE(false);
            //             ItemJournalTemplateL.SETCURRENTKEY(Type, "Page ID");
            //             ItemJournalTemplateL.SETRANGE(Type, ItemJournalTemplateL.Type::Transfer);
            //             ItemJournalTemplateL.SETRANGE("Page ID", PAGE::"Item Reclass. Journal");
            //             if ItemJournalTemplateL.findset() then begin
            //                 repeat
            //                     iL += 1;
            //                     ItemJournalBatchL.SETCURRENTKEY("Journal Template Name", "Template Type", "Use in Bulk Transfer");
            //                     ItemJournalBatchL.SETRANGE("Journal Template Name", ItemJournalTemplateL.Name);
            //                     ItemJournalBatchL.SETRANGE("Template Type", ItemJournalBatchL."Template Type"::Transfer);
            //                     ItemJournalBatchL.SETRANGE("Use in Bulk Transfer", true);
            //                     if ItemJournalBatchL.FINDFIRST() then begin
            //                         TemplateNameL := ItemJournalTemplateL.Name;
            //                         BatchNameL := ItemJournalBatchL.Name;
            //                     end;
            //                 until ItemJournalTemplateL.NEXT() = 0;
            //             end;
            //             if iL > 1 then
            //                 ItemReclassJournalL.GetBatchName(TemplateNameL, BatchNameL);
            //             ItemReclassJournalL.RUN();
            //             //HEI.04<<
            //         end;
            //     }
            // }
            //BC Upgrade GUNREM01 << FDD DTW 029  commented

        }
    }

    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.GET() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
        /* //Bc Upgrade YADAVM09 Dependency on Drink it object rMANXLSetup>>
                Rec.SETRANGE("User ID Filter", USERID);
                if rMANXLSetup.READPERMISSION then
                    blnVisible := false
                else
                    blnVisible := true;
        */ //Bc Upgrade YADAVM09 Dependency on Drink it object rMANXLSetup<<

        SetVisible();
    end;

    var

        blnVisible: Boolean;
        //rMANXLSetup: Record "Manufacturing XL Setup"; //Bc Upgrade Drink object
        CaptionTest: Text;
        ShowCue11: Boolean;
        CueGroup11: Text;
        a: Integer;
        ShowCue: Boolean;
        ShowCue1: Boolean;
        ShowCue2: Boolean;
        ShowCue3: Boolean;
        ShowCue4: Boolean;
        ShowCue5: Boolean;
        ShowCue6: Boolean;
        ShowCue7: Boolean;
        ShowCue8: Boolean;
        ShowCue9: Boolean;
        ShowCue10: Boolean;
        FirmPlannedProdOrders_Page: Page "Firm Planned Prod. Orders";
        ProdOrderFiltered: Record "Production Order";
        ReleasedProductionOrders_Page: Page "Released Production Orders";
        FinishedProductionOrders_Page: Page "Finished Production Orders";
        PurchOrderStatus: Option Simulated,Planned,"Firm Planned",Released,Finished;
        UserSetupMgt: Codeunit "User Setup Management";
        ShowCue12: Boolean;
        ShowCue13: Boolean;
        ShowCue14: Boolean;
        ShowCue15: Boolean;
        FirmPlannedProdOrders_Page2: Page "Firm Planned Prod. Orders MRC";
        ReleasedProductionOrders_Page2: Page "Released Production Orders MRC";
        FinishedProductionOrders_Page2: Page "Finished Production Orders MRC";

    local procedure Count_Open_PO_Page(): Integer;
    var
        ProductionOrders: Record "Production Order";
    begin
        ProductionOrders.SETRANGE(ProductionOrders.Status, ProductionOrders.Status::"Firm Planned");
        exit(ProductionOrders.COUNT);
    end;

    local procedure Count_PO(POStatus: Option Simulated,Planned,"Firm Planned",Released,Finished; TileNo: Integer): Integer;
    var
        ProductionOrders: Record "Production Order";
        UserPersonalization: Record "User Personalization";
        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
        i: Integer;
        lRoleCentreGrouping: Text;
        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
        lUserSetup: Record "User Setup";
    begin
        UserPersonalization.RESET();
        UserPersonalization.SETRANGE("User ID", USERID);
        if UserPersonalization.FINDFIRST() then begin
            ProfileIDTileCodeSetup.RESET();
            ProfileIDTileCodeSetup.SETRANGE("Profile ID", UserPersonalization."Profile ID");
            if ProfileIDTileCodeSetup.FINDFIRST() then begin
                i := 1;
                ProfileIDTileCodeSetup2.RESET();
                ProfileIDTileCodeSetupTemp.RESET();
                ProfileIDTileCodeSetup2.SETRANGE("Profile ID", UserPersonalization."Profile ID");
                if ProfileIDTileCodeSetup2.FINDFIRST() then
                    repeat
                        ProfileIDTileCodeSetupTemp.TRANSFERFIELDS(ProfileIDTileCodeSetup2);
                        ProfileIDTileCodeSetupTemp."Line No." := i;
                        ProfileIDTileCodeSetupTemp.INSERT();
                        i += 1;
                    until ProfileIDTileCodeSetup2.NEXT() = 0;
            end;
        end;

        ProfileIDTileCodeSetupTemp.RESET();
        ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", TileNo);
        if ProfileIDTileCodeSetupTemp.FINDFIRST() then
            lRoleCentreGrouping := ProfileIDTileCodeSetupTemp."Role Centre Grouping";

        ProductionOrders.SETRANGE(ProductionOrders.Status, POStatus);
        if lRoleCentreGrouping <> '' then
            ProductionOrders.SETFILTER("Role Centre Tile Code FND", lRoleCentreGrouping);

        // if UserSetupMgt.GetProductionTextFilter <> '' then
        //     ProductionOrders.SETFILTER("Responsibility Center", UserSetupMgt.GetProductionTextFilter);//Bc Upgrade YADAVM09 Drink it function commented

        exit(ProductionOrders.COUNT);
    end;

    procedure GetCaptionClassPO(ViewType: Integer; TileNo: Integer): Text[250];
    var
        UserPersonalization: Record "User Personalization";
        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
        i: Integer;
    begin
        UserPersonalization.RESET();
        UserPersonalization.SETRANGE("User ID", USERID);
        if UserPersonalization.FINDFIRST() then begin
            ProfileIDTileCodeSetup.RESET();
            ProfileIDTileCodeSetup.SETRANGE("Profile ID", UserPersonalization."Profile ID");
            if ProfileIDTileCodeSetup.FINDFIRST() then begin
                i := 1;
                ProfileIDTileCodeSetup2.RESET();
                ProfileIDTileCodeSetupTemp.RESET();
                ProfileIDTileCodeSetup2.SETRANGE("Profile ID", UserPersonalization."Profile ID");
                if ProfileIDTileCodeSetup2.FINDFIRST() then
                    repeat
                        ProfileIDTileCodeSetupTemp.TRANSFERFIELDS(ProfileIDTileCodeSetup2);
                        ProfileIDTileCodeSetupTemp."Line No." := i;
                        ProfileIDTileCodeSetupTemp.INSERT();
                        i += 1;
                    until ProfileIDTileCodeSetup2.NEXT() = 0;

                case ViewType of
                    1:
                        begin
                            if TileNo = 1 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 1);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 2 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 2);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 3 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 3);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 4 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 4);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 5 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 5);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 6 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 6);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 7 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 7);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 8 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 8);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 9 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 9);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 10 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 10);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 11 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 11);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 12 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 12);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 13 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 13);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 14 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 14);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                            if TileNo = 15 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 15);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                        end;
                    2:
                        begin
                            if TileNo = 2 then begin
                                ProfileIDTileCodeSetupTemp.RESET();
                                ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", 2);
                                if ProfileIDTileCodeSetupTemp.FINDFIRST() then
                                    exit(ProfileIDTileCodeSetupTemp.Description);
                            end;
                        end;
                end;
            end;
        end;

        exit('');
    end;

    local procedure SetVisible();
    var
        UserPersonalization: Record "User Personalization";
        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
        i: Integer;
        lShowCue: array[15] of Integer;
        j: Integer;
    begin
        ShowCue1 := false;
        ShowCue2 := false;
        ShowCue3 := false;
        ShowCue4 := false;
        ShowCue5 := false;
        ShowCue6 := false;
        ShowCue7 := false;
        ShowCue8 := false;
        ShowCue9 := false;
        ShowCue10 := false;
        ShowCue11 := false;
        ShowCue12 := false;
        ShowCue13 := false;
        ShowCue14 := false;
        ShowCue15 := false;

        for j := 1 to 15 do
            lShowCue[j] := 0;

        UserPersonalization.RESET();
        UserPersonalization.SETRANGE("User ID", USERID);
        if UserPersonalization.FINDFIRST() then begin
            ProfileIDTileCodeSetup.RESET();
            ProfileIDTileCodeSetup.SETRANGE("Profile ID", UserPersonalization."Profile ID");
            if ProfileIDTileCodeSetup.FINDFIRST() then begin
                i := 1;
                ProfileIDTileCodeSetup2.RESET();
                ProfileIDTileCodeSetupTemp.RESET();
                ProfileIDTileCodeSetup2.SETRANGE("Profile ID", UserPersonalization."Profile ID");
                if ProfileIDTileCodeSetup2.FINDFIRST() then
                    repeat
                        ProfileIDTileCodeSetupTemp.TRANSFERFIELDS(ProfileIDTileCodeSetup2);
                        ProfileIDTileCodeSetupTemp."Line No." := i;
                        ProfileIDTileCodeSetupTemp.INSERT();
                        lShowCue[i] := 1;
                        i += 1;
                    until ProfileIDTileCodeSetup2.NEXT() = 0;
            end;
        end;

        if lShowCue[1] = 1 then
            ShowCue1 := true;

        if lShowCue[2] = 1 then
            ShowCue2 := true;

        if lShowCue[3] = 1 then
            ShowCue3 := true;

        if lShowCue[4] = 1 then
            ShowCue4 := true;

        if lShowCue[5] = 1 then
            ShowCue5 := true;

        if lShowCue[6] = 1 then
            ShowCue6 := true;

        if lShowCue[7] = 1 then
            ShowCue7 := true;

        if lShowCue[8] = 1 then
            ShowCue8 := true;

        if lShowCue[9] = 1 then
            ShowCue9 := true;

        if lShowCue[10] = 1 then
            ShowCue10 := true;

        if lShowCue[11] = 1 then
            ShowCue11 := true;

        if lShowCue[12] = 1 then
            ShowCue12 := true;

        if lShowCue[13] = 1 then
            ShowCue13 := true;

        if lShowCue[14] = 1 then
            ShowCue14 := true;

        if lShowCue[15] = 1 then
            ShowCue15 := true;
    end;

    local procedure CueDrillDown(Status: Option Simulated,Planned,"Firm Planned",Released,Finished; Tile: Integer);
    var
        UserPersonalization: Record "User Personalization";
        ProfileIDTileCodeSetup: Record "Profile ID-Tile Code Setup FND";
        ProfileIDTileCodeSetupTemp: Record "Profile ID-Tile Code Setup FND" temporary;
        ProfileIDTileCodeSetup2: Record "Profile ID-Tile Code Setup FND";
        i: Integer;
        TileNo: Integer;
        lRoleCentreGrouping: Text;
        RoleCenterTileSetup: Record "Role Center Tile Setup FND";
        lProductionOrderTop: Record "Production Order";
        lProductionOrderTopRec: Record "Production Order";
    begin
        ProdOrderFiltered.RESET();

        UserPersonalization.RESET();
        UserPersonalization.SETRANGE("User ID", USERID);
        if UserPersonalization.FINDFIRST() then begin
            ProfileIDTileCodeSetup.RESET();
            ProfileIDTileCodeSetup.SETRANGE("Profile ID", UserPersonalization."Profile ID");
            if ProfileIDTileCodeSetup.FINDFIRST() then begin
                i := 1;
                ProfileIDTileCodeSetup2.RESET();
                ProfileIDTileCodeSetupTemp.RESET();
                ProfileIDTileCodeSetup2.SETRANGE("Profile ID", UserPersonalization."Profile ID");
                if ProfileIDTileCodeSetup2.FINDFIRST() then
                    repeat
                        ProfileIDTileCodeSetupTemp.TRANSFERFIELDS(ProfileIDTileCodeSetup2);
                        ProfileIDTileCodeSetupTemp."Line No." := i;
                        ProfileIDTileCodeSetupTemp.INSERT();
                        i += 1;
                    until ProfileIDTileCodeSetup2.NEXT() = 0;
            end;
        end;

        TileNo := Tile;

        ProfileIDTileCodeSetupTemp.RESET();
        ProfileIDTileCodeSetupTemp.SETRANGE("Line No.", TileNo);
        if ProfileIDTileCodeSetupTemp.FINDFIRST() then
            lRoleCentreGrouping := ProfileIDTileCodeSetupTemp."Role Centre Grouping";

        if lRoleCentreGrouping <> '' then
            ProdOrderFiltered.SETFILTER("Role Centre Tile Code FND", lRoleCentreGrouping);

        ProdOrderFiltered.ASCENDING(false);

        if Status = Status::"Firm Planned" then begin
            //HEI.02>>
            //FirmPlannedProdOrders_Page.SETTABLEVIEW(ProdOrderFiltered);
            FirmPlannedProdOrders_Page2.SETTABLEVIEW(ProdOrderFiltered);
            //HEI.02<<

            lProductionOrderTop.RESET();
            lProductionOrderTop.COPYFILTERS(ProdOrderFiltered);
            if lProductionOrderTop.FINDLAST() then begin
                lProductionOrderTopRec.GET(lProductionOrderTop.Status, lProductionOrderTop."No.");
                //HEI.02>>
                //FirmPlannedProdOrders_Page.SETRECORD(lProductionOrderTopRec);
                FirmPlannedProdOrders_Page2.SETRECORD(lProductionOrderTopRec);
                //HEI.02<<
            end;

            //HEI.02>>
            //FirmPlannedProdOrders_Page.RUN();
            FirmPlannedProdOrders_Page2.RUN();
            //HEI.02<<
        end;

        if Status = Status::Released then begin
            //HEI.02>>
            //ReleasedProductionOrders_Page.SETTABLEVIEW(ProdOrderFiltered);
            ReleasedProductionOrders_Page2.SETTABLEVIEW(ProdOrderFiltered);
            //HEI.02<<

            lProductionOrderTop.RESET();
            lProductionOrderTop.COPYFILTERS(ProdOrderFiltered);
            if lProductionOrderTop.FINDLAST() then begin
                lProductionOrderTopRec.GET(lProductionOrderTop.Status, lProductionOrderTop."No.");
                //HEI.02>>
                //ReleasedProductionOrders_Page.SETRECORD(lProductionOrderTopRec);
                ReleasedProductionOrders_Page2.SETRECORD(lProductionOrderTopRec);
                //HEI.02<<
            end;

            //HEI.02>>
            //ReleasedProductionOrders_Page.RUN();
            ReleasedProductionOrders_Page2.RUN();
            //HEI.02<<
        end;

        if Status = Status::Finished then begin
            //HEI.02>>
            //FinishedProductionOrders_Page.SETTABLEVIEW(ProdOrderFiltered);
            FinishedProductionOrders_Page2.SETTABLEVIEW(ProdOrderFiltered);
            //HEI.02<<

            lProductionOrderTop.RESET();
            lProductionOrderTop.COPYFILTERS(ProdOrderFiltered);
            if lProductionOrderTop.FINDLAST() then begin
                lProductionOrderTopRec.GET(lProductionOrderTop.Status, lProductionOrderTop."No.");
                //HEI.02>>
                //FinishedProductionOrders_Page.SETRECORD(lProductionOrderTopRec);
                FinishedProductionOrders_Page2.SETRECORD(lProductionOrderTopRec);
                //HEI.02<<
            end;

            //HEI.02>>
            //FinishedProductionOrders_Page.RUN();
            FinishedProductionOrders_Page2.RUN();
            //HEI.02<<
        end;
    end;
}

