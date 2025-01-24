class UpdateAssociations < ActiveRecord::Migration[8.0]
  def change
    add_reference :events, :organizer, null: false, foreign_key: { to_table: :users }

    # Add event_id and attendee_id to invitations table
    change_table :invitations do |t|
      t.references :event, null: false, foreign_key: true
      t.references :attendee, null: false, foreign_key: { to_table: :users }
    end

    # Add unique index to ensure one invitation per event-user pair
    add_index :invitations, [ :event_id, :attendee_id ], unique: true
  end
end
