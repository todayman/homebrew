require 'formula'

class Wxmac < Formula
  url 'http://downloads.sourceforge.net/project/wxwindows/2.8.11/wxMac-2.8.11.tar.bz2'
  homepage 'http://www.wxwidgets.org'
  md5 '81c20d7b2ba31becb18e467dbe09be8f'

  def caveats; <<-EOS.undent
    wxWidgets 2.8.x builds 32-bit only, so you probably won't be able to use it
    for other Homebrew-installed softare on Snow Leopard (like Erlang).
    EOS
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    system "make install"
  end
end
