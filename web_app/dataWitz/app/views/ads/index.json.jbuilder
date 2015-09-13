json.array!(@ads) do |ad|
  json.extract! ad, :id, :email, :cityName, :title, :description, :user_id, :userMobile, :locations, :subCategory
  json.url ad_url(ad, format: :json)
end
