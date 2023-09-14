class Ability
  include CanCan::Ability

  def initialize(user)
    user || User.new
    can :read, :all
    can :manage, Group, { user: }
    can :manage, Spending, { user: }
  end
end
