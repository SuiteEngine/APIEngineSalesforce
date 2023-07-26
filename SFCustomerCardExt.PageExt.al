/// <summary>
/// PageExtension "SFCustomerCardExt" (ID 60100) extends Record Customer Card.
/// </summary>
pageextension 70100 SFCustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group(SalesForce)
            {
                Caption = 'Salesforce';
                field(SFID; Rec.SFID)
                {
                    ApplicationArea = All;
                    ToolTip = 'The Salesforce Account ID';
                }
                field(SFOwnerID; Rec.SFOwnerID)
                {
                    ApplicationArea = All;
                    ToolTip = 'The Salesforce Account Owner ID';
                }
                field(SFLastModifiedDateTime; Rec.SFLastModifiedDateTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Salesforce Account Last Modified Date Time.';
                }
                field(SFFieldsLastModifiedDateTime; Rec.SFFieldsLastModifiedDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified Date Time';
                    ToolTip = 'Salesforce fields last modified date time.';
                }
            }
        }

    }

    actions
    {
        addlast(processing)
        {
            action(UpdateSalesforce)
            {
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = MoveUp;
                Promoted = true;
                PromotedOnly = true;
                Caption = 'Send to Salesforce';
                ToolTip = 'Send the customer data to Salesforce';
                trigger OnAction();
                var
                    SFIntegrationOperation: Codeunit SFIntegrationOperation;
                begin
                    SFIntegrationOperation.SendBCCustomer(Rec);
                    Rec.Get(Rec."No.");
                end;

            }
            action(DownloadSalesforce)
            {
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = MoveDown;
                Promoted = true;
                PromotedOnly = true;
                Caption = 'Retrieve from Salesforce';
                ToolTip = 'Retrieve the customer data from Salesforce';
                trigger OnAction();
                var
                    SFIntegrationOperation: Codeunit SFIntegrationOperation;
                begin
                    SFIntegrationOperation.RetrieveSalesForceAccount(Rec);

                    Rec.Get(Rec."No.");
                    CurrPage.Update(false);

                end;

            }
        }
    }


    trigger OnModifyRecord(): Boolean
    begin
        //This function updates the last modified date-time when any of the sync fields is modified.
        if SFFieldsModified() then begin
            Rec.SFFieldsLastModifiedDateTime := CurrentDateTime;
        end;
    end;

    /// <summary>
    /// SFFieldsModified.
    /// This function returns true if any of the fields synchronized with Salesforce have been modified. 
    /// If a new field is added to be synced, it should also be included in this function.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    local procedure SFFieldsModified(): Boolean
    begin
        exit(
            (Rec.Name <> xRec.Name) or
            (Rec.Address <> xRec.Address) or
            (Rec."Address 2" <> xRec."Address 2") or
            (Rec.City <> xRec.City) or
            (Rec.County <> xRec.County) or
            (Rec."Post Code" <> xRec."Post Code") or
            (Rec."Country/Region Code" <> xRec."Country/Region Code")
        )

    end;

}
