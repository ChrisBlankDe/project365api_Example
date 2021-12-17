page 50101 "KVSPSAAPI PspLines"
{
    PageType = API;
    APIPublisher = 'kumavision';
    APIGroup = 'project';
    APIVersion = 'beta';
    EntityName = 'workBreakdownStructureLine';
    EntitySetName = 'workBreakdownStructureLines';
    SourceTable = KVSPSAJobPSPLine;
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;
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
                field(jobId; JobId)
                {
                    trigger OnValidate()
                    var
                        job: Record job;
                    begin
                        job.GetBySystemId(JobId);
                        Rec."Job No." := job."No.";
                    end;
                }

                field(type; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(workTypeCode; Rec."Work Type Code")
                {
                    Caption = 'Work Type Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
                field(endingDate; Rec."Ending Date")
                {
                    Caption = 'Ending Date';
                }

                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }

                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                part(jobBudgetLines; "KVSPSAAPI BudgetLines")
                {
                    EntityName = 'jobBudgetLine';
                    EntitySetName = 'jobBudgetLines';
                    SubPageLink = "Job No." = Field("Job No."), "Job Budget Name" = field("Job Budget Name"), "Version No." = field("Version No."),"PSP Line No."=field("Line No.");
                }

            }
        }
    }
    var
        JobId: guid;

    trigger OnAfterGetCurrRecord()
    var
        job: Record job;
    begin
        job.get(rec."Job No.");
        JobId := job.SystemId;
    end;
}