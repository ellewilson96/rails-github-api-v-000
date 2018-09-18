class RepositoriesController < ApplicationController

  def index
    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {"Authorization": "token #{session[:token]}"}
    end
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {"Authorization": "token #{session[:token]}"}
    end
    @user = JSON.parse(user_resp.body)
    @repos = JSON.parse(repos.body)
  end
  
   def create
    resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end

end
