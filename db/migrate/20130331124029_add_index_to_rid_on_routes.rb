class AddIndexToRidOnRoutes < ActiveRecord::Migration
  def change
    change_table :routes do |t|
      t.index :rid
    end
  end
end
