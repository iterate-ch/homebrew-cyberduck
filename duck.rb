class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.6.5.16823.tar.gz"
  sha1 "b001073a32fef9690b84ec2f90f1cf3887df5c6e"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.6.5 (16823)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
