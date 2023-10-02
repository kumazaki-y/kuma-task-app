class TasksController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @tasks = Task.all
    end

    def show
        @task = Task.find(params[:id])
        @board = @task.board
    end

    def new
        @board = Board.find(params[:board_id])
        @task = @board.tasks.build(user: current_user)
    end

    def create
        @board = Board.find(params[:board_id])
        @task = @board.tasks.build(task_params.merge(user: current_user))
    if @task.save
        redirect_to board_task_path(@board, @task), notice: '保存できたよ'
        else
        flash.now[:error] = '保存に失敗しました'
        render :new
        end
    end

    def edit
        @task = current_user.tasks.find(params[:id])
    end

    def update
        @task = current_user.tasks.find(params[:id])
        if @task.update(task_params)
            redirect_to board_task_path(@task.board), notice: '更新できたよ'
        else
        flash.now[:error] = '更新に失敗しました'
        render :edit
        end
    end

    def destroy
        task = current_user.tasks.find(params[:id])
        task.destroy!
        redirect_to root_path, notice: '削除に成功しました'
    end

    private

    def task_params
      params.require(:task).permit(:name, :description, :id, :eye_catch)
    end

end