MOLE_VERSION = "0.4.0"
MOLE_SHA = "b63ceb292726a0fa2b2491818da081cff84c24696561500cc41a7fec57502793"

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
