require_relative '../../version'
require 'ldap_client'

class ConfigurationsController < ApplicationController
  skip_before_filter :require_login, :only => :version

  def show
    render :json => { :response => { :external_auth_enabled => LdapClient.enabled? } }
  end

  def version
    render :inline => build_string
  end

  def build_string
    f = File.join(Rails.root, 'version_build')
    File.exists?(f) ? File.read(f) : Chorus::VERSION::STRING
  end
end
