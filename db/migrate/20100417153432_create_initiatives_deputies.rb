class CreateInitiativesDeputies < ActiveRecord::Migration
  def self.up
    create_table :deputies_initiatives do |t|
      t.integer :initiative_id
      t.integer :deputy_id
    end
  end

  def self.down
    drop_table :deputies_initiatives
  end
end
