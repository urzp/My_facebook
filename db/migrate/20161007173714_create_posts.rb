class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.date :date
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
