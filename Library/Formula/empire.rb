require 'formula'

class Empire <Formula
  url 'http://sourceforge.net/projects/empserver/files/empire-4.3.26/empire-4.3.26.tar.gz'
  homepage 'http://empserver.sourceforge.net'
  md5 '75a90a8fc376f9480e458836970efe68'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
