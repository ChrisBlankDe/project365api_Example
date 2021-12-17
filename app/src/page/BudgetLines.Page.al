page 50102 "KVSPSAAPI BudgetLines"
{
    PageType = API;
    APIPublisher = 'kumavision';
    APIGroup = 'project';
    APIVersion = 'beta';
    EntityName = 'jobBudgetLine';
    EntitySetName = 'jobBudgetLines';
    SourceTable = "KVSPSA Job Budget Line";
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
                field(workBreakdownStructureId; WorkBreakdownStructureId)
                {
                    trigger OnValidate()
                    var
                        JobPspHeader: Record KVSPSAJobPSPHeader;
                    begin
                        JobPspHeader.GetBySystemId(WorkBreakdownStructureId);
                        Rec."Job No." := JobPspHeader."Job No.";
                        Rec."Job Budget Name" := JobPspHeader."Job Budget Name";
                        Rec."Version No." := JobPspHeader."Version No.";
                    end;
                }
                field(workBreakdownStructureLineId; WorkBreakdownStructureLineId)
                {
                    trigger OnValidate()
                    var
                        JobPspLine: Record KVSPSAJobPSPLine;
                    begin
                        JobPspLine.GetBySystemId(WorkBreakdownStructureLineId);
                        Rec."Job No." := JobPspLine."Job No.";
                        Rec."Job Budget Name" := JobPspLine."Job Budget Name";
                        Rec."Version No." := JobPspLine."Version No.";
                        rec."Line No." := JobPspLine."Line No.";
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
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(toDoNo; Rec."To-Do No.")
                {
                    Caption = 'To-Do No.';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
                field(endingDate; Rec."Ending Date")
                {
                    Caption = 'Ending Date';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }

    var
        JobId, WorkBreakdownStructureId, WorkBreakdownStructureLineId : guid;

    trigger OnAfterGetCurrRecord()
    var
        job: Record job;
        JobPSPHeader: Record KVSPSAJobPSPHeader;
        JobPSPLine: Record KVSPSAJobPSPLine;
    begin
        job.get(rec."Job No.");
        JobId := job.SystemId;
        JobPSPHeader.get(Rec."Job No.", Rec."Job Budget Name", Rec."Version No.");
        WorkBreakdownStructureId := JobPSPHeader.SystemId;

        JobPSPLine.get(Rec."Job No.", Rec."Job Budget Name", Rec."Version No.",Rec."PSP Line No.");
        WorkBreakdownStructureLineId := JobPSPLine.SystemId;

    end;
}
