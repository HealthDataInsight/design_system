# Adding a first group of departments
department1 = Department.find_or_create_by!(id: 1, title: 'Sales')
department2 = Department.find_or_create_by!(id: 2, title: 'Marketing')
department3 = Department.find_or_create_by!(id: 3, title: 'Finance')

# Adding a first group of roles
role1 = Role.find_or_create_by!(title: 'User', description: 'This is a user role')
role2 = Role.find_or_create_by!(title: 'Admin', description: 'This is an admin role')
role3 = Role.find_or_create_by!(title: 'Super Admin', description: 'This is a super admin role')

# Adding a first group of assistants
Assistant.find_or_create_by!(
  age: 30,
  colour: 'red',
  date_of_birth: Date.new(1990, 1, 1),
  department: department1,
  description: 'AB is a user',
  desired_filling: ['pastrami'],
  email: 'ab@example.com',
  lunch_option: 'Salad',
  password: 'password',
  phone: '07700900001',
  role: role1,
  terms_agreed: true,
  title: 'Lorem ipsum dolor sit amet',
  website: 'https://www.ab.com'
)
Assistant.find_or_create_by!(
  age: 40,
  colour: 'red',
  date_of_birth: Date.new(1990, 1, 1),
  department: department2,
  description: 'CD is an admin',
  desired_filling: ['pastrami'],
  email: 'cd@example.com',
  lunch_option: 'Salad',
  password: 'password',
  phone: '07700900002',
  role: role2,
  terms_agreed: true,
  title: 'consectetur adipisicing elit',
  website: 'https://www.cd.com'
)
Assistant.find_or_create_by!(
  age: 50,
  colour: 'blue',
  date_of_birth: Date.new(1990, 1, 1),
  department: department3,
  description: 'EF is a super admin',
  desired_filling: ['cheddar'],
  email: 'three@ex.com',
  lunch_option: 'Jacket potato',
  password: 'password',
  phone: '07700900003',
  role: role3,
  terms_agreed: true,
  title: 'sed do eiusmod tempor incididunt',
  website: 'https://www.ef.com'
)
