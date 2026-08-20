tableextension 50223 "Customized Calendar Change Ext" extends "Customized Calendar Change"
{
    fields
    {
        field(50000; "Recurring Frequency FND"; DateFormula)
        {
            Caption = 'Recurring Frequency';
            DataClassification = ToBeClassified;
        }
        field(50001; "Starting Date FND"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(50002; "Ending Date FND"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = ToBeClassified;
        }
        field(50003; "Calling FND"; Boolean)
        {
            Caption = 'Calling';
            DataClassification = ToBeClassified;
        }
        field(50004; "Shipment FND"; Boolean)
        {
            Caption = 'Shipment';
            DataClassification = ToBeClassified;
        }
        field(50005; "Promised Delivery FND"; Boolean)
        {
            Caption = 'Promised Delivery';
            DataClassification = ToBeClassified;
        }
        field(50006; "Shipment Day FND"; Option)
        {
            Caption = 'Shipment Day';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(50007; "Shipment Time FND"; Time)
        {
            Caption = 'Shipment Time';
            DataClassification = ToBeClassified;
        }
        field(50008; "Promised Delivery Day FND"; Option)
        {
            Caption = 'Promised Delivery Day';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(50009; "Promised Delivery Time FND"; Time)
        {
            Caption = 'Promised Delivery Time';
            DataClassification = ToBeClassified;
        }
        field(50010; "Calling Day FND"; Option)
        {
            Caption = 'Calling Day';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(50011; "Calling Time FND"; Time)
        {
            Caption = 'Calling Time';
            DataClassification = ToBeClassified;
        }
    }
}
