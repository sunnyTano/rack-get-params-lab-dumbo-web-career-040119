class Application

  # @@items = ["Apples","Carrots","Pears"]
  @@cart = []

        def call(env)
          resp = Rack::Response.new
          req = Rack::Request.new(env)
      
                      if req.path.match(/items/)
                        @@items.each do |item|
                          resp.write "#{item}\n"
                        end
                      elsif req.path.match(/search/) 
                        search_term = req.params["q"]
                        resp.write handle_search(search_term)
                        
                      elsif req.path.match(/cart/)
                        if @@cart.size == 0
                          resp.write "Your cart is empty"
                        else
                        @@cart.each do |item|
                          resp.write "#{item}\n"
                          end
                        end
                      
                    elsif req.path.match(/add/)
                      search_term = req.params["item"] #couldnt use the :key method (is it bc the params is a s)
                      # puts req.params[:item]
                      #if it was search_term = req (this would b the entire url)
                      # with the params[:key] => this is the input the user is searching for (starts after the = sign, everything after = sign is called params, short for parameter)
                      # this is saving the url's key to a variable
                        if @@items.include?(search_term) 
                           #.inlcudes iterates over the array but only returns true or false not the item itself
                          #looking thru the url and checking to see if there is a  path(/items) 
                          @@cart << search_term #this is the item we are searching for, the parameter (string after the equal sign)
                          resp.write "added #{search_term}"
                        else
                         
                          # puts search_term
                          # puts req.params
                          resp.write "We don't have that item #{search_term}"
                        end
                    else
                        resp.write "Path Not Found"
                  end
               
      
          resp.finish
        end

        def handle_search(search_term)
          if @@items.include?(search_term)
            return "#{search_term} is one of our items"
          else
            return "Couldn't find #{search_term}"
          end
        end
        
        
end
