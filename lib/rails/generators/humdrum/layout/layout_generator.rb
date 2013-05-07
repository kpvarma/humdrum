module Humdrum
  module Generators
    class LayoutGenerator < Rails::Generators::Base
      
      source_root File.expand_path('../templates', __FILE__)
      
      desc "Generates a layout file with the name 'public' and the required partials " <<
           "which can be used for all public pages (user need not sign in) like about us, contact us." <<
           "Pass --user_layout to generate another layout for users who are signed in." <<
           "Pass --admin_layout to generate another layout for admin users."
                 
      argument :layout_name, :type=>:string, :default => "application"
      argument :application_name, :type=>:string, :default => "Application Name"
  
      class_option :stylesheet, :type => :boolean, :default => true, :desc => "This will not generate the stylesheets"
      class_option :javascript, :type => :boolean, :default => true, :desc => "This will not generate the javascripts"
      class_option :graphics, :type => :boolean, :default => true, :desc => "This will not generate the graphics"
  
      class_option :public_layout, :type => :boolean, :default => true, :desc => "This will create a public.html.erb which can be used for public pages, not logged in users."
      class_option :admin_layout, :type => :boolean, :default => false, :desc => "This will create a public.html.erb which can be used for admin pages."
      class_option :user_layout, :type => :boolean, :default => false, :desc => "This will create a public.html.erb which can be used for pages shown to a signed in user."
      
      def generate_stylesheets
        if options.stylesheet?
          copy_file "stylesheets/boilerplate.css.scss", "app/assets/stylesheets/humdrum/boilerplate.css.scss"
          copy_file "stylesheets/normalize.css.scss", "app/assets/stylesheets/humdrum/normalize.css.scss"
          copy_file "stylesheets/positioning.css.scss", "app/assets/stylesheets/humdrum/positioning.css.scss"
          copy_file "stylesheets/palettes.css.scss", "app/assets/stylesheets/humdrum/palettes.css.scss"
          copy_file "stylesheets/box.css.scss", "app/assets/stylesheets/humdrum/box.css.scss"
          copy_file "stylesheets/caligraphy.css.scss", "app/assets/stylesheets/humdrum/caligraphy.css.scss"
          copy_file "stylesheets/dividers.css.scss", "app/assets/stylesheets/humdrum/dividers.css.scss"
          copy_file "stylesheets/form.css.scss", "app/assets/stylesheets/humdrum/form.css.scss"
          copy_file "stylesheets/misc.css.scss", "app/assets/stylesheets/humdrum/misc.css.scss"
        end
      end
  
      def generate_javascripts
        if options.javascript?
          copy_file "javascripts/modernizr.2.6.2.js", "app/assets/javascripts/humdrum/modernizr.2.6.2.js"
        end
      end
  
      def generate_graphics
        if options.graphics?
          copy_file "images/favicon.ico", "app/assets/images/favicon.ico"
          copy_file "images/glyphicons-halflings.png", "app/assets/images/glyphicons-halflings.png"
          copy_file "images/glyphicons-halflings-white.png", "app/assets/images/glyphicons-halflings-white.png"
        end
      end
  
      def generate_layout
        template "views/layouts/common/_flash_message.html.erb", "app/views/layouts/common/_flash_message.html.erb"
        template "views/layouts/common/_meta_tags.html.erb", "app/views/layouts/common/_meta_tags.html.erb"
    
        if options.admin_layout?
          template "views/layouts/admin.html.erb", "app/views/layouts/admin.html.erb" 
          template "views/layouts/admin/_header.html.erb", "app/views/layouts/admin/_header.html.erb"
          template "views/layouts/admin/_footer.html.erb", "app/views/layouts/admin/_footer.html.erb"
          template "views/layouts/admin/_navbar.html.erb", "app/views/layouts/admin/_navbar.html.erb"
        end
    
        if options.public_layout?
          template "views/layouts/public.html.erb", "app/views/layouts/public.html.erb" 
          template "views/layouts/public/_header.html.erb", "app/views/layouts/public/_header.html.erb"
          template "views/layouts/public/_footer.html.erb", "app/views/layouts/public/_footer.html.erb"
          template "views/layouts/public/_navbar.html.erb", "app/views/layouts/public/_navbar.html.erb"
        end
    
        if options.user_layout?
          template "views/layouts/user.html.erb", "app/views/layouts/user.html.erb" 
          template "views/layouts/user/_header.html.erb", "app/views/layouts/user/_header.html.erb"
          template "views/layouts/user/_footer.html.erb", "app/views/layouts/user/_footer.html.erb"
          template "views/layouts/user/_navbar.html.erb", "app/views/layouts/user/_navbar.html.erb"
        end
    
      end
    
      def generate_controllers
        template "controllers/welcome_controller.rb", "app/controllers/welcome_controller.rb" if options.public_layout?
        template "controllers/public_controller.rb", "app/controllers/public_controller.rb" if options.public_layout?
        template "controllers/user_controller.rb", "app/controllers/user_controller.rb" if options.user_layout?
        template "controllers/admin_controller.rb", "app/controllers/admin_controller.rb" if options.admin_layout?
      end
      
      def generate_views
        template "views/welcome/index.html.erb", "app/views/welcome/index.html.erb" if options.public_layout?
      end
      
      def generate_routes
        route("root :to => 'welcome#index'")
      end
      
      private
  
      def file_name
        layout_name.underscore
      end
  
    end
  end
end