class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.8.17731.tar.gz"
  sha1 "cca6fb275c3d74157ec6994163670e6b4656e3d1"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.8 (17731)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
