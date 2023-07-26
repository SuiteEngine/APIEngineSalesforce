# APIEngineSalesforce
APIEngineSalesforce is a Business Central (BC) extension that facilitates integration between BC and Salesforce. 
This extension demonstrates how to synchronize Salesforce accounts with BC Customers using the Suite Engine API Engine library.

In this example, two buttons have been added to the Business Central Customer card:
1. "Send to Salesforce" - This button allows you to send Customer information to Salesforce.
2. "Retrieve from Salesforce" - This button enables you to retrieve account information from Salesforce.

New fields have been introduced to the Customer table:
1. SFID - The Salesforce account ID.
2. SFOwnerID - The ID of the Salesforce account owner.
3. SFLastModifiedDateTime - The date and time of the last modification made to the account on Salesforce.
4. SFFieldsLastModifiedDateTime - The date and time of the last modification made by the user to the BC fields that are synced to Salesforce.


The following fields are synchronized between the two systems:
1. Name
2. Address
3. City
4. County
5. PostCode
6. Country


If you have any further questions or need more information, feel free to reach out to us.
