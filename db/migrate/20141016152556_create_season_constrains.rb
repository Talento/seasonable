class CreateSeasonConstrains < ActiveRecord::Migration
  def change
    create_table :season_constrains do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.references :target, :polymorphic => true
      t.timestamps
    end
  end
end
