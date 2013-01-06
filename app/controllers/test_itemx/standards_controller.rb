# encoding: utf-8 

module TestItemx
  class StandardsController < ApplicationController
   
    before_filter :require_signin
    before_filter :require_employee
  
    helper_method :has_edit_create_right?
   
    def index
      @title = "测试标准"
      if has_edit_create_right?
        @standards = Standard.order("name")
      else
        @standards = Standard.active_std.order("name")
      end
    end
  
    def new
  
      if !has_edit_create_right?
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=无权创建新标准!")
      end
      @standard = Standard.new()
      @title = "输入标准"    
    end
  
    def create
      @standard = Standard.new(params[:standard], :as => :role_new)
      @standard.last_updated_by_id = session[:user_id]
      if has_edit_create_right?
        if @standard.save!
          #send out notification email
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=新标准成功保存！")
        else
          flash.now[:error] = "数据有错误。新标准无法保存！"
          render 'new'
        end
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=无权输入新标准!")
      end
    end
  
    def edit
      if !has_edit_create_right?
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=无权更新标准!")     
      end
      @standard = Standard.find(params[:id])
      @title = "更新标准"  
    end
  
    def update
      @standard = Standard.find(params[:id])
      if has_edit_create_right?
        @standard.last_updated_by_id = session[:user_id]
        if @standard.update_attributes(params[:standard], :as => :role_update)
          #send out notification email
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=标准更改成功保存！")
        else
          flash.new[:error] = "数据有错误。标准更改无法保存！"
          render 'edit'
        end
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=无权更改标准!")
      end    
    end
  
    def show
      @standard = Standard.find(params[:id])
      @title = "标准内容"     
    end
  
    protected
    def has_edit_create_right?
      grant_access?('create', 'test_itemx_standards', nil, nil) || grant_access?('update', 'test_itemx_standards', nil, nil)
      #return true if eng_dept_head? || corp_head? || ceo?
    end
  end
end