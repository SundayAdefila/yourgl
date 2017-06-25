class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.text :h1, array: true, default: []
      t.text :h2, array: true, default: []
      t.text :h3, array: true, default: []
      t.text :links, array: true, default: []
      t.string :page_url

      t.timestamps
    end
  end
end
