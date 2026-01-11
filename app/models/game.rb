class Game < ApplicationRecord
  has_secure_password validations: false
  serialize :history, coder: JSON

  before_create :generate_token

  def to_param
    token
  end

  def spin!
    return if finished?

    available_numbers = (1..75).to_a - history
    if available_numbers.any?
      new_number = available_numbers.sample
      history << new_number
      save!
      new_number
    else
      nil
    end
  end

  def reset!
    update!(history: [])
  end

  def current_number
    history.last
  end

  def finished?
    history.size >= 75
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(8)
  end
end
