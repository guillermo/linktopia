class CreateParliamentaryGroups < ActiveRecord::Migration
  def self.up
    create_table :parliamentary_groups do |t|
      t.string :name
      t.string :logo_url

      t.timestamps
    end
  end

  def self.down
    drop_table :parliamentary_groups
  end
end
