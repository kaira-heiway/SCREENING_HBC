codeunit 51001 "Restricted Fields Mgt. CBN"
{
    // version OSFS16.1,HEI.03

    // HEI.01 FDD-OTCGAP015a HeiliteBase IBM ISYED01 11/07/2017
    //   #New code unit created for restricting the user on table fileds
    // HEI.02 CHG2185841 IBM SAMNR01 05-01-2023
    //   #Add expedite permission for table "Service Password" as read permission
    // HEI.03  YADAVM05 10.03.2023 CHG2187935_HB3211 code added to skip CMG Mandatory check on report
    // HEI.04  YADAVM05 20.03.2023 CHG2187935_HB3211 Remove Function OnBeforeOnDatabaseModify

    //Permissions = TableData "Service Password" = r;  // BC Upgrade NANDIS03

    // POENAB02, 15.06.2026, changes for 2C

    SingleInstance = true;

    trigger OnRun();
    begin
    end;

    var
        RestrictedField: Record "Restricted Field FND";
        RestrictedFieldUserAccess: Record "Restricted Fld User Access FND";
        Error01: Label 'User %1  is not granted the permission to change this field';
    //UserGroupMember: Record "User Group Member";  // BC upgrade NANDIS03

    // [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterGetDatabaseTableTriggerSetup', '', false, false)]  // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::GlobalTriggerManagement, OnAfterGetDatabaseTableTriggerSetup, '', false, false)]  // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    procedure OnAfterGetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean; var OnDatabaseRename: Boolean);
    begin
        if COMPANYNAME = '' then
            exit;

        RestrictedField.SETRANGE("Table ID", TableId);
        RestrictedField.SETRANGE("Field ID");
        if RestrictedField.FINDFIRST() then begin
            OnDatabaseInsert := true;
            OnDatabaseModify := true;
            OnDatabaseDelete := true;
            OnDatabaseRename := true;
            //POENAB02, 15.06.2026>>
            // end else begin
            //     OnDatabaseInsert := false;
            //     OnDatabaseModify := false;
            //     OnDatabaseDelete := false;
            //     OnDatabaseRename := false;
            //POENAB02, 15.06.2026<<
        end;
    end;


    //[EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseDelete', '', false, false)]  // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::GlobalTriggerManagement, 'OnAfterOnDatabaseDelete', '', false, false)]  // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    procedure OnAfterOnDatabaseDelete(RecRef: RecordRef);
    begin
        if RecRef.ISTEMPORARY then
            exit;

        RestrictedField.SETRANGE("Table ID", RecRef.NUMBER);
        if RestrictedField.findset() then
            repeat
                FindUserAccess();
            until RestrictedField.NEXT() = 0;
    end;

    //[EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseInsert', '', false, false)] // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::GlobalTriggerManagement, 'OnAfterOnDatabaseInsert', '', false, false)] // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    procedure OnAfterOnDatabaseInsert(RecRef: RecordRef);
    var
        FldRef: FieldRef;
    begin
        if RecRef.ISTEMPORARY then
            exit;

        RestrictedField.SETRANGE("Table ID", RecRef.NUMBER);
        if RestrictedField.findset() then
            repeat
                FldRef := RecRef.FIELD(RestrictedField."Field ID");
                if FORMAT(FldRef.TYPE) <> 'Option' then
                    if FORMAT(FldRef.VALUE) <> '' then
                        FindUserAccess();
            until RestrictedField.NEXT() = 0;
    end;

    //[EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseModify', '', false, false)]  // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::GlobalTriggerManagement, 'OnAfterOnDatabaseModify', '', false, false)]  // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    procedure OnAfterOnDatabaseModify(RecRef: RecordRef);
    var
        xRecRef: RecordRef;
        FldRef: FieldRef;
        xFldRef: FieldRef;
    begin
        if RecRef.ISTEMPORARY then
            exit;

        if not xRecRef.GET(RecRef.RECORDID) then
            exit;

        RestrictedField.SETRANGE("Table ID", RecRef.NUMBER);
        if RestrictedField.findset() then
            repeat
                FldRef := RecRef.FIELD(RestrictedField."Field ID");
                xFldRef := xRecRef.FIELD(RestrictedField."Field ID");
                if FORMAT(FldRef.VALUE) <> FORMAT(xFldRef.VALUE) then
                    FindUserAccess();
            until RestrictedField.NEXT() = 0;
    end;

    //[EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnGlobalRename', '', false, false)]  // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::GlobalTriggerManagement, 'OnAfterOnGlobalRename', '', false, false)]  // BC Upgrade NANDIS03 - blocked as ApplicationManagement(Codeunit 1 is obsolete)
    procedure OnAfterOnGlobalRename(RecRef: RecordRef; xRecRef: RecordRef);
    var
        FldRef: FieldRef;
        xFldRef: FieldRef;
    begin
        if RecRef.ISTEMPORARY then
            exit;

        RestrictedField.SETRANGE("Table ID", RecRef.NUMBER);
        if RestrictedField.findset() then
            repeat
                FldRef := RecRef.FIELD(RestrictedField."Field ID");
                xFldRef := xRecRef.FIELD(RestrictedField."Field ID");
                if FORMAT(FldRef.VALUE) <> FORMAT(xFldRef.VALUE) then
                    FindUserAccess();
            until RestrictedField.NEXT() = 0;
    end;

    local procedure FindUserAccess();
    var
        SecurityGroupMemberBuffer: Record "Security Group Member Buffer";  //  BC Upgrade NANDIS03
        SecurityGroup: Codeunit "Security Group";
    begin
        RestrictedFieldUserAccess.SETRANGE("Table ID", RestrictedField."Table ID");
        RestrictedFieldUserAccess.SETRANGE("Field ID", RestrictedField."Field ID");
        RestrictedFieldUserAccess.SETRANGE(Type, RestrictedFieldUserAccess.Type::User);
        if RestrictedFieldUserAccess.findset() then begin
            repeat
                ERROR(Error01, USERID);
            until RestrictedFieldUserAccess.NEXT() = 0;
        end
        else begin
            RestrictedFieldUserAccess.RESET();
            RestrictedFieldUserAccess.SETRANGE("Table ID", RestrictedField."Table ID");
            RestrictedFieldUserAccess.SETRANGE("Field ID", RestrictedField."Field ID");
            RestrictedFieldUserAccess.SETRANGE(Type, RestrictedFieldUserAccess.Type::"User Group");
            if RestrictedFieldUserAccess.FINDFIRST() then begin
                repeat
                    if RestrictedFieldUserAccess."User / User Group ID" <> '' then begin
                        // UserGroupMember.SETRANGE("User Group Code", RestrictedFieldUserAccess."User / User Group ID");
                        // if UserGroupMember.FINDFIRST then begin
                        //     if UserGroupMember."User Name" <> USERID then
                        //         ERROR(Error01, USERID);
                        // end;  // BC Upgrade NANDIS03
                        SecurityGroup.GetMembers(SecurityGroupMemberBuffer);  // BC Upgrade NANDIS03
                        SecurityGroupMemberBuffer.SetRange("Security Group Code", RestrictedFieldUserAccess."User / User Group ID");  // BC Upgrade NANDIS03
                        if not SecurityGroupMemberBuffer.IsEmpty then begin  // BC Upgrade NANDIS03
                            if SecurityGroupMemberBuffer."User Name" <> USERID then  // BC Upgrade NANDIS03
                                ERROR(Error01, USERID);  // BC Upgrade NANDIS03
                        end;  // BC Upgrade NANDIS03
                    end;
                until RestrictedFieldUserAccess.NEXT() = 0;
            end;
        end;
    end;
}

