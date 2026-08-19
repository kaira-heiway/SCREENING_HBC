// pageextension 52031 GetReturnShipmentLinesExt extends "Get Return Shipment Lines"
// {
//     //BC UPGRADE ATHUKUS01 FDD_STP008>>
//     //1.Created new page extension to add new fields in the existing page "Get Return Shipment Lines" which are required for SPL India localization.
//     //BC UPGRADE ATHUKUS01 FDD_STP008<<


//     layout
//     {

//         addlast(Control1)
//         {

//             field("Return Order No."; Rec."Return Order No.")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the return order number this line is associated with.';
//             }
//             field("Vendor Shipment No."; Rec."Document No.")
//             {
//                 Caption = 'Vendor Shipment No.';
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Vendor Shipment No. field.', Comment = '%';
//             }

//             field("SPL Code"; Rec."SPL Code")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the SPL Code field.', Comment = '%';
//             }
//             field("SPL Name"; Rec."SPL Name")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the SPL Name field.', Comment = '%';
//             }
//             field("Consumption SPL Code"; Rec."Consumption SPL Code")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Consumption SPL Code field.', Comment = '%';
//             }

//         }
//     }
// }


