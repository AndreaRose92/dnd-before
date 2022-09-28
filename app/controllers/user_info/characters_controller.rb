class CharactersController < ApplicationController

  def index
    render json: Character.where(user: current_user)
  end

  def show
    render json: find_character
  end

  def create
    user = current_user
    char = Character.create!(char_params)
    char.calculate_hp(hp_params)
    new_char_params[:proficiency_choices].each do |prof| CharSkill.create!(character: char, proficiency: Proficiency.find_by(name: prof)) end
    char.dnd_class.proficiencies.last(2).each do |prof| CharSkill.create!(character: char, proficiency: prof) end
    new_char_params[:starting_spells].each do |spell| CharSpell.create!(character: char, spell: Spell.find_by(name: spell)) end
    render json: char, status: :created
  end

  def update
    char = find_character
    char.update!(char_params)
    render json: char, status: :accepted
  end

  def health
    char = find_character
    char.update(current_hp: hp_params[:current_hp].clamp(0, char.hp) )
    render json: char, status: :accepted
  end

  def destroy
    find_character.destroy
    head :no_content
  end

  private

  def find_character
    Character.find(params[:id])
  end

  def char_params
    params.permit(:name, :level, :user_id, :dnd_class_id, :race_id, :Strength, :Dexterity, :Constitution, :Intelligence, :Wisdom, :Charisma)
  end

  def hp_params
    params.permit(:name, :hp, :current_hp, :hp_option, :hp_values)
  end

  def new_char_params
    params.permit(:name, :proficiency_choices, :starting_spells)
  end

end
