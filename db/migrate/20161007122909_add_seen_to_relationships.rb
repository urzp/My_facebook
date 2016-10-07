class AddSeenToRelationships < ActiveRecord::Migration
  def change
    add_column	:relationships, :seen, :boolean, default: false
  end
end
