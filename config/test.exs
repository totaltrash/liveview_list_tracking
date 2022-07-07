import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :my_app, MyAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "72iIFqXcO1Uk1z43KOl+fFP+Trl/dDPq5ENY7xqhRwjtfm9gefN4pOaxYrL0ST5X",
  server: false

# In test we don't send emails.
config :my_app, MyApp.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
