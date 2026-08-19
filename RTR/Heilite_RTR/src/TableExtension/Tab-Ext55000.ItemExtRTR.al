tableextension 55000 ItemExt_RTR extends Item
{// BC Upgrade Kamnay01 in Heineken_RTR extension is created for adding CIL ID Code and CIL ID2 Code fields to Item table 
    fields
    {
        //BC Upgrade Kamnay01>> Moved to RTR_IBM Ext
        field(50005; "CIL ID Code RTR"; Code[10])
        {
            CaptionML = ENU = 'CIL ID Code',
                        FRA = 'CIL ID Code';
            Description = 'HEI4.0';
            TableRelation = "CIL Code RTR";
        }
        field(50006; "CIL ID2 Code RTR"; Code[10])
        {
            caption ='CIL ID2 Code';
            Description = 'HEI4.0';
            TableRelation = "CIL2 Code RTR";

        }
        // BC Upgrade Kamnay01<< Moved to RTR_IBM Ext
    }
}
