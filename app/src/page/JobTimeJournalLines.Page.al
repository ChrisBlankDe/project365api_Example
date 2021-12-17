page 50104 "KVSPSAAPI JobTimeJournalLines"
{
    PageType = API;
    APIPublisher = 'kumavision';
    APIGroup = 'project';
    APIVersion = 'beta';
    EntityName = 'jobTimeJournalLine';
    EntitySetName = 'jobTimeJournalLines';
    SourceTable = KVSPSAJobTimeJournalLine;
    ODataKeyFields = SystemId;
    DelayedInsert = true;
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
                field(jobTimeJournalId; JobTimeJournalBatchId)
                {
                    trigger OnValidate()
                    var
                        JobTimeJournalBatch: Record "KVSPSAJobTimeJournalBatch";
                    begin
                        JobTimeJournalBatch.GetBySystemId(JobTimeJournalBatchId);
                        Rec."Journal Template Name" := JobTimeJournalBatch."Journal Template Name";
                        rec."Journal Batch Name" := JobTimeJournalBatch.Name;
                        rec."Resource No." := JobTimeJournalBatch."Res.-No.";
                    end;
                }
                field(lineNumber; Rec."Line No.")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(toDoNo; Rec."To-Do No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
            }
        }
    }
    var
        JobTimeJournalBatchId: guid;

    trigger OnAfterGetCurrRecord()
    var
        JobTimeJournalBatch: Record "KVSPSAJobTimeJournalBatch";
    begin
        JobTimeJournalBatch.get(rec."Journal Template Name", rec."Journal Batch Name");
        JobTimeJournalBatchId := JobTimeJournalBatch.SystemId;
    end;

    [ServiceEnabled]
    [Scope('Cloud')]
    procedure Post(var actionContext: WebServiceActionContext)
    var
        JobTimeJournalLine: record KVSPSAJobTimeJournalLine;
        // JobTimeJnlPost:Codeunit "KVSPSAJob-Time Jnl.-Post";
       JobTimeJnlPost: Codeunit "KVSPSAJob-Time Jnl.-Post Line";
    begin
        JobTimeJournalLine.get(Rec."Journal Template Name",rec."Journal Batch Name", Rec."Line No.");
        JobTimeJournalLine.SetRecFilter();
                JobTimeJnlPost.Run(JobTimeJournalLine);
       
        // Set the result code to inform the caller that an item was created.
        actionContext.SetResultCode(WebServiceActionResultCode::Deleted);
    end;

}