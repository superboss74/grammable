require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'comments#create action' do
    # Specification to ensure Users Are Logged in When
    # Creating Comments
    #
    # * A gram needs to exist in our database.
    # * When someone who is not logged in triggers an HTTP POST
    #   request to a URL that looks like /grams/:gram_id/comments,
    #   with the message "awesome gram".
    # * Our server will redirect the user to login.
    it 'should allow users to create comments on grams' do
      # Next line creates a gram using Factorybots
      gram = FactoryBot.create(:gram)
      # Next two lines create a user that is required
      # to be signed into the app
      user = FactoryBot.create(:user)
      sign_in user
      # Next line will trigger a gram to the create action and
      # specify a message of "awesome gram!".
      post :create, params: { gram_id: gram.id, comment: { message: 'awesome gram' } }
      # Next line will confirm that our app's response is to to
      # get the user to redirected to the root path.
      expect(response).to redirect_to root_path
      # Nex two lines will confirm that a single comment has been
      # created in the database with the message "awesome gram"
      expect(gram.comments.length).to eq 1
      expect(gram.comments.first.message).to eq 'awesome gram'
    end

    #Specification to Ensure Users Are Logged in When Creating Comments
    #
    # * A gram needs to exist in our database.
    # * When someone who is not logged in triggers an HTTP POST 
    #   request to a URL that looks like /grams/:gram_id/comments,
    #   with the message "awesome gram".
    # * Our server will redirect the user to login.
    it 'should require a user to be logged in to comment on a gram' do
      # we need a gram to exist in our database before we trigger
      # the action, use FactoryBot to create a gram in the database.
      gram = FactoryBot.create(:gram)
      # Next line will create an HTTP POST to the create action,
      # with the message of "awesome gram".
      # We don't need a user to be logged in.
      post :create, params: { gram_id: gram.id, comment: { message: 'awesome gram' } }
      # we expect the response to redirect to the sign-in page
      expect(response).to redirect_to new_user_session_path
    end

    # Specification for the Comment Creation Cannot Find a Gram
    #
    # * As a user who is logged into the site.
    # * When when they trigger an HTTP POST request to a URL that
    #   looks like /grams/YOLOSWAG/comments, with the message "awesome gram"
    # * Our server should respond with the HTTP Response of 404 Not Found
    it "should return http status code of not found if the gram isn't found" do
      # Creating a user we can use for this test
      user = FactoryBot.create(:user)
      # The user must be signed in.
      sign_in user
      # Next line will create an HTTP POST request to create a gram
      post :create, params: { gram_id: 'YOLOSWAG', comment: { message: 'awesome gram' } }
      # Next line will check that we are returning a $04 Not Found error.
      expect(response).to have_http_status :not_found
    end
  end
end
