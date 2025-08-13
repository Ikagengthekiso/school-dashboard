class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :student, null: false, foreign_key: true
      t.decimal :amount
      t.date :payment_date
      t.boolean :paid

      t.timestamps
    end
  end
end
