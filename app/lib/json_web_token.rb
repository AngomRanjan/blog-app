class JsonWebToken
  def self.decode(token)
    JWT.decode(token, 'John')[0]
  end
end
