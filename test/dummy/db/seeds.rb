# Adding a first group of departments
department1 = Department.find_or_create_by!(title: 'Sales')
department2 = Department.find_or_create_by!(title: 'Marketing')
department3 = Department.find_or_create_by!(title: 'Finance')

# Adding a first group of roles
role1 = Role.find_or_create_by!(title: 'User')
role2 = Role.find_or_create_by!(title: 'Admin')
role3 = Role.find_or_create_by!(title: 'Super Admin')

# Adding a first group of offices
office1 = Office.find_or_create_by!(title: 'London', description: 'London office')
office2 = Office.find_or_create_by!(title: 'Cambridge', description: 'Cambridge office')

# Adding a first group of assistants
assistant1 = Assistant.find_or_create_by!(
  title: 'AB',
  department: department1,
  role: role1,
  office: office1,
  date_of_birth: Date.new(1990, 1, 1),
  description: 'AB is a user',
  terms_agreed: true,
  lunch_option: 'Salad',
  desired_filling: 'Pastrami'
)
assistant2 = Assistant.find_or_create_by!(
  title: 'CD',
  department: department2,
  role: role2,
  office: office2,
  date_of_birth: Date.new(1990, 1, 1),
  description: 'CD is an admin',
  terms_agreed: true,
  lunch_option: 'Salad',
  desired_filling: 'Pastrami'
)
assistant3 = Assistant.find_or_create_by!(
  title: 'EF',
  department: department3,
  role: role3,
  office: office2,
  date_of_birth: Date.new(1990, 1, 1),
  description: 'EF is a super admin',
  terms_agreed: true,
  lunch_option: 'Jacket potato',
  desired_filling: 'Cheddar'
)
