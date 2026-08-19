tableextension 50088 ItemBudgetNameExtFND extends "Item Budget Name"
{
    // version NAVW17.00,HEI.01
    // HEI.01 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added fileds to Data Version Reference table 
    fields
    {
        modify("Analysis Area")
        {
            CaptionML = ENU = 'Analysis Area', FRA = 'Zone d''analyse';
            //OptionCaptionML = ENU = 'Sales,Purchase', FRA = 'Ventes,Achats';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Budget Dimension 1 Code")
        {
            CaptionML = ENU = 'Budget Dimension 1 Code', FRA = 'Code axe budget 1';
        }
        modify("Budget Dimension 2 Code")
        {
            CaptionML = ENU = 'Budget Dimension 2 Code', FRA = 'Code axe budget 2';
        }
        modify("Budget Dimension 3 Code")
        {
            CaptionML = ENU = 'Budget Dimension 3 Code', FRA = 'Code axe budget 3';
        }

        //Unsupported feature: CodeModification on ""Budget Dimension 1 Code"(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Budget Dimension 1 Code" <> xRec."Budget Dimension 1 Code" THEN BEGIN
          IF Dim.CheckIfDimUsed("Budget Dimension 1 Code",17,Name,'',"Analysis Area") THEN
            ERROR(Text000,Dim.GetCheckDimErr);
          MODIFY;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Budget Dimension 1 Code" <> xRec."Budget Dimension 1 Code" then begin
          if Dim.CheckIfDimUsed("Budget Dimension 1 Code",17,Name,'',"Analysis Area") then
            ERROR(Text000,Dim.GetCheckDimErr);
          MODIFY;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Budget Dimension 2 Code"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Budget Dimension 2 Code" <> xRec."Budget Dimension 2 Code" THEN BEGIN
          IF Dim.CheckIfDimUsed("Budget Dimension 2 Code",18,Name,'',"Analysis Area") THEN
            ERROR(Text000,Dim.GetCheckDimErr);
          MODIFY;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Budget Dimension 2 Code" <> xRec."Budget Dimension 2 Code" then begin
          if Dim.CheckIfDimUsed("Budget Dimension 2 Code",18,Name,'',"Analysis Area") then
            ERROR(Text000,Dim.GetCheckDimErr);
          MODIFY;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Budget Dimension 3 Code"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Budget Dimension 3 Code" <> xRec."Budget Dimension 3 Code" THEN BEGIN
          IF Dim.CheckIfDimUsed("Budget Dimension 3 Code",19,Name,'',"Analysis Area") THEN
            ERROR(Text000,Dim.GetCheckDimErr);
          MODIFY;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Budget Dimension 3 Code" <> xRec."Budget Dimension 3 Code" then begin
          if Dim.CheckIfDimUsed("Budget Dimension 3 Code",19,Name,'',"Analysis Area") then
            ERROR(Text000,Dim.GetCheckDimErr);
          MODIFY;
        end;
        */
        //end;
        field(50000; "Data Version Reference FND"; Code[20])
        {
            CaptionML = ENU = 'Data Version Reference',
                        FRA = 'Version Reference Data';
            Description = 'HEI.01';
        }
        field(50001; "Autom. cpy Bdgt. Dim.1 frm FND"; Option)
        {
            Description = 'HEI.01';
            Caption = 'Automatice Copy Budget Dimension 1 from';
            OptionCaption = '" ,Customer,Vendor,Item"';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(50002; "Autom. cpy Bdgt. Dim.2 frm FND"; Option)
        {
            Description = 'HEI.01';
            Caption = 'Automatice Copy Budget Dimension 2 from';
            OptionCaption = '" ,Customer,Vendor,Item"';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(50003; "Autom. cpy Bdgt. Dim.3 frm FND"; Option)
        {
            Description = 'HEI.01';
            Caption = 'Automatice Copy Budget Dimension 3 from';
            OptionCaption = '" ,Customer,Vendor,Item"';
            OptionMembers = " ",Customer,Vendor,Item;
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemBudgetEntry.SETCURRENTKEY("Analysis Area","Budget Name");
    ItemBudgetEntry.SETRANGE("Analysis Area","Analysis Area");
    ItemBudgetEntry.SETRANGE("Budget Name",Name);
    ItemBudgetEntry.DELETEALL(TRUE);

    ItemAnalysisViewBudgetEntry.SETRANGE("Analysis Area","Analysis Area");
    ItemAnalysisViewBudgetEntry.SETRANGE("Budget Name",Name);
    ItemAnalysisViewBudgetEntry.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    ItemBudgetEntry.DELETEALL(true);
    #5..8
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=%1\You cannot use the same dimension twice in the same budget.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=%1\You cannot use the same dimension twice in the same budget.;FRA=%1\Vous ne pouvez pas utiliser le même axe analytique deux fois dans le même budget.;
    //Variable type has not been exported.
}

