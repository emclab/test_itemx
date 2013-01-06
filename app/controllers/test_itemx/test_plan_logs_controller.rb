#encoding: utf-8

module TestItemx


  class TestPlanLogsController < ApplicationController
    
    before_filter :require_signin
    before_filter :require_employee
    
    helper_method :has_create_right?, :has_destroy_right?
    
    def show
      @title= "开案单内容"
      @test_plan = TestPlan.find(params[:test_plan_id])
      @test_plan_log = TestPlanLog.find(params[:id])
    end
  
    def new
      @title= "输入开案单"    
      @test_plan = TestPlan.find(params[:test_plan_id])
      if has_create_right?
        @test_plan_log = @test_plan.test_plan_logs.new()
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足！")
      end
    end
  
    def create
      @test_plan = TestPlan.find(params[:test_plan_id])
      if has_create_right?  
        @test_plan_log = @test_plan.test_plan_logs.new(params[:test_plan_log], :as => :role_new)
        @test_plan_log.last_updated_by_id = session[:user_id]
        if @test_plan_log.save
          redirect_to quote_test_plan_path(@test_plan.quote, @test_plan), :notice => "Log已保存！"
        else
          flash.now[:error] = '无法保存Log！'
          render 'new'
        end
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足！")
      end
    end
  
    def destroy
    end
  
    protected
    
    
    def has_create_right?
      grant_access?('create', 'test_itemx_test_plan_logs', nil, nil)
    end
    
    def has_edit_right?
      grant_access?('update', 'test_itemx_test_plan_logs', nil, nil)
    end
    
    def has_destroy_right?
      grant_access?('destroy', 'test_itemx_test_plan_logs', nil, nil) 
    end
  end

end