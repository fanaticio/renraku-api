shared_examples 'a classic model' do
  it { should be_kind_of(Mongoid::Timestamps) }
end
