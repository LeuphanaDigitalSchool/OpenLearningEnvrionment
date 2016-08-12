# frozen_string_literal: true

Role.create(name: 'Public user')
Role.create(name: 'Student')
Role.create(name: 'Support')
Role.create(name: 'Teacher')
Role.create(name: 'Course director')
Role.create(name: 'Course manager')

CourseManager.create!(email: 'admin@example.com', password: 'admin1234', password_confirmation: 'admin1234')
CourseDirector.create!(email: 'course_director@example.com', password: 'admin1234', password_confirmation: 'admin1234')
Teacher.create!(email: 'teacher@example.com', password: 'admin1234', password_confirmation: 'admin1234')
Support.create!(email: 'support@example.com', password: 'admin1234', password_confirmation: 'admin1234')
Student.create!(email: 'student@example.com', password: 'admin1234', password_confirmation: 'admin1234')
PublicUser.create!(email: 'public_user@example.com', password: 'admin1234', password_confirmation: 'admin1234')

Course.create!(title: 'First course', description: 'Opis', start_date: '2016-08-08', end_date: '2017-08-08')
