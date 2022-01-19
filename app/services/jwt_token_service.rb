require 'jwt'

class JwtTokenService
  # Encodes and signs JWT Payload with expiration
  def self.encode(payload)
    payload.reverse_merge!(meta)
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end

  # Decodes the JWT with the signed secret
  def self.decode(token)
    JWT.decode(token, ENV['JWT_SECRET_KEY'])
  end

  # Validates the payload hash for expiration and meta claims
  def self.valid_payload(payload)
    if expired(payload)
      false
    else
      true
    end
  end

  # Default options to be encoded in the token
  def self.meta
    {
      expiration_time: 1.day.to_i
    }
  end

  # Validates if the token is expired by exp parameter
  def self.expired(payload)
    Time.at(payload['expiration_time']) < Time.now
  end
end