codeunit 58108 "Generic Web Service Client"
{
    //BC Upgrade GUNREM01 Old ID-50143
    // HEI.01 FDD-HT1398 CHG2065738 IBM.GUNERE01 14.07.2020 # new codeunit created

    //BC Upgrade GUNREM01
    //# Commenetd whole codeunit and written all procedure, becuase this whole code unit is related to web service. 
    //# In NAV they used Dotnet variables those are supproted In BC.
    //# using Https and xml document whole codeunit is updated.
    //# Created every procedure based on NAV

    trigger OnRun();
    begin
    end;

    //     var
    //         Assembly: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.Assembly";
    //         ServiceType: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Type";
    //         EntityType: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Type";
    //         FilterType: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Type";
    //         FieldsType: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Type";
    //         LineType: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Type";
    //         Entity: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Line: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Entities: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         Filters: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Collections.Generic.List`1";
    //         Lines: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Collections.Generic.List`1";
    //         LinesProperty: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.PropertyInfo";
    //         Activator: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Activator";
    //         _Read: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         _ReadByRecId: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         _ReadMultiple: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         _IsUpdated: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         _GetRecIdFromKey: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         _Create: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         _CreateMultiple: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         _Update: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         _UpdateMultiple: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         _Delete: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.MethodInfo";
    //         Text001: Label '%1 is not allowed for the %2 web service.';
    //         ServiceUri: Text;
    //         Name: Text;
    //         Text002: Label '%1 is not initialized.';
    //         Text003: Label '%1 does not have a definition for the %2 field.';
    //         AssertAllowedOperationName: Text;
    //         GetNull: Boolean;
    //         Text004: Label 'The service is not a Microsoft Dynamics NAV page service.\\%1';
    //         Cursor: Integer;
    //         Text005: Label 'Field %1 does not exist for the %2 web service.';
    //         Text006: Label '%1 does not have lines.';
    //         Text007: Label 'Line';
    //         Text008: Label 'Unhandled type: %1.';

    //     procedure CONNECT(Uri: Text);
    //     var
    //         WebRequest: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.WebRequest";
    //         RequestStream: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.Stream";
    //         ServiceDescription: DotNet "'System.Web.Services, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.System.Web.Services.Description.ServiceDescription";
    //         ServiceDescriptionImporter: DotNet "'System.Web.Services, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.System.Web.Services.Description.ServiceDescriptionImporter";
    //         ServiceDescriptionImportWarnings: DotNet "'System.Web.Services, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.System.Web.Services.Description.ServiceDescriptionImportWarnings";
    //         CodeNamespace: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.CodeDom.CodeNamespace";
    //         CodeCompileUnit: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.CodeDom.CodeCompileUnit";
    //         CodeCompileUnitArray: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         CodeGenerationOptions: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.CodeDom.Compiler.CodeGeneratorOptions";
    //         CompilerParameters: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.CodeDom.Compiler.CompilerParameters";
    //         CompilerResults: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.CodeDom.Compiler.CompilerResults";
    //         StringWriter: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.StringWriter";
    //         CultureInfo: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Globalization.CultureInfo";
    //         CSharpCodeProvider: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.Microsoft.CSharp.CSharpCodeProvider";
    //         AssemblyReferences: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         String: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    //     begin
    //         ServiceUri := Uri;

    //         WebRequest := WebRequest.Create(ServiceUri);
    //         Authenticate(WebRequest);
    //         RequestStream := WebRequest.GetResponse().GetResponseStream();

    //         ServiceDescription := ServiceDescription.Read(RequestStream);
    //         ServiceDescriptionImporter := ServiceDescriptionImporter.ServiceDescriptionImporter();
    //         ServiceDescriptionImporter.AddServiceDescription(ServiceDescription, '', '');
    //         ServiceDescriptionImporter.ProtocolName := 'SOAP';
    //         ServiceDescriptionImporter.CodeGenerationOptions := 1; // GenerateProperties

    //         CodeNamespace := CodeNamespace.CodeNamespace();
    //         CodeCompileUnit := CodeCompileUnit.CodeCompileUnit();
    //         CodeCompileUnit.Namespaces.Add(CodeNamespace);

    //         ServiceDescriptionImportWarnings := ServiceDescriptionImporter.Import(CodeNamespace, CodeCompileUnit);
    //         if ServiceDescriptionImportWarnings = 0 then begin
    //             StringWriter := StringWriter.StringWriter(CultureInfo.CurrentCulture);
    //             CSharpCodeProvider := CSharpCodeProvider.CSharpCodeProvider();
    //             CSharpCodeProvider.GenerateCodeFromNamespace(CodeNamespace, StringWriter, CodeGenerationOptions.CodeGeneratorOptions);

    //             AssemblyReferences := AssemblyReferences.CreateInstance(GETDOTNETTYPE(String), 2);
    //             AssemblyReferences.SetValue('System.Web.Services.dll', 0);
    //             AssemblyReferences.SetValue('System.Xml.dll', 1);

    //             CompilerParameters := CompilerParameters.CompilerParameters(AssemblyReferences);
    //             CompilerParameters.GenerateExecutable := false;
    //             CompilerParameters.GenerateInMemory := true;
    //             CompilerParameters.TreatWarningsAsErrors := true;
    //             CompilerParameters.WarningLevel := 4;

    //             CodeCompileUnitArray := CodeCompileUnitArray.CreateInstance(GETDOTNETTYPE(CodeCompileUnit), 1);
    //             CodeCompileUnitArray.SetValue(CodeCompileUnit, 0);

    //             CompilerResults := CSharpCodeProvider.CompileAssemblyFromDom(CompilerParameters, CodeCompileUnitArray);
    //             Assembly := CompilerResults.CompiledAssembly;

    //             DetectTypes(ServiceDescription.Services.Item(0).Name);

    //             RESET;
    //         end;
    //     end;

    //     local procedure DetectTypes(ServiceName: Text);
    //     var
    //         Types: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         Type: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Type";
    //         TypeName: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    //         PropertyInfo: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.PropertyInfo";
    //         Properties: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         IsPageService: Boolean;
    //         i: Integer;
    //     begin
    //         CLEAR(LineType);
    //         CLEAR(ServiceType);
    //         CLEAR(FilterType);
    //         CLEAR(FieldsType);
    //         CLEAR(LinesProperty);

    //         Types := Assembly.ExportedTypes;
    //         if Types.Length > 1 then begin
    //             for i := 0 to Types.Length - 1 do begin
    //                 Type := Types.GetValue(i);
    //                 TypeName := Type.Name;
    //                 case true of
    //                     TypeName.EndsWith('_Line'):
    //                         LineType := Type;
    //                     TypeName.EndsWith('_Service'):
    //                         ServiceType := Type;
    //                     TypeName.EndsWith('_Filter'):
    //                         FilterType := Type;
    //                     TypeName.EndsWith('_Fields'):
    //                         FieldsType := Type;
    //                 end;
    //             end;

    //             if not ISNULL(ServiceType) then begin
    //                 TypeName := ServiceType.Name;
    //                 Name := TypeName.Substring(0, TypeName.Length - 8);
    //                 EntityType := Assembly.GetType(Name);

    //                 if HASLINES then begin
    //                     Properties := EntityType.GetProperties;
    //                     for i := 0 to Properties.Length - 1 do begin
    //                         PropertyInfo := Properties.GetValue(i);
    //                         Type := PropertyInfo.PropertyType;
    //                         if Type.Name = LineType.Name + '[]' then
    //                             LinesProperty := PropertyInfo;
    //                     end;
    //                 end;

    //                 _Read := ServiceType.GetMethod('Read');
    //                 _ReadByRecId := ServiceType.GetMethod('ReadByRecId');
    //                 _ReadMultiple := ServiceType.GetMethod('ReadMultiple');
    //                 _IsUpdated := ServiceType.GetMethod('IsUpdated');
    //                 _GetRecIdFromKey := ServiceType.GetMethod('GetRecIdFromKey');
    //                 _Create := ServiceType.GetMethod('Create');
    //                 _CreateMultiple := ServiceType.GetMethod('CreateMultiple');
    //                 _Update := ServiceType.GetMethod('Update');
    //                 _UpdateMultiple := ServiceType.GetMethod('UpdateMultiple');
    //                 _Delete := ServiceType.GetMethod('Delete');
    //                 if not (ISNULL(_Read) and ISNULL(_ReadMultiple) and ISNULL(_IsUpdated)) then
    //                     IsPageService := true;
    //             end;
    //         end;

    //         if not IsPageService then
    //             ERROR(Text004, ServiceUri);
    //     end;

    //     procedure HASLINES(): Boolean;
    //     begin
    //         exit(not ISNULL(LineType));
    //     end;

    //     procedure INSERTALLOWED(): Boolean;
    //     begin
    //         AssertAllowedOperationName := 'Insert';
    //         exit(not ISNULL(_Create));
    //     end;

    //     procedure MODIFYALLOWED(): Boolean;
    //     begin
    //         AssertAllowedOperationName := 'Modify';
    //         exit(not ISNULL(_Update));
    //     end;

    //     procedure DELETEALLOWED(): Boolean;
    //     begin
    //         AssertAllowedOperationName := 'Delete';
    //         exit(not ISNULL(_Delete));
    //     end;

    //     local procedure AssertAllowed(Allowed: Boolean);
    //     begin
    //         if not Allowed then
    //             ERROR(Text001, AssertAllowedOperationName, Name);
    //     end;

    //     local procedure AssertInitialized();
    //     begin
    //         if ISNULL(Entity) then
    //             ERROR(Text002, Name);
    //     end;

    //     local procedure AssertHasLines();
    //     begin
    //         if not HASLINES then
    //             ERROR(Text006, Name);
    //     end;

    //     local procedure AssertLineInitialized();
    //     begin
    //         if ISNULL(Line) then
    //             ERROR(Text002, Text007);
    //     end;

    //     procedure INIT();
    //     var
    //         String: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    //     begin
    //         Entity := Activator.CreateInstance(EntityType);
    //         Lines := Lines.List;
    //         CLEAR(Entities);
    //         RESET;
    //     end;

    //     procedure NEWLINE();
    //     var
    //         LinesArray: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         i: Integer;
    //     begin
    //         AssertHasLines;
    //         Line := Activator.CreateInstance(LineType);
    //         Lines.Add(Line);

    //         LinesArray := LinesArray.CreateInstance(LineType, Lines.Count);
    //         for i := 0 to Lines.Count - 1 do
    //             LinesArray.SetValue(Lines.Item(i), i);

    //         LinesProperty.SetValue(Entity, LinesArray);
    //     end;

    //     procedure CREATE();
    //     var
    //         Service: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         "Object": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Parameters: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //     begin
    //         AssertAllowed(INSERTALLOWED);
    //         AssertInitialized;

    //         Parameters := Parameters.CreateInstance(GETDOTNETTYPE(Object), _Create.GetParameters().Length);
    //         Parameters.SetValue(Entity, Parameters.Length - 1);

    //         Service := Activator.CreateInstance(ServiceType);
    //         Authenticate(Service);

    //         _Create.Invoke(Service, Parameters);
    //         Entity := Parameters.GetValue(Parameters.Length - 1);
    //     end;

    //     procedure UPDATE();
    //     var
    //         Service: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         "Object": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Parameters: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //     begin
    //         AssertAllowed(MODIFYALLOWED);
    //         AssertInitialized;

    //         Parameters := Parameters.CreateInstance(GETDOTNETTYPE(Object), _Create.GetParameters().Length);
    //         Parameters.SetValue(Entity, Parameters.Length - 1);

    //         Service := Activator.CreateInstance(ServiceType);
    //         Authenticate(Service);

    //         _Update.Invoke(Service, Parameters);
    //         Entity := Parameters.GetValue(Parameters.Length - 1);
    //     end;

    //     procedure UPDATEMULTIPLE();
    //     var
    //         Service: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         "Object": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Parameters: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //     begin
    //         AssertAllowed(MODIFYALLOWED);
    //         AssertInitialized;

    //         Parameters := Parameters.CreateInstance(GETDOTNETTYPE(Object), _Create.GetParameters().Length);
    //         Parameters.SetValue(Entity, Parameters.Length - 1);

    //         Service := Activator.CreateInstance(ServiceType);
    //         Authenticate(Service);

    //         _Update.Invoke(Service, Parameters);
    //         Entity := Parameters.GetValue(Parameters.Length - 1);
    //     end;

    //     procedure DELETE();
    //     var
    //         Service: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         "Object": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Parameters: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         "Key": Text;
    //     begin
    //         AssertAllowed(DELETEALLOWED);
    //         AssertInitialized;

    //         Key := GETVALUE('Key');
    //         if (Key = '') and GetNull then
    //             READ;

    //         Parameters := Parameters.CreateInstance(GETDOTNETTYPE(Object), 1);
    //         Parameters.SetValue(GETVALUE('Key'), 0);

    //         Service := Activator.CreateInstance(ServiceType);
    //         Authenticate(Service);

    //         _Delete.Invoke(Service, Parameters);
    //     end;

    //     procedure READ();
    //     var
    //         Service: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         "Object": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Parameters: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         ParameterInfo: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.ParameterInfo";
    //         PropertyInfo: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.PropertyInfo";
    //         i: Integer;
    //     begin
    //         AssertInitialized;

    //         Parameters := Parameters.CreateInstance(GETDOTNETTYPE(Object), _Read.GetParameters().Length);
    //         for i := 0 to Parameters.Length - 1 do begin
    //             ParameterInfo := _Read.GetParameters().GetValue(i);
    //             PropertyInfo := EntityType.GetProperty(ParameterInfo.Name);
    //             Parameters.SetValue(PropertyInfo.GetValue(Entity), i);
    //         end;

    //         Service := Activator.CreateInstance(ServiceType);
    //         Authenticate(Service);

    //         Entity := _Read.Invoke(Service, Parameters);
    //         CLEAR(Entities);
    //     end;

    //     procedure READMULTIPLE(): Boolean;
    //     var
    //         Service: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         "Object": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Parameters: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         ParameterInfo: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.ParameterInfo";
    //         ReadFilters: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         NullString: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    //         i: Integer;
    //     begin
    //         ReadFilters := ReadFilters.CreateInstance(FilterType, Filters.Count);
    //         for i := 0 to Filters.Count - 1 do
    //             ReadFilters.SetValue(Filters.Item(i), i);

    //         Parameters := Parameters.CreateInstance(GETDOTNETTYPE(Object), 3);
    //         Parameters.SetValue(ReadFilters, 0);
    //         Parameters.SetValue(NullString, 1);
    //         Parameters.SetValue(0, 2);

    //         Service := Activator.CreateInstance(ServiceType);
    //         Authenticate(Service);

    //         Entities := _ReadMultiple.Invoke(Service, Parameters);
    //         Cursor := 0;

    //         if Entities.Length > 0 then begin
    //             Cursor := 0;
    //             NEXT;
    //             exit(true);
    //         end else
    //             exit(false);
    //     end;

    //     procedure RESET();
    //     begin
    //         Filters := Filters.List;
    //     end;

    //     procedure NEXT(): Integer;
    //     begin
    //         if Cursor < Entities.Length then begin
    //             Entity := Entities.GetValue(Cursor);
    //             Cursor := Cursor + 1;
    //             exit(1);
    //         end else
    //             exit(0);
    //     end;

    //     procedure SETFILTER(FieldName: Text; Criteria: Text);
    //     var
    //         EnumValues: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         "Filter": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         "Field": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Enum: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Enum";
    //         PropertyInfo: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.PropertyInfo";
    //         i: Integer;
    //         FieldExists: Boolean;
    //     begin
    //         EnumValues := Enum.GetValues(FieldsType);
    //         while (i < EnumValues.Length) and (not FieldExists) do begin
    //             if FORMAT(EnumValues.GetValue(i)) = FieldName then
    //                 FieldExists := true;
    //             i := i + 1;
    //         end;
    //         if not FieldExists then
    //             ERROR(Text005, FieldName, Name);
    //         Field := Enum.Parse(FieldsType, FieldName);

    //         Filter := Activator.CreateInstance(FilterType);
    //         PropertyInfo := FilterType.GetProperty('Field');
    //         PropertyInfo.SetValue(Filter, Field);
    //         PropertyInfo := FilterType.GetProperty('Criteria');
    //         PropertyInfo.SetValue(Filter, Criteria);
    //         Filters.Add(Filter);
    //     end;

    //     procedure SetObjectValue("Field": Text; Value: Variant; Target: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object");
    //     var
    //         PropertyInfo: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.PropertyInfo";
    //         Enum: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Enum";
    //         "Object": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Type: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Type";
    //         EnumValues: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //         ValueBool: Boolean;
    //         ValueInt: Integer;
    //         ValueText: Text;
    //         ValueDecimal: Decimal;
    //         ValueDateTime: DateTime;
    //     begin
    //         Type := Target.GetType();
    //         PropertyInfo := Type.GetProperty(Field);
    //         if ISNULL(PropertyInfo) then
    //             ERROR(Text003, Type.Name, Field);

    //         if PropertyInfo.PropertyType.BaseType.FullName = 'System.Enum' then begin
    //             if Value.ISINTEGER then begin
    //                 ValueInt := Value;
    //                 EnumValues := Enum.GetValues(PropertyInfo.PropertyType);
    //                 ValueText := FORMAT(EnumValues.GetValue(ValueInt));
    //             end else
    //                 ValueText := Value;
    //             Object := Enum.Parse(PropertyInfo.PropertyType, ValueText);
    //             PropertyInfo.SetValue(Target, Object);
    //         end else begin
    //             case PropertyInfo.PropertyType.FullName of
    //                 'System.String':
    //                     begin
    //                         ValueText := Value;
    //                         PropertyInfo.SetValue(Target, ValueText);
    //                     end;
    //                 'System.Decimal':
    //                     begin
    //                         ValueDecimal := Value;
    //                         PropertyInfo.SetValue(Target, ValueDecimal);
    //                     end;
    //                 'System.DateTime':
    //                     begin
    //                         ValueDateTime := Value;
    //                         PropertyInfo.SetValue(Target, ValueDateTime);
    //                     end;
    //                 'System.Int32':
    //                     begin
    //                         ValueInt := Value;
    //                         PropertyInfo.SetValue(Target, ValueInt);
    //                     end;
    //                 'System.Boolean':
    //                     begin
    //                         ValueBool := Value;
    //                         PropertyInfo.SetValue(Target, ValueBool);
    //                     end;
    //                 else
    //                     ERROR(Text008, PropertyInfo.PropertyType.FullName);
    //             end;
    //         end;

    //         PropertyInfo := Type.GetProperty(Field + 'Specified');
    //         if not ISNULL(PropertyInfo) then
    //             PropertyInfo.SetValue(Target, true);
    //     end;

    //     procedure GetObjectValue("Field": Text; Source: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object"): Text;
    //     var
    //         PropertyInfo: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.PropertyInfo";
    //         "Object": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //         Type: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Type";
    //     begin
    //         GetNull := false;
    //         Type := Source.GetType();

    //         PropertyInfo := Type.GetProperty(Field);
    //         if ISNULL(PropertyInfo) then
    //             ERROR(Text003, Type.Name, Field);

    //         if not ISNULL(Source) then begin
    //             Object := PropertyInfo.GetValue(Source);
    //             if not ISNULL(Object) then
    //                 exit(Object.ToString());
    //         end;

    //         GetNull := true;
    //         exit('');
    //     end;

    //     procedure SETVALUE("Field": Text; Value: Variant);
    //     begin
    //         SetObjectValue(Field, Value, Entity);
    //     end;

    //     procedure GETVALUE("Field": Text): Text;
    //     var
    //         PropertyInfo: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Reflection.PropertyInfo";
    //         "Object": DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    //     begin
    //         exit(GetObjectValue(Field, Entity));
    //     end;

    //     procedure SETLINEVALUE("Field": Text; Value: Variant);
    //     begin
    //         SetObjectValue(Field, Value, Line);
    //     end;

    //     procedure GETLINEVALUE("Field": Text): Text;
    //     begin
    //         exit(GetObjectValue(Field, Line));
    //     end;

    //     local procedure Authenticate(ServiceInstance: DotNet "'System.Web.Services, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.System.Web.Services.Protocols.SoapHttpClientProtocol");
    //     var
    //         WebServicesSetup: Record "Common Source Sharing Setup";
    //         Client: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.WebRequest";
    //         Credential: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.NetworkCredential";
    //     begin
    //         with WebServicesSetup do begin
    //             if GET then
    //                 ServiceInstance.Credentials := Credential.NetworkCredential("WS Username", "WS Password")
    //             else
    //                 ServiceInstance.UseDefaultCredentials := true;
    //         end;
    //     end;

    //BC Upgrade GUNREM01 >>

    var
        ServiceUri: Text;
        ServiceNamespace: Text;
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        Headers: HttpHeaders;

        WsdlXml: XmlDocument;
        RequestXml: XmlDocument;
        ResponseXml: XmlDocument;
        EnvelopeXml: XmlDocument;

        RootElement: XmlElement;
        BodyElement: XmlElement;
        OperationElement: XmlElement;
        FieldEleme: XmlElement;

        NodeList: XmlNodeList;
        Node: XmlNode;
        XMlElem: XmlElement;

        LineTypeName: Text;
        ServiceTypeName: Text;
        FilterTypeName: Text;
        FieldsTypeName: Text;
        EntityTypeName: Text;

        ReadOperation: Text;
        ReadMultipleOperation: Text;
        CreateOperation: Text;
        UpdateOperation: Text;
        DeleteOperation: Text;
        ReadByRecIdOperation: Text;
        IsUpdatedOperation: Text;
        IsPageServiceDetected: Boolean;
        GetRecIdFromKeyOperation: Text;
        CreateMultipleOperation: Text;
        UpdateMultipleOperation: Text;
        IsInitialized: Boolean;

        ErrNotConnected: Label 'Service not connected.';
        ErrNotInitialized: Label 'Entity not initialized.';
        ErrOperationNotAllowed: Label '%1 operation not supported.';
        ErrHttpError: Label 'HTTP Error: %1';


    procedure Connect(Uri: Text)
    var
        WsdlText: Text;
    begin
        ServiceUri := Uri;

        Client.Get(ServiceUri, ResponseMessage);

        if not ResponseMessage.IsSuccessStatusCode then
            Error(ErrHttpError, ResponseMessage.HttpStatusCode);

        ResponseMessage.Content.ReadAs(WsdlText);

        XmlDocument.ReadFrom(WsdlText, WsdlXml);

        DetectTypes();
    end;


    local procedure DetectTypes()
    var
        NodeName: Text;
        XmlDoc: XmlDocument;
    begin
        Clear(LineTypeName);
        Clear(ServiceTypeName);
        Clear(FilterTypeName);
        Clear(FieldsTypeName);
        Clear(EntityTypeName);
        Clear(IsPageServiceDetected);


        WsdlXml.SelectNodes('//*[local-name()="complexType"]', NodeList);

        foreach Node in NodeList do begin

            NodeName := GetAttribute(Node, 'name');

            if NodeName.EndsWith('_Line') then
                LineTypeName := NodeName;

            if NodeName.EndsWith('_Service') then
                ServiceTypeName := NodeName;

            if NodeName.EndsWith('_Filter') then
                FilterTypeName := NodeName;

            if NodeName.EndsWith('_Fields') then
                FieldsTypeName := NodeName;
        end;

        if ServiceTypeName <> '' then
            EntityTypeName := ServiceTypeName.Substring(0, StrLen(ServiceTypeName) - 8);

        DetectOperations();

        if not IsPageServiceDetected then
            Error('Not a valid Business Central Page Service');
    end;

    local procedure DetectOperations()
    var
        MethodName: Text;
    begin
        Clear(ReadOperation);
        Clear(ReadByRecIdOperation);
        Clear(ReadMultipleOperation);
        Clear(IsUpdatedOperation);
        Clear(GetRecIdFromKeyOperation);
        Clear(CreateOperation);
        Clear(CreateMultipleOperation);
        Clear(UpdateOperation);
        Clear(UpdateMultipleOperation);
        Clear(DeleteOperation);

        WsdlXml.SelectNodes('//*[local-name()="operation"]', NodeList);

        foreach Node in NodeList do begin

            MethodName := GetAttribute(Node, 'name');

            case MethodName of

                'Read':
                    ReadOperation := MethodName;

                'ReadByRecId':
                    ReadByRecIdOperation := MethodName;

                'ReadMultiple':
                    ReadMultipleOperation := MethodName;

                'IsUpdated':
                    IsUpdatedOperation := MethodName;

                'GetRecIdFromKey':
                    GetRecIdFromKeyOperation := MethodName;

                'Create':
                    CreateOperation := MethodName;

                'CreateMultiple':
                    CreateMultipleOperation := MethodName;

                'Update':
                    UpdateOperation := MethodName;

                'UpdateMultiple':
                    UpdateMultipleOperation := MethodName;

                'Delete':
                    DeleteOperation := MethodName;

            end;

        end;

        if ReadOperation <> '' then
            IsPageServiceDetected := true;

    end;



    procedure Init()
    begin
        Clear(RequestXml);
        Clear(RootElement);
        RequestXml := XmlDocument.Create();
        RootElement := XmlElement.Create(EntityTypeName);
        RequestXml.Add(RootElement);
        IsInitialized := true;

    end;



    procedure SetValue(FieldName: Text; FieldValue: Text)
    var
        TextNode: XmlText;
    begin

        if not IsInitialized then
            Error(ErrNotInitialized);

        FieldEleme := XmlElement.Create(FieldName);

        TextNode := XmlText.Create(FieldValue);

        FieldEleme.Add(TextNode);

        RootElement.Add(FieldEleme);
    end;

    procedure CreateRecord()
    begin
        if CreateOperation = '' then
            Error(ErrOperationNotAllowed, 'Create');

        SendSoapRequest(CreateOperation);

    end;

    procedure UpdateRecord()
    begin

        if UpdateOperation = '' then
            Error(ErrOperationNotAllowed, 'Update');

        SendSoapRequest(UpdateOperation);

    end;

    procedure DeleteRecord(KeyValue: Text)
    begin

        Init();

        SetValue('Key', KeyValue);

        SendSoapRequest(DeleteOperation);

    end;

    procedure ReadRecord(KeyValue: Text)
    begin

        Init();

        SetValue('No', KeyValue);

        SendSoapRequest(ReadOperation);

    end;




    local procedure SendSoapRequest(OperationName: Text)
    var
        SoapText: Text;
        ResponseText: Text;
        RequestBodyText: Text;
    begin
        RequestXml.WriteTo(RequestBodyText);
        SoapText :=
        '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
        '<soap:Body>' +
        '<' + OperationName + ' xmlns="urn:microsoft-dynamics-schemas/page/' + EntityTypeName + '">' +
        RequestBodyText +
        '</' + OperationName + '>' +
        '</soap:Body>' +
        '</soap:Envelope>';


        Content.WriteFrom(SoapText);

        Content.GetHeaders(Headers);

        Headers.Clear();

        Headers.Add('Content-Type', 'text/xml; charset=utf-8');


        Client.Post(ServiceUri, Content, ResponseMessage);

        if not ResponseMessage.IsSuccessStatusCode then
            Error(ErrHttpError, ResponseMessage.HttpStatusCode);


        ResponseMessage.Content.ReadAs(ResponseText);

        XmlDocument.ReadFrom(ResponseText, ResponseXml);

    end;


    local procedure GetAttribute(Node: XmlNode; AttributeName: Text): Text
    var
        Element: XmlElement;
        Attribute: XmlAttribute;
    begin

        if not Node.IsXmlElement then
            exit('');

        Element := Node.AsXmlElement();

        foreach Attribute in Element.Attributes do
            if Attribute.Name = AttributeName then
                exit(Attribute.Value);

        exit('');

    end;


    procedure InsertAllowed(): Boolean
    begin
        exit(CreateOperation <> '');
    end;


    procedure ModifyAllowed(): Boolean
    begin
        exit(UpdateOperation <> '');
    end;


    procedure DeleteAllowed(): Boolean
    begin
        exit(DeleteOperation <> '');
    end;


    procedure ReadAllowed(): Boolean
    begin
        exit(ReadOperation <> '');
    end;


    procedure HasLines(): Boolean
    begin
        exit(LineTypeName <> '');
    end;

}
//BC Upgrade GUNREM01 <<


