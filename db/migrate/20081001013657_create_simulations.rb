class CreateSimulations < ActiveRecord::Migration
  def self.up
    create_table :simulations do |t|
      t.integer :anzahl_autos
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :simulations
  end
end
