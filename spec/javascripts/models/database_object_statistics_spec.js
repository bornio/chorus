describe("chorus.models.DatabaseObjectStatistics", function() {
    describe("#url", function() {
        beforeEach(function() {
            this.databaseObjectStatistics = new chorus.models.DatabaseObjectStatistics()
        })

        describe("when it gets a table", function() {
            it("should show the table url", function(){
                this.databaseObjectStatistics.set({
                    instanceId: 1,
                    databaseName: "theDatabase",
                    schemaName: "theSchema",
                    type: "SOURCE_TABLE",
                    objectType: "BASE_TABLE",
                    objectName: "aName"
                })

                expect(this.databaseObjectStatistics.url()).toMatchUrl("/edc/data/1/database/theDatabase/schema/theSchema?type=meta&filter=aName")
            })
        })

        describe("when it gets a view", function() {
            it("should show the view url", function() {
                this.databaseObjectStatistics.set({
                    instanceId: 1,
                    databaseName: "theDatabase",
                    schemaName: "theSchema",
                    type: "CHORUS_VIEW",
                    objectType: "",
                    objectName: "anotherName"
                })

                expect(this.databaseObjectStatistics.url()).toMatchUrl("/edc/data/1/database/theDatabase/schema/theSchema?type=meta&filter=anotherName")
            })
        })

        describe("when it has a datasetId property", function() {
            it("uses the dataset API", function() {
                this.databaseObjectStatistics.set({
                    instanceId: 1,
                    databaseName: "theDatabase",
                    schemaName: "theSchema",
                    type: "CHORUS_VIEW",
                    objectType: "",
                    objectName: "anotherName",
                    workspace: {
                        id: 10010
                    }
                })

                this.databaseObjectStatistics.datasetId = "composite|id"

                expect(this.databaseObjectStatistics.url()).toMatchUrl("/edc/workspace/10010/dataset/composite|id")
            })
        })
    })
})