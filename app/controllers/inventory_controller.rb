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
        
        
        arraycnt = 0
        produtsids = []

        # <Update records from CSV>

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
                
                produtsids[arraycnt]=@product.productid

                arraycnt = arraycnt +1
                
            end
            
        end

        # </Update records from CSV>
        
        
        # <Delete records which are removed from CSV>
        @products=Product.all

        @products.each do |product|
           
            if !product.productid.in?(produtsids)
                product.destroy
            end
        end

        # </Delete records which are removed from CSV>
        
        redirect_to inventory_index_path

    end
end
