# frozen_string_literal: true

User.create!(email: 'admin@example.com', password: 'admin1234', password_confirmation: 'admin1234')
Course.create!(title: 'First course', description: 'Opis', start_date: '2016-08-08', end_date: '2017-08-08')
