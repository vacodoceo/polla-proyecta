namespace :fix do
  desc "TODO"
  task third_place_group: :environment do
    Polla.all().each do |p|
      third = {}
      ['a', 'b', 'c'].each do |g|
        third[g] = p.first_rounds.find_by({group: g, position: 3}).country_name
      end
      bets = p.bets.order(:id)
      # puts p.id
      if third['c'] != bets[0].country_2_name and third['b'] != bets[0].country_2_name
        # puts bets[0].to_json
        bets[0].update(country_2_name: third['c'])
        if bets[0].result == "2"
          # puts bets[4].to_json
          bets[4].update(country_1_name: third['c'])
          if bets[4].result == "1"
            # puts bets[7].to_json
            bets[7].update(country_1_name: third['c'])
          else
            # puts bets[6].to_json
            bets[6].update(country_1_name: third['c'])
          end
        end
      end
      if third['a'] != bets[3].country_2_name and third['b'] != bets[3].country_2_name
        # puts bets[3].to_json
        bets[3].update(country_2_name: third['a'])
        if bets[3].result == "2"
            # puts bets[5].to_json
            bets[5].update(country_2_name: third['a'])
          if bets[5].result == "2"
            # puts bets[7].to_json
            bets[7].update(country_2_name: third['a'])
          else
            # puts bets[6].to_json
            bets[6].update(country_2_name: third['a'])
          end
        end
      end
    end
  end

  desc "TODO"
  task final_result: :environment do
    Polla.all().each do |p|
      final = p.bets.order(:id)[-1]
      if final.result_team_1 > final.result_team_2
        final.update(result: "1")
      elsif final.result_team_1 < final.result_team_2
        final.update(result: "2")
      else
        final.update(result: "")
      end
    end
  end

end
