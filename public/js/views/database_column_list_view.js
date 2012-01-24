(function($, ns) {
    ns.views.DatabaseColumnList = ns.views.Base.extend({
        className : "database_column_list",
        useLoadingSection: true,

        events: {
            "click a" : "onNameClicked",
            "click a.back" : "onBackClicked"
        },

        makeModel: function() {
            this.collection = new ns.models.DatabaseColumnSet();
            this.schema = this.options.sandbox.schema();
        },

        setup: function() {
            this.bind("datasetSelected", this.setTable, this);
        },

        postRender: function() {
            chorus.search({
                input: this.$('input.search'),
                list: this.$('ul')
            });
        },

        setTable: function(tableOrView) {
            this.resource = this.collection = tableOrView.columns();
            this.collection.fetch();
            this.collection.bind("reset", this.render, this);
        },

        onNameClicked: function(e) {
            e.preventDefault();
        },

        onBackClicked: function(e) {
            e.preventDefault();
            this.trigger("back");
        },

        additionalContext: function() {
            var tableName = this.collection.attributes.tableName;
            var schemaName = this.collection.attributes.schemaName;

            return {
                schemaSpan: ns.helpers.spanFor(schemaName, { class: "schema", title: schemaName }),
                tableSpan: ns.helpers.spanFor(tableName, { class: "table", title: tableName })
            };
        }
    });
})(jQuery, chorus);
