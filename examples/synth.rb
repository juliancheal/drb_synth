require_relative "../drb_synth"

# Create new instance
synth = DRBSynth.new


# List all Midi Devices
# Useful to know what to populate synths.yml file with
# synth.list_devices.each do |device|
#   puts device.pretty_name
# end

# Start DRB server
synth.start_drb
