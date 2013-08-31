module Humdrum
  module Generators
    class LayoutGenerator < Rails::Generators::Base
      
      source_root File.expand_path('../templates', __FILE__)
      
      desc "Generates a layout file with the given name (default is 'application') and the required partials " <<
           "Pass --application_name=MyNewApp to set a name / brand for the application." <<
           "Pass --framework=bootstrap3 to copy bootstrap3 assets and generate a layout which is compatible to it."
      
      argument :layout_name, :type=>:string, :default => "application", :desc => "This creates/replaces application.html.erb by default"
      
      class_option :application_name, :type => :string, :default => "New App", :desc => "The name of the application. This is used as the brand name in header."
      class_option :fixed, :type => :boolean, :default => false, :desc => "Create fixed layouts. Default is fluid (Gumby doesn't support fluid framework. Hence applicable only for bootstrap for the timebeing.)"
      class_option :framework, :type => :string, :default => 'bootstrap3', :desc => "Support Twitter Bootstrap (twitter.github.io/bootstrap/) and Gumpy (http://gumbyframework.com/). Default is bootstrap. Pass gumby for Gumby Framework"
      
      class_option :skip_stylesheet, :type => :boolean, :default => false, :desc => "Generate the stylesheets"
      class_option :skip_javascript, :type => :boolean, :default => false, :desc => "Generate the javascripts"
      class_option :skip_graphics, :type => :boolean, :default => false, :desc => "Generate the graphics (images required for the css and UI frameworks)"

      class_option :skip_welcome_page, :type => :boolean, :default => false, :desc => "Skip creating welcome_controller.rb, index action and related views & routes."
      class_option :skip_kaminari, :type => :boolean, :default => false, :desc => "Skip creating kaminari views for pagination"

      ## Parse from config file
      #class_option :config_file, :type => :string, :desc => "Parse options from the config file."
      
      #@@config = nil
  
      #def config
      #  args = options.dup
      #  args.config_file ||= '.csvconverter.yaml'
      #
      #  config = YAML::load File.open(args[:file], 'r')
      #end
      
      def application_name
        options.application_name
      end
      
      def framework
        options.framework
      end
      
      def generate_stylesheets
        unless options.skip_stylesheet?
          
          template "stylesheets/application.css", "app/assets/stylesheets/application.css"
          
          case framework
          when "bootstrap3"
            
            # Copy bootstrap css file
            copy_file "stylesheets/bootstrap3/bootstrap.css", "app/assets/stylesheets/bootstrap.css"
            
            # Its named overrides-bootstrap so that it loads after bootstrap.css
            copy_file "stylesheets/bootstrap3/overrides-bootstrap.css", "app/assets/stylesheets/overrides-bootstrap.css"
          when "bootstrap2"
            
            # Copy bootstrap css file
            copy_file "stylesheets/bootstrap2/bootstrap.css", "app/assets/stylesheets/bootstrap.css"
            copy_file "stylesheets/bootstrap2/bootstrap-responsive.css", "app/assets/stylesheets/bootstrap-responsive.css"
            
            # Its named overrides-bootstrap so that it loads after bootstrap.css
            copy_file "stylesheets/bootstrap2/overrides-bootstrap.css", "app/assets/stylesheets/overrides-bootstrap.css"
          when "gumby"
            
            # Copy gumby css file
            copy_file "stylesheets/gumby/gumby.css", "app/assets/stylesheets/gumby.css"
            copy_file "stylesheets/gumby/gumby-pagination.css", "app/assets/stylesheets/gumby-pagination.css"
            
            # Its named overrides-gumby so that it loads after gumby.css
            copy_file "stylesheets/gumby/overrides-gumby.css", "app/assets/stylesheets/overrides-gumby.css"
          end
          
        end
      end
  
      def generate_javascripts
        unless options.skip_javascript?
          template "javascripts/application.js", "app/assets/javascripts/application.js"
          template "javascripts/validations/#{framework}/main.js", "app/assets/javascripts/validations/main.js"
          copy_file "javascripts/modernizr.2.6.2.js", "app/assets/javascripts/modernizr.2.6.2.js"
          case framework
          when "bootstrap3"
            copy_file "javascripts/bootstrap3/bootstrap.min.js", "app/assets/javascripts/bootstrap.min.js"
            copy_file "javascripts/bootstrap3/utilities.js", "app/assets/javascripts/utilities.js"
          when "bootstrap2"
            copy_file "javascripts/bootstrap2/bootstrap.min.js", "app/assets/javascripts/bootstrap.min.js"
            copy_file "javascripts/bootstrap2/utilities.js", "app/assets/javascripts/utilities.js"
          when "gumby"
            copy_file "javascripts/gumby/gumby.min.js", "app/assets/javascripts/gumby.min.js"
          end
        end
      end
  
      # TODO - This section has to be optimized. All the assets should be organized under the framework folders.
      # We should also use fontawesome irrespective of what the framework is
      def generate_graphics
        unless options.skip_graphics?
          copy_file "images/favicon.ico", "app/assets/images/favicon.ico"
          case framework
          when "bootstrap3"
            #copy_file "images/glyphicons-halflings.png", "app/assets/images/glyphicons-halflings.png"
            #copy_file "images/glyphicons-halflings-white.png", "app/assets/images/glyphicons-halflings-white.png"
          when "bootstrap2"
            copy_file "images/glyphicons-halflings.png", "app/assets/images/glyphicons-halflings.png"
            copy_file "images/glyphicons-halflings-white.png", "app/assets/images/glyphicons-halflings-white.png"
          when "gumby"
            directory "images/fonts", "app/assets/images/fonts"
          end
        end
      end
      
      def generate_helpers
        template "helpers/title_helper.rb", "app/helpers/title_helper.rb"
        template "helpers/navigation_helper.rb", "app/helpers/navigation_helper.rb"
        template "helpers/meta_tags_helper.rb", "app/helpers/meta_tags_helper.rb"
        template "helpers/display_helper.rb", "app/helpers/display_helper.rb"
        template "helpers/params_parser_helper.rb", "app/helpers/params_parser_helper.rb"
        template "helpers/flash_helper.rb", "app/helpers/flash_helper.rb"
      end
      
      def generate_layout
        
        template "views/#{framework}/layouts/application.html.erb", "app/views/layouts/application.html.erb" 
        template "views/#{framework}/layouts/application/_header.html.erb", "app/views/layouts/application/_header.html.erb"
        template "views/#{framework}/layouts/application/_footer.html.erb", "app/views/layouts/application/_footer.html.erb"
        template "views/#{framework}/layouts/application/_navbar.html.erb", "app/views/layouts/application/_navbar.html.erb"
        
        template "views/#{framework}/layouts/common/_flash_message.html.erb", "app/views/layouts/common/_flash_message.html.erb"
        template "views/#{framework}/layouts/common/_meta_tags.html.erb", "app/views/layouts/common/_meta_tags.html.erb"
        template "views/#{framework}/layouts/common/_overlays.html.erb", "app/views/layouts/common/_overlays.html.erb"
        
        template "views/#{framework}/layouts/layout_name.html.erb", "app/views/layouts/#{layout_name}.html.erb" 
        template "views/#{framework}/layouts/layout_name/_header.html.erb", "app/views/layouts/#{layout_name}/_header.html.erb"
        template "views/#{framework}/layouts/layout_name/_footer.html.erb", "app/views/layouts/#{layout_name}/_footer.html.erb"
        template "views/#{framework}/layouts/layout_name/_navbar.html.erb", "app/views/layouts/#{layout_name}/_navbar.html.erb"
    
      end
    
      def generate_controllers
        template "controllers/application_controller.rb", "app/controllers/application_controller.rb"
        template "controllers/welcome_controller.rb", "app/controllers/welcome_controller.rb" unless options.skip_welcome_page?
        template "controllers/layout_name_controller.rb", "app/controllers/#{layout_name}_controller.rb"
      end
      
      def generate_views
        template "views/#{framework}/welcome/index.html.erb", "app/views/welcome/index.html.erb" unless options.skip_welcome_page?
        
        # Copy kaminari templates
        unless options.skip_kaminari?
          template "views/#{framework}/kaminari/_first_page.html.erb", "app/views/kaminari/_first_page.html.erb"
          template "views/#{framework}/kaminari/_gap.html.erb", "app/views/kaminari/_gap.html.erb"
          template "views/#{framework}/kaminari/_last_page.html.erb", "app/views/kaminari/_last_page.html.erb"
          template "views/#{framework}/kaminari/_next_page.html.erb", "app/views/kaminari/_next_page.html.erb"
          template "views/#{framework}/kaminari/_page.html.erb", "app/views/kaminari/_page.html.erb"
          template "views/#{framework}/kaminari/_paginator.html.erb", "app/views/kaminari/_paginator.html.erb"
          template "views/#{framework}/kaminari/_prev_page.html.erb", "app/views/kaminari/_prev_page.html.erb"
        end
      end
      
      def generate_routes
        route("root :to => 'welcome#index'") unless options.skip_welcome_page
      end
      
      private
  
      def container_class
        case framework
        when "bootstrap3", "gumby"
          "container"
        when "bootstrap2"
          options.fixed? ? "container" : "container-fluid"
        else
          options.fixed? ? "container" : "container-fluid"
        end
      end
      
      def row_class
        case framework
        when "bootstrap3", "gumby"
          "row"
        when "bootstrap2"
          options.fixed? ? "row" : "row-fluid"
        else
          options.fixed? ? "row" : "row-fluid"
        end
      end
      
    end
  end
end