class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.7.16738.tar.gz"
  sha1 "a5a523a66ee97b57bdb9094f59a98bc38490d7c4"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.7 (16738)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
