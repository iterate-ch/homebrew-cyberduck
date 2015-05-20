class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.8.17559.tar.gz"
  sha1 "f6e8ae8d84a51a6de6f24ce810fab5c46e9bdec6"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.8 (17559)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
