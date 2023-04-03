namespace :myrailsapp do
  desc "Run monthly report"
  task monthly_report: :environment do
  	Team.create(name: 'Ind', rating: 10)
    puts "Generate Monthly report"
  end
end