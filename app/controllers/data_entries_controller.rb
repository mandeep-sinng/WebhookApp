class DataEntriesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update]

  def create
    data_entry = DataEntry.new(data_entry_params)
    if data_entry.save
      notify_third_party_apis(data_entry)
      render json: { message: 'Data entry created successfully' }
    else
      render json: { error: data_entry.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def update
    data_entry = DataEntry.find(params[:id])
    if data_entry.update(data_entry_params)
      notify_third_party_apis(data_entry)
      render json: { message: 'Data entry updated successfully' }
    else
      render json: { error: data_entry.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def data_entry_params
    params.require(:data_entry).permit(:name, :data)
  end
  
  def notify_third_party_apis(data_entry)
    config = Rails.application.config
    config.third_party_apis.each do |endpoint|
      conn = Faraday.new(url: endpoint)
      payload = { name: data_entry.name, data: data_entry.data }.to_json
  
      response = conn.post do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = payload
      end
  
      Rails.logger.info("Webhook to #{endpoint} returned status #{response.status}")
    end
  end
  
end
