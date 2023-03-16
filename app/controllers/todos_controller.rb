class TodosController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]
    protect_from_forgery with: :null_session

    #retrieves all Todo objects from the database and renders them in JSON format
    def index
      todos = Todo.all
      render json: todos
    end

    #renders the Todo object corresponding to the id parameter in JSON format.
    def show
      render json: @todo
    end

    #creates a new Todo object based on the parameters provided in the todo_params method
    def create
      @todo = Todo.new(todo_params)

      if @todo.save
        render json: @todo, status: :created, location: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end

    #updates the Todo object corresponding to the id parameter with the parameters provided in the todo_params method
    def update
      if @todo.update(todo_params)
        render json: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end

    #deletes the Todo object corresponding to the id parameter from the database
    def destroy
      @todo.destroy
    end

    private
      #retrieve a Todo object from the database based on the id parameter
      def set_todo
        @todo = Todo.find(params[:id])
      end

      #permit only the title and completed parameters to be passed through from the HTTP request
      def todo_params
        params.require(:todo).permit(:title, :completed)
      end
  end
