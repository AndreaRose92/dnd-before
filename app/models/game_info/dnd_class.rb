class DndClass < ApplicationRecord
    has_many :class_skills, dependent: :destroy
    has_many :proficiencies, through: :class_skills
    has_many :dnd_class_levels, dependent: :destroy
    has_many :class_spells, dependent: :destroy
    has_many :spells, through: :class_spells
    has_many :spell_levels, dependent: :destroy

end
