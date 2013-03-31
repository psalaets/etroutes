class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name
      t.string :url
      t.string :rid
      t.string :grade
      t.string :set_by
      t.string :gym
      t.string :location

      t.timestamps
    end
  end
end
