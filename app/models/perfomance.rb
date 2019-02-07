class Perfomance < ApplicationRecord

  validates :title, :start_date, :finish_date, presence: true

  validate :check_date_uniqueness

  private

  def check_date_uniqueness
    if Perfomance.where("finish_date >= ?", start_date).where("start_date <= ?", finish_date).count > 0
      errors.add(:date_range, 'Оксана Григорьевна, на эти даты уже есть спектакль!')
    end
  end
end
