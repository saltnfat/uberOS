{ pkgs, lib, inputs, config, ...}: {
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    dataDir = "${config.home.homeDirectory}/.config/mpd";
    extraConfig = ''
      auto_update           "yes"
      restore_paused        "yes"
      audio_output {
      	type                "pipewire"
      	name                "PipeWire Sound Server"
      	buffer_time         "100000"
      }
      bind_to_address "127.0.0.1"
      audio_output {
      	type                "fifo"
      	name                "Visualizer"
      	format              "44100:16:2"
      	path                "/tmp/mpd.fifo"
      }
    '';
    network.startWhenNeeded = true;
  };
}
