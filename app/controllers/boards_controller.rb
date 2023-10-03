class BoardsController < ApplicationController
    before_action :authenticate_user!

    def index
        @boards = Board.all
    end

    def show
        @board = Board.find(params[:id])
        puts @board.inspect  # これを追加
        @tasks = @board.tasks
    end

    def new
        @board = current_user.boards.build
    end

    def create
        @board = current_user.boards.build(board_params)
    if @board.save
        redirect_to board_path(@board), notice: '保存できたよ'
        else
        flash.now[:error] = '保存に失敗しました'
        render :new
        end
    end

    def edit
        @board = current_user.boards.find(params[:id])
    end

    def update
        @board = current_user.boards.find(params[:id])
        if @board.update(board_params)
        redirect_to board_path(@board), notice: '更新できました'
        else
        flash.now[:error] = '更新に失敗しました'
        render :new
        end
    end

    def destroy
        board = current_user.boards.find(params[:id])
        board.destroy!
        redirect_to root_path, notice: '削除に成功しました'
    end

    private

    def board_params
      params.require(:board).permit(:name, :description, :id)
    end

end