require 'formula'

class Flam3 <Formula
  url 'http://flam3.googlecode.com/files/flam3-3.0.tar.gz'
  md5 'a264d7b120e0316e7294d40302308dd0'
  homepage 'http://code.google.com/p/flam3/'

  depends_on 'libpng'
  depends_on 'jpeg'

  def install
    system "./src/configure", "--disable-dependency-tracking",
      "--prefix=#{prefix}", "--enable-pthread",
      "--enable-atomic-ops", "--enable-shared", "--enable-static"
    system "make install"
  end
end
