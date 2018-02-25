class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_validation :log_validation_errors, if: :errors


  private

  def log_validation_errors
    Rails.logger.debug self.errors.full_messages.join("\n")
  end
end
