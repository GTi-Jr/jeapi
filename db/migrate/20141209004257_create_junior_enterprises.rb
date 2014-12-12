class CreateJuniorEnterprises < ActiveRecord::Migration
  def change
    create_table :junior_enterprises do |t|
      t.string :name
      t.string :logo
      t.text :description
      t.text :phrase
      t.string :site
      t.string :phone
      t.string :city
      t.string :state
      t.string :youtube
      t.string :facebook
      t.string :course
      t.string :area
      t.string :address
      t.boolean :consultor
      t.boolean :product
      t.integer :access
      t.boolean :project
      t.boolean :training
      t.integer :user_id

      t.timestamps
    end
    add_index :junior_enterprises, :user_id
  end
end
