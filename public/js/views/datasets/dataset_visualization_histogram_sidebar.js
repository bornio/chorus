chorus.views.DatasetVisualizationHistogramSidebar = chorus.views.DatasetVisualizationSidebar.extend({
    className: "dataset_visualization_histogram_sidebar",

    chartOptions: function() {
        return {
            type: "histogram",
            name: this.model.get("objectName"),
            xAxis: this.$(".category select option:selected").text(),
            bins: this.$(".limiter .selected_value").text()
        }
    },

    additionalContext: function() {
        return {
            chartType: "histogram",
            numericColumns: this.numericColumns()
        }
    }
});