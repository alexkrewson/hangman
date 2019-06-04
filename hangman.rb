completed = false
good_guess = false
cnt = 0
usable_words = []
letters = []
wrong = 0
temp_game_word = ""

dictionary = File.open("5desk.txt").readlines.each do |line|
    if line.length > 6 && line.length < 13
        usable_words[cnt] = line.chomp.downcase
        cnt += 1
    end
end

game_word = usable_words[rand(usable_words.length)]

puts game_word

fname = "hangman_save.txt"

puts "Would you like to load your last game? (y/n)"
loaded_game = gets.chomp
if loaded_game == "y"
    saved_game = File.open("hangman_save.txt").read.split(',')
    game_word = saved_game[0]
    letters = saved_game[1].split('')
    wrong = saved_game[2].to_i
    puts saved_game
end

while completed == false
    good_guess = false
    while good_guess == false
        puts ""
        puts "Guess a letter...(or press \"1\" to save game)"
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts ""
        puts ""
        letter = gets.chomp
        if letter == "1"
            somefile = File.open(fname, "w")
            somefile.puts "#{game_word},#{letters.join("")},#{wrong}"
            somefile.close
        end
        if letter.length == 1 && letter != "1" # add robustness
            good_guess = true 
        end
        letter.downcase!
    end
    
    letters.push(letter)
    puts "game_word: #{game_word}"
    puts "letters #{letters}"
    temp_game_word = game_word.gsub(/[^#{letters}]/,"_")

    if game_word.include? letter #not if the letter has already beed guessed, though
        puts "good job"
        puts ""
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts ""
        puts ""
        puts temp_game_word
    else
        puts "try again"
        puts ""
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts ""
        puts ""
        puts temp_game_word
        wrong += 1
    end

    loaded_game = "n"
puts temp_game_word.include? "_"
    unless temp_game_word.include? "_"
        completed = true
        puts "You win!"
        puts temp_game_word
    end

    if wrong > 5
        puts "You loose!"
        completed = true
    end

end


