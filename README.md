# project365 API Example
This example shows how apis can be used in dynamics 365 business central to access data from the project365 solution.

This is divided into the app which provides the APIs and a [postman](https://www.postman.com/) collection which shows how the apis can be used.

The app is based on BC 19.0 and project365 19.0, but should run on future versions without any problems (maybe with small adjustments).
The postman collection can be [easily imported](https://learning.postman.com/docs/getting-started/importing-and-exporting-data/#importing-data-into-postman). Afterwards only the [variables have to be set](https://learning.postman.com/docs/sending-requests/variables/) accordingly and the first requests can be executed.

There are three Entities which can be used for general WBS interactions:
- workBreakdownStructure
- workBreakdownStructureLine
- jobBudgetLine

There are also two Entities which allow the recording of project times. With the bound action ```post``` it is even possible to call an action for posting them:

- jobTimeJournal
- jobTimeJournalLine
