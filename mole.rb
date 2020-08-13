MOLE_VERSION = "1.0.0"
MOLE_SHA = "7e98e21a8f450784d9f68bd05135470bffed645d84c7071de0c73a1276f42673"
GO_VERSION = "1.14.7"

class Mole < Formula
  desc "App to create ssh tunnels focused on resiliency and user experience."
  homepage "https://davrodpin.github.io/mole/"
  url "https://github.com/davrodpin/mole/archive/v#{MOLE_VERSION}.tar.gz"
  sha256 "#{MOLE_SHA}"

  depends_on "go" => GO_VERSION
  def install
    bin_path = buildpath/"src/github.com/davrodpin/mole"
    bin_path.install Dir["*"]

    cd bin_path do
      system "go", "build", "-o", "bin/mole", "-ldflags", "-X main.version=#{MOLE_VERSION}", "github.com/davrodpin/mole"
    end
  end

  test do
    assert_match "mole #{MOLE_VERSION}", shell_output("#{bin}/mole version 2>&1", 2)
  end
end
