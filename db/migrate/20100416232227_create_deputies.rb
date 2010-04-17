class CreateDeputies < ActiveRecord::Migration
  def self.up
    create_table :deputies do |t|
      t.string :name
      t.string :photo_url
      t.belongs_to :parliamentary_group
      t.belongs_to :political_party
      t.string :email
      t.string :url
      t.integer :initiatives_count
      t.integer :speeches_count

      t.timestamps
    end
  end

  def self.down
    drop_table :deputies
  end
end
