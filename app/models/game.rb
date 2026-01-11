class Game < ApplicationRecord
  # 最新のゲームを取得、なければ作成
  def self.current_game
    last_game = last
    if last_game.nil? || last_game.finished?
      create(history: [])
    else
      last_game
    end
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
end
