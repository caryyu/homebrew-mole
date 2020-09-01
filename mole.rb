MOLE_VERSION = "1.0.1"
MOLE_SHA = "ef835962447709c391ba2322249982e400906285a65f145776b4742dc224d821"
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
      system "go", "build", "-ldflags", "-X github.com/davrodpin/mole/cmd.version=#{MOLE_VERSION}", "github.com/davrodpin/mole"
    end
  end

  test do
    assert_match "mole #{MOLE_VERSION}", shell_output("#{bin}/mole version 2>&1", 2)
  end
end
