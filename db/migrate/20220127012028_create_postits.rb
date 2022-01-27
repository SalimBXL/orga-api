class CreatePostits < ActiveRecord::Migration[7.0]
  def change
    create_table :postits do |t|
      t.string :title
      t.text :body
      t.integer :level

      t.timestamps
    end
  end
end
