CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['AKIAIOD52SFZUWGSVIMQ'],  # required
    :aws_secret_access_key  => ENV['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'],
  }
  config.fog_directory  = 'name_of_directory'                # required
end
