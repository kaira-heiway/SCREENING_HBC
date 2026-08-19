page 58098 "API Interface Log2"
{
    // version HEI.10

    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New page created
    // HEI.02 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New Field added: "Posting Status"
    //   # New Action Group created: "Posting"
    //   # New Page Actions created for Posted Documents
    // HEI.03 INC3770544 - CHG2130622 IBM NASTAA02 15.10.2021 # API Entries are unable to be Reprocessed
    //   # Code added on Page Action "Reprocess Posting"
    // HEI.04 HB2469 - CHG2122312 IBM NASTAA02 17.11.2021 # Payment API with B2B DOT Interface into HL
    //   # Defined Promoted Categories in 'PromotedActionCategoriesML' Property
    // HEI.07 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    //   # Add field "No. of Re-processed"
    //   # Add field "Checking Status"
    //   # Add field "Checking Codeunit"
    //   # Add field "JobQueue Codeunit"
    //   # Add field "Job Queue Sync Date/Time"
    //   # Add look & feel optimization
    // HEI.05 CHG2155847 HB2821 IBM NANDIS01 28.10.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # "Order ID" added in Page
    // HEI.06 CHG2155847 HB2821 IBM NANDIS01 20.01.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # fields shown in Page - "Posting Error Message" and "Processing Codeunit"
    // HEI.08 CHG2188870 DEBUSD01 10.02.2023 Sales Order API Performance change flow
    //   # Remove button batch re-process reports
    // HEI.09 CHG2194055 DEBUSD01 07.03.2023 Sales Order API Performance change flow
    //   # Add parameter function IsReadyReprocessPost()
    // HEI.10 CHG2194055 BHANDS01 13.06.2023 API Sales Order Posting Reprocessing Batch
    //   # New field added 56 "Re-processed Posting Batch"
    //   # Added Field "Re-processed Posting"

    // BC Upgrade SHUKLP03 >> Nav Page Id - 50421

    Caption = 'API Interface Log';
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Posting,Page';
    SourceTable = "API Interface Log2 INT";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists;  // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Interface Code"; Rec."Interface Code")
                {
                }
                field("Request Sync. Date/Time"; Rec."Request Sync. Date/Time")
                {
                }
                field("Response Sync. Date/Time"; Rec."Response Sync. Date/Time")
                {
                }
                field("Checking Status"; Rec."Checking Status")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Posting Status"; Rec."Posting Status")
                {
                }
                field("Message ID"; Rec."Message ID")
                {
                }
                field("Source System Identifier"; Rec."Source System Identifier")
                {
                }
                field(Entity; Rec.Entity)
                {
                }
                field(Operation; Rec.Operation)
                {
                }
                field("File Format"; Rec."File Format")
                {
                }
                field("Source Request Timestamp"; Rec."Source Request Timestamp")
                {
                }
                field("Source Type"; Rec."Source Type")
                {
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Order ID"; Rec."Order ID")
                {
                }
                field("Parent Entry No."; Rec."Parent Entry No.")
                {
                    DrillDown = true;
                    Lookup = false;

                    trigger OnDrillDown();
                    begin
                        //HEI.07>>
                        if Rec."Parent Entry No." <> 0 then
                            Rec.GET(Rec."Parent Entry No.");
                        //HEI.07>>
                    end;
                }
                field(Manual; Rec.Manual)
                {
                }
                field("Re-processing Date/Time"; Rec."Re-processing Date/Time")
                {
                }
                field("Re-processed"; Rec."Re-processed")
                {
                }
                field("No. of Re-processed"; Rec."No. of Re-processed")
                {
                    Visible = false;
                }
                field("Job Queue Sync. Date/Time"; Rec."Job Queue Sync. Date/Time")
                {
                    Visible = false;
                }
                field("Job Queue Entry ID"; Rec."Job Queue Entry ID")
                {
                    Visible = false;
                }
                field("Posting Error Message"; Rec."Posting Error Message")
                {
                }
                field("Processing Codeunit"; Rec."Processing Codeunit")
                {
                }
                field("Re-processed Posting"; Rec."Re-processed Posting")
                {
                }
                field("Re-processed Posting Batch"; Rec."Re-processed Posting Batch")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowError)
            {
                Caption = 'Show Error Message';
                Enabled = ErrorActionEnabled;
                Image = Error;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    Rec.ShowError;
                end;
            }
            action(ShowRequest)
            {
                Caption = 'Show Request Message';
                Enabled = RequestMsgActionEnabled;
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    Rec.ShowRequest;
                end;
            }
            action(ShowResponse)
            {
                Caption = 'Show Response Message';
                Enabled = ResponseMsgActionEnabled;
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    Rec.ShowResponse;
                end;
            }
            action(Reprocess)
            {
                Caption = 'Re-process';
                Enabled = ReprocessActionEnabled;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Rec.Reprocess;
                end;
            }
            action(OpenCreatedRecord)
            {
                Caption = 'Open Created Record';
                Enabled = OpenDocActionEnabled;
                Image = "Order";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    Rec.OpenCreatedRecord;
                end;
            }
            group(Posting)
            {
                Caption = 'Posting';
                action(ShowPostingError)
                {
                    Caption = 'Show Posting Error';
                    Enabled = PostingErrorActionEnabled;
                    Image = ErrorLog;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction();
                    begin
                        //HEI.02>>
                        Rec.ShowPostingError;
                        //HEI.02<<
                    end;
                }
                action(ReprocessPosting)
                {
                    Caption = 'Re-process Posting';
                    Enabled = ReprocessPostActionEnabled;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction();
                    begin
                        //HEI.02>>
                        Rec.ReprocessPosting(false); //HEI.03
                        //HEI.02<<
                    end;
                }
                action(OpenPostedDocument)
                {
                    Caption = 'Open Posted Document';
                    Enabled = OpenDocPostActionEnabled;
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction();
                    begin
                        //HEI.02>>
                        Rec.OpenPostedDocument;
                        //HEI.02<<
                    end;
                }
            }
            group("Page")
            {
                Caption = 'Page';
                action("Go to Parent")
                {
                    Caption = 'Go to Parent Entry';
                    Enabled = PreviousRecActionEnabled;
                    Image = PreviousRecord;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = false;
                    PromotedOnly = true;

                    trigger OnAction();
                    begin
                        //HEI.07>>
                        if Rec."Parent Entry No." <> 0 then
                            Rec.GET(Rec."Parent Entry No.");
                        //HEI.07<<
                    end;
                }
                action("Go to Last ")
                {
                    Caption = 'Go to Last Process';
                    Enabled = NextRecActionEnabled;
                    Image = NextRecord;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = false;
                    PromotedOnly = true;

                    trigger OnAction();
                    var
                        LastEntryNo: Integer;
                    begin
                        //HEI.07>>
                        LastEntryNo := Rec.GetLastParentRecEntryNo();
                        if LastEntryNo <> 0 then
                            Rec.GET(LastEntryNo);
                        //HEI.07<<
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        //HEI.07>>
        ErrorActionEnabled := Rec.HasErrorFile();
        PostingErrorActionEnabled := Rec.HasPostingErrorFile();
        RequestMsgActionEnabled := Rec.HasRequestFile();
        ResponseMsgActionEnabled := Rec.HasResponseFile();
        ReprocessActionEnabled := Rec.IsReadyReprocess();
        //HEI.09>>
        ReprocessPostActionEnabled := Rec.IsReadyReprocessPost(false);
        //HEI.09<<
        OpenDocActionEnabled := true;
        OpenDocPostActionEnabled := true;
        PreviousRecActionEnabled := (Rec."Parent Entry No." <> 0);
        NextRecActionEnabled := true;
        //HEI.07>>
    end;

    trigger OnInit();
    begin
        //HEI.07>>
        ErrorActionEnabled := false;
        PostingErrorActionEnabled := false;
        RequestMsgActionEnabled := false;
        ResponseMsgActionEnabled := false;
        ReprocessActionEnabled := false;
        ReprocessPostActionEnabled := false;
        OpenDocActionEnabled := false;
        OpenDocPostActionEnabled := false;
        PreviousRecActionEnabled := false;
        NextRecActionEnabled := false;
        //HEI.07>>
    end;

    var
        ErrorActionEnabled: Boolean;
        PostingErrorActionEnabled: Boolean;
        RequestMsgActionEnabled: Boolean;
        ResponseMsgActionEnabled: Boolean;
        ReprocessActionEnabled: Boolean;
        ReprocessPostActionEnabled: Boolean;
        OpenDocActionEnabled: Boolean;
        OpenDocPostActionEnabled: Boolean;
        PreviousRecActionEnabled: Boolean;
        NextRecActionEnabled: Boolean;
}

