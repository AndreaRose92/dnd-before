class Skill < ApplicationRecord
    has_many :character_skills, dependent: :destroy
    has_many :race_skills, dependent: :destroy
    has_many :class_skills, dependent: :destroy
    has_many :dnd_classes, through: :class_skills
    has_many :races, through: :race_skills
end
