require 'rails_helper'

RSpec.describe "Task Requests", :type => :request do
  describe "tasks API" do
    let(:homework){ FactoryBot.create(:homework) }
    let(:email){ FactoryBot.create(:email) }
    let(:user_with_tasks){ FactoryBot.create(:user_with_tasks) }
    let(:token) { authentication_token(user_with_tasks) }
    let(:headers) { {AUTHORIZATION: "Bearer #{token}"} }

    it 'unauthorized user is given 401' do
      get '/v1/tasks'
      expect(response.status).to eq(401)
    end

    it 'returns a list of tasks for the current user' do
      task = homework
      get v1_tasks_path, headers: headers

      expect(response).to be_successful
      expect(json.length).to eq(2)
    end

    it 'returns the requested task' do
      get v1_task_path(homework.id), headers: headers

      expect(response).to be_successful

      expect(json['name']).to eq("complete homework")
    end

    it 'creates a new task' do
      user =  FactoryBot.create(:user)
      task_attributes = FactoryBot.attributes_for(:email, user_id: user_with_tasks.id)

      expect {
        post "/v1/tasks", headers: headers,
        params: { task: task_attributes } }.to change(Task, :count).by(1)

        expect(response.status).to eq(201)
      end
    end
  end
