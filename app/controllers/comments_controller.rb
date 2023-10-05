class CommentsController < ApplicationController
    before_action :set_board_and_task

    def new
        @comment = Comment.new
    end

    def create
        @comment = @task.comments.build(comment_params.merge(user: current_user))
        if @comment.save
          redirect_to board_task_path(@board, @task), notice: 'コメントを保存しました'
        else
          flash.now[:error] = 'コメントの保存に失敗しました'
          render :new
        end
    end

      def destroy
        @comment = Comment.find(params[:id])
        # 削除処理やリダイレクト処理など
      end
      

      private

      def set_board_and_task
        @board = Board.find(params[:board_id])
        @task = @board.tasks.find(params[:task_id])
      end
    
      def comment_params
        params.require(:comment).permit(:content)
      end

end
