class AddUserRefToPostits < ActiveRecord::Migration[7.0]
  def change
    add_reference :postits, :user, foreign_key: true
  end
end
