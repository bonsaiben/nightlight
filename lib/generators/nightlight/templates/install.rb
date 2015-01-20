class <%= migration_class_name %> < ActiveRecord::Migration
  def change
    create_table :nightlight_pages do |t|
      t.references :assignee
      t.string :name
      t.string :path
      t.string :reqs
      t.string :sample_path
      t.text :notes
      t.datetime :last_checked_at
      t.boolean :hidden, default: false
      t.timestamps
    end

    create_table :nightlight_activities do |t|
      t.references :user
      t.references :page
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
