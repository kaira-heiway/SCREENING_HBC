table 50180 "Loyalty Free Reason Buffer FND"
{
    // version HEI.01,NRQ151359

    // HEI.01 CHG2059200 IBM SAMANR01 04.22.2020
    //   # Object Created
    // NRQ151359 AKH 17/07/2020 Loyalty enhancement
    //                          Changed type of field Points Integer -> Decimal

    CaptionML = ENU = 'Free Reason Code',
                FRA = 'Code motif gratuit';
    //DrillDownPageID = "Free Reason Code";  // BC Upgrade NANDIS03 - Dependency on Aptean
    //LookupPageID = "Free Reason Code";  // BC Upgrade NANDIS03 - Dependency on Aptean

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(2; "Free Reason Code"; Code[20])
        {
            CaptionML = ENU = 'Code',
                        FRA = 'Code';
            //TableRelation = "Free Reason Code" where(Type = CONST(Loyalty));  // BC Upgrade NANDIS03 - Dependency on Aptean
        }
        field(3; "Free Reason Description"; Text[50])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
        }
        field(4; Points; Decimal)
        {
            Description = 'NRQ151359';
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Type; Option)
        {
            CaptionML = ENU = 'Type',
                        FRA = 'Type';
            OptionCaptionML = ENU = ' ,Free,Loan,,,,Loyalty',
                              FRA = ' ,Gartuit,Pret,,,,Loyalty';
            OptionMembers = " ",Free,Loan,,,,Loyalty;
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Free Reason Code")
        {
        }
    }

    fieldgroups
    {
    }

    // procedure TranslateDescription(var Value: Record "Free Reason Code"; Language: Code[10]);
    // var
    //     FreeReasonTranslation: Record "Free Reason Translation";
    // begin
    //     if FreeReasonTranslation.GET(Value.Code, Language) then
    //         Value.Description := FreeReasonTranslation.Description;
    // end;  // BC Upgrade NANDIS03 - Dependency on Aptean
}

