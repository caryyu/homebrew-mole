MOLE_VERSION = "2.0.0"
MOLE_SHA = "adafcf59c0b0c0270e466b4d7e15f98c06641870dd70f0b275c53a3d52608b2d"
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
      system "go", "build", "-o", "bin/mole", "-ldflags", "-X github.com/davrodpin/mole/cmd.version=#{MOLE_VERSION}", "github.com/davrodpin/mole"
    end

    bin.install "src/github.com/davrodpin/mole/bin/mole" => "mole"
  end

  test do
    assert_match "mole #{MOLE_VERSION}", shell_output("#{bin}/mole version 2>&1", 2)
  end
end
