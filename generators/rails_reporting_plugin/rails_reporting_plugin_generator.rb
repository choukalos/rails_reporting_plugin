class RailsReportingPluginGenerator < Rails::Generator::Base 
  
  def manifest
    record do |r|
      r.migration_template 'migration.rb', "db/migrate"
      r.rotue_resource :p_reports
    end
  end
  
  def file_name
    "create_rails_reporting_plugin" 
  end
  
end
