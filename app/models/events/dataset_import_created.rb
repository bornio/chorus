module Events
  class DatasetImportCreated < Base
    has_targets :workspace, :dataset
    has_activities :actor, :workspace, :dataset
    has_additional_data :source_dataset_id, :destination_table
    translate_additional_data_ids :source_dataset => Dataset
  end
end