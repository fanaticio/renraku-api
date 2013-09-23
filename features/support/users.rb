Before do
  User.any_instance.stub(:auth_token).and_return('generated-token')
  user = User.new(login: 'ataken', email: 'already-taken@mail.com', auth_token: 'already-generated-token', password: 'pa55w0rd')
  user.organizations << Organization.create(name: 'already-taken-account')
  user.save
end
