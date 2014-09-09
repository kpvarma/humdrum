module Humdrum
  module Generators
    class SetupGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      desc "Generates a database.example.yml file depending upon the database passed (first argument). Usage: rails g humdrum:database postgresql"

      class_option :ruby_version, :type => :string, :default => "1.9.3-p429", :desc => "Ruby Version to create .ruby-version file"
      class_option :rbenv_gemsets, :type => :string, :default => "app", :desc => "Name of the gemset. this file is used by rbenv"

      class_option :config_database, :type => :boolean, :default => true, :desc => "Pass false if you want to generate database.yml again."

      class_option :skip_version, :type => :boolean, :default => false, :desc => "Pass false if you don't want to generate .ruby-version"
      class_option :skip_gemset, :type => :boolean, :default => false, :desc => "Pass false if you don't want to generate .ruby-gemset"
      class_option :skip_gitignore, :type => :boolean, :default => false, :desc => "Pass false if you don't want to generate .gitignore"

      class_option :config_database, :type => :boolean, :default => false, :desc => "Pass --config-database if you want to generate database.yml again."
      class_option :dbase, :type => :string, :default => "postgresql", :desc => "Mention the database postgresql | mysql | sqlite"
      class_option :dbase_name, :type => :string, :default => "app", :desc => "Pass your database username"
      class_option :db_username, :type => :string, :default => "<username>", :desc => "Pass your database username. This requries config_database to be false"
      class_option :db_password, :type => :string, :default => "<password>", :desc => "Pass your database password. This requries config_database to be false"

      def generate_constants_config
        template "config/initializers/config_center.rb", "config/initializers/config_center.rb"
      end

      def generate_locales
        template "config/locales/humdrum.en.yml", "config/locales/humdrum.en.yml"
      end

      def generate_core_ext
        template "lib/core_ext/string.rb", "lib/core_ext/string.rb"
      end

      def set_gitignore
        unless options.skip_gitignore
          template "gitignore", ".gitignore"
        end
      end

      def set_ruby_version
        unless options.skip_ruby_version
          template "ruby-version", ".ruby-version"
        end
      end

      def set_rbenv_gemsets
        unless options.skip_gemset
          template "rbenv-gemsets", ".rbenv-gemsets"
        end
      end

      def configure_database
        if options.config_database
          template "config/database.example.sql", "config/database.example.yml"
          template "config/database.sql", "config/database.yml"
        end
      end

      private

      def dbase
        options.dbase
      end

      def dbase_name
        options.dbase_name
      end

      def db_username
        options.db_username
      end

      def db_password
        options.db_password
      end

      def ruby_version
        options.ruby_version
      end

      def rbenv_gemsets
        options.rbenv_gemsets
      end

    end
  end
end