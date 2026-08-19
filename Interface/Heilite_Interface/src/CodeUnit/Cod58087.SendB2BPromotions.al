codeunit 58087 "Send B2B Promotions"
{
    //BC Upgrade GUNREM01 Old ID-50123
    // version HEI.09

    // HEI.01 CHG2056939 DEBUSD01 20.10.2022 Promotion Interface b2b
    // HEI.02 CHG2056939 DEBUSD01 07.11.2022 Promotion Interface b2b
    //   #Add storeId = Company Information "Legal Entity Code"
    //   #Fix "Type"
    // HEI.03 CHG2056939 DEBUSD01 09.11.2022 Promotion Interface b2b
    //   #Fix guid fields "Id","Name"
    // HEI.04 CHG2056939 DEBUSD01 14.11.2022 Promotion Interface b2b rework
    //   #Fix format decimal fields
    // HEI.05 CHG2056939 DEBUSD01 17.11.2022 Promotion Interface b2b rework
    //   #Rework change bill-to to sell-to (if Sales Setup "Bill-to/Sell-to Prices Calc." = 'Bill-to')
    // HEI.06 CHG2056939 DEBUSD01 21.11.2022 Promotion Interface b2b rework
    //   #Add field Unit of measure code and Free Unit of measure code
    // HEI.07 CHG2056939 DEBUSD01 23.11.2022 Promotion Interface b2b rework
    //   #Add default item value when empty Unit of measure code and Free Unit of measure code
    //   #Fix calculate per filter (item, order)
    // HEI.08 CHG2056939 DEBUSD01 25.11.2022 Promotion Interface b2b rework
    //   #Add xml node <Promotion> per promotion record as <id>
    //   #Add xml node <Item> per source item (if group/all)
    // HEI.09 CHG2056939 DEBUSD01 13.12.2022 Promotions B2B with CustomerGroup
    //   #Add xml node <userGroup>

    //BC Upgrade GUNREM01
    //# Commenetd DIT code 
    //# Replaced dotnet varibales with xml variables and added code using xml var


    trigger OnRun();
    begin
        CreateAndSendResponseXML;
    end;

    var
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
        // RunSalesPromotionFilters: Record "Sales Promotion Item Charge"; //BC Upgrade GUNREM01 DIT table
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        Customer2: Record Customer;
        Item: Record Item;
        RunDate: Date;

    procedure SetRunDate(NewDate: Date);
    begin
        RunDate := NewDate;
    end;
    //BC Upgrade GUNREM01 dependecny with DIT >>
    // procedure SetRunSalesPromotionFilters(var NewSalesPromotionFilters: Record "Sales Promotion Item Charge");
    // begin
    //     RunSalesPromotionFilters.COPYFILTERS(NewSalesPromotionFilters);
    // end;
    //BC Upgrade GUNREM01 dependecny with DIT <<
    procedure CreateAndSendResponseXML(): Boolean;
    var
        InterfaceSetup: Record "Interface Setup INT";
        IntegrationFrameworkLog: Record "Integration Framework Log INT";
        //BC Upgrade GUNREM01 Replaced Dotnet variables with XMLNode >>
        // XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // XMLCurrNodeRoot: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLCurrNode3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLDoc: XmlDocument;
        XMLCurrNodeRoot: XmlNode;
        XMLCurrNode: XmlNode;
        XMLCurrNode2: XmlNode;
        XMLCurrNode3: XmlNode;
        //BC Upgrade GUNREM01 Replaced Dotnet variables with XMLNode <<
        OutputStream: OutStream;
        UseDate: Date;
        Cust: Record Customer;
        Item: Record Item;
        //BC Upgrade GUNREM01  DIT Tables >>
        // SalesPromotion: Record "Sales Promotion Item Charge";
        // TempSalesPromotion: Record "Sales Promotion Item Charge" temporary;
        // PromotionGroup: Record "Drink Promotion Group";
        // PromotionGroupRel: Record "Drink Promotion Relation";
        //BC Upgrade GUNREM01  DIT Tables <<
        SalesPromotionSub: Record "Sales Prom Item Charge Sub FND";
        XMLFile: Text;
        ToFile: Text;
        FileMgt: Codeunit "File Management";
        Continue: Boolean;
    begin
        if B2BInterfaceSetup.GET and not B2BInterfaceSetup."Enable B2B Interfaces" then
            exit(false);

        if not InterfaceSetup.GET(B2BInterfaceSetup."B2B Promotion Interface") and not InterfaceSetup.Enabled then
            exit(false);
        //HEI.04>>
        InterfaceSetup.TESTFIELD(Direction, InterfaceSetup.Direction::Outbound);
        //HEI.04<<

        CompanyInfo.GET();
        //HEI.05>>
        SalesSetup.GET();
        //HEI.05<<

        UseDate := RunDate;
        if UseDate = 0D then
            UseDate := WORKDATE;

        //filters
        //BC Upgrade GUNREM01 Dependency with DIT >>
        // SalesPromotion.RESET;
        // SalesPromotion.COPYFILTERS(RunSalesPromotionFilters);
        // SalesPromotion.SETCURRENTKEY(
        //   "Source Type", "Source No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Location Code", "Variant Code",
        //   "Unit of Measure Code", "Shipment Method Code", "Calculate per", Type, "No.", "Minimum Quantity", "Minimum Quantity in HL", "Minimum Amount");

        // //HEI.07>>
        // if SalesPromotion.GETFILTER("Calculate per") = '' then
        //     SalesPromotion.SETFILTER("Calculate per", '%1|%2', SalesPromotion."Calculate per"::Item, SalesPromotion."Calculate per"::Order);
        // //HEI.07<<

        // if (SalesPromotion.GETFILTER("Starting Date") = '') and (SalesPromotion.GETFILTER("Ending Date") = '') then begin
        //     SalesPromotion.SETFILTER("Ending Date", '%1|>=%2', 0D, UseDate);
        //     SalesPromotion.SETRANGE("Starting Date", 0D, UseDate);
        // end;
        // if SalesPromotion.ISEMPTY then
        //     exit(false);
        //BC Upgrade GUNREM01 Dependency with DIT <<

        //start
        InsertFrameworkLog(IntegrationFrameworkLog, InterfaceSetup);
        //HEI.08>>
        CreateResponseXMLMsg(XMLDoc, XMLCurrNodeRoot, 'PromotionList');
        //HEI.08<<

        //loop
        //BC Upgrade GUNREM01 Dependency with DIT >>
        // if SalesPromotion.FINDSET() then
        //     repeat
        //         Continue := true;
        //         if SalesPromotion."Sales Type" = SalesPromotion."Sales Type"::"Customer Promotion Group" then begin
        //             if PromotionGroup.Code <> SalesPromotion."Sales Code" then begin
        //                 PromotionGroup.GET(PromotionGroup."Source Type"::Customer, SalesPromotion."Sales Code");
        //                 PromotionGroup.CALCFIELDS("No. of Relations");
        //             end;
        //             Continue := (PromotionGroup."No. of Relations" <> 0);
        //         end;
        //         if Continue then begin
        //             //HEI.08>>
        //             XMLCurrNode := XMLDoc.CreateElement('Promotion');
        //             XMLCurrNodeRoot.AppendChild(XMLCurrNode);
        //             //HEI.08<<

        //             CreateResponseHeaderMsg(XMLDoc, XMLCurrNode, XMLCurrNode2, SalesPromotion);
        //             CreateResponseGroupMsg(XMLDoc, XMLCurrNode, XMLCurrNode2, 'Items');

        //             case SalesPromotion."Source Type" of
        //                 SalesPromotion."Source Type"::Item:
        //                     begin
        //                         TempSalesPromotion := SalesPromotion;
        //                         //HEI.08>>
        //                         XMLCurrNode3 := XMLDoc.CreateElement('Item');
        //                         XMLCurrNode2.AppendChild(XMLCurrNode3);
        //                         CreateResponseLineMsg(XMLDoc, XMLCurrNode3, TempSalesPromotion, UseDate);
        //                         //HEI.08<<
        //                     end;
        //                 SalesPromotion."Source Type"::"Item Promotion Group":
        //                     begin
        //                         PromotionGroupRel.SETRANGE("Source Type", PromotionGroupRel."Source Type"::Item);
        //                         PromotionGroupRel.SETRANGE(Code, SalesPromotion."Source No.");
        //                         if PromotionGroupRel.FINDSET then
        //                             repeat
        //                                 TempSalesPromotion := SalesPromotion;
        //                                 TempSalesPromotion."Source Type" := TempSalesPromotion."Source Type"::Item;
        //                                 TempSalesPromotion."Source No." := PromotionGroupRel."Source No.";
        //                                 //HEI.08>>
        //                                 XMLCurrNode3 := XMLDoc.CreateElement('Item');
        //                                 XMLCurrNode2.AppendChild(XMLCurrNode3);
        //                                 CreateResponseLineMsg(XMLDoc, XMLCurrNode3, TempSalesPromotion, UseDate);
        //                             //HEI.08<<
        //                             until PromotionGroupRel.NEXT = 0;
        //                     end;
        //                 SalesPromotion."Source Type"::"All Items":
        //                     begin
        //                         TempSalesPromotion := SalesPromotion;
        //                         //HEI.08>>
        //                         XMLCurrNode3 := XMLDoc.CreateElement('Item');
        //                         XMLCurrNode2.AppendChild(XMLCurrNode3);
        //                         CreateResponseLineMsg(XMLDoc, XMLCurrNode3, TempSalesPromotion, UseDate);
        //                         //HEI.08<<
        //                     end;
        //                 SalesPromotion."Source Type"::"Multiple Sources":
        //                     begin
        //                         SalesPromotionSub.SETRANGE("Parent Source Type", SalesPromotion."Source Type");
        //                         SalesPromotionSub.SETRANGE("Parent Source No.", SalesPromotion."Source No.");
        //                         SalesPromotionSub.SETRANGE("Sales Type", SalesPromotion."Sales Type");
        //                         SalesPromotionSub.SETRANGE("Sales Code", SalesPromotion."Sales Code");
        //                         SalesPromotionSub.SETRANGE("Starting Date", SalesPromotion."Starting Date");
        //                         SalesPromotionSub.SETRANGE("Currency Code", SalesPromotion."Currency Code");
        //                         SalesPromotionSub.SETRANGE("Location Code", SalesPromotion."Location Code");
        //                         SalesPromotionSub.SETRANGE("Shipment Method Code", SalesPromotion."Shipment Method Code");
        //                         SalesPromotionSub.SETRANGE("Calculate per", SalesPromotion."Calculate per");
        //                         SalesPromotionSub.SETRANGE(Type, SalesPromotion.Type);
        //                         SalesPromotionSub.SETRANGE("No.", SalesPromotion."No.");
        //                         if SalesPromotionSub.FINDSET() then
        //                             repeat
        //                                 TempSalesPromotion.TRANSFERFIELDS(SalesPromotionSub);
        //                                 //HEI.08>>
        //                                 XMLCurrNode3 := XMLDoc.CreateElement('Item');
        //                                 XMLCurrNode2.AppendChild(XMLCurrNode3);
        //                                 CreateResponseLineMsg(XMLDoc, XMLCurrNode3, TempSalesPromotion, UseDate);
        //                             //HEI.08<<
        //                             until SalesPromotionSub.NEXT() = 0;
        //                     end;
        //             end;
        //         end;
        //     until SalesPromotion.NEXT() = 0;
        //BC Upgrade GUNREM01 Dependency with DIT <<
        UpdateFrameworkLog(IntegrationFrameworkLog, OutputStream);
        SaveXMLDocToOut(XMLDoc, OutputStream);
        IntegrationFrameworkLog.SendMessage;

        CLEAR(XMLDoc);
        //HEI.08>>
        CLEAR(XMLCurrNodeRoot);
        CLEAR(XMLCurrNode);
        CLEAR(XMLCurrNode2);
        CLEAR(XMLCurrNode3);
        //HEI.08<<
        CLEAR(OutputStream);
        exit(true);
    end;
    //BC Upgrade GUNREM01 -Dependency with DIT >>
    // local procedure CreateResponseHeaderMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; SalesPromotion: Record "Sales Promotion Item Charge");

    // var
    //     XMLDOMMgt: Codeunit "XML DOM Management";
    //     NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     PkeyText: Text;
    //     VirtoType: Option " ","MultiTier Escalated","Discount by Amount","Percentage Discount","Combo Deal","Flexi Combo","Cart Discount by Amount","Cart Percentage Discount","Percentage Off";
    // begin
    //     XMLCurrNode2 := XMLCurrNode;

    //     //PkeyText := ToStringPromotionKey(SalesPromotion);
    //     PkeyText := FORMAT(SalesPromotion."Record GUID", 0, 9);
    //     //HEI.03>>
    //     PkeyText := DELCHR(DELCHR(PkeyText, '<', '[{'), '>', '}]');
    //     //HEI.03<<
    //     XMLDOMMgt.AddElement(XMLCurrNode2, 'id', PkeyText, '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode2, 'Name', PkeyText + '_PR', '', NewChildNode);
    //     //HEI.02>>
    //     VirtoType := VirtoType::"MultiTier Escalated";
    //     XMLDOMMgt.AddElement(XMLCurrNode2, 'type', FORMAT(VirtoType), '', NewChildNode);
    //     //HEI.02<<
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'referenceCode','<str>','',NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode2, 'startDate', ToStringDateToDateTime(SalesPromotion."Starting Date"), '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode2, 'endDate', ToStringDateToDateTime(SalesPromotion."Ending Date"), '', NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'region','<str>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'promotionType','<str>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'priority','<integer>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'isExclusive','<bool>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'maxActivationCount','<>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'linkedId','<str>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'isActive','<bool>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'showOnStoreFront','<bool>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'isSet','<bool>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode2,'isConsignment','<bool>','',NewChildNode);
    //     //HEI.02>>
    //     XMLDOMMgt.AddElement(XMLCurrNode2, 'storeIds', FORMAT(CompanyInfo."Legal Entity Code"), '', NewChildNode);
    //     //HEI.02<<

    //     CLEAR(NewChildNode);
    // end;
    //BC Upgrade GUNREM01 -Dependency with DIT <<

    // local procedure CreateResponseGroupMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; ElementName: Text);
    local procedure CreateResponseGroupMsg(var XMLDoc: XmlDocument; var XMLCurrNode: XmlNode; var XMLCurrNode2: XmlNode; ElementName: Text); //BC Upgrade GUNREM01 Replaced Dotnet variables with MXL 

    var
        XMLDOMMgt: Codeunit "XML DOM Management";
        //  NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        NewChildNode: XmlNode;//BC Upgrade GUNREM01 Replaced Dotnet variables with MXL
        XMLElem: XmlElement;
    begin
        //BC Upgrade GUNREM01 Replaced code  using XML variables >>
        // XMLCurrNode2 := XMLDoc.CreateElement(ElementName);
        // XMLCurrNode.AppendChild(XMLCurrNode2);
        XMLDoc := XmlDocument.Create();
        XMLElem := XmlElement.Create(ElementName);
        XMLDoc.Add(XMLElem);
        //BC Upgrade GUNREM01 Replaced code using XML variables <<

    end;
    //BC Upgrade GUNREM01 Dependency with DIT >>
    // local procedure CreateResponseLineMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; SalesPromotion: Record "Sales Promotion Item Charge"; AsPerDate: Date);
    // var
    //     XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLCurrNode3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLCurrNode4: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLDOMMgt: Codeunit "XML DOM Management";
    //     NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     PromotionGroupRel: Record "Drink Promotion Relation";
    //     ItemPriceText: Text;
    // begin
    //     //HEI.07>>
    //     SalesPromotion.TESTFIELD("Source No.");
    //     if Item."No." <> SalesPromotion."Source No." then
    //         Item.GET(SalesPromotion."Source No.");
    //     if SalesPromotion."Unit of Measure Code" = '' then begin
    //         if Item."Sales Unit of Measure" <> '' then
    //             SalesPromotion."Unit of Measure Code" := Item."Sales Unit of Measure"
    //         else
    //             SalesPromotion."Unit of Measure Code" := Item."Base Unit of Measure";
    //     end;
    //     if SalesPromotion."Unit of Measure Code (Value)" = '' then begin
    //         SalesPromotion.TESTFIELD("No.");
    //         if Item."No." <> SalesPromotion."No." then
    //             Item.GET(SalesPromotion."No.");
    //         if Item."Sales Unit of Measure" <> '' then
    //             SalesPromotion."Unit of Measure Code (Value)" := Item."Sales Unit of Measure"
    //         else
    //             SalesPromotion."Unit of Measure Code (Value)" := Item."Base Unit of Measure";
    //     end;
    //     //HEI.07<<

    //     XMLCurrNode3 := XMLDoc.CreateElement('productConditions');
    //     XMLCurrNode.AppendChild(XMLCurrNode3);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'sku', SalesPromotion."Source No.", '', NewChildNode);
    //     //HEI.06>>
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'unitOfMeasure', SalesPromotion."Unit of Measure Code", '', NewChildNode);
    //     //HEI.06<<
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'minQuantity', ToStringDecimal(SalesPromotion."Minimum Quantity"), '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'maxQuantity', ToStringDecimal(SalesPromotion."Maximum Free Quantity"), '', NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode3,'startDate','<datetime>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode3,'endDate','<datetime>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode3,'totalQuantity','<0>','',NewChildNode);
    //     CLEAR(NewChildNode);

    //     XMLCurrNode3 := XMLDoc.CreateElement('effects');
    //     XMLCurrNode.AppendChild(XMLCurrNode3);
    //     XMLCurrNode4 := XMLDoc.CreateElement('discount');
    //     XMLCurrNode3.AppendChild(XMLCurrNode4);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'absoluteAmount','<0>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'relativeAmount','<0>','',NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode4, 'sku', SalesPromotion."Source No.", '', NewChildNode);
    //     //HEI.06>>
    //     XMLDOMMgt.AddElement(XMLCurrNode4, 'unitOfMeasure', SalesPromotion."Unit of Measure Code", '', NewChildNode);
    //     //HEI.06<<
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'cap','<0>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'quantity',<0>,'',NewChildNode);
    //     // CLEAR(NewChildNode);

    //     XMLCurrNode4 := XMLDoc.CreateElement('freeOfCharge');
    //     XMLCurrNode3.AppendChild(XMLCurrNode4);
    //     XMLDOMMgt.AddElement(XMLCurrNode4, 'sku', SalesPromotion."No.", '', NewChildNode);
    //     //HEI.06>>
    //     XMLDOMMgt.AddElement(XMLCurrNode4, 'unitOfMeasure', SalesPromotion."Unit of Measure Code (Value)", '', NewChildNode);
    //     //HEI.06<<
    //     XMLDOMMgt.AddElement(XMLCurrNode4, 'quantity', ToStringDecimal(SalesPromotion."Free Quantity"), '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode4, 'maxMultiplier', ToStringDecimal(SalesPromotion."Multiple Quantity"), '', NewChildNode);
    //     CLEAR(NewChildNode);

    //     //ItemPriceText:= '0';
    //     //SalesPromotion.EvaluateUnitPriceText(ItemPriceText,AsPerDate);

    //     // XMLCurrNode4 := XMLDoc.CreateElement('promoOnPromo');
    //     // XMLCurrNode3.AppendChild(XMLCurrNode4);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'sku','<str>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'minQuantity','<0>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'maxQuantity','<0>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'absoluteAmount','<0>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'relativeAmount','<0>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'freeOfChargeSku','<str>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode4,'freeOfChargeQuantity','<0>','',NewChildNode);
    //     // CLEAR(NewChildNode);

    //     XMLCurrNode3 := XMLDoc.CreateElement('customerConditions');
    //     XMLCurrNode.AppendChild(XMLCurrNode3);
    //     // XMLDOMMgt.AddElement(XMLCurrNode3,'isFirstTimeBuyer','<bool>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode3,'outletId','<str>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode3,'isDeleted','<bool>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode3,'startDate','<datetime>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode3,'endDate','<datetime>','',NewChildNode);
    //     // XMLDOMMgt.AddElement(XMLCurrNode3,'userGroups','<str-list>','',NewChildNode);
    //     // CLEAR(NewChildNode);

    //     case SalesPromotion."Sales Type" of
    //         SalesPromotion."Sales Type"::Customer:
    //             begin
    //                 //HEI.05>>
    //                 //HEI.09>>
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'isEveryone', ToStringBoolean(false), '', NewChildNode);
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'userGroup', '', '', NewChildNode);
    //                 //HEI.09<<
    //                 SalesPromotion.TESTFIELD("Sales Code");
    //                 Customer.GET(SalesPromotion."Sales Code");
    //                 if SalesSetup."Bill-to/Sell-to Prices Calc." = SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to" then begin
    //                     Customer2.SETRANGE("Bill-to Customer No.", Customer."No.");
    //                     if Customer2.ISEMPTY then
    //                         XMLDOMMgt.AddElement(XMLCurrNode3, 'outletId', Customer."No.", '', NewChildNode)
    //                     else
    //                         if Customer2.FINDSET then
    //                             repeat
    //                                 XMLDOMMgt.AddElement(XMLCurrNode3, 'outletId', Customer2."No.", '', NewChildNode);
    //                             until Customer2.NEXT = 0;
    //                 end else
    //                     XMLDOMMgt.AddElement(XMLCurrNode3, 'outletId', Customer."No.", '', NewChildNode);
    //                 //HEI.09
    //                 //HEI.05<<
    //             end;
    //         SalesPromotion."Sales Type"::"Customer Promotion Group":
    //             begin
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'isEveryone', ToStringBoolean(false), '', NewChildNode);
    //                 //HEI.09>>
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'userGroup', SalesPromotion."Sales Code", '', NewChildNode);
    //                 // PromotionGroupRel.SETRANGE("Source Type",PromotionGroupRel."Source Type"::Customer);
    //                 // PromotionGroupRel.SETRANGE(Code,SalesPromotion."Sales Code");
    //                 // IF PromotionGroupRel.FINDSET THEN
    //                 //  REPEAT
    //                 //    //HEI.05>>
    //                 //    IF SalesSetup."Bill-to/Sell-to Prices Calc." = SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to" THEN BEGIN
    //                 //      Customer2.SETRANGE("Bill-to Customer No.",PromotionGroupRel."Source No.");
    //                 //      IF Customer2.ISEMPTY THEN
    //                 //        XMLDOMMgt.AddElement(XMLCurrNode3,'outletId',PromotionGroupRel."Source No.",'',NewChildNode)
    //                 //      ELSE
    //                 //        IF Customer2.FINDSET THEN
    //                 //          REPEAT
    //                 //            XMLDOMMgt.AddElement(XMLCurrNode3,'outletId',Customer2."No.",'',NewChildNode);
    //                 //          UNTIL Customer2.NEXT = 0;
    //                 //    END ELSE
    //                 //      XMLDOMMgt.AddElement(XMLCurrNode3,'outletId',PromotionGroupRel."Source No.",'',NewChildNode);
    //                 //    //HEI.05<<
    //                 //  UNTIL PromotionGroupRel.NEXT = 0;
    //                 //HEI.09<<
    //             end;
    //         SalesPromotion."Sales Type"::"All Customers":
    //             begin
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'isEveryone', ToStringBoolean(true), '', NewChildNode);
    //                 //XMLDOMMgt.AddElement(XMLCurrNode3,'outletId','','',NewChildNode);
    //             end;
    //     end;
    // end;
    //BC Upgrade GUNREM01 Dependency with DIT <<

    //  local procedure CreateResponseXMLMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; MainNodeName: Text);
    local procedure CreateResponseXMLMsg(var XMLDoc: XmlDocument; var XMLCurrNode: XmlNode; MainNodeName: Text);

    var
        // ProcessingInstruction: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlProcessingInstruction";
        ProcessingInstruction: XmlProcessingInstruction;
        XmlDecl: XmlDeclaration;
        XMLElem: XmlElement;
    begin
        //BC Upgrade GUNREM01 replaced code using XML var >>
        // XMLDoc := XMLDoc.XmlDocument;
        // XMLCurrNode := XMLDoc.CreateElement(MainNodeName);
        // XMLDoc.AppendChild(XMLCurrNode);
        // ProcessingInstruction := XMLDoc.CreateProcessingInstruction('?xml', 'version="1.0" encoding="UTF-8"?');


        MainNodeName := 'Root';
        XmlDoc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XmlDecl);
        XMLElem := XmlElement.Create(MainNodeName);
        XmlDoc.Add(XMLElem);

        //BC Upgrade GUNREM01 replaced code using XML var <<
    end;

    //BC Upgrade GUNREM01 Dependency with DIT table >>
    // local procedure ToStringPromotionKey(CurrRec: Record "Sales Promotion Item Charge") Result: Text[127];
    // var
    //     Space: Text[1];
    // begin
    //     //PrimaryKey
    //     Space := '|';
    //     Result := ToStringOption(CurrRec."Source Type") + Space
    //               + FORMAT(CurrRec."Source No.") + Space
    //               + ToStringOption(CurrRec."Sales Type") + Space
    //               + FORMAT(CurrRec."Sales Code") + Space
    //               + ToStringDate(CurrRec."Starting Date") + Space
    //               + FORMAT(CurrRec."Currency Code") + Space
    //               + FORMAT(CurrRec."Location Code") + Space
    //               + FORMAT(CurrRec."Variant Code") + Space
    //               + FORMAT(CurrRec."Unit of Measure Code") + Space
    //               + FORMAT(CurrRec."Shipment Method Code") + Space
    //               + ToStringOption(CurrRec."Calculate per") + Space
    //               + ToStringOption(CurrRec.Type) + Space
    //               + FORMAT(CurrRec."No.") + Space
    //               + ToStringDecimal(CurrRec."Minimum Quantity") + Space
    //               + ToStringDecimal(CurrRec."Minimum Quantity in HL") + Space
    //               + ToStringDecimal(CurrRec."Minimum Amount");
    // end;
    //BC Upgrade GUNREM01 Dependency with DIT table <<
    local procedure InsertFrameworkLog(var IntegrationFrameworkLog: Record "Integration Framework Log INT"; InterfaceSetup: Record "Interface Setup INT");
    begin
        InterfaceSetup.TESTFIELD(Code);
        IntegrationFrameworkLog.INIT;
        IntegrationFrameworkLog."Interface Code" := InterfaceSetup.Code;
        IntegrationFrameworkLog."Request Sync. Date/Time" := CURRENTDATETIME;
        IntegrationFrameworkLog."Call Type" := InterfaceSetup."Call Type";
        IntegrationFrameworkLog.INSERT(true);
    end;

    local procedure UpdateFrameworkLog(var IntegrationFrameworkLog: Record "Integration Framework Log INT"; var OutputStream: OutStream);
    begin
        IntegrationFrameworkLog.CALCFIELDS("Response File");
        IntegrationFrameworkLog."Response File".CREATEOUTSTREAM(OutputStream);
        IntegrationFrameworkLog."Response Date/Time" := CURRENTDATETIME;
        IntegrationFrameworkLog.MODIFY(true);
    end;

    //  local procedure SaveXMLDocToOut(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var OutputStream: OutStream);
    local procedure SaveXMLDocToOut(var XMLDoc: XmlDocument; var OutputStream: OutStream);

    var
        TempBigText: BigText;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
        Request: BigText;
    //BC Upgrade GUNREM01 <<
    begin
        // TempBigText.ADDTEXT(XMLDoc.InnerXml);
        // TempBigText.WRITE(OutputStream);
        // CLEAR(TempBigText);
        RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
        XMLDoc.WriteTo(RespOut);
        RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
        RespIn.ReadText(RespText);
        Request.AddText(RespText);
    end;

    local procedure ToStringDate(Value: Date): Text;
    begin
        exit(FORMAT(Value, 0, 9));
    end;

    local procedure ToStringDateTime(Value: DateTime): Text;
    begin
        exit(FORMAT(Value, 0, 9));
    end;

    local procedure ToStringDateToDateTime(Value: Date): Text;
    begin
        if Value = 0D then
            exit('');
        exit(FORMAT(CREATEDATETIME(Value, 120000T), 0, 9));
    end;

    local procedure ToStringBoolean(Value: Boolean): Text;
    begin
        exit(FORMAT(Value, 0, 9));
    end;

    local procedure ToStringOption(Value: Option): Text;
    begin
        exit(FORMAT(Value, 0, 2));
    end;

    local procedure ToStringDecimal(Value: Decimal): Text;
    begin
        //HEI.04>>
        exit(FORMAT(Value, 0, 9));
        //HEI.04<<
    end;

    local procedure ToStringDecimalInt(Value: Decimal): Text;
    var
        IntValue: Integer;
    begin
        IntValue := ROUND(Value, 1);
        //HEI.04>>
        exit(FORMAT(IntValue, 0, 9));
        //HEI.04<<
    end;
}

