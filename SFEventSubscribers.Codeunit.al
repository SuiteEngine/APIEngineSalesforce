/// <summary>
/// Codeunit SFEventSubscribers (ID 70101).
/// </summary>
codeunit 70101 SFEventSubscribers
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SENAPI Automation Job Queue", 'OnBeforeProcessAutomation', '', true, true)]
    local procedure SENAPIAutomationJobQueueOnBeforeProcessAutomation(var SENAPIAutomation: Record "SENAPI Automation"; var IsHandled: Boolean)
    var
        SFIntegrationOperation: Codeunit SFIntegrationOperation;
        StartRunDateTime: DateTime;
    begin
        StartRunDateTime := CurrentDateTime;

        if SENAPIAutomation.Type = SENAPIAutomation.Type::Salesforce then begin
            case SENAPIAutomation.Code of
                'PUSHACCOUNTUPDATE':
                    begin
                        SFIntegrationOperation.SendAllCustomerInformationUpdatedSince(SENAPIAutomation."Last Run Timestamp");
                        IsHandled := true;
                        SENAPIAutomation."Last Run Timestamp" := StartRunDateTime;
                        SENAPIAutomation.Modify();

                    end;
                'GETACCOUNTUPDATE':
                    begin
                        SFIntegrationOperation.RetrieveSalesForceAccountUpdatedSince(SENAPIAutomation."Last Run Timestamp");
                        IsHandled := true;
                        SENAPIAutomation."Last Run Timestamp" := StartRunDateTime;
                        SENAPIAutomation.Modify();
                    end;




            end;


        end;

    end;

}
