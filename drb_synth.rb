require 'drb/drb'
require 'midi'
require 'yaml'
require 'ostruct'
require 'logger'

class DRBSynth

  attr_reader :all_devices

  def initialize
    @synths = []
    @devices = {}

    @log = Logger.new(STDOUT)
    @log.level = Logger::INFO

    configuration

    @synths.each do |synth|
      device = MIDI::Session.new(all_devices.find { |d| d.id == synth.port }) unless synth.port.nil?
      @devices[synth.key.to_sym] = {device: device, metadata: synth}
    end
  end

  def configuration(file='synths.yml')
    synth_file = YAML.load_file(file)

    if synth_file
      synth_file.each do |synth|
        @synths << OpenStruct.new(synth)
      end
    end
  end

  def note(value, device)
    @log.info("Note: #{value}, Device: #{device_name(device)}")
    generate(device, value)
  end

  def generate(device, data, args = nil)
    synth = @devices[device][:device]
    synth.play(data, 0.05)
    synth.off
  end

  def start_drb(host="localhost",port='9999')
    DRb.start_service("druby://#{host}:#{port}", self)
    DRb.thread.join
  end

  def list_devices(&block)
    all_devices
  end

  private

  def all_devices
    @all_devices ||= UniMIDI::Output.all
  end

  def device_name(device)
    @devices[device][:metadata].name
  end
end
