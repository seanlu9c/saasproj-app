class Project < ActiveRecord::Base
  belongs_to :tenant

  
  validates_uniqueness_of :title
  has_many :artifacts, dependent: :destroy   ##### if delete project, all actifact will be deleted
  has_many :user_projects
  has_many :users, through: :user_projects

  
  
  validate :free_plan_can_only_have_one_project ## custom validation
  
  
  def free_plan_can_only_have_one_project
    if self.new_record? && (tenant.projects.count > 0) && (tenant.plan == 'free')
      errors.add(:base, "Free plans cannot have more than one project")
    end
  end
  
  
  
  ###   PLACEHOLDER codes ..
  ### temporary ... to delete later
  # def self.by_plan_and_tenant(tenant_id)
  #   tenant = Tenant.find(tenant_id)
    
  #   if tenant.plan == 'premium'
  #     tenant.projects    ## grab all projects that tenant has
  #   else
  #     tenant.projects.order(:id).limit(1)
  #   end
  # end
  
  def self.by_user_plan_and_tenant(tenant_id, user)
    tenant = Tenant.find(tenant_id)
    if tenant.plan == 'premium'
      if user.is_admin?
        tenant.projects
      else
        user.projects.where(tenant_id: tenant.id)
      end
    else
      if user.is_admin?
        tenant.projects.order(:id).limit(1)
      else
        user.projects.where(tenant_id: tenant.id).order(:id).limit(1) ## order by :id
      end
    end
  end
  


  

end
