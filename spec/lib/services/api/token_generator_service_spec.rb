require 'spec_helper'
require 'services/api/token_generator_service'

describe API::TokenGeneratorService do
  before(:each) do
    stub_const('ENV', {})
    ENV['SALT'] = 'secret-salt'
  end

  describe '#encrypt' do
    it 'returns a SHA based on parameters and a salt' do
      generated_sha = double
      subject.stub(:generate_sha).with([:param_1, :param_2, 'secret-salt']).and_return(generated_sha)

      expect(subject.encrypt(:param_1, :param_2)).to eql(generated_sha)
    end

    context 'on multiple calls' do
      context 'when the parameters are the same' do
        it 'always returns the same SHA' do
          expect(subject.encrypt('value_to_encrypt')).to eql(subject.encrypt('value_to_encrypt'))
        end
      end

      context 'when the parameters are not the same' do
        it 'returns another SHA' do
          expect(subject.encrypt('value_to_encrypt')).to_not eql(subject.encrypt('another_value_to_encrypt'))
        end
      end
    end
  end

  describe '#generate' do
    it 'returns a SHA via SecureRandom' do
      stub_const('SecureRandom', double)
      allow(SecureRandom).to receive(:uuid).and_return('generated-sha')

      expect(subject.generate).to eql('generated-sha')
    end

    context 'on multiple calls' do
      it 'returns another SHA' do
        expect(subject.generate).to_not eql(subject.generate)
      end
    end
  end

  describe '#generate_sha' do
    it 'returns an hexdigest base on data' do
      generated_sha = double
      allow(Digest::SHA2).to receive(:hexdigest).with('param_1-param_2').and_return(generated_sha)

      expect(subject.send(:generate_sha, [:param_1, :param_2])).to eql(generated_sha)
    end
  end
end
