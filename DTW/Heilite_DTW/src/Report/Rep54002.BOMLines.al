report 54002 "BOM Lines"
{
    // version HEI.01
    //BC upgrade Kamnay01 Original(Heilite) Report id 50269
    // HEI.01 FDD-CHG2012344_HB567_Bill-of Materials Reports IBM NANDIS01 19.06.2019
    //   New report created for exporting Bill-of Materials data
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\BOM Lines.rdl';
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;


    dataset
    {
        dataitem("Production BOM Line"; "Production BOM Line")
        {
            DataItemTableView = SORTING("Production BOM No.", "Version Code", "Line No.");
            RequestFilterFields = "Production BOM No.", "Version Code";
            column(Filters; "Production BOM Line".GETFILTERS)
            {
            }
            column(RoutingLinkCode_ProductionBOMLine; "Production BOM Line"."Routing Link Code")
            {
            }
             //BC upgrade Kamnay01>> this is Drinkit field but this field is added in Production BOM Line table
            column(Productionjnlflushing_ProductionBOMLine; "Production BOM Line"."Production jnl. flushing FND")
            {
            }
            //BC upgrade Kamnay01<< this is Drinkit field but this field is added in Production BOM Line table

            column(Scrap_ProductionBOMLine; "Production BOM Line"."Scrap %")
            {
            }
            column(Quantityper_ProductionBOMLine; FORMAT("Production BOM Line"."Quantity per"))
            {
            }
            column(No_ProductionBOMLine; "Production BOM Line"."No.")
            {
            }
            column(LineNo_ProductionBOMLine; "Production BOM Line"."Line No.")
            {
            }
            column(UnitofMeasureCode_ProductionBOMLine; "Production BOM Line"."Unit of Measure Code")
            {
            }
            column(Description_ProductionBOMLine; "Production BOM Line".Description)
            {
            }
            column(ProductionBOMNo_ProductionBOMLine; "Production BOM Line"."Production BOM No.")
            {
            }
            /* Bc Upgrade YADAVM09 Drink it field Commented>>
            column(LocationCode_ProductionBOMLine;"Production BOM Line"."Location Code")
            {
            }
            *///Bc Upgrade YADAVM09 Drink it field Commented>>

            //BC upgrade Kamnay01>> this is Drinkit field but this field is added in Production BOM Line table 
            column(prod_jnl_flushing; "Production BOM Line"."Production jnl. flushing FND")
            {
            }
            //BC upgrade Kamnay01<< this is Drinkit field but this field is added in Production BOM Line table

            column(Routing_LinkCode; "Production BOM Line"."Routing Link Code")
            {
            }
            column(Version; "Production BOM Line"."Version Code")
            {
            }
            column(Status; Status)
            {
            }
            column(LastDate; FORMAT(LastDate))
            {
            }
            column(Desc; Desc)
            {
            }
            column(UOM_Hdr; VersionUOM)
            {
            }
            column(LocationCode; g_recPrd_BOM_Hdr."Linked SKU FND")
            {
            }
            column(TotQty; FORMAT(TotQty))
            {
            }
            column(LocCode; LoCCode)
            {
            }
            column(SKU; SKU)
            {
            }
            column(ShowVersion; ShowVersion)
            {
            }

            trigger OnAfterGetRecord();
            begin
                Status := '';
                VersionUOM := '';
                LastDate := 0D;
                Desc := '';
                LoCCode := '';
                SKU := '';
                ShowVersion := '';
                TotQty := 0;

                TotQty := 0;
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));

                TotQty := "Production BOM Line"."Quantity per" + (("Production BOM Line"."Scrap %" / 100) * "Production BOM Line"."Quantity per");

                g_recStockkeeping_Unit.RESET();
                g_recStockkeeping_Unit.SETRANGE(g_recStockkeeping_Unit."Production BOM No.", "Production BOM No.");
                if g_recStockkeeping_Unit.FINDFIRST() then begin
                    LoCCode := g_recStockkeeping_Unit."Location Code";
                    SKU := g_recStockkeeping_Unit."Item No.";
                end;

                g_recProdBOMVersion.RESET();
                g_recProdBOMVersion.SETRANGE(g_recProdBOMVersion."Production BOM No.", "Production BOM No.");
                g_recProdBOMVersion.SETRANGE(g_recProdBOMVersion."Version Code", "Production BOM Line"."Version Code");
                if g_recProdBOMVersion.FINDFIRST() then begin
                    if g_recProdBOMVersion."Active FND" then begin
                        ShowVersion := 'Yes';
                        Status := FORMAT(g_recProdBOMVersion.Status);
                        LastDate := g_recProdBOMVersion."Last Date Modified";
                        Desc := g_recProdBOMVersion.Description;
                        VersionUOM := g_recProdBOMVersion."Unit of Measure Code";
                    end else begin
                        ShowVersion := '';
                        if g_recPrd_BOM_Hdr.GET("Production BOM Line"."Production BOM No.") then begin
                            Status := FORMAT(g_recPrd_BOM_Hdr.Status);
                            LastDate := g_recProdBOMVersion."Last Date Modified";
                            Desc := g_recProdBOMVersion.Description;
                            VersionUOM := g_recProdBOMVersion."Unit of Measure Code";
                        end;
                    end;
                end else begin
                    if g_recPrd_BOM_Hdr.GET("Production BOM Line"."Production BOM No.") then begin
                        Status := FORMAT(g_recPrd_BOM_Hdr.Status);
                        LastDate := g_recPrd_BOM_Hdr."Last Date Modified";
                        VersionUOM := g_recPrd_BOM_Hdr."Unit of Measure Code";
                        Desc := g_recPrd_BOM_Hdr.Description;
                    end;
                end;
            end;

            trigger OnPostDataItem();
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem();
            begin
                if ISEMPTY then
                    ERROR(Text50000);

                Window.OPEN(Text50001 + '@1@@@@@@@@@@@@@@@@@@@@@\');
                TotalRecNo := COUNT;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportHeaderlbl = 'BOM Lines';
    }

    var
        Window: Dialog;
        Text50000: Label 'Nothing to export';
        Text50001: Label 'Processing Data';
        TotalRecNo: Integer;
        RecNo: Integer;
        Text50003: Label 'Production BOM';
        g_recPrd_BOM_Hdr: Record "Production BOM Header";
        TotQty: Decimal;
        LastDate: Date;
        g_recStockkeeping_Unit: Record "Stockkeeping Unit";
        SKU: Code[20];
        LoCCode: Code[10];
        g_recProdBOMVersion: Record "Production BOM Version";
        ShowVersion: Text;
        Status: Text;
        Desc: Text;
        VersionUOM: Text;
}

