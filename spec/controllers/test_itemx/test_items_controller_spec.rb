# encoding: utf-8
require 'spec_helper'

module TestItemx

  describe TestItemx::TestItemsController do

    before(:each) do
      #the following recognizes that there is a before filter without execution of it.
      controller.should_receive(:require_signin)
      #controller.should_receive(:require_employee)
      #controller.should_receive(:session_timeout)
    end

    render_views

    describe "'index'" do
      it "should be successful for index" do
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.create(:test_item, :standard_id => s.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        get 'index', {:use_route => :test_items}
        response.should be_success
      end

      it "should be successful for index for sales member" do
        session[:sales] = true
        #session[:member] = true
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.create(:test_item, :standard_id => s.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        get 'index', {:use_route => :test_items}
        response.should be_success
      end

      it "should be successful for index for eng member" do
        session[:eng] = true
        #session[:member] = true
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.create(:test_item, :standard_id => s.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        get 'index', {:use_route => :test_items}
        response.should be_success
      end

    end

    describe "'new'" do
      it "should be successful for eng dept head" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_items')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        t = FactoryGirl.attributes_for(:test_item)
        get 'new', {:use_route => :test_items}
        response.should be_success
      end

      it "should reject those without rights" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        t = FactoryGirl.attributes_for(:test_item)
        get 'new', {:use_route => :test_items}
        response.should redirect_to URI.escape("/view_handler?index=0&msg=权限不足！")
      end
    end

    describe "'create'" do
      it "should be successful for eng dept head" do
        #session[:eng] = true
        session[:eng_dept_head] = true
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.attributes_for(:test_item, :standard_id => s.id)
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_items')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        get 'create', {:use_route => :test_items, :test_item => t }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=已保存测试项目！")
      end

      it "should increase the record count by 1" do
        session[:corp_head] = true
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.attributes_for(:test_item, :standard_id => s.id)
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'corp_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_items')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        lambda do
          get 'create', {:use_route => :test_items, :test_item => t }
        end.should change(TestItem, :count).by(1)
      end

      it "should reject those without rights" do
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.attributes_for(:test_item, :standard_id => s.id)
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        get 'create', {:use_route => :test_items, :test_item => t }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=权限不足！")
      end
    end

    describe "'edit'" do
      it "should reject without right" do
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.create(:test_item, :standard_id => s.id)
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        get 'edit', {:use_route => :test_items, :id => t.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=无修改权限！")
      end

      it "should be success for eng dept head" do
        #session[:eng] = true
        session[:eng_dept_head] = true
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.create(:test_item, :standard_id => s.id)
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'update', :table_name => 'test_itemx_test_items')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        get 'edit', {:use_route => :test_items, :id => t.id }
        response.should be_success
      end
    end

    describe "'update'" do

      it "should reject those without rights" do
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.create(:test_item, :standard_id => s.id)
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        get 'update', {:use_route => :test_items, :id => t.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=无修改权限！")
      end

      it "should be successful for eng dept head" do
        #session[:eng] = true
        session[:eng_dept_head] = true
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.create(:test_item, :standard_id => s.id)
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'update', :table_name => 'test_itemx_test_items')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)

        get 'update', {:use_route => :test_items, :id => t.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=已更新测试项目！")
      end

    end

    describe "'show'" do
      it "should be successful for everyone" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        s = FactoryGirl.create(:standard)
        t = FactoryGirl.create(:test_item, :standard_id => s.id, :last_updated_by_id => u.id)
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        get 'show', {:use_route => :test_items, :id => t.id }
        response.should be_success
      end
    end

  end
end