module API
  module Templates
    class CreationService
      include API::BaseService

      def create(user, parameters)
        check_parameters(parameters)

        organization = user.organizations.find_by(name: parameters[:organization_id])
        validation_error_on({ organization_name: ['does not exist'] }) unless organization

        template = Template.new(parameters[:template].to_hash)
        organization.templates << template

        unless organization.save
          validation_error_on(template.errors)
        end

        template
      end

    private

      def check_parameters(parameters)
        parameters.permit(:default_version, :format, :organization_id, :vendor_string, template: [:body_html, :body_text, :from, :name, :subject, { variables: [:name, :default_value] }])
        parameters.require(:template).require(:body_html)
        parameters.require(:template).require(:body_text)
        parameters.require(:template).require(:from)
        parameters.require(:template).require(:name)
        parameters.require(:template).require(:subject)
        parameters.require(:organization_id)
        if parameters[:template][:variables]
          parameters[:template][:variables].each do |variable|
            variable_parameter = ActionController::Parameters.new(variable)
            variable_parameter.require(:name)
          end
        end
      end
    end
  end
end
