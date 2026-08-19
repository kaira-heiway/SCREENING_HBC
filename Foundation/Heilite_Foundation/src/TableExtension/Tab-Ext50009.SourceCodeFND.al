tableextension 50009 SourceCodeExtFND extends "Source Code"
{
    // version NAVW19.00,HEI.02

    // HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New function added
    //     # CheckSimulationEntries
    //   # New field added
    //     # 10810 Simulation
    // HEI.02 CHG2160321 IBM SISUM01 25/01/2023 #Add field id 50000

    fields
    {

        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        // field(10810; Simulation; Boolean)
        // {
        //     CaptionML = ENU = 'Simulation',
        //                 FRA = 'Simulation';

        //     trigger OnValidate();
        //     begin
        //         //HEI.01>>
        //         CompanyInfo.GET;
        //         if CompanyInfo."Enable French Localization" then
        //             if (Simulation <> xRec.Simulation) then
        //                 CheckSimulationEntries;
        //         //HEI.01<<
        //     end;
        // }  // BC Upgrade NANDIS03
        field(50000; "Skip Dimension Control FND"; Boolean)
        {
            Caption = 'Skip Dimension Control';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }

    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //begin
    /*
    //HEI.01>>
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      if Simulation then
        CheckSimulationEntries;
    //HEI.01<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        CompanyInfo: Record "Company Information";
        GLEntry: Record "G/L Entry";
        GenJnlLine: Record "Gen. Journal Line";
        Text10800: TextConst ENU = 'This source code is used on posted entries. ', FRA = 'Ce code source est utilisé dans les écritures enregistrées. ';

    // trigger OnDelete()
    // var
    //     myInt: Integer;
    // begin
    //     //HEI.01>>
    //     CompanyInfo.GET;
    //     IF CompanyInfo."Enable French Localization" THEN
    //         IF Simulation THEN
    //             CheckSimulationEntries;
    //     //HEI.01<<
    // end;

    // procedure CheckSimulationEntries()

    // begin
    //     //HEI.01>>
    //     CompanyInfo.GET;
    //     IF NOT CompanyInfo."Enable French Localization" THEN
    //         EXIT;

    //     GenJnlLine.SETRANGE(GenJnlLine."Source Code", Code);
    //     GLEntry.SETRANGE(GLEntry."Source Code", Code);
    //     IF GenJnlLine.FIND('-') OR GLEntry.FIND('-') THEN
    //         ERROR(Text10800);
    //     //HEI.01<<    
    // end;  // BC Upgrade NANDIS03 - function added but blocked due to FR localization
}

