class AddStartToIterations < ActiveRecord::Migration
  def change
    add_column :iterations, :start, :datetime
  end
end
