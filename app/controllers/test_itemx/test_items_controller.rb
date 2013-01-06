# encoding: utf-8

require_dependency "test_itemx/application_controller"

module TestItemx
  
  class TestItemsController < ApplicationController

    before_filter :require_signin
    #before_filter :require_employee
    
    helper_method :has_edit_right?, :has_create_right?
      
    def index
      @title = "测试项目" 
      if has_edit_right?
        @test_items = TestItem.order("name")
      else
        @test_items = TestItem.active_test_item.order("name")
      end
    end
  
    def new
      @title = "输入测试项目"   
      if has_create_right?
        @test_item = TestItem.new()
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足！")
      end  
    end
  
    def create
      if has_create_right?
        @test_item = TestItem.new(params[:test_item], :as => :role_new)
        @test_item.last_updated_by_id = session[:user_id]
        if @test_item.save
          #email notification
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=已保存测试项目！")
        else
          flash.now[:error] = "无法保存测试项目！"
          render 'new'
        end
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足！")
      end  
    end
  
    def edit
      @title = "更新测试项目" 
      if has_edit_right?
        @test_item = TestItem.find(params[:id])
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=无修改权限！")      
      end    
    end
  
    def update
      if has_edit_right?
        @test_item = TestItem.find(params[:id])
        @test_item.last_updated_by_id = session[:user_id]
        if @test_item.update_attributes(params[:test_item], :as => :role_update)
          #email notification
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=已更新测试项目！")
        else
          flash.now[:error] = "数据错误！"
          render 'edit'
        end
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=无修改权限！")      
      end        
    end
  
    def show
      @title = "测试项目内容"   
      @test_item = TestItem.find(params[:id])  
    end
    
    protected
    
    def has_create_right?
      grant_access?('create', 'test_itemx_test_items', nil, nil)
    end
    
    def has_edit_right?
      grant_access?('update', 'test_itemx_test_items', nil, nil)
    end
  
  end

end