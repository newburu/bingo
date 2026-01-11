# Verification Script
puts "--- Bingo Game Verification ---"

# 1. Clean state
Game.destroy_all
puts "Cleared database."

# 2. Start Game
game = Game.current_game
puts "Started Game ID: #{game.id}, History: #{game.history}"

# 3. Spin 5 times
puts "Spinning 5 times..."
5.times do |i|
  num = game.spin!
  puts "Spin #{i+1}: #{num}"
rescue => e
  puts "Error spinning: #{e.message}"
end

puts "History: #{game.reload.history}"

if game.history.size == 5
  puts "✅ Spin logic works (5 numbers added)."
else
  puts "❌ Spin logic failed."
end

# 4. Check duplicates (should be none)
if game.history.uniq.size == game.history.size
  puts "✅ No duplicates found."
else
  puts "❌ Duplicates found!"
end

# 5. Reset
puts "Resetting game..."
game.reset!
puts "History after reset: #{game.reload.history}"

if game.history.empty?
  puts "✅ Reset logic works."
else
  puts "❌ Reset logic failed."
end

puts "--- Verification Complete ---"
