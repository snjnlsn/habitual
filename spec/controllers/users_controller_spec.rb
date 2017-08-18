require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context "when the user is not valid" do

    it "returns a status code of 422 for an invalid user" do
         post :create, params: { user: { user_identifier: nil } }
         expect(response.status).to eq 422
    end

    it "returns a json object with errors in response body" do
    post :create, params: { user: { name: 'Dog' } }
    expect(JSON.parse(response.body)['user_identifier']).to eq ["can't be blank"]
    end

  end

  context "when the user is valid" do

    it "returns a status code of 201 for a valid user" do
       post :create, params: { user: { user_identifier: '12345', name: "Dog" } }
       expect(response.status).to eq 201
    end

    it "returns a json object in response body" do
      post :create, params: { user: { user_identifier: '12345', name: 'Dog' } }
      expect(JSON.parse(response.body)['id']).to_not be nil
    end

  end

end
