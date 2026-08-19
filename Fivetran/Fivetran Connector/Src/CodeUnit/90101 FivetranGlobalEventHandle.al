codeunit 90101 FivetranGlobalEventHandle
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", 'GetDatabaseTableTriggerSetup', '', true, true)]
    local procedure GetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean)
    begin
        OnDatabaseDelete := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", 'OnDatabaseDelete', '', true, true)]
    local procedure OnDatabaseDelete(RecRef: RecordRef)
    var
        JSONObject: JsonObject;
        json: Text[1200];
        client: HttpClient;
        Response: HttpResponseMessage;
        content: HttpContent;
        systemModifiedAt: DateTime;
        contentHeaders: HttpHeaders;
        urlToUse: Text[200];
        subscription: Record "Custom Subscription";
        company: Record Company;
        systemId: Text[200];
        recordOfSharedTable: Boolean;
    begin
        recordOfSharedTable := false;

        subscription.SetCurrentKey(tableId);
        subscription.SetFilter(tableId, Format(RecRef.Number()));

        if (subscription.FindFirst()) then begin
            if (subscription.companyId = 'ALL') then begin
                recordOfSharedTable := true;
            end;
        end;

        if (not recordOfSharedTable) then begin
            company.Get(RecRef.CurrentCompany);
            subscription.SetCurrentKey(companyId, tableId);
            subscription.SetFilter(tableId, Format(RecRef.Number()));
            subscription.SetFilter(companyId, Format(company.Id).ToLower().Replace('{', '').Replace('}', ''));
        end;


        if subscription.FindSet() then begin
            JSONObject.Add('tableId', RecRef.Number());
            JSONObject.Add('companyId', Format(company.Id).ToLower().Replace('{', '').Replace('}', ''));
            JSONObject.Add('position', RecRef.GetPosition());
            JSONObject.Add('payloadId', '');
            JSONObject.Add('systemId', Format(RecRef.Field(2000000000).Value).ToLower().Replace('{', '').Replace('}', ''));
            systemModifiedAt := RecRef.Field(RecRef.SystemModifiedAtNo).Value;
            JSONObject.Add('systemModifiedAt', systemModifiedAt);
            repeat
                subscription.recordsDeleted := subscription.recordsDeleted + 1;
                subscription.Modify();
                JSONObject.Replace('payloadId', subscription.recordsDeleted);
                Client.Clear();
                JSONObject.WriteTo(json);
                Content.WriteFrom(json);
                content.GetHeaders(contentHeaders);
                contentHeaders.Clear();
                contentHeaders.Add('Content-Type', 'application/json');
                urlToUse := subscription.url;
                Client.Post(urlToUse, Content, Response);
            until subscription.Next() = 0;
        end;
    end;
}

/*
* Pages for few of the standard tables, which exposes the all of the supported columns.
*/
