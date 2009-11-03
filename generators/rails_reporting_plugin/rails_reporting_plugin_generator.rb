require File.expand_path(File.dirname(__FILE__) + "/lib/insert_routes.rb")

class RailsReportingPluginGenerator < Rails::Generator::Base 
  
  def manifest
    record do |r|
      r.migration_template 'migration.rb', "db/migrate"
      r.route_resource :p_reports
    end
  end
  
  def file_name
    "create_rails_reporting_plugin" 
  end
  
end
