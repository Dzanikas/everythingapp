class UpdateSchemaForEventAndInviations < ActiveRecord::Migration[8.0]
  def change
    def change
      # Update events table
      change_table :events do |t|
        t.references :organizer, null: false, foreign_key: { to_table: :users }
      end
      # Add an index to optimize queries involving the organizer
      add_index :events, :organizer_id

      # Update invitations table
      change_table :invitations do |t|
        t.references :event, null: false, foreign_key: true
        t.references :attendee, null: false, foreign_key: { to_table: :users }
      end

      # Add unique index to ensure one invitation per event-user pair
      add_index :invitations, [ :event_id, :attendee_id ], unique: true
    end
  end
end
