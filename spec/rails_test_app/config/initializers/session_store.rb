# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_test_app_session',
  :secret      => 'f9ab167ae93678adf60c30b9f9722958ebb8c13f9a119cb4ef450243c80416e6136228a4cbfc38646b399b9f2853808404a680286d1a3f3cebdf602a4a9b9004'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
