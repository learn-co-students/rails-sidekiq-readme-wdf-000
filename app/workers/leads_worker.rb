# this worker allows us to move the processing of the CSV file out of the controller
class LeadsWorker
  require 'csv'
  include Sidekiq::Worker

  # this method perform takes whatever data is required to complete the job
  def perform(leads_file)
    # remember that we also have to update our controller action telling it to run
    # this worker as opposed to processing it inline
    CSV.foreach(leads_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end
end
