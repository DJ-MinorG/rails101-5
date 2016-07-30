class AddTableToGroup < ActiveRecord::Migration[5.0]
  def change
      create_table :groups do |t|
        t.column :title, :string
        t.column :description, :text
      end
  end
end
