class InstanceAccess < DefaultAccess
  def edit?(instance)
    current_user.admin? || instance.owner == current_user
  end

  def show?(instance)
    current_user.admin? || instance.shared? || current_user.instance_accounts.where(:instance_id => instance.id).exists?
  end
end

