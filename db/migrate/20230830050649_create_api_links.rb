class CreateApiLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :api_links do |t|
      t.string :title
      t.string :url
      t.string :token

      t.timestamps
    end
  end
end
