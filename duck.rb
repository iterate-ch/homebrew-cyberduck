class Duck < Formula
  desc "Command-line interface for Cyberduck (a multi-protocol file transfer tool)"
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/nightly/duck-7.10.0.35132.tar.gz"
  sha256 "cf06b6f200712729e22bc2959afd07c323dcdff8aa1fab11f2756b11159e759b"
  license "GPL-3.0-only"

  def install
    # Because compiling would need a JDK and xcodebuild we just use the pre-compiled binary.
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    unless "Cyberduck 7.10.0 (35132)\n".eql? %x(`#{bin}/duck -version`)
      raise "Version mismatch"
    end
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
