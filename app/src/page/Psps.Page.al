page 50100 "KVSPSAAPI Psps"
{
    PageType = API;
    APIPublisher = 'kumavision';
    APIGroup = 'project';
    APIVersion = 'beta';
    EntityName = 'workBreakdownStructure';
    EntitySetName = 'workBreakdownStructures';
    SourceTable = KVSPSAJobPSPHeader;
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;

    Extensible = false;
    SourceTableView = where(Active = const(true));

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
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                    Editable = false;
                }
                field(jobId; JobId)
                {
                    Editable = false;
                }
                field(versionNo; Rec."Version No.")
                {
                    Editable = false;
                }
                field(description; Rec.Description)
                {
                }
                field(personResponsible; Rec."Person Responsible") //todo use id
                {
                }
                part(workBreakdownStructureLines; "KVSPSAAPI PspLines")
                {
                    Caption='Lines';
                    EntityName = 'workBreakdownStructureLine';
                    EntitySetName = 'workBreakdownStructureLines';
                    SubPageLink = "Job No." = Field("Job No."), "Job Budget Name" = field("Job Budget Name"), "Version No." = field("Version No.");
                }

            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        job: Record job;
    begin
        job.get(rec."Job No.");
        JobId := job.SystemId;
    end;

    var
        JobId: GUid;
}