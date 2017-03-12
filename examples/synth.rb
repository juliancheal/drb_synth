require_relative "../drb_synth"

# Create new instance
synth = DRBSynth.new

# # List all Midi Devices
# # Useful to know what to populate synths.yml file with
# synth.list_devices.each do |device|
#   puts "Name: #{device.pretty_name} Direction: #{device.direction}"
# end

# # Start DRB server
synth.start_drb
