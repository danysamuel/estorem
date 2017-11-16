class StoreController < ApplicationController

   
    def index
        
                @Title='Products Range'
                
                @products=Product.all
        
                @categories=Product.select('distinct(category)')
            end
        
end
