class InvitationWorker
  include Sidekiq::Worker
  def perform()
    # do something
  end
end
