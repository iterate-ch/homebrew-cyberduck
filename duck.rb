class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.8.17726.tar.gz"
  sha1 "6716dc4f2b99d895f1d3c772e8291c0ea222bce7"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.8 (17726)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
