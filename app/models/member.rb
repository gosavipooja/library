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

end
