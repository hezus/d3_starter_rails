# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Trainee.destroy_all
Skill.destroy_all

many_names = %w(
Sophia
Emma
Olivia
Isabella
Ava
Lily
Zoe
Chloe
Mia
Madison
Emily
Ella
Madelyn
Abigail
Aubrey
Addison
Avery
Layla
Hailey
Amelia
Hannah
Charlotte
Kaitlyn
Harper
Kaylee
Sophie
Mackenzie
Peyton
Riley
Grace
Brooklyn
Sarah
Aaliyah
Anna
Arianna
Ellie
Natalie
Isabelle
Lillian
Evelyn
Elizabeth
Lyla
Lucy
Claire
Makayla
Kylie
Audrey
Maya
Leah
Gabriella
Annabelle
Savannah
Nora
Reagan
Scarlett
Samantha
Alyssa
Allison
Elena
Stella
Alexis
Victoria
Aria
Molly
Maria
Bailey
Sydney
Bella
Mila
Taylor
Kayla
Eva
Jasmine
Gianna
Alexandra
Julia
Eliana
Kennedy
Brianna
Ruby
Lauren
Alice
Violet
Kendall
Morgan
Caroline
Piper
Brooke
Elise
Alexa
Sienna
Reese
Clara
Paige
Kate
Nevaeh
Sadie
Quinn
Isla
Eleanor
Boys' Names

Aiden
Jackson
Ethan
Liam
Mason
Noah
Lucas
Jacob
Jayden
Jack
Logan
Ryan
Caleb
Benjamin
William
Michael
Alexander
Elijah
Matthew
Dylan
James
Owen
Connor
Brayden
Carter
Landon
Joshua
Luke
Daniel
Gabriel
Nicholas
Nathan
Oliver
Henry
Andrew
Gavin
Cameron
Eli
Max
Isaac
Evan
Samuel
Grayson
Tyler
Zachary
Wyatt
Joseph
Charlie
Hunter
David
Anthony
Christian
Colton
Thomas
Dominic
Austin
John
Sebastian
Cooper
Levi
Parker
Isaiah
Chase
Blake
Aaron
Alex
Adam
Tristan
Julian
Jonathan
Christopher
Jace
Nolan
Miles
Jordan
Carson
Colin
Ian
Riley
Xavier
Hudson
Adrian
Cole
Brody
Leo
Jake
Bentley
Sean
Jeremiah
Asher
Nathaniel
Micah
Jason
Ryder
Declan
Hayden
Brandon
Easton
Lincoln
Harrison
)

skills = Skill.create([
                          {description: "SQL", category: "Database"},
                          {description: "Mysql", category: "Database"},
                          {description: "Postgres", category: "Database"},
                          {description: "Java", category: "Backend"},
                          {description: "Ruby", category: "Backend"},
                          {description: "Ruby on Rails", category: "Backend"},
                          {description: "Javascript", category: "Frontend"},
                          {description: "HTML", category: "Frontend"},
                          {description: "CSS", category: "Frontend"},
                          {description: "React", category: "Javascript"},
                          {description: "Angular", category: "Javascript"},
                          {description: "Vue", category: "Javascript"},
                          {description: "Ember", category: "Javascript"},
                      ])

many_names.each do |name|
  Trainee.create({
      name: name,
      gender: ["male", "female"].sample,
      age: rand(25..45),
      distance: rand(15..120),
      job_category: ["frontend", "backend", "full-stack"].sample,
      skills: skills.sample(rand(4..8))
  })
end