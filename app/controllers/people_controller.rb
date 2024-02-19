class PeopleController < ApplicationController
  before_action :set_person, only: [:edit, :update, :destroy]

  def index
    @people = Person.includes(:detail)
  end

  def new
    @person = Person.new
    @person.build_detail
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    respond_to do |format|
      if @person.save
        format.turbo_stream {}
        format.html { redirect_to people_path, notice: 'Person created.' }
      else
        format.html { redirect_to :new, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to people_path }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("person_#{@person.id}", partial: 'person', locals: { person: @person }) }
      else
        format.html { redirect_to edit_person_path }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @person.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove("person_#{@person.id}") }
        format.html { redirect_to people_path }
      else
        format.html { redirect_to people_path, notice: @person.errors.full_message }
      end
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, detail_attributes: [:id, :title, :age, :phone, :email])
  end
end
