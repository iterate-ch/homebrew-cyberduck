class Duck < Formula
  desc "Command-line interface for Cyberduck (a multi-protocol file transfer tool)"
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/nightly/duck-9.0.3.42111.tar.gz"
  sha256 "391b7b779149aa44962b73befaeee4945c52956f672c9980d2d7da48c6f00e8b"
  license "GPL-3.0-only"

  depends_on "openjdk@17"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    rm_r "#{libexec}/Contents/PlugIns/Runtime.jre"
    ln_s Formula["openjdk@17"].libexec/"openjdk.jdk", "#{libexec}/Contents/PlugIns/Runtime.jre"
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 9.0.3 (42111)\n".eql? %x(`#{bin}/duck -version`)
      raise "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
