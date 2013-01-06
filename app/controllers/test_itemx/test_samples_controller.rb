# encoding: utf-8

module TestItemx

  class TestSamplesController < ApplicationController
    before_filter :require_signin
    before_filter :require_employee
  
    
    helper_method :has_edit_right?, :has_create_right?, :has_delete_right?
    
    def show
      @test_sample = TestSample.find(params[:id])
      @test_plan = @test_sample.test_plan
    end
  
    def new
      @test_plan = TestPlan.find(params[:test_plan_id])
      @test_sample = @test_plan.test_samples.new
      if !has_create_right?
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足！")
      end
    end
  
    def create
      @test_plan = TestPlan.find(params[:test_plan_id])
      if has_create_right?
        @test_sample = @test_plan.test_samples.new(params[:test_sample], :as => :role_new)
        @test_sample.last_updated_by_id = session[:user_id]
        if @test_sample.save
          redirect_to quote_test_plan_path(@test_plan.quote, @test_plan), :notice => '样品记录已保存！'
        else
          flash.now[:error] = '无法保存！'
          render 'new'
        end 
      end 
    end
    
    def edit
      @test_plan = TestPlan.find(params[:test_plan_id])
      @test_sample = TestSample.find(params[:id])
      if !has_edit_right?
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足！")
      end
    end
  
    def update
      @test_plan = TestPlan.find(params[:test_plan_id])
      @test_sample = TestSample.find(params[:id])   
      if has_edit_right?
        @test_sample.last_updated_by_id = session[:user_id]
        if @test_sample.update_attributes(params[:test_sample], :as => :role_update)
          redirect_to quote_test_plan_path(@test_plan.quote, @test_plan), :notice => '记录已修改！'
        else
          flash.now[:error] = '无法保存！'
          render 'edit'
        end
      end  
    end
    
    def destroy
    end
    
    protected
    
    def has_create_right? #(test_plan)
      #rfq = test_plan.quote.rfq
      #return true if session[:user_id] == rfq.emc_eng_id && eng?
      #return true if session[:user_id] == rfq.safety_eng_id && eng?
      #return true if eng_dept_head? || corp_head? || ceo?   
      return true if grant_access?('create', 'test_itemx_test_samples', nil, nil) || grant_access?('update', 'test_itemx_test_samples', nil, nil)
    end
    
    def has_edit_right? #(test_plan)
      #rfq = test_plan.quote.rfq
      #return true if session[:user_id] == rfq.emc_eng_id && eng?
      #return true if session[:user_id] == rfq.safety_eng_id && eng?
      #return true if eng_dept_head? || corp_head? || ceo? 
      return true if grant_access?('create', 'test_itemx_test_samples', nil, nil) || grant_access?('update', 'test_itemx_test_samples', nil, nil)
    end

    def has_delete_right? #(test_plan)
                        #rfq = test_plan.quote.rfq
                        #return true if session[:user_id] == rfq.emc_eng_id && eng?
                        #return true if session[:user_id] == rfq.safety_eng_id && eng?
                        #return true if eng_dept_head? || corp_head? || ceo?
      return true if grant_access?('delete', 'test_itemx_test_samples', nil, nil)
    end


  end

end