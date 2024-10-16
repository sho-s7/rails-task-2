class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :check_in, presence: true
  validates :check_out, presence: true
  validate  :check_in_check
  validate  :check_out_check
  validates :number, presence: true, numericality: {greater_than_or_equal_to: 1}

  def check_in_check
    if check_in.present? && check_out.present? && check_in < Time.zone.now.beginning_of_day
      errors.add(:check_in, "日は本日以降に設定してください")
    end
  end

  def check_out_check
    if check_in.present? && check_out.present? && check_out <= check_in
      errors.add(:check_out, "日はチェックイン日より後に設定してください")
    end
  end
end
