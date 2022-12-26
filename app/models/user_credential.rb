class UserCredential < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :user, polymorphic: true, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # enum role: { admin: 0, traveller: 1, sender: 2 }
end
