class ProductsController < ApplicationController

    def index

        @Title='Products List'
        
        @products=Product.all

        @categories=Product.select('distinct(category)')
    end

    def show
        @Title=params[:id]
       
        @products = Product.where(category: params[:id])
        
        
    end


end
