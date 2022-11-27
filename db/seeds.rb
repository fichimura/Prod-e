# #User.create!(email: 'admin@example.com', password: 'admin@example.com', password_confirmation: 'admin@example.com')
# user = User.new(
#   email: 'teste@teste.com',
#   password: 'teste@teste.com',
#   password_confirmation: 'teste@teste.com'

# )
# user.skip_confirmation!
# user.save!

PublicActivity.enabled = false
30.times do
    Course.create!([{
      titulo: Faker::Educator.course_name,
      descricao: Faker::TvShows::GameOfThrones.quote,
      user_id: User.first.id,
      linguagens: Faker::ProgrammingLanguage.name, 
      nivel: 'Iniciante'
    }])
  end

PublicActivity.enabled = true
