class WebhookJob
  include Sidekiq::Job

  def perform(data_entry, api_id)
    data_entry = JSON.parse(data_entry).symbolize_keys
    api = ApiLink.find(api_id)
    conn = Faraday.new(url: api.url)
    payload = { name: data_entry[:name], data: data_entry[:data], token: api.token }.to_json
      
    response = conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = payload
    end
      
    Rails.logger.warn("Webhook to #{api.title} returned status #{response.status}")
  end
end
