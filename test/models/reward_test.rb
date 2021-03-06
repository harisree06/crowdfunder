require 'test_helper'

class RewardTest < ActiveSupport::TestCase

  test 'A reward can be created' do
    project = build(:project, start_date: Time.now.utc - rand(60).days, end_date: Time.now.utc + rand(10).days)
    project.save
    reward = build(:reward, dollar_amount: 99.00, description: 'A heartfelt thanks!', project: project)
    reward.save
    assert reward.valid?
    assert reward.persisted?
  end

  test 'A reward cannot be created without a dollar amount' do
    project = build(:project, start_date: Time.now.utc - rand(60).days, end_date: Time.now.utc + rand(10).days)
    project.save
    reward = build(:reward, description: 'A heartfelt thanks', project: project)
    reward.save
    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  test 'A reward cannot be created without a description' do
    project = build(:project, start_date: Time.now.utc - rand(60).days, end_date: Time.now.utc + rand(10).days)
    project.save
    reward = build(:reward, dollar_amount: 99.00, project: project)
    reward.save
    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end


    test 'project dollar amount must be a positive number' do
      project = build(:project, start_date: Time.now.utc - rand(60).days, end_date: Time.now.utc + rand(10).days)
      project.save
      reward = build(:reward, dollar_amount: 99.00, description: 'A heartfelt', project: project)
      reward.save
      assert reward.valid?
      assert reward.dollar_amount
    end

    test 'project dollar amount cannot be negative' do
      project = build(:project, start_date: Time.now.utc - rand(60).days, end_date: Time.now.utc + rand(10).days)
      project.save
      reward = build(:reward, dollar_amount: -99.00, description: 'A heartfelt', project: project)
      reward.save

      assert reward.invalid? 'Reward should be invalid with negative dollar_amount'
      assert reward.new_record?
    end

end
