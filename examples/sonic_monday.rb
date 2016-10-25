# A sample Sonic Pi sketch that uses DRBSynth
require 'drb/drb'
DRb.start_service
volca = DRbObject.new_with_uri('druby://localhost:9999')

define :mydrums do
  2.times do
    volca.note(36,:volca_beats)
    sleep 0.5
  end

  8.times do
    volca.note(36,:volca_beats)
    sleep 0.125
  end

  4.times do
    volca.note(36,:volca_beats)
    sleep 0.5
  end
end

define :mysynths do
  with_fx :reverb do
    with_synth :dsaw do
      with_synth_defaults attack: 0.01, amp: 0.5, release: 0.5 do
        notes = [:F, :C, :D, :D, :G, :C, :D, :D]

        notes.each do |n|
          2.times do
            volca.note(note(n, octave: 2),:volca_keys)
            sleep 0.25
            volca.note(note(n, octave: 3),:volca_keys)
            sleep 0.25
          end
        end
      end
    end
  end
end

live_loop :bassline do
  mydrums
end

sleep 8

live_loop :synth_notes do
  mysynths
end
