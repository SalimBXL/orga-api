class AddIsPrivateToPostits < ActiveRecord::Migration[7.0]
  def change
    add_column :postits, :is_private, :boolean
  end
end
