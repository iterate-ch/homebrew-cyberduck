class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.8.17508.tar.gz"
  sha1 "0a722b024c886fc73ec11db8e2d1f819f0795784"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.8 (17508)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
