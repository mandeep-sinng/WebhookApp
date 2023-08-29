module Admin
  class DataEntriesController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    def update
      super
      notify_third_party_apis(resource_params)
    end

    def create
      super
      notify_third_party_apis(resource_params)
    end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes(action_name)).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-demo.herokuapp.com/customizing_controller_actions
    # for more information

    def notify_third_party_apis(data_entry)
      config = Rails.application.config
      config.third_party_apis.each do |endpoint|
        conn = Faraday.new(url: endpoint)
        payload = { name: data_entry[:name], data: data_entry[:data] }.to_json
    
        response = conn.post do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = payload
        end
    
        Rails.logger.warn("Webhook to #{endpoint} returned status #{response.status}")
      end
    end
  
  end
end
