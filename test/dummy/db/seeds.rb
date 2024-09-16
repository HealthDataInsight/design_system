# Adding a first group of departments
department1 = Department.find_or_create_by!(title: 'Sales')
department2 = Department.find_or_create_by!(title: 'Marketing')
department3 = Department.find_or_create_by!(title: 'Finance')

# Adding a first group of assistants
Assistant.find_or_create_by!(title: 'Lorem ipsum dolor sit amet', department: department1)
Assistant.find_or_create_by!(title: 'consectetur adipisicing elit', department: department2)
Assistant.find_or_create_by!(title: 'sed do eiusmod tempor incididunt', department: department3)
