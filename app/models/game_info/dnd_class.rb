class DndClass < ApplicationRecord
    require './db/reference_data.rb'
    has_many :class_skills, dependent: :destroy
    has_many :proficiencies, through: :class_skills
    has_many :dnd_class_levels, dependent: :destroy
    has_many :class_spells, dependent: :destroy
    has_many :spells, through: :class_spells
    has_many :spell_levels, dependent: :destroy
    has_many :character_builders, dependent: :destroy
    has_many :features

    attr_accessor :spellcasting_level, :available_spells

    def spellcasting_level input
        self.dnd_class_levels.find_by(level: input).spell_level
    end

    def available_spells input
        self.spells.where('level < ?', input)
    end

    def create_proficiencies
        $class_skills.filter{ |skill| skill[0] == self }.each do |pair|
            ClassSkill.create(dnd_class: self, proficiency_id: skill[1])
        end
    end
end
