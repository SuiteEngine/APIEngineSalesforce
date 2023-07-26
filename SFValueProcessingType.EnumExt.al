/// <summary>
/// EnumExtension SampleExt Value Processing Type (ID 50100) extends Record SENAPI Value Processing Type.
/// </summary>
enumextension 70100 "SFValueProcessingType" extends "SENAPI Value Processing Type"
{


    value(70100; salesforce)
    {
        Caption = 'Salesforce';
        Implementation = SENAPIValueProcessing = SFValueProcessing;
    }
}
