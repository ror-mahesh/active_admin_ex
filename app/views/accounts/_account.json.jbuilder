json.extract! account, :id, :name, :email, :password, :created_at, :updated_at
json.url account_url(account, format: :json)
