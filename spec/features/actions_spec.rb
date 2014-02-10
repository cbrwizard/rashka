require 'spec_helper'
require 'rspec/expectations'

describe "user_actions", :type => :feature do

  it "triggers_evacuation", :js => true do
    visit '/'
    people_left_before = Stat.first.people_left

    find("#evac_btn").click
    find("#share_btn").should be_visible
    people_left_after = Stat.first.people_left

    people_left_after.should == people_left_before + 1
  end

  it "displays_reason", :js => true do
    visit '/'

    find("#evac_btn").click
    find("#share_btn").click
    find("#reason_field").value.should_not be_nil
  end

  it "changes_reason", :js => true do
    visit '/'
    find("#evac_btn").click
    find("#share_btn").click

    reason_before = find("#reason_field").value
    find("#get_random_container a").click
    reason_after = find("#reason_field").value

    reason_before.should_not == reason_after
  end
end
