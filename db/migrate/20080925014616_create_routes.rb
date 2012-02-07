class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.string :from
      t.string :to
      t.integer :distance
      t.integer :detour
      t.integer :time_to_pickup

      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
