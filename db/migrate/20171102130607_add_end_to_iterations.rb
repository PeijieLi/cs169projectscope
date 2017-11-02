class AddEndToIterations < ActiveRecord::Migration
  def change
    add_column :iterations, :end, :datetime
  end
end
