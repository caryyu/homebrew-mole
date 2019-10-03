MOLE_VERSION = "0.5.0"
MOLE_SHA = "58cff1a00510eb677e0bf929393f9697e71ea25e3c8a84290e4a75d3b91f7648"
GO_VERSION = "1.13.1"

class Mole < Formula
  desc "App to create ssh tunnels"
  homepage "https://davrodpin.github.io/mole/"
  url "https://github.com/davrodpin/mole/archive/v#{MOLE_VERSION}.tar.gz"
  sha256 "#{MOLE_SHA}"

  depends_on "go" => GO_VERSION
  def install
    bin_path = buildpath/"src/github.com/davrodpin/mole"
    bin_path.install Dir["*"]

    cd bin_path do
      system "go", "build", "-o", bin/"mole", "-ldflags", "-X main.version=#{MOLE_VERSION}", "github.com/davrodpin/mole/cmd/mole"
    end
  end

  test do
    assert_match "mole #{MOLE_VERSION}", shell_output("#{bin}/mole -version 2>&1", 2)
  end
end
