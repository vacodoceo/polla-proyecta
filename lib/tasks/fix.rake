namespace :fix do
  desc "TODO"
  task third_place_group: :environment do
    Polla.all().each do |p|
      third = {}
      ['a', 'b', 'c'].each do |g|
        third[g] = p.first_rounds.find_by({group: g, position: 3}).country_name
      end
      # puts p.id
      if third['c'] != p.bets[0].country_2_name and third['b'] != p.bets[0].country_2_name
        # puts p.bets[0].to_json
        p.bets[0].update(country_2_name: third['c'])
        if p.bets[0].result == "2"
          # puts p.bets[4].to_json
          p.bets[4].update(country_1_name: third['c'])
          if p.bets[4].result == "1"
            # puts p.bets[7].to_json
            p.bets[7].update(country_1_name: third['c'])
          else
            # puts p.bets[6].to_json
            p.bets[6].update(country_1_name: third['c'])
          end
        end
      end
      if third['a'] != p.bets[3].country_2_name and third['b'] != p.bets[3].country_2_name
        # puts p.bets[3].to_json
        p.bets[3].update(country_2_name: third['a'])
        if p.bets[3].result == "2"
            # puts p.bets[5].to_json
            p.bets[5].update(country_2_name: third['a'])
          if p.bets[5].result == "2"
            # puts p.bets[7].to_json
            p.bets[7].update(country_2_name: third['a'])
          else
            # puts p.bets[6].to_json
            p.bets[6].update(country_2_name: third['a'])
          end
        end
      end
    end
  end

  desc "TODO"
  task final_result: :environment do
  end

end
