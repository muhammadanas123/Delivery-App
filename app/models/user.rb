class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :journeys, dependent: :destroy

  has_many :sender_orders, class_name: 'Order', foreign_key: :sender_id, dependent: :destroy
  has_many :traveller_orders, class_name: 'Order', foreign_key: :traveller_id, dependent: :destroy 

  def not_completed_journey
    self.journeys.find_by(status: "not_completed")
  end

  def completed_journeys
    self.journeys.where(status: "completed")
  end


  # validates :firstname, :lastname, length: { minimum: 3, maximum: 15 }, presence: true
  # validates :phone_no, :landline, length: { minimum:11, maximum:11 }

end
