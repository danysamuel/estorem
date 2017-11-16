class StoreController < ApplicationController

    def index
        @Title='Index'

        @posts = Store.all
        
    end

end
