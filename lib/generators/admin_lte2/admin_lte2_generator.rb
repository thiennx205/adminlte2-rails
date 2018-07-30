class AdminLte2Generator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  class_option :stylesheet_engine

  def main
    stylesheet_extension = options[:stylesheet_engine] || 'css'

    inject_into_file "app/assets/stylesheets/application.#{stylesheet_extension}", "@import \"AdminLTE/skins/skin-blue\";\n", after: ' */'
    inject_into_file "app/assets/stylesheets/application.#{stylesheet_extension}", "@import \"AdminLTE/AdminLTE\";\n", after: ' */'
    inject_into_file "app/assets/stylesheets/application.#{stylesheet_extension}", "@import \"bootstrap\";\n", after: ' */'
    inject_into_file "app/assets/stylesheets/application.#{stylesheet_extension}", "\n@import \"bootstrap-sprockets\";\n", after: ' */'

    inject_into_file "app/assets/javascripts/application.js", "//= require bootstrap-sprockets\n", after: "//= require jquery\n"
    inject_into_application_javascript('app', before: '//= require_tree')

    copy_file '_admin_lte_2_header.html.erb', 'app/views/layouts/_admin_lte_2_header.html.erb'
    copy_file '_admin_lte_2_sidebar.html.erb', 'app/views/layouts/_admin_lte_2_sidebar.html.erb'
    copy_file 'admin_lte_2.html.erb', 'app/views/layouts/admin_lte_2.html.erb'
  end

  private

  def inject_into_application_stylesheet(file)
    stylesheet_extension = options[:stylesheet_engine] || 'css'
    inject_into_file "app/assets/stylesheets/application.#{stylesheet_extension}", " *= require #{file}\n", before: ' *= require_self'
  end

  def inject_into_application_javascript(file, before: '//= require app')
    inject_into_file 'app/assets/javascripts/application.js', "//= require #{file}\n", before: before
  end

end