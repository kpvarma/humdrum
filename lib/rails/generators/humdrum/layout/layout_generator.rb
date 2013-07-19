module Humdrum
  module Generators
    class LayoutGenerator < Rails::Generators::Base
      
      source_root File.expand_path('../templates', __FILE__)
      
      desc "Generates a layout file with the name 'public' and the required partials " <<
           "which can be used for all public pages (user need not sign in) like about us, contact us." <<
           "Pass --user_layout to generate another layout for users who are signed in." <<
           "Pass --admin_layout to generate another layout for admin users."
                 
      argument :application_name, :type=>:string, :default => "Application Name"
      #argument :layout_name, :type=>:string, :default => "application"
      
      class_option :fluid, :type => :boolean, :default => true, :desc => "Pass false to create fixed layouts. Default is true"
      
      class_option :stylesheet, :type => :boolean, :default => true, :desc => "This will not generate the stylesheets"
      class_option :javascript, :type => :boolean, :default => true, :desc => "This will not generate the javascripts"
      class_option :graphics, :type => :boolean, :default => true, :desc => "This will not generate the graphics"
  
      class_option :public_layout, :type => :boolean, :default => true, :desc => "This will create a public.html.erb which can be used for public pages, not logged in users."
      class_option :admin_layout, :type => :boolean, :default => false, :desc => "This will create a public.html.erb which can be used for admin pages."
      class_option :user_layout, :type => :boolean, :default => false, :desc => "This will create a public.html.erb which can be used for pages shown to a signed in user."
      
      class_option :front_end_framework, :type => :string, :default => 'gumby', :desc => "Support Twitter Bootstrap (twitter.github.io/bootstrap/) and Gumpy (http://gumbyframework.com/). Default is bootstrap. Pass gumby for Gumby Framework"
      
      ## Parse from config file
      #class_option :config_file, :type => :string, :desc => "Parse options from the config file."
      
      #@@config = nil
  
      #def config
      #  args = options.dup
      #  args.config_file ||= '.csvconverter.yaml'
      #
      #  config = YAML::load File.open(args[:file], 'r')
      #end
  
      def generate_stylesheets
        if options.stylesheet?
          
          template "stylesheets/application.css", "app/assets/stylesheets/application.css"
          
          if options.front_end_framework == "bootstrap"
            
            # Copy bootstrap css file
            copy_file "stylesheets/bootstrap.css", "app/assets/stylesheets/bootstrap.css"
            
            # Its named overrides-bootstrap so that it loads after bootstrap.css
            copy_file "stylesheets/overrides-bootstrap.css", "app/assets/stylesheets/overrides-bootstrap.css"
          elsif options.front_end_framework == "gumby"
            
            # Copy gumby css file
            copy_file "stylesheets/gumby.css", "app/assets/stylesheets/gumby.css"
            copy_file "stylesheets/gumby-pagination.css", "app/assets/stylesheets/gumby-pagination.css"
            
            # Its named overrides-gumby so that it loads after gumby.css
            copy_file "stylesheets/overrides-gumby.css", "app/assets/stylesheets/overrides-gumby.css"
          end
          
        end
      end
  
      def generate_javascripts
        if options.javascript?
          template "javascripts/application.js", "app/assets/javascripts/application.js"
          template "javascripts/validations/main.js", "app/assets/javascripts/validations/main.js"
          copy_file "javascripts/modernizr.2.6.2.js", "app/assets/javascripts/modernizr.2.6.2.js"
          if options.front_end_framework == "bootstrap"
            copy_file "javascripts/bootstrap.js", "app/assets/javascripts/bootstrap.js"
          elsif options.front_end_framework == "gumby"
            copy_file "javascripts/gumby.min.js", "app/assets/javascripts/gumby.min.js"
          end
        end
      end
  
      def generate_graphics
        if options.graphics?
          copy_file "images/favicon.ico", "app/assets/images/favicon.ico"
          if options.front_end_framework == "bootstrap"
            copy_file "images/glyphicons-halflings.png", "app/assets/images/glyphicons-halflings.png"
            copy_file "images/glyphicons-halflings-white.png", "app/assets/images/glyphicons-halflings-white.png"
          elsif options.front_end_framework == "gumby"
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
        template "views/#{options.front_end_framework}/layouts/common/_flash_message.html.erb", "app/views/layouts/common/_flash_message.html.erb"
        template "views/#{options.front_end_framework}/layouts/common/_meta_tags.html.erb", "app/views/layouts/common/_meta_tags.html.erb"
        template "views/#{options.front_end_framework}/layouts/common/_overlays.html.erb", "app/views/layouts/common/_overlays.html.erb"
    
        if options.admin_layout?
          template "views/#{options.front_end_framework}/layouts/admin.html.erb", "app/views/layouts/admin.html.erb" 
          template "views/#{options.front_end_framework}/layouts/admin/_header.html.erb", "app/views/layouts/admin/_header.html.erb"
          template "views/#{options.front_end_framework}/layouts/admin/_footer.html.erb", "app/views/layouts/admin/_footer.html.erb"
          template "views/#{options.front_end_framework}/layouts/admin/_navbar.html.erb", "app/views/layouts/admin/_navbar.html.erb"
        end
    
        if options.public_layout?
          template "views/#{options.front_end_framework}/layouts/public.html.erb", "app/views/layouts/public.html.erb" 
          template "views/#{options.front_end_framework}/layouts/public/_header.html.erb", "app/views/layouts/public/_header.html.erb"
          template "views/#{options.front_end_framework}/layouts/public/_footer.html.erb", "app/views/layouts/public/_footer.html.erb"
          template "views/#{options.front_end_framework}/layouts/public/_navbar.html.erb", "app/views/layouts/public/_navbar.html.erb"
        end
    
        if options.user_layout?
          template "views/#{options.front_end_framework}/layouts/user.html.erb", "app/views/layouts/user.html.erb" 
          template "views/#{options.front_end_framework}/layouts/user/_header.html.erb", "app/views/layouts/user/_header.html.erb"
          template "views/#{options.front_end_framework}/layouts/user/_footer.html.erb", "app/views/layouts/user/_footer.html.erb"
          template "views/#{options.front_end_framework}/layouts/user/_navbar.html.erb", "app/views/layouts/user/_navbar.html.erb"
        end
    
      end
    
      def generate_controllers
        template "controllers/application_controller.rb", "app/controllers/application_controller.rb"
        template "controllers/welcome_controller.rb", "app/controllers/welcome_controller.rb" if options.public_layout?
        template "controllers/public_controller.rb", "app/controllers/public_controller.rb" if options.public_layout?
        template "controllers/user_controller.rb", "app/controllers/user_controller.rb" if options.user_layout?
        template "controllers/admin_controller.rb", "app/controllers/admin_controller.rb" if options.admin_layout?
      end
      
      def generate_views
        template "views/#{options.front_end_framework}/welcome/index.html.erb", "app/views/welcome/index.html.erb" if options.public_layout?
      end
      
      def generate_routes
        route("root :to => 'welcome#index'")
      end
      
      private
  
      def container_class
        options.fluid? ? "container-fluid" : "container"
      end
      
      def row_class
        options.fluid? ? "row-fluid" : "row"
      end
      
    end
  end
end