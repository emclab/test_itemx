# encoding: utf-8
require 'spec_helper'

module TestItemx

  describe TestItemx::TestPlansController do

    before(:each) do
      #the following recognizes that there is a before filter without execution of it.
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      #controller.should_receive(:session_timeout)
    end

    render_views

    describe "'index'" do
      it "should be successful" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'all_index_view', :table_name => 'test_itemx_test_plans')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        cust = FactoryGirl.create(:customerx_customer)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :sales_id => u.id,:product_id => prod.id, :emc_eng_id => u.id, :safety_eng_id => u.id, :customer_id => cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tp = FactoryGirl.create(:test_plan, :quote_id => q.id)
        get 'index', {:use_route => :test_items }
        response.should be_success
      end
    end

    describe "'new'" do
      it "should be successful for approved quote and those with rights" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_plans')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        cust = FactoryGirl.create(:customerx_customer)
        t = FactoryGirl.create(:test_item)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :sales_id => u.id, :product_id => prod.id, :emc_eng_id => u.id, :safety_eng_id => u.id, :customer_id => cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id, :approved_by_customer => true, :customer_approver_name => 'a guy',
                    :approved_by_corp_head => true, :test_item_ids => [t.id])
        tp = FactoryGirl.attributes_for(:test_plan, :quote_id => q.id)
        get 'new', {:use_route => :test_items, :quote_id => q.id }
        response.should be_success
      end

      it "should redirect to previous page for those without right" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        #cust = FactoryGirl.create(:customer)
        t = FactoryGirl.create(:test_item)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :sales_id => u.id,:product_id => prod.id, :emc_eng_id => u.id, :safety_eng_id => u.id, :customer_id => 1) #cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id, :approved_by_customer => true, :customer_approver_name => 'a guy',
                    :approved_by_corp_head => true, :test_item_ids => [t.id])
        tp = FactoryGirl.attributes_for(:test_plan, :quote_id => q.id)
        get 'new', {:use_route => :test_items, :quote_id => q.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=权限不足或报价尚未批准！")
      end
    end

    describe "'create'" do

      it "should redirect to previous page for quote which is not ready" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_plans')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        #cust = FactoryGirl.create(:customer)
        t = FactoryGirl.create(:test_item)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :sales_id => u.id, :product_id => prod.id, :emc_eng_id => u.id, :safety_eng_id => u.id, :customer_id => 1) #cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id, :approved_by_customer => false, :customer_approver_name => 'a guy',
                    :approved_by_corp_head => true, :test_item_ids => [t.id])
        tp = FactoryGirl.attributes_for(:test_plan, :quote_id => q.id)
        get 'create', {:use_route => :test_items, :quote_id => q.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=权限不足或报价尚未批准！")
      end

      it "should redirect to previous page after successful saving a new record and record count increase by -1-" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'test_itemx_test_plans')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        #cust = FactoryGirl.create(:customer)
        t = FactoryGirl.create(:test_item)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :sales_id => u.id,:product_id => prod.id,  :emc_eng_id => u.id, :safety_eng_id => u.id, :customer_id => 1) #cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id, :approved_by_customer => true, :customer_approver_name => 'a guy',
                    :approved_by_corp_head => true, :test_item_ids => [t.id])
        tp = FactoryGirl.attributes_for(:test_plan, :quote_id => q.id, :last_updated_by_id => u.id)
        lambda do
          get 'create', {:use_route => :test_items, :quote_id => q.id, :test_plan => tp  }
          response.should redirect_to URI.escape("/view_handler?index=0&msg=开案单已保存！")
        end.should change(TestPlan, :count).by(1)
      end

    end

    describe "'edit'" do
      it "should reject those without rights" do
        ul = FactoryGirl.create(:authentify_user_level )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        #cust = FactoryGirl.create(:customer)
        t = FactoryGirl.create(:test_item)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :sales_id => u.id, :product_id => prod.id, :emc_eng_id => u.id, :safety_eng_id => u.id, :customer_id => 1) #cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id, :approved_by_customer => true, :customer_approver_name => 'a guy',
                    :approved_by_corp_head => true, :test_item_ids => [t.id])
        tp = FactoryGirl.create(:test_plan, :quote_id => q.id, :last_updated_by_id => u.id)
        get 'edit', {:use_route => :test_items, :id => tp.id, :quote_id => q.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=权限不足!")
      end
    end

    describe "'update'" do

      it "should update for those with rights" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'update', :table_name => 'test_itemx_test_plans')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        #cust = FactoryGirl.create(:customer)
        t = FactoryGirl.create(:test_item)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :sales_id => u.id, :product_id => prod.id, :emc_eng_id => u.id, :safety_eng_id => u.id, :customer_id => 1) #cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id, :approved_by_customer => true, :customer_approver_name => 'a guy',
                    :approved_by_corp_head => true, :test_item_ids => [t.id])
        tp = FactoryGirl.create(:test_plan, :quote_id => q.id, :last_updated_by_id => u.id)
        get 'update', {:use_route => :test_items, :quote_id => q.id, :id => tp.id, :test_plan => {:sample_requirement => 'this is a new sample requirement!'} }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=开案单已修改！")
      end

      it "should redirect to 'edit' if data has error" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action1 = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'approve', :table_name => 'test_itemx_test_plans')
        action2 = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'update', :table_name => 'test_itemx_test_plans')
        right1 = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action1.id)
        right2 = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action2.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        cust = FactoryGirl.create(:customerx_customer)
        t = FactoryGirl.create(:test_item)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :sales_id => u.id, :product_id => prod.id, :emc_eng_id => u.id, :safety_eng_id => u.id, :customer_id => cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id, :approved_by_customer => true, :customer_approver_name => 'a guy',
                    :approved_by_corp_head => true, :test_item_ids => [t.id])
        tp = FactoryGirl.create(:test_plan, :quote_id => q.id, :last_updated_by_id => u.id)
        get 'update', {:use_route => :test_items, :quote_id => q.id, :id => tp.id, :test_plan => {:sample_requirement => nil} }
        response.should render_template('edit')
      end

    end

    describe "'show'" do
      it "should be successful for emc_eng in the rfq" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'show', :table_name => 'test_itemx_test_plans')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        cust = FactoryGirl.create(:customerx_customer)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :emc_eng_id => u.id, :product_id => prod.id,:safety_eng_id => u.id, :sales_id => u.id, :customer_id => cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tl = FactoryGirl.create(:test_plan, :quote_id => q.id)
        get 'show', {:use_route => :test_items, :quote_id => q.id, :id => tl.id}
        response.should be_success
      end

      it "should be successful for reporer" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'reporter')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'show', :table_name => 'test_itemx_test_plans')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        cust = FactoryGirl.create(:customerx_customer)
        prod = FactoryGirl.create(:productx_emc_it_product)
        rfq = FactoryGirl.create(:rfq, :product_id => prod.id, :emc_eng_id => u.id, :safety_eng_id => u.id, :sales_id => u.id, :customer_id => cust.id)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tl = FactoryGirl.create(:test_plan, :quote_id => q.id)
        get 'show',{:use_route => :test_items, :quote_id => q.id, :id => tl.id }
        response.should be_success
      end

      it "should reject those without right" do
        ul = FactoryGirl.create(:authentify_user_level )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        rfq = FactoryGirl.create(:rfq)
        q = FactoryGirl.create(:quote, :rfq_id => rfq.id)
        tl = FactoryGirl.create(:test_plan, :quote_id => q.id)
        get 'show',{:use_route => :test_items, :quote_id => q.id, :id => tl.id }
        response.should redirect_to URI.escape("/view_handler?index=0&msg=权限不足！")
      end
    end

  end
end