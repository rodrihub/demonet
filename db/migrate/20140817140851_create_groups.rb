class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :desc
      t.string :type
      t.string :state

      t.timestamps
    end
  end
end
