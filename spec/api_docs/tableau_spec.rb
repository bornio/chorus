require 'spec_helper'

resource "Tableau" do
  let(:dataset) { datasets(:chorus_view) }
  let(:workspace) { workspaces(:public) }
  let(:user) { dataset.gpdb_instance.owner }

  before do
    log_in user
    any_instance_of(TableauWorkbook) do |wb|
      stub(wb).save { true }
    end
  end

  post "/workspaces/:workspace_id/datasets/:dataset_id/tableau_workbooks" do
    parameter :name, "Name of the workbook to be created"
    parameter :dataset_id, "Id of the dataset to link to the workbook"
    parameter :workspace_id, "Id of the workspace containing the dataset"

    required_parameters :name
    required_parameters :dataset_id
    required_parameters :workspace_id

    let(:dataset_id) { dataset.id }
    let(:workspace_id) { workspace.id }
    let(:name) { 'MyTableauWorkbook'}

    example_request "Create a tableau workbook" do
      status.should == 201
    end
  end
end