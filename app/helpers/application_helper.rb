module ApplicationHelper
  def bootstrap_class_for_alert(alert_type)
    { success:  "alert-success", alert: "alert-warning", notice: "alert-info", error: "alert-danger" }[alert_type]
  end
end
