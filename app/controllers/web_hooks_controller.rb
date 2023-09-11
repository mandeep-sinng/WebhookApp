class WebHooksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def webhook
        Rails.logger.warn("Webhook received data!")
        tokens = ApiLink.select(:token).all.map(&:token)
        if tokens.include?(params[:token])
           render json: params
        else
            render json: {error: 'Token verify failed!'}, status: 401
        end
    end
end
