# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_awesome_session',
  :secret      => '1bceb3fb72246913ec684833210936a782f897f775febf0e3b33d9ff8519118535993c8fd0e732a4d0f3fdc960e5bee37e319cdbcde9f1b1356f0954693e4d81'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
