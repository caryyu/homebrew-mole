MOLE_VERSION = "0.4.0"
MOLE_SHA = "0e7fde18f0965c857da1e546c7cb13c72bd68b174286e0ee047043f8ee3e7e5c"

class Mole < Formula
  desc "App to create ssh tunnels"
  homepage "https://davrodpin.github.io/mole/"
  url "https://github.com/davrodpin/mole/archive/v#{MOLE_VERSION}.tar.gz"
  sha256 "#{MOLE_SHA}"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

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
