class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.string :zip
      t.text :forecast_data
      t.datetime :expires_at

      t.timestamps
    end
  end
end
