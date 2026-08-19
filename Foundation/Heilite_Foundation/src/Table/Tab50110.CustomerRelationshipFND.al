table 50110 "Customer Relationship FND"
{
    // version HEI.01

    // HEI.01 FDD Indirect Customer Master IBM.NAIKH01 28.09.2018
    //   # created a new Table

    DrillDownPageID = "Customer Relationship";
    LookupPageID = "Customer Relationship";

    fields
    {
        field(1; "No."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate();
            begin
                if cust.GET("No.") then;
                Name := cust.Name;
            end;
        }
        field(2; Name; Text[50])
        {
            FieldClass = Normal;
            TableRelation = Customer;
        }
        field(4; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
    }

    keys
    {
        key(Key1; "No.", "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        CustNo := Rec.GETFILTER("Customer No.");
        if cust.GET("No.") then;
        if cust1.GET(CustNo) then;

        if cust."No." = cust1."No." then
            ERROR(Err001);
        /*
          IF cust."Contract Type" =  cust."Contract Type"::" " THEN
            RelationType := 1;
        
          IF (cust."Contract Type" = cust."Contract Type"::"CTS Only") OR
             (cust."Contract Type" = cust."Contract Type"::"Full Contract") THEN
             RelationType := 2;
        
         IF cust1."Contract Type" =  cust1."Contract Type"::" " THEN
            RelationType1 := 1;
        
          IF (cust1."Contract Type" = cust1."Contract Type"::"CTS Only") OR
             (cust1."Contract Type" = cust1."Contract Type"::"Full Contract") THEN
             RelationType1 := 2;
        
        IF RelationType = RelationType1 THEN
          ERROR(Err001);
          */
        "Customer No." := CustNo;

    end;

    trigger OnModify();
    begin

        CustNo := Rec.GETFILTER("Customer No.");
        "Customer No." := CustNo;
    end;

    var
        cust: Record Customer;
        cust1: Record Customer;
        CustNo: Code[20];
        RelationType: Integer;
        RelationType1: Integer;
        Err001: Label 'Selected customer is same as the primary customer';
}

