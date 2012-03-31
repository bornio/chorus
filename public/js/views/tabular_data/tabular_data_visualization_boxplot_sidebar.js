chorus.views.TabularDataVisualizationBoxplotSidebar = chorus.views.TabularDataVisualizationSidebar.extend({
    className: "tabular_data_visualization_sidebar",
    additionalClass: "boxplot",

    columnGroups: [
        {
            type: "numeric",
            name: "value"
        },
        {
            type: "all",
            name: "category",
            options: true
        }
    ],

    postRender: function() {
        this.$(".category option:eq(1)").attr('selected', 'selected');
        this._super('postRender');
    },

    chartOptions: function() {
        return {
            type: "boxplot",
            name: this.model.get("objectName"),
            xAxis: this.$(".category select option:selected").text(),
            yAxis: this.$(".value select option:selected").text(),
            bins: this.$(".limiter .selected_value").text()
        }
    }
});
