# encoding: utf-8 
require 'spec_helper'

module TestItemx

    describe TestItemx::StandardsController do
    before(:each) do
      #the following recognizes that there is a before filter without execution of it.
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
    end
    
    render_views  
  
    describe "'index'" do
      it "should be successful" do
        std = FactoryGirl.create(:standard)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        get 'index', {:use_route => :test_items}
        response.should be_success
      end
    end
  
    describe "'edit'" do
      it "should be successful for eng dept head" do
        session[:eng_dept_head] = true
        #session[:eng] = true
        std = FactoryGirl.create(:standard)
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'update', :table_name => 'test_itemx_standards')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        get 'edit', {:use_route => :test_items, :id => std.id }
        response.should be_success
      end
      
      it "should be successful for corp head" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'corp_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'update', :table_name => 'test_itemx_standards')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        std = FactoryGirl.create(:standard)
        get 'edit', {:use_route => :test_items, :id => std.id }
        response.should be_success
      end    
      
      it "should be redirected if has no right" do
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        std = FactoryGirl.create(:standard)
        get 'edit', {:use_route => :test_items, :id => std.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=无权更新标准!")
      end
    end
  
    describe "'update'" do
      it "should be successful for corp head" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'corp_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'update', :table_name => 'test_itemx_standards')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        std = FactoryGirl.create(:standard)
        post 'update', {:use_route => :test_items, :id => std.id, :standard => {:name => 'name changed'}  }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=标准更改成功保存！")
      end
      
      it "should be successful for end dept head" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'update', :table_name => 'test_itemx_standards')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        std = FactoryGirl.create(:standard)
        post 'update', {:use_route => :test_items, :id => std.id, :standard => {:name => 'name changed'} }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=标准更改成功保存！")
      end
          
      it "should reject those without rights" do
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        std = FactoryGirl.create(:standard)
        post 'update', {:use_route => :test_items, :id => std.id, :standard => {:name => 'name changed'} }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=无权更改标准!")      
      end
    end
  
    describe "'new'" do
      it "should be successful for eng dept head" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_standards')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        get 'new', {:use_route => :test_items }
        response.should be_success
      end
      
      it "should be redirected if has no right" do
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        get 'new', {:use_route => :test_items }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=无权创建新标准!")
      end
    end
  
    describe "'create'" do
      it "should be successful for those with proper rights" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_standards')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        std = FactoryGirl.attributes_for(:standard)
        post 'create', {:use_route => :test_items , :standard => std }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=新标准成功保存！")
      end
      
      it "should reject for those who does not have rights" do
        ugrp1 = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'sales')
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')

        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_standards')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp1.id, :sys_action_on_table_id => action.id)
        std = FactoryGirl.attributes_for(:standard)
        post 'create', {:use_route => :test_items , :standard => std }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=无权输入新标准!")     
      end
      
        it "should create one standard if successful" do
          ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
          action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_standards')
          right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
          ul = FactoryGirl.create(:authentify_user_level)
          u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
          session[:user_id] = u.id
          session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
          std = FactoryGirl.attributes_for(:standard)
          lambda do
              post :create, {:use_route => :test_items , :standard => std }
            end.should change(Standard, :count).by(1)
          end

          it "should create one standard if successful" do
            ul = FactoryGirl.create(:authentify_user_level)
            u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
            session[:user_id] = u.id
            session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
            std = FactoryGirl.attributes_for(:standard)
            lambda do
              post :create, {:use_route => :test_items , :standard => std }
            end.should change(Standard, :count).by(0)
          end
                 
    end
  
    describe "'show'" do
      it "should be successful" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_standards')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level)
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        std = FactoryGirl.create(:standard)
        get 'show', {:use_route => :test_items , :id => std.id }
        response.should be_success
      end
    end
  
  end
end
