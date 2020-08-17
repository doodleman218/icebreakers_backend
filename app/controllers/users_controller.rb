class UsersController < ApplicationController 


  def index
    allUsers = User.all
    room = Room.find(user_params[:room])
    UsersChannel.broadcast_to room, {allUsers: allUsers}
  end

  def test
    users = User.all 
    room = Room.find(user_params[:room])
  end

  def create
    user = User.new(user_params)
  end

  def show 
    user = User.find(user_params[:id])
  end

  
  def select
    reshufflingUsers = false
    reshufflingQuestions = false
    room = Room.find(user_params[:room])
    allUsers = room.users.all
    
    updateUser = room.users.find_by(username: user_params[:currentPlayer])
    updateUser.update(is_active: false)
    updateQuestion = room.room_questions.find_by(question_id: question_params[:id])
    updateQuestion.update(is_active: false)
    userArray = room.users.select { |userObj| userObj.is_active === true }
    
    if userArray.length === 0  
      room.users.map { |userObj| userObj.update(is_active: true) } 
      userArray = room.users
      reshufflingUsers = true 
    end

    currentPlayer = userArray.sample(1).first
    questionArray = room.room_questions.all.select { |userObj| userObj.is_active === true }
  
    if questionArray.length === 0
      room.room_questions.map { |questionObj| questionObj.update(is_active: true) }
      questionArray = room.room_questions
      reshufflingQuestions = true
    end

    questionID = questionArray.sample(1).first.question_id
    currentQuestion = Question.find(questionID)
   
    UsersChannel.broadcast_to room, { currentPlayer: currentPlayer, currentQuestion: currentQuestion, reshufflingUsers: reshufflingUsers, reshufflingQuestions: reshufflingQuestions, allUsers: allUsers }
   
  end

  def start
    room = Room.find(user_params[:room])
    allUsers = room.users.all
    room.update(game_started: true)
    userArray = room.users.select { |roomObj| roomObj.is_active === true }
    currentPlayer = userArray.sample(1).first
    questionArray = room.room_questions.select { |roomObj| roomObj.is_active === true }
    questionID = questionArray.sample(1).first.question_id
    currentQuestion = Question.all.find(questionID)
    p currentPlayer
    UsersChannel.broadcast_to room, { currentPlayer: currentPlayer, currentQuestion: currentQuestion, allUsers: allUsers, room: room }
  end

  def destroy
    user = User.find(user_params[:id])
    render json: user
    user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :id, :room, :currentPlayer, :currentQuestion, :reshufflingUsers)
  end

  def question_params
    params.require(:question).permit(:id)
  end

end
