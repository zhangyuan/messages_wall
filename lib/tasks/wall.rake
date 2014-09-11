namespace :wall do
  task generate_token: :environment do
    Wall.find_each.each do |wall|
      wall.generate_token
      wall.save!
    end
  end
end
