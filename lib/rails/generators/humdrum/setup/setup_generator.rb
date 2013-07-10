module Humdrum
  module Generators
    class SetupGenerator < Rails::Generators::Base
      
      source_root File.expand_path('../templates', __FILE__)
      
      desc "Generates a database.example.yml file depending upon the database passed (first argument). Usage: rails g humdrum:database postgresql"
                 
      class_option :dbase, :type => :string, :default => "postgresql", :desc => "Mention the database postgresql | mysql | sqlite"
      class_option :dbase_name, :type => :string, :default => "app", :desc => "Pass your database username"
      class_option :db_username, :type => :string, :default => "<username>", :desc => "Pass your database username"
      class_option :db_password, :type => :string, :default => "<password>", :desc => "Pass your database password"
      class_option :ruby_version, :type => :string, :default => "ruby-1.9.3-p429", :desc => "Ruby Version to create .ruby-version file"
      class_option :ruby_gemset, :type => :string, :default => "app", :desc => "Name of the gemset"
  
      def set_database
        template "config/database.example.sql", "config/database.example.yml"
        template "config/database.sql", "config/database.yml"
      end
      
      def set_gitignore
        template ".gitignore", "gitignore"
      end
      
      def set_ruby_version
        template ".ruby-version", "ruby-version"
      end
      
      def set_ruby_gemset
        template ".ruby-gemset", "ruby-gemset"
      end
      
      private
      
      def dbase
        options.dbase
      end
      
      def dbase_name
        options.dbase_name
      end
  
    end
  end
end