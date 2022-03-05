json.extract! transaction, :id, :description, :mount, :date_transaction, :type, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
