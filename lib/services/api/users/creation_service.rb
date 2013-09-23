module API
  module Users
    class CreationService
      include API::BaseService

      def create(parameters)
        check_parameters(parameters)
        organization_name = parameters.delete(:organization_name)

        validation_error_on({ organization_name: ['is already taken'] }) if User.where('organizations.name' => organization_name).exists?

        user = User.new(parameters[:user].to_hash)
        if user.save
          user.organizations << Organization.new({ name: organization_name })
          user
        else
          validation_error_on(user.errors)
        end
      end

    private

      def check_parameters(parameters)
        parameters.permit(:format, :vendor_string, :default_version, :organization_name, user: [:login, :email, :password])
        parameters.require(:user).require(:login)
        parameters.require(:user).require(:email)
        parameters.require(:user).require(:password)
        parameters.require(:organization_name)
      end
    end
  end
end
