class CreateInitiatives < ActiveRecord::Migration
  def self.up
    create_table :initiatives do |t|
      t.string :body
      t.string :kind
      t.string :subkind
      t.datetime :submitted_at
      t.datetime :described_at
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :initiatives
  end
end
