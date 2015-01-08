require "formula"

class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-4.6.2.16336.tar.gz"
  version "4.6.2.16336"
  sha1 "fca3b813f31aaf29d243d670a8f2c57c57afe889"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 4.6.2 (16336)\n".eql? %x(#{bin}/duck -version)
      fail "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
