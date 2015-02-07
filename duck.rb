class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.7.16726.tar.gz"
  sha1 "fc1fbdc90ab61f2ecc596fd885138751d2bf95f0"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.7 (16726)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
