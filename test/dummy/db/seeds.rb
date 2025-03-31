# Adding a first group of departments
department1 = Department.find_or_create_by!(id: 1, title: 'Sales', description: 'This is the sales department')
department2 = Department.find_or_create_by!(id: 2, title: 'Marketing', description: 'This is the marketing department')
department3 = Department.find_or_create_by!(id: 3, title: 'Finance', description: 'This is the finance department')

# Adding a first group of roles
role1 = Role.find_or_create_by!(title: 'User', description: 'This is a user role')
role2 = Role.find_or_create_by!(title: 'Admin', description: 'This is an admin role')
role3 = Role.find_or_create_by!(title: 'Super Admin', description: 'This is a super admin role')

# Adding a first group of assistants
assistant1 = Assistant.find_or_create_by!(
  colour: 'red',
  date_of_birth: Date.new(1990, 1, 1),
  department: department1,
  description: 'AB is a user',
  desired_filling: 'Pastrami',
  lunch_option: 'Salad',
  password: 'password',
  role: role1,
  terms_agreed: true,
  title: 'AB',
  phone: '07700900001',
  email: 'ab@example.com',
  website: 'https://www.ab.com'
)
assistant2 = Assistant.find_or_create_by!(
  colour: 'red',
  date_of_birth: Date.new(1990, 1, 1),
  department: department2,
  description: 'CD is an admin',
  desired_filling: 'Pastrami',
  lunch_option: 'Salad',
  password: 'password',
  role: role2,
  terms_agreed: true,
  title: 'CD',
  phone: '07700900002',
  email: 'cd@example.com',
  website: 'https://www.cd.com'
)
assistant3 = Assistant.find_or_create_by!(
  colour: 'blue',
  date_of_birth: Date.new(1990, 1, 1),
  department: department3,
  description: 'EF is a super admin',
  desired_filling: 'Cheddar',
  lunch_option: 'Jacket potato',
  password: 'password',
  role: role3,
  terms_agreed: true,
  title: 'EF',
  phone: '07700900003',
  email: 'ef@example.com',
  website: 'https://www.ef.com'
)
