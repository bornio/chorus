class SearchController < ApplicationController
  before_filter :require_admin, :only => [:reindex]

  def show
    present Search.new(current_user, params)
  end

  def reindex
    QC.enqueue("SolrIndexer.refresh_and_index", params.fetch(:types) { 'all' })
    render :json => {}
  end
end