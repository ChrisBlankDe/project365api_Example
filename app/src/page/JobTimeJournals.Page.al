page 50103 "KVSPSAAPI JobTimeJournals"
{
    PageType = API;
    APIPublisher = 'kumavision';
    APIGroup = 'project';
    APIVersion = 'beta';
    EntityName = 'jobTimeJournal';
    EntitySetName = 'jobTimeJournals';
    SourceTable = KVSPSAJobTimeJournalBatch;
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field("code"; Rec.Name)
                {
                    ShowMandatory = true;
                }
                field(displayName; Rec.Description)
                {
                }
                field(templateDisplayName; Rec."Journal Template Name")
                {
                }
                field(resourceNo; Rec."Res.-No.")
                {
                }
                part(journalLines; "KVSPSAAPI JobTimeJournalLines")
                {
                    Caption = 'Journal Lines';
                    EntityName = 'jobTimeJournalLine';
                    EntitySetName = 'jobTimeJournalLines';
                    SubPageLink = "Journal Batch Name" = Field(Name);
                }
            }
        }
    }
    var
        ThereIsNothingToPostErr: Label 'There is nothing to post.';
        CannotFindBatchErr: Label 'The General Journal Batch with ID %1 cannot be found.', Comment = '%1 - the System ID of the general journal batch';


    [ServiceEnabled]
    [Scope('Cloud')]
    procedure post(var ActionContext: WebServiceActionContext)
    var
        GenJournalBatch: Record KVSPSAJobTimeJournalBatch;
    begin
        GetBatch(GenJournalBatch);
        PostBatch(GenJournalBatch);
        SetActionResponse(ActionContext, Rec.SystemId);
    end;

    local procedure GetBatch(var GenJournalBatch: Record KVSPSAJobTimeJournalBatch)
    begin
        if not GenJournalBatch.GetBySystemId(Rec.SystemId) then
            Error(CannotFindBatchErr, Rec.SystemId);
    end;

    local procedure PostBatch(var GenJournalBatch: Record KVSPSAJobTimeJournalBatch)
    var
        GenJournalLine: Record KVSPSAJobTimeJournalLine;
    begin
        GenJournalLine.SetRange("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
        if not GenJournalLine.FindFirst() then
            Error(ThereIsNothingToPostErr);

        Codeunit.RUN(Codeunit::"KVSPSAJob-Time Jnl.-Post", GenJournalLine);
    end;


    local procedure SetActionResponse(var ActionContext: WebServiceActionContext; BatchId: Guid)
    var
    begin
        ActionContext.SetObjectType(ObjectType::Page);
        ActionContext.SetObjectId(Page::"KVSPSAAPI JobTimeJournals");
        ActionContext.AddEntityKey(Rec.FieldNo(SystemId), BatchId);
        ActionContext.SetResultCode(WebServiceActionResultCode::Deleted);
    end;
}
