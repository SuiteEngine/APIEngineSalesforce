/// <summary>
/// Codeunit SFValueProcessing (ID 70200) implements Interface SENAPIValueProcessing.
/// </summary>
codeunit 70100 SFValueProcessing implements SENAPIValueProcessing
{

    procedure GetValueProcessing(var SENAPIMapping: Record "SENAPI Mapping"; SENAPIDataBufferToProcess: Record "SENAPI Data Buffer"; RecordToProcess: RecordID; ParameterKey: Text[100]; ParameterKeyIndex: Integer): Text
    begin
        case SENAPIMapping."Value Processing Function Name" of
            'SFIDToBCCustNo':
                begin
                    exit(SFIDToBCCustNo(SENAPIDataBufferToProcess.Value));
                end;
        end;

    end;

    procedure GetValueProcessing(var SENAPIVariable: Record "SENAPI Variable"; SENAPIMessage: Record "SENAPI Message"; ProcessNameElement: Boolean; ParameterKey: Text[100]; ParameterKeyIndex: Integer): Text
    begin
    end;

    procedure RegisterValueProcessingMethods()
    var
        SENAPIValueProcessingType: Enum "SENAPI Value Processing Type";
    begin
        RegisterRunctionMethod(SENAPIValueProcessingType::salesforce, 'SFIDToBCCustNo', 'Return the BC Customer No.');
    end;

    local procedure SFIDToBCCustNo(SFIDToSearch: Text): Text
    var
        Customer: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        Customer.SetRange(SFID, SFIDToSearch);
        if Customer.FindFirst() then
            exit(Customer."No.")
        else begin

            SalesSetup.Get();
            SalesSetup.TestField("Customer Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.", Customer."No. Series", 0D, Customer."No.", Customer."No. Series");
            exit(Customer."No.");

        end;
    end;

    local procedure RegisterRunctionMethod(SENAPIValueProcessingType: Enum "SENAPI Value Processing Type"; FunctionName: Text[50]; Description: Text[1024]);
    var
        SENAPIValueProcFuncMethod: Record "SENAPI ValueProcFuncMethod";
    begin
        if not SENAPIValueProcFuncMethod.Get(SENAPIValueProcessingType, FunctionName) then begin
            SENAPIValueProcFuncMethod.Init();
            SENAPIValueProcFuncMethod."Value Processing Type" := SENAPIValueProcessingType;
            SENAPIValueProcFuncMethod.Name := FunctionName;
            SENAPIValueProcFuncMethod.Description := Description;
            SENAPIValueProcFuncMethod.Insert();
        end;

    end;

}
