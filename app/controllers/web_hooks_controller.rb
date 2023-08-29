class WebHooksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def webhook
        Rails.logger.warn("Webhook received data!")
        render json: params
    end
end
