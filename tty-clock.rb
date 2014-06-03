require 'formula'

class TtyClock < Formula
  homepage 'https://github.com/xorg62/tty-clock'
  url 'https://github.com/xorg62/tty-clock/archive/master.zip'
  sha1 '6db1515e4cb47f8a75059d4b9b945ef3134820d1'
  head 'https://github.com/xorg62/tty-clock.git'

  def install
    inreplace "Makefile", "/usr/local/bin/", "#{bin}/"
    system "make"
    system "make install"
  end

  test do
    system "#{bin}/tty-clock -i"
  end
end
