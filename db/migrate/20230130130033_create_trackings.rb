class CreateTrackings < ActiveRecord::Migration[7.0]
  def change
    create_table :trackings do |t|
      t.string :url
      t.string :ip
      t.string :location
      t.string :referrer
      t.string :operating_system
      t.string :device
      t.string :language

      t.timestamps
    end
  end
end
