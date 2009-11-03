require 'fileutils'

dir = File.dirname(__FILE__)
# Install Controllers
FileUtils.cp File.join(dir, 'lib', 'controllers', 'p_reports_controller.rb'), File.join(dir, '../../../app/controllers/p_reports_controller.rb')
# Install Models
FileUtils.cp File.join(dir, 'lib', 'models', 'p_reports.rb'), File.join(dir, '../../../app/models/p_reports.rb')
# Install Views
FileUtils.cp_r Dir[File.join(dir, 'lib', 'views', '*')], File.join(dir, '../../../app/views')
# Show the Install documentation
puts IO.read(File.join(File.dirname(__FILE__), 'INSTALL'))
