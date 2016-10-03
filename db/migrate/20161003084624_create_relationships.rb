class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :wish_id
      t.integer :inv_id
      t.boolean :accepted, default: false

      t.timestamps null: false
    end
    add_index	:relationships,	:wish_id
    add_index	:relationships,	:inv_id
    add_index	:relationships,	[:wish_id,	:inv_id],	unique:	true
  end
end
