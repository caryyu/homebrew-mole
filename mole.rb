MOLE_VERSION = "0.5.0"
MOLE_SHA = "618e29266e4fd42bfbbe9c3b9c030a656f1a24344d7148928f3f71b8bdef9ab3"

class Mole < Formula
  desc "App to create ssh tunnels"
  homepage "https://davrodpin.github.io/mole/"
  url "https://github.com/davrodpin/mole/archive/v#{MOLE_VERSION}.tar.gz"
  sha256 "#{MOLE_SHA}"

  depends_on "go" => :build

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
