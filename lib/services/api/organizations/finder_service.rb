module API
  module Organizations
    class FinderService
      def find_by_name(user, name)
        user.organizations.find_by(name: name)
      end
    end
  end
end
