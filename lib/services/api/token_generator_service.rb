require 'securerandom'

module API
  class TokenGeneratorService
    def encrypt(*parameters)
      generate_sha(parameters + [ENV['SALT']])
    end

    def generate
      SecureRandom.uuid
    end

  private

    def generate_sha(data)
      Digest::SHA2.hexdigest(data.join('-'))
    end
  end
end
