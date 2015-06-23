class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.7.1.17810.tar.gz"
  sha1 "9c9c6fa5feabef3d9649e87b66427feebb308c3d"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.7.1 (17810)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
