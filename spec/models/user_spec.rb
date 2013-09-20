require 'spec_helper'

describe 'User', :rails do
  subject { User.new }

  it_behaves_like 'a classic model'
  expect_it { to have_fields(:auth_token).of_type(String) }
  expect_it { to have_fields(:email).of_type(String) }
  expect_it { to have_fields(:login).of_type(String) }
  expect_it { to have_fields(:password).of_type(String) }
  expect_it { to embed_many(:organizations) }
  expect_it { to validate_presence_of(:auth_token) }
  expect_it { to validate_presence_of(:email) }
  expect_it { to validate_presence_of(:login) }
  expect_it { to validate_presence_of(:password) }
  expect_it { to validate_uniqueness_of(:auth_token) }
  expect_it { to validate_uniqueness_of(:email) }
  expect_it { to validate_uniqueness_of(:login) }
  expect_it { to validate_length_of(:password).greater_than(8) }

  describe 'callbacks' do
    context 'when auth_token is not set' do
      it 'calls #generate_token on validations' do
        expect(subject).to receive(:generate_token)
        subject.valid?
      end
    end

    context 'when auth_token is set' do
      it 'calls #generate_token on validations' do
        expect(subject).to_not receive(:generate_token)
        subject.auth_token = 'some-data'
        subject.valid?
      end
    end

    context 'when password has changed' do
      it 'calls #encrypt_password before saving' do
        subject = FactoryGirl.build(:user)
        subject.save
        expect(subject).to receive(:encrypt_password).once
        subject.password = 'a secret password'
        subject.save
      end
    end

    context 'when password has not changed' do
      it 'does not call #encrypt_password before saving' do
        subject = FactoryGirl.build(:user)
        subject.save
        expect(subject).to_not receive(:encrypt_password)
        subject.save
      end
    end
  end

  describe '#generate_token' do
    let(:token_generator_service) { double }

    before(:each) do
      stub_const('Container', double)
      allow(Container).to receive(:get).with('token.generator').and_return(token_generator_service)
      allow(token_generator_service).to receive(:generate).and_return('generated-token', 'regenerated-token')
    end

    context 'when generated token is already used' do
      before(:each) do
        User.stub_chain(:where, :exists?).and_return(true, false)
      end

      it 'sets the value of auth_token with it' do
        subject.send(:generate_token)
        expect(subject.auth_token).to eql('regenerated-token')
      end
    end

    context 'when generated token does not exist yet' do
      before(:each) do
        User.stub_chain(:where, :exists?).and_return(false)
      end

      it 'sets the value of auth_token with it' do
        subject.send(:generate_token)
        expect(subject.auth_token).to eql('generated-token')
      end
    end
  end

  describe '#encrypt_password' do
    let(:password_encryption_service) { double }

    before(:each) do
      stub_const('Container', double)
      allow(Container).to receive(:get).with('password.encryption').and_return(password_encryption_service)
      allow(password_encryption_service).to receive(:encrypt).with('secret').and_return('encrypted-password')
      subject.password = 'secret'
    end

    it 'sets the encrypted password into the password field' do
      subject.send(:encrypt_password)
      expect(subject.password).to eql('encrypted-password')
    end
  end
end
