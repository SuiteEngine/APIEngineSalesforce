APIEngineSalesforce is an example of Business Central (BC) integration with Salesforce. This extension demonstrates how to synchronize Salesforce accounts to BC Customers using the Suite Engine API Engine library.

In this example, we have added two buttons to the Business Central Customer card:
1. "Send to Salesforce" - This button allows you to send Customer information to Salesforce.
2. "Retrieve from Salesforce" - This button enables you to retrieve account information from Salesforce.


New fields have been introduced to the Customer table:
1. SFID - The Salesforce account ID.
2. SFOwnerID - The ID of the Salesforce account owner.
3. SFLastModifiedDateTime - The date and time of the last modification made to the account on Salesforce.
4. SFFieldsLastModifiedDateTime - The date and time of the last modification made by the user to the BC fields that are synced to Salesforce.

The following fields are sync between the two systems 
1. Name
2. Address
3. City
4. County
5. PostCode
6. Country
