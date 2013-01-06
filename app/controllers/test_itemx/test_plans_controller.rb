# encoding: utf-8

module TestItemx

  
  class TestPlansController < ApplicationController
    
    before_filter :require_signin
    before_filter :require_employee
    before_filter :load_quote
    
    helper_method :has_show_right?, :has_edit_right?, :has_create_right?, :has_log_right?, :quote_approved?, :has_new_sample_right?,
                  :has_all_index_view?, :has_approve_right?
  
    def index
      @title = '开案单'
      #if sales_dept_head? || corp_head? || ceo?
      if has_all_index_view?
        @test_plans = @quote.present? ? @quote.test_plan.order("id DESC").paginate(:per_page => 40, :page => params[:page]) : TestPlan.where('created_at > ?', Time.now - 365.day).order("id DESC").paginate(:per_page => 40, :page => params[:page])
      else
        @test_plans = @quote.present? ? @quote.active_test_plan.order("id DESC").paginate(:per_page => 40, :page => params[:page]) : TestPlan.active_test_plan.where('created_at > ?', Time.now - 365.day).order("id DESC").paginate(:per_page => 40, :page => params[:page])
      end        
    end
  
    def new
      if has_create_right? && quote_approved?(@quote)
        @test_plan = @quote.build_test_plan()
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足或报价尚未批准！")
      end
      
    end
  
    def create
      if has_create_right? && quote_approved?(@quote)
        @test_plan = @quote.build_test_plan(params[:test_plan], :as => :role_new)
        @test_plan.last_updated_by_id = session[:user_id]
        if @test_plan.save
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=开案单已保存！")
        else
          flash.now[:error] = "无法保存开案单！"
          render 'new'
        end
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足或报价尚未批准！")
      end    
    end
  
    def edit
      @title = '更改开案单'
      @test_plan = TestPlan.find(params[:id])
      if !has_edit_right?
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足!")
      end
    end
  
    def update
      if has_edit_right?
        @test_plan = TestPlan.find(params[:id])
        @test_plan.last_updated_by_id = session[:user_id]
        if @test_plan.update_attributes(params[:test_plan], :as => :role_update)
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=开案单已修改！")
        else
          flash.now[:error] = '无法保存修改！'
          render 'edit'
        end
      end
    end
  
    def show
      @title = '开案单内容'
      @test_plan = TestPlan.find(params[:id])
      if !has_show_right?
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=权限不足！")
      end    
    end
  
    def search
      @test_plan = TestPlan.new
    end
    
    def search_results
      @test_plan = TestPlan.new(params[:test_plan], :as => :role_search)
      
      @test_plans = @test_plan.find_test_plans  
    end
    
    protected


    def has_create_right?
      #rfq = quote.rfq
      #return true if session[:user_id] == rfq.emc_eng_id && eng?
      #return true if session[:user_id] == rfq.safety_eng_id && eng?
      #return true if eng_dept_head? || corp_head? || ceo? 
      return true if grant_access?('create', 'test_itemx_test_plans', nil, nil) || grant_access?('update', 'test_itemx_test_plans', nil, nil)
           
    end
  
    def has_show_right?
      #rfq = quote.rfq
      #return true if session[:user_id] == rfq.sales_id && sales?
      #return true if session[:user_id] == rfq.emc_eng_id && eng?
      #return true if session[:user_id] == rfq.safety_eng_id && eng?
      #return true if acct?
      #return true if reporter?
      #return true if dept_head? || corp_head? || ceo?
      return true if grant_access?('show', 'test_itemx_test_plans', nil, nil)

    end
    
    def has_edit_right? #(quote)
      #rfq = quote.rfq
      #return true if session[:user_id] == rfq.emc_eng_id && eng?
      #return true if session[:user_id] == rfq.safety_eng_id && eng?
      #return true if eng_dept_head? || corp_head? || ceo?  
      return true if grant_access?('update', 'test_itemx_test_plans', nil, nil)
   
    end
    
    #allow input test log
    def has_log_right? #(quote)
      #rfq = quote.rfq
      #return true if session[:user_id] == rfq.sales_id && sales?
      #return true if session[:user_id] == rfq.emc_eng_id && eng?
      #return true if session[:user_id] == rfq.safety_eng_id && eng?
      #return true if eng_dept_head? || corp_head? || ceo?    
      #return true if grant_access?('create', 'test_itemx_test_plans', nil, nil) || grant_access?('update', 'test_itemx_test_plans', nil, nil)
      return true if grant_access?('create', 'test_itemx_test_plan_logs', nil, nil) || grant_access?('update', 'test_itemx_test_plan_logs', nil, nil)

    end
    
    #allow input test sample
    def has_new_sample_right? #(quote)
      #rfq = quote.rfq
      #return true if session[:user_id] == rfq.emc_eng_id && eng?
      #return true if session[:user_id] == rfq.safety_eng_id && eng?
      #return true if eng_dept_head? || corp_head? || ceo?
      return true if grant_access?('create', 'test_itemx_test_samples', nil, nil) || grant_access?('update', 'test_itemx_test_samples', nil, nil)
        
    end

    def has_all_index_view?
      return true if grant_access?('all_index_view', 'test_itemx_test_plans', nil, nil)
    end

    def has_approve_right?
      return true if grant_access?('approve', 'test_itemx_test_plans', nil, nil)
    end

    def quote_approved?(quote)
      quote.approved_by_customer && quote.approved_by_corp_head
    end
      
    def load_quote
      @quote = Quotex::Quote.find(params[:quote_id]) if params[:quote_id].present?
    end
  end

end