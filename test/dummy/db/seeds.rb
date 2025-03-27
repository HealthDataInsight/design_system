# Adding a first group of departments
department1 = Department.find_or_create_by!(title: 'Sales')
department2 = Department.find_or_create_by!(title: 'Marketing')
department3 = Department.find_or_create_by!(title: 'Finance')

# Adding a first group of assistants
assistant1 = Assistant.find_or_create_by!(title: 'AB', department: department1, role: 'User')
assistant2 = Assistant.find_or_create_by!(title: 'CD', department: department2, role: 'Admin')
assistant3 = Assistant.find_or_create_by!(title: 'EF', department: department3, role: 'Super Admin')

# Adding a first group of features
feature1 = Feature.find_or_create_by!(name: 'Feature 1', description: 'Description 1', assistant: assistant1)
feature2 = Feature.find_or_create_by!(name: 'Feature 2', description: 'Description 2', assistant: assistant2)
feature3 = Feature.find_or_create_by!(name: 'Feature 3', description: 'Description 3', assistant: assistant3)

# Adding a first group of tasks
task1 = Task.find_or_create_by!(title: 'Sell', description: 'Description 1', assistant: assistant1)
task2 = Task.find_or_create_by!(title: 'Do slides', description: 'Description 2', assistant: assistant2)
task3 = Task.find_or_create_by!(title: 'Audit', description: 'Description 3', assistant: assistant3)
