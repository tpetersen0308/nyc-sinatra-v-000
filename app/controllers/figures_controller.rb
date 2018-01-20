class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all.sort_by{|figure| figure.name}
    erb :'/figures/index'
  end
  
  get '/figures/new' do
    @landmarks = Landmark.all.sort_by{|landmark| landmark.name}
    @titles = Title.all.sort_by{|title| title.name}
    
    erb :'/figures/new'
  end
  
  post '/figures' do
    @figure = Figure.create(params[:figure])
    
    if !params[:title][:name].empty?
      @figure.titles << Title.find_or_create_by(params[:title])
    end
    
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    end
    
    @figure.save
    
    redirect "/figures/#{@figure.id}"
  end
  
  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    
    erb :'/figures/show'
  end
  
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all.sort_by{|landmark| landmark.name}
    @titles = Title.all.sort_by{|title| title.name}
  
    erb :'/figures/edit'
  end
  
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    
    if !params[:title][:name].empty?
      @figure.titles << Title.find_or_create_by(params[:title])
    end
    
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    end
    
    @figure.save
    
    redirect "/figures/#{@figure.id}"
  end
  
end
