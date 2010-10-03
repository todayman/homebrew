require 'formula'

class Flam3 <Formula
  url 'http://flam3.googlecode.com/svn/trunk',
    :using =>SubversionDownloadStrategy, :revision => '19'
  homepage 'http://code.google.com/p/flam3/'
  version '2.8b11'
  
  def install
    system "./src/configure", "--disable-dependency-tracking",
      "--prefix=#{prefix}", "--enable-pthread",
      "--enable-atomic-ops", "--enable-shared", "--enable-static"
    system "make install"
  end
end
