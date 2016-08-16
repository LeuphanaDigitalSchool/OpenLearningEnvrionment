# frozen_string_literal: true

puts 'Start seed data'
puts 'Create permissions'
Permission.create!(name: 'Manage all (Danger!)', subject_class: 'all', action: 'manage')
Permission.create!(name: 'Course (for teacher)', subject_class: 'Course', action: 'manage')
Permission.create!(name: 'Course (for others)',  subject_class: 'Course', action: 'read')

puts 'Create roles'
public_user = Role.create!(name: 'Public user')
student = Role.create!(name: 'Student')
support = Role.create!(name: 'Support')
teacher = Role.create!(name: 'Teacher')
course_director = Role.create!(name: 'Course director')
course_manager = Role.create!(name: 'Course manager')

puts 'Assign permissions to roles'
course_manager.permissions  << Permission.find_by(name: 'Manage all (Danger!)')
course_director.permissions << Permission.find_by(name: 'Course (for teacher)')
teacher.permissions         << Permission.find_by(name: 'Course (for teacher)')
support.permissions         << Permission.find_by(name: 'Course (for others)')
student.permissions         << Permission.find_by(name: 'Course (for others)')
public_user.permissions     << Permission.find_by(name: 'Course (for others)')

puts 'Create users'
CourseManager.create!(firstname: 'Course', lastname: 'Manager', email: 'admin@example.com',
                      password: 'admin1234', password_confirmation: 'admin1234')
CourseDirector.create!(firstname: 'Course', lastname: 'Director', email: 'course_director@example.com',
                       password: 'admin1234', password_confirmation: 'admin1234')
Teacher.create!(firstname: 'Sample', lastname: 'Teacher', email: 'teacher@example.com',
                password: 'admin1234', password_confirmation: 'admin1234')
Support.create!(firstname: 'Sample', lastname: 'Suport', email: 'support@example.com',
                password: 'admin1234', password_confirmation: 'admin1234')
Student.create!(firstname: 'Sample', lastname: 'Student', email: 'student@example.com',
                password: 'admin1234', password_confirmation: 'admin1234', gender: 0, country: 'DE',
                birthdate: '1988-08-08', data_privacy: true, terms_and_conditions: true)
PublicUser.create!(firstname: 'Public', lastname: 'User', email: 'public_user@example.com',
                   password: 'admin1234', password_confirmation: 'admin1234',
                   data_privacy: true, terms_and_conditions: true)

puts 'Create course'
Course.create!(title: 'First course', description: 'Description', start_date: '2016-08-08',
               end_date: '2017-02-20')

puts 'End ;)'
