class RemoveGuidFromRoutes < ActiveRecord::Migration
  def up
    remove_column :routes, :guid
  end

  def down
    add_column :routes, :guid, :string
  end
end
