class Create<%= model_class.pluralize %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
    <%- fields.each do |name, type| -%>
      t.<%= type %> :<%= name %>
    <%- end -%>
    t.timestamps
    end
  end

  def self.down
    drop_table :<%= table_name %>
  end
end