class WorkfilePresenter < Presenter
  delegate :id, :workspace, :owner, :content_type, :file_name, :latest_workfile_version, :has_draft, :execution_schema, to: :model

  def to_hash
    workfile = {
      :id => id,
      :workspace => present(workspace, @options),
      :owner => present(owner),
      :file_name => h(file_name),
      :file_type => h(content_type),
      :latest_version_id => latest_workfile_version.id,
      :has_draft => has_draft(current_user),
      :is_deleted => model.deleted?
    }
    workfile[:execution_schema] = present(execution_schema) if options[:include_execution_schema]
    workfile
  end

  def complete_json?
    options[:include_execution_schema]
  end
end
