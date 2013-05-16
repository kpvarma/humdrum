require 'rails/generators'
require 'rails/generators/migration'

module Humdrum
  module Generators
    class ResourceGenerator < Rails::Generators::Base
      
      include Rails::Generators::Migration
      
      def self.next_migration_number(path)
        @migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i.to_s
      end
      
      source_root File.expand_path('../templates', __FILE__)
      
      desc "Generates a controller, view and route entries for CRUD operations of a resource"
      
      argument :resource_name, :type=>:string
      argument :fields, :type=>:hash, :banner =>"Resource Fields."
      
      class_option :debug, :type => :boolean, :default => false, :desc => "This will print the arguments for debugging"
      
      def debug_args
        print_args if options.debug?
      end
      
      def generate_controllers
        template "controllers/resource_controller.rb", "app/controllers/#{controller_path}_controller.rb"
      end
      
      def generate_views
        template "views/resource/_edit.html.erb", "app/views/#{controller_path}/_edit.html.erb"
        template "views/resource/_filters.html.erb", "app/views/#{controller_path}/_filters.html.erb"
        template "views/resource/_form.html.erb", "app/views/#{controller_path}/_form.html.erb"
        template "views/resource/_index.html.erb", "app/views/#{controller_path}/_index.html.erb"
        template "views/resource/_item.html.erb", "app/views/#{controller_path}/_item.html.erb"
        template "views/resource/_nav_filters.html.erb", "app/views/#{controller_path}/_nav_filters.html.erb"
        template "views/resource/_new.html.erb", "app/views/#{controller_path}/_new.html.erb"
        template "views/resource/_show.html.erb", "app/views/#{controller_path}/_show.html.erb"
        template "views/resource/_summary.html.erb", "app/views/#{controller_path}/_summary.html.erb"
        template "views/resource/create.js.erb", "app/views/#{controller_path}/create.js.erb"
        template "views/resource/destroy.js.erb", "app/views/#{controller_path}/destroy.js.erb"
        template "views/resource/edit.js.erb", "app/views/#{controller_path}/edit.js.erb"
        template "views/resource/index.js.erb", "app/views/#{controller_path}/index.js.erb"
        template "views/resource/new.js.erb", "app/views/#{controller_path}/new.js.erb"
        template "views/resource/show.js.erb", "app/views/#{controller_path}/show.js.erb"
        template "views/resource/update.js.erb", "app/views/#{controller_path}/update.js.erb"
        template "views/resource/index.html.erb", "app/views/#{controller_path}/index.html.erb"
      end
      
      def generate_models
        template "models/resource.rb", "app/models/#{model_path}.rb"
      end
      
      def generate_migrations
        migration_template "migrations/create_resources.rb", "db/migrate/create_#{instances_name}"
      end
      
      def generate_routes
        words = name_phrases
        resource = words.pop
        route words.reverse.inject("resources :#{resource.pluralize}") { |acc, phrase|
          "namespace(:#{phrase}){ #{acc} }"
        }
      end
      
      def generate_locales
        template "config/locales/humdrum.en.yml", "config/locales/humdrum.en.yml"
      end
      
      private
      
      def print_args
        puts ":fields: #{fields}"
        puts ":form_link_param: #{form_link_param}"
        puts "name_phrases: #{name_phrases}"
        puts "controller_path: #{controller_path}"
        puts "controller_class: #{controller_class}"
        puts "model_path: #{model_path}"
        puts "model_class: #{model_class}"
        puts "instance_name: #{instance_name}"
        puts "instances_name: #{instances_name}"
        puts "table_name: #{table_name}"
        
        puts "index path: #{resource_link}"
        puts "show path: #{resource_link('show')}"
        puts "new path: #{resource_link('new')}"
        puts "edit path: #{resource_link('edit')}"
        puts "create path: #{resource_link('create')}"
        puts "update path: #{resource_link('update')}"
        puts "destroy path: #{resource_link('destroy')}"
        
        puts "index url: #{resource_link('index','url')}"
        puts "show url: #{resource_link('show','url')}"
        puts "new url: #{resource_link('new','url')}"
        puts "edit url: #{resource_link('edit','url')}"
        puts "create url: #{resource_link('create','url')}"
        puts "update url: #{resource_link('update','url')}"
        puts "destroy url: #{resource_link('destroy','url')}"
      end
      
      def name_phrases
        if resource_name.include?('::')
          resource_name.split("::")
        elsif resource_name.include?('/')
          resource_name.split("/")
        else
          [resource_name]
        end
      end
      
      def controller_path
        words = name_phrases
        resource = words.pop
        if words.any?
          words.collect(&:downcase).join("/") + "/#{resource.pluralize}"
        else
          "#{resource.pluralize}"
        end
      end
      
      def controller_class
        words = name_phrases
        resource = words.pop
        if words.any?
          words.collect(&:camelize).join("::") + "::#{resource.camelize.pluralize}Controller"
        else
          "#{resource.camelize.pluralize}Controller"
        end
      end
      
      def model_path
        name_phrases.last.downcase
      end
      
      def model_class
        name_phrases.last.camelize
      end
      
      def instance_name
        name_phrases.last.underscore
      end
      
      def instances_name
        instance_name.pluralize
      end
      
      def table_name
        instances_name
      end
      
      def resource_link(actn='index', ltype='path')
        map = {
          'index' => '',
          'show' => '',
          'edit' => 'edit_',
          'new' => 'new_',
          'update' => '',
          'create' => '',
          'destroy' => '',
        }
        words = name_phrases
        resource = words.pop
        if actn == "index"
          map[actn] + (words.any? ? words.join("_" + "_") : "") + resource.pluralize + "_" + ltype
        else
          map[actn] + (words.any? ? words.join("_") + "_" : "") + resource + "_" + ltype
        end
      end 
      
      def form_link_param
        words = name_phrases
        resource = words.pop
        if words.any?
          # to print like this [:admin, :user, :location, @chakka]
          # in form.html.erb
          "[" + (words.map{|x| ":" + x.downcase} << "@" + resource.downcase).join(", ") + "]"
        else
          "@#{resource.downcase}"
        end
      end
      
      def input_type(name, type)
        if name.include?("email") && type == "string"
          return "email"
        elsif name.include?("password") && type == "string"
          return "password"
        elsif (name.include?("phone") || name.include?("mobile")) && type == "string"
          return "tel"
        else
          case type
          when "string"
            "text"
          when "text"
            "textarea"
          when "integer"
            "number"
          when "references"
            "type"
          when "date"
            "date"
          when "datetime"
            "datetime-local"
          when "timestamp", "time"
            "time"
          end
        end
      end
      
      ## List of all the string fields 
      def string_fields
        main_field = main_string_field
        fields.map{|name, type| name if name != main_field && type == "string" }.uniq.compact
      end
      
      ## The main string field like 'name'
      def main_string_field
        fields.map{|name, type| name if name.include?("name") && type == "string"}.uniq.compact || fields.keys.any? ? fields.keys.first : "id"
      end
      
      ## Text Fields like description or summary
      def text_fields
        fields.map{|name, type| name if type == "text"}.uniq.compact
      end
    	
    end
  end
end