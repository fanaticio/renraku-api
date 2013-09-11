shared_examples 'an error presenter' do
  it { should have_attr_accessor :exception }
  it { should have_attr_accessor :error_code }
  it { should have_attr_accessor :error_message }
end
