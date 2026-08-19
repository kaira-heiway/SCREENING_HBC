codeunit 50022 "Session Globals"
{
    // version HEI.02

    // HEI.01 FDD-* IBM LAZARE02 30.06.2017 # Single instance codeunit
    // HEI.02 FDD-MZ-PRDGAP001 IBM LAZARE02 25.07.2018 # New functions SetItemGlobalNo, GetItemGlobalNo
    // HEI.03 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # SetVendorGlobalNo,GetVendorGlobalNo funcs. added
    // HEI.04 FDD-HT788 IBM BULIMC01 13.10.2019 #New functions added: SetCustomerGlobalNo, GetCustomerGlobalNo
    // HEI.05 CHG2003450 IBM.GUNERE01 17.02.2021 # SetSimulateModeGlobal, GetSimulateModeGlobal funcs. added
    // HEI.06 CHG2132399 INC3707788 IBM GAVANM01 20.10.2021 # Auto Sales give system error BrewCo
    //   # funcs. added: SetPostingFromAnotherComp, GetPostingFromAnotherComp
    //   # new global var: PostingFromAnotherCompany
    // HEI.07 IBM COSTES04 27.06.2025 CHG2307645-HB4324-Emailing invoices for goods and empty goods
    //   # new functions SetPostingFromAutobilling, GetPostingFromAutobilling
    // HEI.08 CHG2326215-CC IBM ADHIKG01 09.10.2025 Job queue failure due to missing INV_LEV dimension
    //   # New functions SetCalledFromDDE, GetCalledFromDDE created

    // BC Upgrade PATELS08 >>
    //  # Added Tag HEI.08 in Documentation.
    //  # Added global variable 'CalledFromDDE' as per HEI.08.
    //  # Added procedures 'SetCalledFromDDE' and 'GetCalledFromDDE' as per HEI.08.
    // BC Upgrade PATELS08 <<

    SingleInstance = true;

    trigger OnRun();
    begin
    end;

    var
        HideValidationDialog: Boolean;
        ItemGlobalNo: Code[10];
        VendorGlobalNo: Code[20];
        CustomerGlobalNo: Text[250];
        SimulateModeGlobal: Boolean;
        PostingFromAnotherCompany: Boolean;
        PostingFromAutobilling: Boolean;
        // BC Upgrade PATELS08 >>
        CalledFromDDE: Boolean; // HEI.08
        // BC Upgrade PATELS08 <<

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    procedure GetHideValidationDialog(): Boolean;
    begin
        exit(HideValidationDialog);
    end;

    procedure SetItemGlobalNo(NewItemGlobalNo: Code[10]);
    begin
        ItemGlobalNo := NewItemGlobalNo;
    end;

    procedure GetItemGlobalNo(): Code[10];
    begin
        exit(ItemGlobalNo);
    end;

    procedure SetVendorGlobalNo(NewVendorGlobalNo: Code[20]);
    begin
        //>> HEI.03
        VendorGlobalNo := NewVendorGlobalNo;
        //<< HEI.03
    end;

    procedure GetVendorGlobalNo(): Code[20];
    begin
        //>> HEI.03
        exit(VendorGlobalNo);
        //<< HEI.03
    end;

    procedure SetCustomerGlobalNo(NewCustomerGlobalNo: Text[250]);
    begin
        //HEI.04<<
        CustomerGlobalNo := NewCustomerGlobalNo;
        //HEI.04>>
    end;

    procedure GetCustomerGlobalNo(): Text[250];
    begin
        //HEI.04<<
        exit(CustomerGlobalNo);
        //HEI.04>>
    end;

    procedure SetSimulateModeGlobal(NewSimulateModeGlobal: Boolean): Boolean;
    begin
        //>> HEI.05
        SimulateModeGlobal := NewSimulateModeGlobal;
        //<< HEI.05
    end;

    procedure GetSimulateModeGlobal(): Boolean;
    begin
        //>> HEI.05
        exit(SimulateModeGlobal);
        //<< HEI.05
    end;

    procedure ICSetPostingFromAnotherComp(Flag: Boolean);
    begin
        //HEI.06
        PostingFromAnotherCompany := Flag;
    end;

    procedure ICGetPostingFromAnotherComp(): Boolean;
    begin
        //HEI.06
        exit(PostingFromAnotherCompany);
    end;

    procedure SetPostingFromAutobilling(RunFromAutobilling: Boolean)
    begin
        //HEI.07>>
        PostingFromAutobilling := RunFromAutobilling;
        //HEI.07<<
    end;

    procedure GetPostingFromAutobilling(): Boolean
    begin
        //HEI.07>>
        exit(PostingFromAutobilling);
        //HEI.07<<
    end;

    // BC Upgrade PATELS08 >>
    // HEI.08 >>

    procedure SetCalledFromDDE(Flag: Boolean);
    begin
        CalledFromDDE := Flag;
    end;

    procedure GetCalledFromDDE(): Boolean
    begin
        //HEI.08>>
        exit(CalledFromDDE);
    end;

    // HEI.08 <<
    // BC Upgrade PATELS08 <<

}

