class Duck < Formula
  desc "Command-line interface for Cyberduck (a multi-protocol file transfer tool)"
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/nightly/duck-9.1.4.43087.tar.gz"
  sha256 "cd4040eb81c48c95aa0fb49ae3b6ad1e10fd54aae913c5a27200de8cadcdf7e4"
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
    unless "Cyberduck 9.1.4 (43087)\n".eql? %x(`#{bin}/duck -version`)
      raise "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
