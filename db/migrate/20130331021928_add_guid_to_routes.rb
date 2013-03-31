class AddGuidToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :guid, :string
  end
end
