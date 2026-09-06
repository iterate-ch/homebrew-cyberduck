class Duck < Formula
  desc "Command-line interface for Cyberduck (a multi-protocol file transfer tool)"
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/nightly/duck-9.6.0.45675.tar.gz"
  sha256 "da288dc2ecdb4c594a93079ea94232df2d14f5ca72640f4168890cbc221040f9"
  license "GPL-3.0-only"

  depends_on "openjdk@21"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    rm_r "#{libexec}/Contents/PlugIns/Runtime.jre"
    ln_s Formula["openjdk@21"].libexec/"openjdk.jdk", "#{libexec}/Contents/PlugIns/Runtime.jre"
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 9.6.0 (45675)\n".eql? %x(`#{bin}/duck -version`)
      raise "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
