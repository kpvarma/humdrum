module Humdrum
  module Generators
    class ResourceGenerator < Rails::Generators::Base
      
      source_root File.expand_path('../templates', __FILE__)
      
      desc "Generates a controller, view and route entries for CRUD operations of a resource"
      
      argument :resource_name, :type=>:string
      argument :field, :type=>:string
      
      class_option :layout_name, :type => :string, :default => "public", :desc => "The controllers will use this layout while rendering the views"
      class_option :module_name, :type => :string, :default => nil, :desc => "It will group the controllers, views under this module. Routes will use this as a namespace"

      def generate_controllers
        
        puts "resource_name: #{resource_name}"
        puts "layout_name: #{options.layout_name}"
        puts "module_name: #{options.module_name}"
        puts "options: #{options.inspect}"
        
        #if options.module_name?
        #  template "controllers/resource_controller.rb", "app/controllers/#{module_name}/#{resource_name}_controller.rb"
        #else
        #  template "controllers/resource_controller.rb", "app/controllers/#{resource_name}_controller.rb"
        #end
      end
      
      def generate_views
        #if options.module_name?
        #  parent_folder = "app/views/#{module_name}/#{resource_name}"
        #else
        #  parent_folder = "app/views/#{resource_name}"
        #end
        #template "views/resources/index.html.erb", "#{parent_folder}/index.html.rb"
      end
      
      def generate_routes
        #route("root :to => 'welcome#index'")
      end
      
      private
  
      def file_name
        layout_name.underscore
      end
  
    end
  end
end