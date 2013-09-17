Before do
  User.any_instance.stub(:auth_token).and_return('generated-token')
  user = User.create(login: 'ataken', email: 'already-taken@mail.com', password: 'pa55w0rd')
  user.organizations << Organization.create(name: 'already-taken-account')
end
