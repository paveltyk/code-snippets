# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_code_snippets_session',
  :secret      => 'afbe88c0775cc4811b5324893329d8f32cf9d8cbc3167d00609a9730565f1a17e356cd5696d9863740e877fad177ba4f884e0dd1c38c67fc643a2ba412d4dd94'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
