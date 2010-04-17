class CreatePoliticalParties < ActiveRecord::Migration
  def self.up
    create_table :political_parties do |t|
      t.string :name
      t.string :logo_url

      t.timestamps
    end
  end

  def self.down
    drop_table :political_parties
  end
end
