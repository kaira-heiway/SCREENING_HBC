// namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
// using Microsoft.Manufacturing.Document;
// using Microsoft.FixedAssets.FixedAsset;
// using Microsoft.Finance.Dimension;

// // BC Upgrade POENAB02>>
// //New Codeunit Event added from Financial Utils>>

// codeunit 58017 InterfaceRtRCode
// {

//     [EventSubscriber(ObjectType::Table, 5600, 'OnAfterInsertEvent', '', false, false)]
//     local procedure FAOnInsertTrigger(var Rec: Record "Fixed Asset"; RunTrigger: Boolean);
//     var
//         GeneralInterfaceSetup: Record "General Interface Setup INT";
//         DimensionValue: Record "Dimension Value";
//         DefaultDimension: Record "Default Dimension";
//     begin
//         GeneralInterfaceSetup.Get();
//         DimensionValue.Init();
//         DimensionValue.Validate("Dimension Code", GeneralInterfaceSetup."Project Dimension Code");
//         DimensionValue.Validate(Code, Rec."No.");
//         DimensionValue.Validate(Name, Rec."No.");
//         DimensionValue.Insert();

//         DefaultDimension.Init();
//         DefaultDimension.Validate("Table ID", 5600);
//         DefaultDimension.Validate("No.", Rec."No.");
//         DefaultDimension.Validate("Dimension Code", GeneralInterfaceSetup."Project Dimension Code");
//         DefaultDimension.Validate("Dimension Value Code", Rec."No.");
//         DefaultDimension.Insert();
//     end;
// }
// //New Codeunit Event added from Financial Utils<<
// // BC Upgrade POENAB02<<