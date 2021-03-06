class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.update(owner_id: @pet.owner.id)
    redirect to "pets/#{@pet.id}"
  end
end
