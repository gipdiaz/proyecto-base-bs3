class Ability
 
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user
    unless user.nil?
    	if user.confirmed?
		    if user.role? :sadmin
		    	can :manage, :all
		    	can :access, :rails_admin   # grant access to rails_admin
				can :dashboard              # grant access to the dashboard
			elsif user.role? :admin
		    	can :manage, :all
		    	can :access, :rails_admin   # grant access to rails_admin
				can :dashboard              # grant access to the dashboard
		    end
		    elsif user.role? :user
		      can :manage, [PaginaInicio]
		    end
		else
        	raise CanCan::AccessDenied.new("Debe registrar su mail!")	
        end
    end
    can :read, [PaginaInicio]
  end
end