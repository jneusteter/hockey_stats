HockeyStatsTracker::Admin.controllers :goals do
  get :index do
    @title = "Goals"
    @goals = Goal.all
    render 'goals/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'goal')
    @goal = Goal.new
    render 'goals/new'
  end

  post :create do
    @goal = Goal.new(params[:goal])
    if (@goal.save rescue false)
      @title = pat(:create_title, :model => "goal #{@goal.id}")
      flash[:success] = pat(:create_success, :model => 'Goal')
      params[:save_and_continue] ? redirect(url(:goals, :index)) : redirect(url(:goals, :edit, :id => @goal.id))
    else
      @title = pat(:create_title, :model => 'goal')
      flash.now[:error] = pat(:create_error, :model => 'goal')
      render 'goals/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "goal #{params[:id]}")
    @goal = Goal[params[:id]]
    if @goal
      render 'goals/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'goal', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "goal #{params[:id]}")
    @goal = Goal[params[:id]]
    if @goal
      if @goal.modified! && @goal.update(params[:goal])
        flash[:success] = pat(:update_success, :model => 'Goal', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:goals, :index)) :
          redirect(url(:goals, :edit, :id => @goal.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'goal')
        render 'goals/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'goal', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Goals"
    goal = Goal[params[:id]]
    if goal
      if goal.destroy
        flash[:success] = pat(:delete_success, :model => 'Goal', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'goal')
      end
      redirect url(:goals, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'goal', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Goals"
    unless params[:goal_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'goal')
      redirect(url(:goals, :index))
    end
    ids = params[:goal_ids].split(',').map(&:strip)
    goals = Goal.where(:id => ids)
    
    if goals.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Goals', :ids => "#{ids.join(', ')}")
    end
    redirect url(:goals, :index)
  end
end
