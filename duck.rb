class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.6.5.16911.tar.gz"
  sha1 "d8acf1388e6862176d47934692d4b3dfc3291321"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.6.5 (16911)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
