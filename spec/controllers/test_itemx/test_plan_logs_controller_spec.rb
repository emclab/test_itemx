# encoding: utf-8
require 'spec_helper'

module TestItemx

  describe TestItemx::TestPlanLogsController do

    before(:each) do
      #the following recognizes that there is a before filter without execution of it.
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      #controller.should_receive(:session_timeout)
    end

    render_views

    describe "'show'" do
      it "should be successful" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        cust = FactoryGirl.create(:customerx_customer)
        rfq_test_item = FactoryGirl.create(:rfq_test_item) #, :rfq_id => rfq.id)
        rfq = FactoryGirl.create(:rfq, :customer_id => cust.id, :rfq_test_items => [rfq_test_item])
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tp = FactoryGirl.create(:test_plan, :quote_id => q.id)
        log = FactoryGirl.create(:test_plan_log, :test_plan_id => tp.id, :last_updated_by_id => u.id)
        get 'show', {:use_route => :test_items,  :test_plan_id => tp.id, :id => log.id }
        response.should be_success
      end
    end

    describe "GET 'new'" do

      it "should be successful with rights" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_plan_logs')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        rfq = FactoryGirl.create(:rfq, :emc_eng_id => u.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tp = FactoryGirl.create(:test_plan, :quote_id => q.id)
        get 'new', {:use_route => :test_items, :test_plan_id => tp.id   }
        response.should be_success
      end

      it "should reject for those without right" do
        rfq = FactoryGirl.create(:rfq)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tp = FactoryGirl.create(:test_plan, :quote_id => q.id)
        #session[:user_id] = u.id + 100
        log = FactoryGirl.build(:test_plan_log, :test_plan_id => tp.id)
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        get 'new', {:use_route => :test_items, :test_plan_id => tp.id  }
        log.should redirect_to URI.escape("/view_handler?index=0&msg=权限不足！")
      end
    end

    describe "'create'" do
      it "should be successful for those with rights" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_plan_logs')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        rfq = FactoryGirl.create(:rfq, :emc_eng_id => u.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tp = FactoryGirl.create(:test_plan, :quote_id => 1) #q.id)
        log = FactoryGirl.attributes_for(:test_plan_log, :test_plan_id => tp.id)

        lambda do
          get 'create', {:use_route => :test_items, :test_plan_id => tp.id, :test_plan_log => log }
          response.should redirect_to quote_test_plan_path(q, tp)
        end.should change(TestPlanLog, :count).by(1)
      end

      it "should be rendder new for a data error in saving" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_plan_logs')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        rfq = FactoryGirl.create(:rfq, :safety_eng_id => u.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tp = FactoryGirl.create(:test_plan, :quote_id => q.id)
        log = FactoryGirl.attributes_for(:test_plan_log, :test_plan_id => tp.id, :content => nil)
        lambda do
          get 'create', {:use_route => :test_items, :test_plan_id => tp.id, :test_plan_log => log }
          response.should render_template('new')
        end.should change(TestPlanLog, :count).by(0)
      end

    end

    describe "GET 'destroy'" do
      it "should be successful" do
        get 'destroy' , {:use_route => :test_items }
        response.should be_success
      end
    end

  end
end