class UsersController < ApplicationController 


  def index
    users = User.all
    render json: users
  end

  def test
    # users being broadcasted out
    users = User.all 
    room = Room.find(user_params[:room])
    UsersChannel.broadcast_to room, users
  end

  def create
    user = User.new(user_params)
  end

  def show 
    user = User.find(user_params[:id])
  end

  
  def select
    p "=========================="
    p params
    reshufflingUsers = false
    room = Room.find(user_params[:room])
    
    updateUser = User.find_by(username: user_params[:currentPlayer])
    updateUser.update(is_active: false)
    updateQuestion = room.room_questions.find_by(question_id: question_params[:id])
    updateQuestion.update(is_active: false)
    userArray = room.users.select { |userObj| userObj.is_active == true }
    
    # if userArray.length === 0  
    #   room.users.map { |userObj| userObj.is_active = true } 
    #   userArray = room.users
    #   # make reshuffling variable, toggle in here
    # end
    
    currentPlayer = userArray.sample(1).first
    questionArray = room.room_questions.all.select { |userObj| userObj.is_active == true }
    
    # if questionArray.length === 0

    # end
    
    questionID = questionArray.sample(1).first.question_id
    currentQuestion = Question.all.find(questionID)
  
    UsersChannel.broadcast_to room, { currentPlayer: currentPlayer, currentQuestion: currentQuestion, reshufflingUsers: reshufflingUsers }
  end

  def start
    room = Room.find(user_params[:room])
    room.update(game_started: true)
    userArray = room.users.select { |roomObj| roomObj.is_active == true }
    currentPlayer = userArray.sample(1).first
    questionArray = RoomQuestion.all.select { |roomObj| roomObj.is_active == true }
    questionID = questionArray.sample(1).first.question_id
    currentQuestion = Question.all.find(questionID)
    p currentPlayer
    UsersChannel.broadcast_to room, { currentPlayer: currentPlayer, currentQuestion: currentQuestion }
  end


  private

  def user_params
    params.require(:user).permit(:username, :id, :room, :currentPlayer, :currentQuestion, :reshufflingUsers)
  end

  def question_params
    params.require(:question).permit(:id)
  end

end



    # if user.save
    #   serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #     UserSerializer.new(user)
    #   ).serializable_hash
    #   UsersChannel.broadcast_to room, serialized_data
    #   head :ok
    # end

    # userArray = room.users.select do |roomObj|
    #   byebug
    #   if roomObj.is_active === true
    #     return roomObj
    #   end
    # end