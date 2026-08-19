
codeunit 51036 "Clear Trans. Rcpt. Logs CBN"
{

    // HEI.01 CHG2253923 IBM POENAB02 04.12.2024 HB3943 Stock in transit - enablement of updating standard cost
    // # Object created

    // BC UPGRADE PATELS08 >>
    // # Created New Codeunit and added Tag HEI.01
    // # Nav ID : 50228
    // BC UPGRADE PATELS08 <<
    
    Permissions =
    TableData "Warehouse Setup" = R,
    TableData "Trans Rcpt Logs (Std Cost) FND" = RIMD;

    SingleInstance = false;

    var
        WarehouseSetup: Record "Warehouse Setup";
        DateToDelete: Date;
        RetentionFormula: Text;
        TransRcptLogsStdCost: Record "Trans Rcpt Logs (Std Cost) FND";

    trigger OnRun()
    begin
        WarehouseSetup.GET();
        IF WarehouseSetup."En Stock in Trans. Funct FND" THEN
        IF FORMAT(WarehouseSetup."StockInTransLogRetention FND") <> '' THEN
        BEGIN
            RetentionFormula := '-' + FORMAT(WarehouseSetup."StockInTransLogRetention FND");
            DateToDelete := CALCDATE(RetentionFormula,TODAY);
            TransRcptLogsStdCost.RESET;
            TransRcptLogsStdCost.SETFILTER("Creation Date",'<=%1',DateToDelete);
            TransRcptLogsStdCost.DELETEALL;
        END;
    end;
    
}
