class CreateRailsReportingPlugins < ActiveRecord::Migration
  def self.up
    create_table :p_reports do |t|
      t.string :name
      t.text   :description
      t.text   :code

      t.timestamps
    end
  end

  def self.down
    drop_table :p_reports
  end
end
