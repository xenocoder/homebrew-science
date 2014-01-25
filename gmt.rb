require 'formula'

class Gmt < Formula
  homepage 'http://gmt.soest.hawaii.edu/'
  url 'ftp://ftp.soest.hawaii.edu/gmt/gmt-4.5.11-src.tar.bz2'
  sha1 '9f226fdb498a6868da98a6014517aa9537542f03'

  depends_on 'gdal'
  depends_on 'netcdf'

  resource 'gshhg' do
    url 'ftp://ftp.soest.hawaii.edu/gmt/gshhg-gmt-nc4-2.2.4.tar.gz'
    sha1 'cf253ecf3ad32ee37c33bc60c4598a27e3ec4436'
  end

  def install
    ENV.deparallelize # Parallel builds don't work due to missing makefile dependencies
    datadir = share/name
    system "./configure", "--prefix=#{prefix}",
                          "--datadir=#{datadir}",
                          "--enable-gdal=#{HOMEBREW_PREFIX}",
                          "--enable-netcdf=#{HOMEBREW_PREFIX}",
                          "--enable-shared",
                          "--enable-triangle",
                          "--disable-xgrid",
                          "--disable-mex"
    system "make"
    system "make install-gmt"
    system "make install-data"
    system "make install-suppl"
    system "make install-man"
    datadir.install resource('gshhg')
  end
end
