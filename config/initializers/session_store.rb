# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_linktopia_session',
  :secret      => 'd615e715f07d2cca5ec064fecf047d37a13ef9ee839afc1917f36e745a2ff8c88eeba68f611be224cb84dc004fc8655ca258b39f779d8a07bba25b00b94cec81'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
