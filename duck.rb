class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.6.5.16800.tar.gz"
  sha1 "503f3b281a917116ab4fe598b1b4fedd211f55a2"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.6.5 (16800)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
