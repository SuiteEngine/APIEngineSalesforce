/// <summary>
/// TableExtension Customer Ext. (ID 60100) extends Record Customer.
/// </summary>
tableextension 70100 "SFCustomer Ext." extends Customer
{
    fields
    {
        field(70100; SFID; Text[18])
        {
            Caption = 'Salesforce ID';
            DataClassification = CustomerContent;
        }
        field(70101; SFOwnerID; Text[18])
        {
            Caption = 'Salesforce Owner ID';
            DataClassification = CustomerContent;
        }
        field(70102; SFLastModifiedDateTime; DateTime)
        {
            Caption = 'Salesforce Last Modified Date Time';
            DataClassification = CustomerContent;
        }
        field(70103; SFFieldsLastModifiedDateTime; DateTime)
        {
            Caption = 'Salesforce Fields Last Modified DateTime';
            DataClassification = CustomerContent;
        }
    }
}
