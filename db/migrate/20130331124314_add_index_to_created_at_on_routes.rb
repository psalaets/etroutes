class AddIndexToCreatedAtOnRoutes < ActiveRecord::Migration
  def change
    change_table :routes do |t|
      t.index :created_at
    end
  end
end
