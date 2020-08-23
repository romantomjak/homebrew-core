class Pgmodeler < Formula
  desc "Open source data modeling tool designed for PostgreSQL"
  homepage "https://pgmodeler.io"
  url "https://github.com/pgmodeler/pgmodeler/archive/v0.9.2.tar.gz"
  sha256 "4fd0ae4bf71ce1de5d2d881a247a5347788361b2f9be8e0556e2556db6c03baf"
  license "GPL-3.0-only"
  head "https://github.com/pgmodeler/pgmodeler.git"

  depends_on "libpq"
  depends_on "qt"

  uses_from_macos "libxml2"

  def install
    args = %W[
      -r
      CONFIG+=release
      PREFIX=#{prefix}/pgModeler.app/Contents
      PGSQL_LIB=/usr/local/opt/libpq/lib/libpq.dylib
      PGSQL_INC=/usr/local/opt/libpq/include
      XML_INC=/usr/local/opt/libxml2/include/libxml2
      XML_LIB=/usr/local/opt/libxml2/lib/libxml2.dylib
      pgmodeler.pro
    ]

    system "qmake", *args
    system "make"
    system "make", "install"
  end

  def caveats
    <<~EOS
      This formula installs the GUI version of pgmodeler tool.

      The application can be started with:
        open /usr/local/Cellar/pgmodeler/0.9.3-beta/pgModeler.app

      Alternatively, it can be copied to a location where it will be
      recognized by Launchpad like so:
        cp -R /usr/local/Cellar/pgmodeler/0.9.3-beta/pgModeler.app ~/Applications

      WARNING: The above command will make the application stand-alone,
      brew will no longer update it, you will need to do it yourself.
    EOS
  end

  test do
    assert_match "Usage: pgmodeler-cli [OPTIONS]",
                 shell_output("#{prefix}/pgModeler.app/Contents/MacOS/pgmodeler-cli --help").strip
  end
end
