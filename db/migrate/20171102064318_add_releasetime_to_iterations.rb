class AddReleasetimeToIterations < ActiveRecord::Migration
  def change
    add_column :iterations, :release_at, :datetime
  end
end
