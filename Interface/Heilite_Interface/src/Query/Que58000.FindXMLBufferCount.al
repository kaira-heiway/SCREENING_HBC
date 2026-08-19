query 58000 "Find XML Buffer Count"

{
    // Heilite Navision Old Id - 50007
    // version HEI.01

    // HEI.01 CHG2095189 IBM SAXENA03 27.01.2021
    //   # Code written for Sales Order optimizaiton
    //   # Object created for XML Buffer Count


    elements
    {
        dataitem(XML_Buffer; "XML Buffer")
        {
            filter(Parent_Entry_No; "Parent Entry No.")
            {
            }
            filter(Type; Type)
            {
            }
            column(XMLRowCount)
            {
                Method = Count;
            }
        }
    }
}

