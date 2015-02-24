class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.7.16991.tar.gz"
  sha1 "a054055d4b4921d43a20c5b1a1411cd95a939cd6"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.7 (16991)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
