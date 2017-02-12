class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis, dependent: :nullify  # add optional: true to wiki :belongs_to :user
  # if user is deleted or cancelled out all his private accounts can only be access by admin or any collaborator assigned
  
  has_many :collaborators 
  has_many :wiki_collaborations, through: :collaborators, source: :wiki 

  enum role: { standard: 0, premium: 1, admin: 2 }
  # enum role: [ :standard, :premium, :admin ]  

  scope :user_private_wikis, -> { self.wiki_collaborations }

  after_initialize :set_default 

  def set_default 
  	self.role ||= "standard"
  end

end


