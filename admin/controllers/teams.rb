HockeyStatsTracker::Admin.controllers :teams do
  get :index do
    @title = "Teams"
    @teams = Team.all
    render 'teams/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'team')
    @team = Team.new
    render 'teams/new'
  end

  post :create do
    @team = Team.new(params[:team])
    if (@team.save rescue false)
      @title = pat(:create_title, :model => "team #{@team.id}")
      flash[:success] = pat(:create_success, :model => 'Team')
      params[:save_and_continue] ? redirect(url(:teams, :index)) : redirect(url(:teams, :edit, :id => @team.id))
    else
      @title = pat(:create_title, :model => 'team')
      flash.now[:error] = pat(:create_error, :model => 'team')
      render 'teams/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "team #{params[:id]}")
    @team = Team[params[:id]]
    if @team
      render 'teams/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'team', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "team #{params[:id]}")
    @team = Team[params[:id]]
    if @team
      if @team.modified! && @team.update(params[:team])
        flash[:success] = pat(:update_success, :model => 'Team', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:teams, :index)) :
          redirect(url(:teams, :edit, :id => @team.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'team')
        render 'teams/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'team', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Teams"
    team = Team[params[:id]]
    if team
      if team.destroy
        flash[:success] = pat(:delete_success, :model => 'Team', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'team')
      end
      redirect url(:teams, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'team', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Teams"
    unless params[:team_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'team')
      redirect(url(:teams, :index))
    end
    ids = params[:team_ids].split(',').map(&:strip)
    teams = Team.where(:id => ids)
    
    if teams.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Teams', :ids => "#{ids.join(', ')}")
    end
    redirect url(:teams, :index)
  end
end
