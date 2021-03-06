class Friend < ActiveRecord::Base
  belongs_to :creator, class_name: User
  has_many :group_memberships
  has_many :groups, through: :group_memberships

  validates :fullname, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, allow_blank: true
  validate :has_email_or_phone

  def group_names
    groups.map(&:name).to_sentence
  end

  def attendance_percentage
    '50%'
  end

  private

  def has_email_or_phone
    errors.add(:base, 'Please define email or phone') if email.blank? and phone.blank?
  end
end
