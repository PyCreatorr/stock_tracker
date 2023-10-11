class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      #automatically generated reference to the existed user table. from g migration
      t.references :user, null: false, foreign_key: true 

      # Self association manually created. Refer unexisted table friend to the users.
      t.references :friend, refereces: :users, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
