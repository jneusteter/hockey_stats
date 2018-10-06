HockeyStatsTracker::Admin.controllers :players do
  get :index do
    @title = 'Players'
    @players = Player.all
    render 'players/index'
  end

  get :new do
    @title = pat(:new_title, model: 'player')
    @player = Player.new
    render 'players/new'
  end

  post :create do
    @player = Player.new(params[:player])
    if begin
          @player.save
        rescue StandardError
          false
        end
      @title = pat(:create_title, model: "player #{@player.id}")
      flash[:success] = pat(:create_success, model: 'Player')
      params[:save_and_continue] ? redirect(url(:players, :index)) : redirect(url(:players, :edit, id: @player.id))
    else
      @title = pat(:create_title, model: 'player')
      flash.now[:error] = pat(:create_error, model: 'player')
      render 'players/new'
    end
  end

  get :edit, with: :id do
    @title = pat(:edit_title, model: "player #{params[:id]}")
    @player = Player[params[:id]]
    if @player
      render 'players/edit'
    else
      flash[:warning] = pat(:create_error, model: 'player', id: params[:id].to_s)
      halt 404
    end
  end

  put :update, with: :id do
    @title = pat(:update_title, model: "player #{params[:id]}")
    @player = Player[params[:id]]
    if @player
      if @player.modified! && @player.update(params[:player])
        flash[:success] = pat(:update_success, model: 'Player', id: params[:id].to_s)
        params[:save_and_continue] ?
          redirect(url(:players, :index)) :
          redirect(url(:players, :edit, id: @player.id))
      else
        flash.now[:error] = pat(:update_error, model: 'player')
        render 'players/edit'
      end
    else
      flash[:warning] = pat(:update_warning, model: 'player', id: params[:id].to_s)
      halt 404
    end
  end

  delete :destroy, with: :id do
    @title = 'Players'
    player = Player[params[:id]]
    if player
      if player.destroy
        flash[:success] = pat(:delete_success, model: 'Player', id: params[:id].to_s)
      else
        flash[:error] = pat(:delete_error, model: 'player')
      end
      redirect url(:players, :index)
    else
      flash[:warning] = pat(:delete_warning, model: 'player', id: params[:id].to_s)
      halt 404
    end
  end

  delete :destroy_many do
    @title = 'Players'
    unless params[:player_ids]
      flash[:error] = pat(:destroy_many_error, model: 'player')
      redirect(url(:players, :index))
    end
    ids = params[:player_ids].split(',').map(&:strip)
    players = Player.where(id: ids)

    if players.destroy

      flash[:success] = pat(:destroy_many_success, model: 'Players', ids: ids.join(', ').to_s)
    end
    redirect url(:players, :index)
  end
end
