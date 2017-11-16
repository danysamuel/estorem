class ProductsController < ApplicationController

    def index

        @Title='Products'
        
        @products=Product.all
    end


end
