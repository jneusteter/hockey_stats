HockeyStatsTracker::Admin.controllers :plus_minus do
  get :index do
    @title = "Plus_minus"
    @plus_minus = PlusMinus.all.reverse
    render 'plus_minus/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'plus_minus')
    @plus_minus = PlusMinus.new
    render 'plus_minus/new'
  end

  post :create do
    @plus_minus = PlusMinus.new(params[:plus_minus])
    if (@plus_minus.save rescue false)
      @title = pat(:create_title, :model => "plus_minus #{@plus_minus.id}")
      flash[:success] = pat(:create_success, :model => 'PlusMinus')
      params[:save_and_continue] ? redirect(url(:plus_minus, :index)) : redirect(url(:plus_minus, :edit, :id => @plus_minus.id))
    else
      @title = pat(:create_title, :model => 'plus_minus')
      flash.now[:error] = pat(:create_error, :model => 'plus_minus')
      render 'plus_minus/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "plus_minus #{params[:id]}")
    @plus_minus = PlusMinus[params[:id]]
    if @plus_minus
      render 'plus_minus/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'plus_minus', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "plus_minus #{params[:id]}")
    @plus_minus = PlusMinus[params[:id]]
    if @plus_minus
      if @plus_minus.modified! && @plus_minus.update(params[:plus_minus])
        flash[:success] = pat(:update_success, :model => 'Plus_minus', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:plus_minus, :index)) :
          redirect(url(:plus_minus, :edit, :id => @plus_minus.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'plus_minus')
        render 'plus_minus/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'plus_minus', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Plus_minus"
    plus_minus = PlusMinus[params[:id]]
    if plus_minus
      if plus_minus.destroy
        flash[:success] = pat(:delete_success, :model => 'Plus_minus', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'plus_minus')
      end
      redirect url(:plus_minus, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'plus_minus', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Plus_minus"
    unless params[:plus_minus_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'plus_minus')
      redirect(url(:plus_minus, :index))
    end
    ids = params[:plus_minus_ids].split(',').map(&:strip)
    plus_minus = PlusMinus.where(:id => ids)

    if plus_minus.destroy

      flash[:success] = pat(:destroy_many_success, :model => 'Plus_minus', :ids => "#{ids.join(', ')}")
    end
    redirect url(:plus_minus, :index)
  end
end
