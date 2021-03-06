class CredentialsValidator
  include ActiveModel::Validations

  validates_presence_of :username, :password

  attr_accessor :username, :password

  def self.user(username, password)
    new(username, password).user
  end

  class Invalid < StandardError
    attr_reader :record

    def initialize(record)
      @record = record
    end
  end

  def initialize(username, password)
    @username, @password = username, password
  end

  def user
    if valid?
      user = if username =~ /^(chorus|edc)admin$/
        User.authenticate(username, password)
      elsif LdapClient.enabled?
        authenticated = LdapClient.authenticate(username, password)
        User.find_by_username(username) if authenticated
      else
        User.authenticate(username, password)
      end

      if user
        return user
      else
        errors.add(:username_or_password, :invalid)
        raise Invalid.new(self)
      end
    else
      raise Invalid.new(self)
    end
  end

  private

  def read_attribute_for_validation(attribute)
    if attribute == :username_or_password
      nil
    else
      send(attribute)
    end
  end
end