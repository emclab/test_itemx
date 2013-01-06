# encoding: utf-8
require 'spec_helper'

module TestItemx


  describe TestItemx::TestSamplesController do

    before(:each) do
      #the following recognizes that there is a before filter without execution of it.
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      #controller.should_receive(:session_timeout)
    end

    render_views

    describe "'show'" do
      it "should be successful for everyone" do
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        m = FactoryGirl.create(:manufacturer)
        rfq = FactoryGirl.create(:rfq, :emc_eng_id => u.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tl = FactoryGirl.create(:test_plan, :quote_id => q.id)
        ts = FactoryGirl.create(:test_sample, :test_plan_id => tl.id, :manufacturer_id => m.id)
        get 'show', {:use_route => :test_items, :id => ts.id, :test_plan_id => tl.id }
        response.should be_success
      end
    end

    describe "'new'" do

      it "should be successful" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_samples')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        m = FactoryGirl.create(:manufacturer)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :emc_eng_id => u.id,:product_id => prod.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tl = FactoryGirl.create(:test_plan, :quote_id => q.id)
        ts = FactoryGirl.attributes_for(:test_sample, :test_plan_id => tl.id, :manufacturer_id => m.id)
        get 'new', {:use_route => :test_items, :test_plan_id => tl.id  }
        response.should be_success
      end

      it "should reject for those without rights" do
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        m = FactoryGirl.create(:manufacturer)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :emc_eng_id => u.id,:product_id => prod.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tl = FactoryGirl.create(:test_plan, :quote_id => q.id)
        ts = FactoryGirl.attributes_for(:test_sample, :test_plan_id => tl.id, :manufacturer_id => m.id)
        get 'new', {:use_route => :test_items, :test_plan_id => tl.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=权限不足！")
      end

    end

    describe "'create'" do
      it "should be successful and sample record increased by -1-" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_samples')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        m = FactoryGirl.create(:manufacturer)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :emc_eng_id => u.id,:product_id => prod.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tl = FactoryGirl.create(:test_plan, :quote_id => q.id)
        ts = FactoryGirl.attributes_for(:test_sample, :test_plan_id => tl.id, :manufacturer_id => m.id)
        lambda do
          get 'create', {:use_route => :test_items, :test_plan_id => tl.id, :test_sample => ts }
          response.should redirect_to quote_test_plan_path(tl.quote_id, tl)
        end.should change(TestSample, :count).by(1)
      end
    end

    describe "'edit'" do
      it "should reject for those without rights" do
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        m = FactoryGirl.create(:manufacturer)
        rfq = FactoryGirl.create(:rfq, :emc_eng_id => u.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tl = FactoryGirl.create(:test_plan, :quote_id => q.id)
        ts = FactoryGirl.create(:test_sample, :test_plan_id => tl.id, :manufacturer_id => m.id)
        get 'edit', {:use_route => :test_items, :id => ts.id, :test_plan_id => tl.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=权限不足！")
      end
    end

    describe "'update'" do
      it "should be OK for those with rights" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_samples')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        m = FactoryGirl.create(:manufacturer)
        rfq = FactoryGirl.create(:rfq, :emc_eng_id => u.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tl = FactoryGirl.create(:test_plan, :quote_id => q.id)
        ts = FactoryGirl.create(:test_sample, :test_plan_id => tl.id, :manufacturer_id => m.id)
        lambda do
          get 'update', {:use_route => :test_items, :id => ts.id, :test_plan_id => tl.id, :test_sample => {:return_date => '2012-6-6' }  }
          response.should redirect_to quote_test_plan_path(tl.quote, tl)
          #response.should render_template('edit')
        end.should change(TestSample, :count).by(0)
      end

    end

    describe "'destroy'" do
      it "should be successful" do
        get 'destroy', {:use_route => :test_items}
        response.should be_success
      end
    end

  end
end