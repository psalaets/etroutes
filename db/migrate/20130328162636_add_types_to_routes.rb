class AddTypesToRoutes < ActiveRecord::Migration
  def change
    change_table :routes do |t|
      t.string :types
    end
  end
end
