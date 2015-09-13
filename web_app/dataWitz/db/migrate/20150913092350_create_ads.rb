class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :email
      t.string :cityName
      t.string :title
      t.string :description
      t.integer :user_id
      t.string :userMobile
      t.string :subCategory
      t.string :ad_type
      t.string :brand_name
      t.string :condition
      t.string :you_are

      t.timestamps
    end
  end
end
