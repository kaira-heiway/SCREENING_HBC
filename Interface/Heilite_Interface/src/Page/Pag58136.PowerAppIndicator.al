page 58136 "PowerApp Indicator"
{
    // HEI.01 HTS-78 IBM NANDIS01 27.03.2020
    //   # New Page created for Powerapps
    //BC Upgrade MISHRS14  >>
    // ADDED ApplicationArea
    // Blocked --DITW Field- Creation Date/Time in OnOpenPage Trigger
    //BC Upgrade MISHRS14  <<

    DeleteAllowed = false;
    SourceTable = "Integer";
    SourceTableView = WHERE(Number = CONST(1));
    //BC Upgrade MISHRS14  >> ADDED ApplicationArea
    ApplicationArea = All;
    //BC Upgrade MISHRS14  <<

    layout
    {
        area(content)
        {
            group(General)
            {
                field(NoOfUsers; NoofUsers)
                {
                    Caption = 'No Of Users Logged In';
                }
                field(NoOfDBBlocks; NoofDBLocks)
                {
                    Caption = 'No Of Database Locks';
                }
                field(NoOfOrderslasthr; NoOfOrderslasthr)
                {
                    Caption = 'No Of Orders Shipped in last 1 hour';
                }
                field(NoOfOrderssincemorning; NoOfOrderssincemorning)
                {
                    Caption = 'No Of Orders Shipped since Morning';
                }
                field(NoOfInvoicelasthr; NoOfInvoicelasthr)
                {
                    Caption = 'No Of Invoices in last 1 hour';
                }
                field(NoOfInvoicesincemorning; NoOfInvoicesincemorning)
                {
                    Caption = 'No Of Invoices since Morning';
                }
                field(UserID; UserID2)
                {
                    Caption = 'User ID';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    var
        User: Record User;
    begin
        NoofUsers := 0;
        NoofDBLocks := 0;
        NoOfOrderslasthr := 0;
        NoOfOrderssincemorning := 0;
        NoOfInvoicelasthr := 0;
        NoOfInvoicesincemorning := 0;

        //UserID2 := 'heiway\nastaa02';

        //IF UserID2 <> '' THEN  BEGIN
        //ERROR('User ID sent %1',UserID2);
        /*User.SETRANGE("User Name",UserID2);
        IF User.FINDFIRST THEN BEGIN*/


        grec_ActiveSession.RESET();
        if grec_ActiveSession.FINDSET() then
            NoofUsers := grec_ActiveSession.COUNT;

        grec_DBLocks.RESET();
        if grec_DBLocks.FINDSET() then
            NoofDBLocks := grec_DBLocks.COUNT;

        grec_SalesShpmntHdr.RESET();
        grec_SalesShpmntHdr.SETRANGE(grec_SalesShpmntHdr."Posting Date", TODAY);
        if grec_SalesShpmntHdr.FINDSET() then
            repeat
                CLEAR(Duration);
                intHours := 0;
                //BC Upgrade MISHRS14  >> Blocked because --DITW Field- Creation Date/Time
                //Duration := CURRENTDATETIME - grec_SalesShpmntHdr."Creation Date/Time";
                Duration := CURRENTDATETIME - grec_SalesShpmntHdr.SystemCreatedAt;  // Replaced with base field.
                //BC Upgrade MISHRS14  <<
                intHours := Duration div (60 * 60 * 1000);
                if (intHours < 1) then
                    NoOfOrderslasthr += 1;
                if (intHours <= 24) then
                    NoOfOrderssincemorning += 1;
            until grec_SalesShpmntHdr.NEXT() = 0;

        grec_SalesInvcHdr.RESET();
        grec_SalesInvcHdr.SETRANGE(grec_SalesInvcHdr."Posting Date", TODAY);
        if grec_SalesInvcHdr.FINDSET() then
            repeat
                CLEAR(DurationInv);
                intHoursInv := 0;
                //BC Upgrade MISHRS14  >> Blocked because --DITW Field- Creation Date/Time
                //DurationInv := CURRENTDATETIME - grec_SalesInvcHdr."Creation Date/Time";
                DurationInv := CURRENTDATETIME - grec_SalesInvcHdr.SystemCreatedAt;  // Replaced with base field.
                //BC Upgrade MISHRS14  <<
                intHoursInv := DurationInv div (60 * 60 * 1000);
                if (intHoursInv < 1) then
                    NoOfInvoicelasthr += 1;
                if (intHours <= 24) then
                    NoOfInvoicesincemorning += 1;
            until grec_SalesInvcHdr.NEXT() = 0;

        //END;
        //END;

    end;

    var
        NoofUsers: Integer;
        grec_ActiveSession: Record "Active Session";
        NoofDBLocks: Integer;
        grec_DBLocks: Record "Database Locks";
        NoOfOrderslasthr: Integer;
        NoOfOrderssincemorning: Integer;
        grec_SalesShpmntHdr: Record "Sales Shipment Header";
        NoOfInvoicelasthr: Integer;
        NoOfInvoicesincemorning: Integer;
        grec_SalesInvcHdr: Record "Sales Invoice Header";
        Duration: BigInteger;
        intHours: Integer;
        intMin: Integer;
        DurationInv: BigInteger;
        intHoursInv: Integer;
        UserID2: Text[50];
}

