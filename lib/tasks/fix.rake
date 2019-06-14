namespace :fix do
  desc "TODO"
  task third_place_group: :environment do
    to_change = []
    Polla.all().each do |p|
      third = {}
      ['a', 'b', 'c'].each do |g|
        third[g] = p.first_rounds.find_by({group: g, position: 3}).country_name
      end
      p.bets.each do |b|
        puts b.to_json
      end
    end
  end

  desc "TODO"
  task final_result: :environment do
  end

end
