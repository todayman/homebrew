require 'formula'

def build_clang?; ARGV.include? '--with-clang'; end
def build_debug?; ARGV.include? '--debug'; end

class Clang <Formula
  url       'http://llvm.org/releases/2.7/clang-2.7.tgz'
  head	    'http://llvm.org/svn/llvm-project/cfe/trunk'
  homepage  'http://llvm.org/'
  md5       'b83260aa8c13494adf8978b5f238bf1b'
  def download_strategy
    if version == 'HEAD'
      SubversionDownloadStrategy
    else
      CurlDownloadStrategy
    end
  end
end

class Llvm <Formula
  url       'http://llvm.org/releases/2.7/llvm-2.7.tgz'
  head	    'http://llvm.org/svn/llvm-project/llvm/trunk'
  homepage  'http://llvm.org/'
  md5       'ac322661f20e7d6c810b1869f886ad9b'
  def download_strategy
    if version == 'HEAD'
      SubversionDownloadStrategy
    else
      CurlDownloadStrategy
    end
  end

  def options
    [
      ['--with-clang', 'Also build & install clang'],
      ['--debug', 'Build LLVM ( and clang perhaps ) with debugging symbols']
    ]
  end

  def install
    ENV.gcc_4_2 # llvm can't compile itself
        
    if build_clang?
      clang_dir = Pathname.new(Dir.pwd)+'tools/clang'
      if version == 'HEAD'
        clang_form = Clang.new 'clang'
      else
        clang_form = Clang.new
      end
      clang_form.brew do
        clang_dir.install Dir['*']
      end
    end
    
    if build_debug?
      system "./configure", "--prefix=#{prefix}",
                            "--enable-debug-runtime",
                            "--enable-debug-symbols"
    else
      system "./configure", "--prefix=#{prefix}",
                            "--enable-targets=host-only",
                            "--enable-optimized"
    end
      
    system "make" # seperate steps required, otherwise the build fails
    system "make install" # seperate steps required, otherwise the build fails
    
    if build_clang?
      Dir.chdir clang_dir do
        system "make install"
      end
    end
  end
end
