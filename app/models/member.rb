class Member < ActiveRecord::Base
  attr_accessor :password_field

  EMAIL_PATTTERN = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_PATTTERN

  validates :password_field, :presence => true

  validates_length_of :password_field, :in => 6..20, :on => :create

  validates :name, :presence => true

  before_save :encrypt_password

  protected

  def encrypt_password
    self.password = Digest::SHA1.hexdigest(password_field).to_s
  end

  def self.authenticate(email="", login_password="")
      member = Member.find_by_email(email)
    if member && member.match_password(login_password)
      return member
    else
      return false
    end
  end

  def self.getmember(id="")
    member = Member.find_by_id(id)
    return member
  end

  public
  def match_password(login_password="")
    password == Digest::SHA1.hexdigest(login_password).to_s
  end
end
