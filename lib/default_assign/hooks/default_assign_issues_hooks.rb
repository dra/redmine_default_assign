class DefaultAssignIssueHook < Redmine::Hook::ViewListener
  def view_issues_form_details_top(context={})
    # new issues haven't been assigned an id yet
    if context[:issue].id == nil
      selected = context[:project].default_assignee.id unless context[:project].default_assignee.blank?
      selected ||= Setting.plugin_redmine_default_assign['default_assignee_id'] unless Setting.plugin_redmine_default_assign['default_assignee_id'].blank? or 
											not context[:project].assignable_users.member?(User.find(Setting.plugin_redmine_default_assign['default_assignee_id']).id)
      selected ||= nil
      
      context[:issue].assigned_to_id = selected      
    end
    
    return
 
  end  
end
