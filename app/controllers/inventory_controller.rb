class InventoryController < ApplicationController
     

    def index
        @Title='Stock'


        @products=Product.all

        @count=Product.all.count
    end

    def syncdata
        require 'roo'
       
        @Title='Updating.....'
        xlsx = Roo::Spreadsheet.open('test.csv')
        
        
        xlsx.sheet(0).each(productid: 'ProductID', category: 'Category',product_name: 'Product Name', price: 'Price') do |line|
           
            if (line[:productid] != "ProductID")
                @product=Product.new
                @product.productid=line[:productid]
                @product.category=line[:category]
                @product.product_name=line[:product_name]
                @product.price=line[:price]
                        
                if !Product.exists?(productid: @product.productid)
                    @product.save
                else
                    Product.update(@product.productid,line)
                end

            end

           
            
            
        end
        redirect_to inventory_index_path

    end
end
