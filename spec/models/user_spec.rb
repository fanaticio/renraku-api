require 'spec_helper'

describe 'User', :rails do
  subject { User.new }

  it_behaves_like 'a classic model'
  it { should have_fields(:auth_token).of_type(String) }
  it { should have_fields(:email).of_type(String) }
  it { should have_fields(:login).of_type(String) }
  it { should have_fields(:password).of_type(String) }
  it { should embed_many(:organizations) }
  it { should validate_presence_of(:auth_token) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:auth_token) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:login) }
  it { should validate_length_of(:password).greater_than(8) }

  describe 'callbacks' do
    context 'when auth_token is not set' do
      it 'calls #generate_token on validations' do
        subject.should_receive(:generate_token)
        subject.valid?
      end
    end

    context 'when auth_token is set' do
      it 'calls #generate_token on validations' do
        subject.should_not_receive(:generate_token)
        subject.auth_token = 'some-data'
        subject.valid?
      end
    end

    context 'when password has changed' do
      it 'calls #encrypt_password before saving' do
        subject = FactoryGirl.build(:user)
        subject.save
        subject.should_receive(:encrypt_password).once
        subject.password = 'a secret password'
        subject.save
      end
    end

    context 'when password has not changed' do
      it 'does not call #encrypt_password before saving' do
        subject = FactoryGirl.build(:user)
        subject.save
        subject.should_not_receive(:encrypt_password)
        subject.save
      end
    end
  end

  describe '#generate_token' do
    let(:token_generator_service) { double }

    before(:each) do
      stub_const('Container', double)
      Container.stub(:get).with('token.generator').and_return(token_generator_service)
      token_generator_service.stub(:generate).and_return('generated-token', 'regenerated-token')
    end

    context 'when generated token is already used' do
      before(:each) do
        User.stub_chain(:where, :exists?).and_return(true, false)
      end

      it 'sets the value of auth_token with it' do
        subject.send(:generate_token)
        subject.auth_token.should == 'regenerated-token'
      end
    end

    context 'when generated token does not exist yet' do
      before(:each) do
        User.stub_chain(:where, :exists?).and_return(false)
      end

      it 'sets the value of auth_token with it' do
        subject.send(:generate_token)
        subject.auth_token.should == 'generated-token'
      end
    end
  end

  describe '#encrypt_password' do
    let(:password_encryption_service) { double }

    before(:each) do
      stub_const('Container', double)
      Container.stub(:get).with('password.encryption').and_return(password_encryption_service)
      password_encryption_service.stub(:encrypt).with('secret').and_return('encrypted-password')
      subject.password = 'secret'
    end

    it 'sets the encrypted password into the password field' do
      subject.send(:encrypt_password)
      subject.password.should == 'encrypted-password'
    end
  end
end
