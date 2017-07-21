class CreateChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :checks do |t|
      t.text :addresses

      t.timestamps
    end
  end
end
