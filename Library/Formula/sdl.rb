require 'formula'

class Sdl < Formula
  url 'http://www.libsdl.org/release/SDL-1.2.14.tar.gz'
  head 'http://www.libsdl.org/tmp/SDL-1.3.zip'
  homepage 'http://www.libsdl.org/'
  def md5
    if ARGV.build_head?
      '7323582e03de905dc96bdee49e5fb0e7'
    else
      'e52086d1b508fa0b76c52ee30b55bec4'
    end
  end

  # we have to do this because most build scripts assume that all sdl modules
  # are installed to the same prefix. Consequently SDL stuff cannot be
  # keg-only but I doubt that will be needed.
  def self.use_homebrew_prefix files
    inreplace files, '@prefix@', HOMEBREW_PREFIX
  end

  def install
    fails_with_llvm
    Sdl.use_homebrew_prefix %w[sdl.pc.in sdl-config.in]

    # Sdl assumes X11 is present on UNIX
    ENV.x11
    system "./autogen.sh" if ARGV.build_head?
    system "./configure", "--prefix=#{prefix}", "--disable-nasm"
    system "make install"

    # Copy source files needed for Ojective-C support.
    libexec.install Dir["src/main/macosx/*"]
  end
end
