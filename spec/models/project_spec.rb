require 'spec_helper'

describe Project do
    # before :each do
    #     @project = Project.create(name: 'ER Moonlight Scheduler')
    # end
    # describe 'getting pull request data' do
    #     it 'should initially have no pull request' do
    #         expect(@project.pull_request).to eq(nil)
    #     end
    #     it 'should create a new pull request object' do
    #         @project.get_pull_request_data
    #         expect(@project.pull_request).not_to eq(nil)
    #     end
    #     it 'should populate the fields of the pull request object' do
    #         @project.get_pull_request_data
    #         pull_request = @project.pull_request
    #         expect(pull_request.red).to be >= 0
    #         expect(pull_request.yellow).to be >= 0
    #         expect(pull_request.green).to be >= 0
    #     end
    # end
    # describe 'getting slack data' do
    #     it 'should initially have no slack points' do
    #         expect(@project.slack_data_points.length).to eq(0) 
    #     end
    #     it 'should create slack data point objects' do
    #         @project.get_slack_data
    #         expect(@project.slack_data_points.length).to be > 0
    #     end
    #     it 'should have zero or more message per data point object' do
    #         @project.get_slack_data
    #         @project.slack_data_points.each do |point|
    #             expect(point.messages).to be >= 0 
    #         end
    #     end
    # end
end