class Skill < ApplicationRecord
  has_and_belongs_to_many :trainees
end
