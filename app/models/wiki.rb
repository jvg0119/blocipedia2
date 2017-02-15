class Wiki < ApplicationRecord
  belongs_to :user, optional: true # removes validates :user, presence: true

  has_many :collaborators 
  has_many :wiki_collaborators, through: :collaborators, source: :user 
  #has_many :users, through: :collaborators

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 20 }

  scope :public_wikis, -> { where(private: false) }           
  scope :private_wikis, -> { where(private: true) }
  
  extend FriendlyId
  friendly_id :title, use: :slugged

end
