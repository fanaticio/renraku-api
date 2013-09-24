module API
  module Organizations
    class DetailService
      include API::BaseService

      def find(user, parameters)
        check_parameters(parameters)

        organization = Container.get('organization.finder').find_by_name(user, parameters[:id])
        validation_error_on({ organization_name: ['does not exist'] }) unless organization

        organization
      end

    private

      def check_parameters(parameters)
        parameters.permit(:default_version, :format, :id, :vendor_string, organization: {})
        parameters.require(:id)
      end
    end
  end
end
