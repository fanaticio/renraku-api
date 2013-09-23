module API
  module Users
    class FinderService
      include API::BaseService

      def find_by_token(token)
        User.find_by(auth_token: token)
      end
    end
  end
end
