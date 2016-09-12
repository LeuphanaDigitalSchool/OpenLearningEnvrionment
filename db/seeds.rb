# frozen_string_literal: true

puts 'Start seed data'
puts '-> Create permissions'
Permission.create!(name: 'Manage all (Danger!)', subject_class: 'all',      action: 'manage')
Permission.create!(name: 'Course (for teacher)', subject_class: 'Course',   action: 'manage')
Permission.create!(name: 'Course (for others)',  subject_class: 'Course',   action: 'read')
Permission.create!(name: 'Storage',              subject_class: 'Storage',  action: 'manage')

puts '-> Create roles'
Role.create!(name: 'Public user')
Role.create!(name: 'Student')
Role.create!(name: 'Support')
Role.create!(name: 'Teacher')
Role.create!(name: 'Course director')
Role.create!(name: 'Course manager')
public_user     = Role.find_by(name: 'Public user')
student         = Role.find_by(name: 'Student')
support         = Role.find_by(name: 'Support')
teacher         = Role.find_by(name: 'Teacher')
course_director = Role.find_by(name: 'Course director')
course_manager  = Role.find_by(name: 'Course manager')

puts '-> Assign permissions to roles'
course_manager.permissions  << Permission.find_by(name: 'Manage all (Danger!)')
course_director.permissions << Permission.find_by(name: 'Course (for teacher)')
teacher.permissions         << Permission.find_by(name: 'Course (for teacher)')
teacher.permissions         << Permission.find_by(name: 'Storage')
support.permissions         << Permission.find_by(name: 'Course (for others)')
student.permissions         << Permission.find_by(name: 'Course (for others)')
student.permissions         << Permission.find_by(name: 'Storage')
public_user.permissions     << Permission.find_by(name: 'Course (for others)')

puts '-> Create users'
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

puts '-> Create course'
course = Course.create!(title: 'First course', description: 'Description', start_date: '2016-06-01',
                        end_date: '2017-02-28')
student_preferences = { role_id: 2, upload_jpg: true }
teacher_preferences = { role_id: 4, upload_pdf: true, upload_jpg: true, upload_mp3: true, upload_mp4: true }
manager_preferences = { role_id: 6, upload_pdf: true, upload_jpg: true, upload_mp3: true, upload_mp4: true,
                        resource_description_add: true, resource_description_del: true, resources_del: true,
                        embed_external_links: true }

# phase 1
course_phase = course.course_phases.create(title: 'Phase 1', start_date: '2016-09-01', end_date: '2016-09-30')
course_phase.course_phase_preferences.create(student_preferences)
course_phase.course_phase_preferences.create(teacher_preferences)
course_phase.course_phase_preferences.create(manager_preferences)

# phase 2
course_phase = course.course_phases.create(title: 'Phase 2', start_date: '2016-10-01', end_date: '2016-10-30')
course_phase.course_phase_preferences.create(student_preferences)
course_phase.course_phase_preferences.create(teacher_preferences)
course_phase.course_phase_preferences.create(manager_preferences)

# phase 3
course_phase = course.course_phases.create(title: 'Phase 3', start_date: '2016-11-01', end_date: '2016-11-30')
course_phase.course_phase_preferences.create(student_preferences)
course_phase.course_phase_preferences.create(teacher_preferences)
course_phase.course_phase_preferences.create(manager_preferences)

# phase 4
course_phase = course.course_phases.create(title: 'Phase 4', start_date: '2016-12-01', end_date: '2016-12-30')
course_phase.course_phase_preferences.create(student_preferences)
course_phase.course_phase_preferences.create(teacher_preferences)
course_phase.course_phase_preferences.create(manager_preferences)

# phase 5
course_phase = course.course_phases.create(title: 'Phase 5', start_date: '2017-01-01', end_date: '2016-01-30')
course_phase.course_phase_preferences.create(student_preferences)
course_phase.course_phase_preferences.create(teacher_preferences)
course_phase.course_phase_preferences.create(manager_preferences)

# phase 6
course_phase = course.course_phases.create(title: 'Phase 6', start_date: '2017-02-01', end_date: '2017-02-28')
course_phase.course_phase_preferences.create(student_preferences)
course_phase.course_phase_preferences.create(teacher_preferences)
course_phase.course_phase_preferences.create(manager_preferences)

puts 'End ;)'
