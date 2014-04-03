require "formula"

class Syncthing < Formula
  homepage "http://syncthing.net"
  url "https://github.com/calmh/syncthing/archive/v0.7.1.tar.gz"
  sha1 "e644a480242dae108ccc219c8c680594ba5b0bc8"

  depends_on "go"
  depends_on "mercurial"

  def install

    system "go", "get", "github.com/cratonica/embedder"

    system "go", "get", "github.com/calmh/syncthing/cmd/syncthing"

    Dir.chdir(ENV['GOPATH'] + "/src/github.com/calmh/syncthing")

    system "./build.sh"

    bin.install ENV['GOPATH'] + "/src/github.com/calmh/syncthing/syncthing"
  end

  def caveats; <<-EOS.undent
    You can always start syncthing manually by executing `syncthing` in a Terminal.

    Alternatively you can create a launchd script that automatically starts the syncthing daemon at boot and keeps it running.
    An example script would look like this:

    <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>net.syncthing.syncthing</string>
        <key>Program</key>
        <string>/usr/local/bin/syncthing</string>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
  EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test syncthing`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
