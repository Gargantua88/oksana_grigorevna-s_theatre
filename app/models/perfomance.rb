class Perfomance < ApplicationRecord

  validates :title, :start_date, :finish_date, presence: true

  validate :check_date_uniqueness, :end_date_is_after_start_date

  private

  def check_date_uniqueness
    return if start_date.blank? || finish_date.blank?

    if Perfomance.where("finish_date >= ?", start_date).where("start_date <= ?", finish_date).count > 0
      errors.add(:date_range, 'Оксана Григорьевна, на эти даты уже есть спектакль!')
    end
  end

  def end_date_is_after_start_date
    return if start_date.blank? || finish_date.blank?

    if self.finish_date < self.start_date
      errors.add(:end_date, 'Оксана Григорьевна, проверьте даты!')
    end
  end
end
