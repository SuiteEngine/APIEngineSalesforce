/// <summary>
/// Codeunit SFIntegrationOperation (ID 70103).
/// </summary>
codeunit 70103 SFIntegrationOperation
{
    internal procedure SendBCCustomer(Customer: Record Customer): Boolean
    var
        SENAPIMessage: Record "SENAPI Message";
        SENAPIMessageManagement: Codeunit SENAPIMessageManagement;
    begin
        if Customer.SFID = '' then
            exit(false);

        //Initializing API Message Variable
        SENAPIMessage := SENAPIMessageManagement.CreateNewAPIMessage('SALESFORCE', 'UPDATEACCOUNT');
        //Attaching the Customer Record to the Message 
        SENAPIMessageManagement.AddNewRecordParamterToAPIMessage(SENAPIMessage, Customer.RecordId);

        //Execute API call
        SENAPIMessageManagement.ExecuteAPIMessage(SENAPIMessage);

        //Return true if the http status code is sucess (in 200 range)
        exit((SENAPIMessage.IsSuccessStatusCode()));

    end;


    internal procedure RetrieveSalesForceAccount(Customer: Record Customer): Boolean
    var
        SENAPIMessage: Record "SENAPI Message";
        SENAPIMessageManagement: Codeunit SENAPIMessageManagement;
    begin
        if Customer.SFID = '' then
            exit(false);

        //Retrives the customer data from salesforce

        //Initializing API Message Variable
        SENAPIMessage := SENAPIMessageManagement.CreateNewAPIMessage('SALESFORCE', 'GETACCOUNT');
        //Attaching the Customer Record to the Message 
        SENAPIMessageManagement.AddNewRecordParamterToAPIMessage(SENAPIMessage, Customer.RecordId);

        //Execute API call
        SENAPIMessageManagement.ExecuteAPIMessage(SENAPIMessage);

        //Return true if the http status code is sucess (in 200 range)
        exit((SENAPIMessage.IsSuccessStatusCode()));

    end;


    internal procedure SendAllCustomerInformationUpdatedSince(SinceDateTime: DateTime) updatedCount: Integer
    var
        CustomerToUpdate: Record Customer;
    begin
        CustomerToUpdate.SetFilter(SFFieldsLastModifiedDateTime, '>%1', SinceDateTime);
        CustomerToUpdate.SetFilter(SFID, '<>%1', '');
        if CustomerToUpdate.FindSet() then
            repeat
                if SendBCCustomer(CustomerToUpdate) then
                    updatedCount += 1;

            until CustomerToUpdate.Next() = 0;
    end;

    internal procedure RetrieveSalesForceAccountUpdatedSince(SinceDateTime: DateTime): Boolean
    var
        SENAPIMessage: Record "SENAPI Message";
        SENAPIMessageManagement: Codeunit SENAPIMessageManagement;
        SFSQLQuery: Text[250]; //Currently we are limited to 250 character but there will be update that will allowing to store the text in blob
    begin
        //Retrives the customer data from salesforce

        //This is the Salesforce query to retrive all the account that has been updated since 
        SFSQLQuery := 'SELECT+Id,OwnerId,name,type,BillingAddress,ShippingAddress,LastModifiedDate+from+Account+WHERE+LastModifiedDate+>+' + Format(SinceDateTime, 0, 9);

        //Initializing API Message Variable
        SENAPIMessage := SENAPIMessageManagement.CreateNewAPIMessage('SALESFORCE', 'GETACCOUNTSMODIFIED');

        //Attaching the SFSQLQuery
        SENAPIMessageManagement.AddTextValueParamterToAPIMessage(SENAPIMessage, 'sqlquery', SFSQLQuery);

        //Execute API call
        SENAPIMessageManagement.ExecuteAPIMessage(SENAPIMessage);

        //Return true if the http status code is sucess (in 200 range)
        exit((SENAPIMessage.IsSuccessStatusCode()));

    end;


}
