
restaurants = FactoryBot.create_list(:restaurant, 10)

# We create department with static value for validation
# we have and Faker created duplicated values since department names are limited
departments = [
  'Marketing', 'Sales', 'Engineering',
  'Support', 'Product', 'Operations',
  'Human Resources', 'Legal', 'Finance',
  'InfoSec', 'IT'
]

departments.each do |department_name|
  department = Department.create!(name: department_name)

  # Create employees for each department
  FactoryBot.create_list(:employee, rand(1..10), department:)

  # Create groups fir each 4 people and send invitations
  Employee.all.shuffle.each_slice(4) do |employees|
    group = Group.create(week: Date.today.cweek, restaurant: restaurants.sample)
    employees.each do |employee|
      employee.invitations.create(group:, role: 'member', status: Invitation.statuses.keys.sample)
    end

    group.accepted_invitations.sample&.update(role: 'leader')
  end
end
