# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Spending.destroy_all
Group.destroy_all
User.destroy_all

quantity_users = 10
quantity_groups = 15
quantity_spendings= 20
users = []
group = []
spending = []

for user_position in 1..quantity_users do
  temp_user = User.create!(
    name: "pepe #{user_position}",
    email: "email#{user_position}@email.com",
    password: "abcdef"
  )

  temp_user.save!
  users << temp_user
end

for user_position in 0..(quantity_users - 1) do
  for group_position in 1..(quantity_groups) do
    temp_group = Group.create!(
      user: users[user_position],
      name: "Group  ##{user_position + 1} ##{group_position}",
      icon: "Group  ##{user_position + 1} ##{group_position}"
    )
    temp_spend = ''
    for spending_position in 1..(quantity_spendings) do
      temp_spending = Spending.create!(
        author: users[user_position],
        name: "Transaction ##{user_position + 1} ##{spending_position}",
        amount: spending_position,
        groups: [temp_group]
      )
      temp_spend = temp_spending
    end
    temp_group.spendings = [temp_spend]
  end

end

puts "Created #{User.count} users"
puts "Created #{Group.count} groups"
puts "Created #{Spending.count} transactions"
