class Duck < Formula
  desc "Command-line interface for Cyberduck (a multi-protocol file transfer tool)"
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/nightly/duck-9.6.0.45877.tar.gz"
  sha256 "d0c1e884a6e9e2ddd5bd53add131afce39c586f51f7a46c974d780cc8e5a7c04"
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
    unless "Cyberduck 9.6.0 (45877)\n".eql? %x(`#{bin}/duck -version`)
      raise "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
