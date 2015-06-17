class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.8.17762.tar.gz"
  sha1 "61581ddf5f70a39e2d5d8f5f990d3f39e3419e8f"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.8 (17762)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
