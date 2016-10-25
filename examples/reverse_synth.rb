require_relative "../drb_synth"
require_relative "../endpoints/sonic_pi"

# Create new instance
synth = DRBSynth.new

# Start DRB server
synth.start_drb
