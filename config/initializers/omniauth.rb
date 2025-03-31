
# skip CRSF verification
OmniAuth.config.request_validation_phase = ->(env) { true }
