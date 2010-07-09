require 'formula'

class QscintillaGpl <Formula
  url 'http://www.riverbankcomputing.com/static/Downloads/QScintilla2/QScintilla-gpl-2.4.3.tar.gz'
  homepage 'http://www.riverbankcomputing.com/software/qscintilla/intro'
  md5 'b1c83d42398493bedb22f4df1868627d'

  depends_on 'pyqt'
  depends_on 'qt'
  
  def patches
      # the configuration expects to be configured in the actual directory, but that's not happening...
      DATA
  end
  
  def install
    system "qmake", "Qt4/qscintilla.pro"
    system "make"
    system "make install"
    system "python","Python/configure.py"
    system "make"
    system "make install"
    system "cd .."
    system "qmake", "designer-Qt4/designer.pro"
    system "make"
    system "make install"
  end
end

__END__
diff --git a/Python/configure.py b/Python/configure.py
index c11d5b5..c96f17f 100644
--- a/Python/configure.py
+++ b/Python/configure.py
@@ -232,9 +232,9 @@ def generate_code():
     argv.append(buildfile)
 
     if pyqt.pyqt_version >= 0x040000:
-        argv.append("sip/qscimod4.sip")
+        argv.append("Python/sip/qscimod4.sip")
     else:
-        argv.append("sip/qscimod3.sip")
+        argv.append("Python/sip/qscimod3.sip")
 
     os.system(" ".join(argv))
 
-- 
