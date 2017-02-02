class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :wikis

  enum role: { standard: 0, premium: 1, admin: 2 }
  # enum role: [ :standard, :premium, :admin ]

  after_initialize :set_default 

  def set_default 
  	self.role ||= "standard"
  end

end


