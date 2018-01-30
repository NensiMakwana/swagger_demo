module API  
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc "Return all users"
        get "", root: :users do
          User.all
        end

        desc "Return a user"  
        params do
          optional :id, type: String, desc: "ID of the 
            user"
        end
        get "/get_user", root: "user" do
          if permitted_params[:id]
            User.where(id: permitted_params[:id]).first!
          else
            User.where(api_key: params[:api_key]).first!
          end
        end

        desc "Add user"
        params do
          requires :name, type: String, desc: "Enter user name"
        end
        post "", root: "users" do
          api_key = SecureRandom.hex
          User.create(name: permitted_params[:name], api_key: api_key)
        end 
      end
    end
  end
end  